#!/bin/bash

ICON_PATH="/home/duclos/.config/awesome/theme/icons/clock.png"

while [ 1 ]; do
    notify-send -i ${ICON_PATH} \
                -t 2000 \
                "Work Time!"

    for ((i=0; i++; i<9)); do
        sleep 5m
        part=$((i + 1))
        notify-send -i ${ICON_PATH} \
                    -t 1000 \
                    "${part} out of 9 working intervals is done!"
    done

    notify-send -i ${ICON_PATH} \
                -t 2000 \
                "Break Time!"
    sleep 15m
done
