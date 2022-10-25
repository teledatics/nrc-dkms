#!/bin/bash 

# Teledatics spi_ft232h & nrc module load helper script

SPI_BUS_NO=`nrc_busno.sh`
SPI_GPIO_NO=`nrc_gpiono.sh`
MOD_PATH="/lib/modules/`uname -r`/updates/dkms"
MOD_NAME="nrc"
MOD_PATH_NAME=`ls ${MOD_PATH}/${MOD_NAME}*`

# exit if FTDI USB-SPI module not loaded
if [ "${SPI_GPIO_NO}" == "-1" ]; then
	exit -1;
fi

# exit if nrc module already loaded
if lsmod | grep -Eq "^${MOD_NAME} "; then
	exit -1;
fi

insmod ${MOD_PATH_NAME} fw_name=nrc7292_cspi.bin bd_name=nrc7292_bd.dat spi_bus_num=${SPI_BUS_NO} spi_cs_num=0 spi_gpio_irq=${SPI_GPIO_NO} spi_polling_interval=5 hifspeed=3000000

# wait until module is loaded
while ! lsmod | grep -Eq "^${MOD_NAME} "; do
        sleep 1;
done
