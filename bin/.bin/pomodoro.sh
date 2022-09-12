#!/bin/bash

ICON_PATH="/home/duclos/.config/awesome/theme/icons/clock.png"

i=0
while :; do
    echo "Work Time"
    notify-send -i ${ICON_PATH} \
                -t 5000 \
                "Work Time!"

    for i in $(seq 1 9); do
        sleep 5m
        notify-send -i ${ICON_PATH} \
                    -u critical \
                    -t 5000 \
                    "${i} out of 9 working intervals is done!"
    done

    exit 1

    notify-send -i ${ICON_PATH} \
                -t 2000 \
                "Break Time!"
    echo "Break Time"
    sleep 15m
done
