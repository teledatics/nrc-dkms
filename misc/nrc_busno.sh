#!/bin/bash

# Teledatics TD-XPAH spi bus number tool

BUSNO=$(for i in $(ls /sys/class/spi_master/); do if [ "$(basename $(readlink /sys/class/spi_master/$i/device))" == "spi-ft232h.0" ]; then echo $i | sed 's/[^0-9]*//g'; fi; done)
SPI_BUS=${BUSNO:-0}
echo ${SPI_BUS}
