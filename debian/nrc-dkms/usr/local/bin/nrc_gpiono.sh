#!/bin/bash

# Teledatics TD-XPAH gpio number tool

GPIO=$(for i in $(ls /sys/bus/usb/devices/); do for j in $(ls /sys/bus/usb/devices/$i/); do if [ "$j" == "spi-ft232h.0" ]; then echo $(ls /sys/bus/usb/devices/$i/gpio/ | sed 's/[^0-9]*//g'); fi; done; done)
GPIO_NO=${GPIO:--1}
echo ${GPIO_NO}
