#!/bin/bash
#
# Menu script to launch specific projects.

custom_dmenu="rofi -dmenu -format i"

hc() {
  herbstclient "$@"
}

launch_alacritty() {
  # First argument is command
  # Second argument is instance's name
  if [ "$#" -eq 1 ]; then
    alacritty -e "bash" -c "$1; bash" &
  else
    alacritty --class "$2" -e "bash" -c "$1; bash" &
  fi
}

launch_tum() {
  hc use 1
  hc cycle_layout 1 max
  firefox 'https://chat.tum.de/channel/espl' \
          'https://campus.tum.de/tumonline/ee/ui/ca2/app/desktop/#/pl/ui/$ctx/wbKalender.wbPerson?$ctx=design=ca2;header=max;lang=de'
}

launch_edx() {
  hc use 9
  hc cycle_layout 1 max
  firefox 'https://learning.edx.org/course/course-v1:UCSanDiegoX+ALGS201x+1T2019/home' \
          'https://courses.edx.org/courses/course-v1:UCSanDiegoX+ALGS201x+1T2019/pdfbook/0/'
  wait "$!"

  firefox 'https://google.github.io/styleguide/cppguide.html'
  wait "$!"

  hc rule instance=Alacritty:freertos tag=10 focus=off
  launch_alacritty "cd ~/Documents/work/espl/FreeRTOS/FreeRTOS-Pacman/ && vim src/main.c" \
                   "edx"
}

launch_ESS() {
  firefox \
    'https://www.moodle.tum.de/my/'

  firefox \
    'file:///opt/XMClib/XMC_Peripheral_Library_v2.1.16/XMCLib/doc/html/modules.html'

  zathura ~/Documents/university/classes/embedded_security/references/XMC4500/Board_Users_Manual_XMC4500_Relax_Kit-V1_R1.2_released.pdf &
  zathura ~/Documents/university/classes/embedded_security/references/XMC4500/Infineon-xmc4500_rm_v1.6_2016-UM-v01_06-EN.pdf &
}

launch_FreeRTOS() {
  hc use 6
  hc cycle_layout 1 max

  firefox 'https://www.kernel.org/doc/html/v4.10/process/coding-style.html' \
          'https://www.youtube.com/watch?v=-CbyAk3Sn9I' \
          'file:///home/duclos/Documents/work/espl/docs/ESPL-project-ss19.pdf'
  wait "$!"

  firefox 'https://github.com/duclos-cavalcanti/FreeRTOS-Pacman/tree/demo' \
          'https://github.com/duclos-cavalcanti/FreeRTOS-Pacman/blob/demo/src' \
          'https://github.com/duclos-cavalcanti/FreeRTOS-Pacman/blob/demo/src/main.c'
  wait "$!"

  firefox 'https://github.com/alxhoff/FreeRTOS-Emulator/wiki/Libraries-and-APIs' \
          'https://github.com/alxhoff/FreeRTOS-Emulator/wiki/AsyncIO' \
          'https://alxhoff.github.io/FreeRTOS-Emulator/modules.html' \
          'https://www.freertos.org/a00106.html'
  wait "$!"

  hc rule instance=Alacritty:freertos tag=10 focus=off
  launch_alacritty "cd ~/Documents/work/espl/FreeRTOS/FreeRTOS-Pacman/ && vim src/main.c" \
                   "freertos"
}

launch_ML() {
  hc use 6
  hc cycle_layout 1 max

  firefox 'https://work.caltech.edu/telecourse.html' \
          'https://work.caltech.edu/library/' \
          'https://www.youtube.com/watch?v=mbyG85GZ0PI'
  wait "$!"
  sleep 2s

  firefox 'https://www.youtube.com/playlist?list=PLC1qU-LWwrF64f4QKQT-Vg5Wr4qEE1Zxk' \
          'https://www.youtube.com/watch?v=wEoyxE0GP2M&list=PLC1qU-LWwrF64f4QKQT-Vg5Wr4qEE1Zxk&index=6'
  wait "$!"
  sleep 2s

  firefox 'https://www.cs.ubc.ca/~nando/540-2013/lectures.html' \
          'https://www.youtube.com/playlist?list=PLE6Wd9FR--Ecf_5nCbnSQMHqORpiChfJf' \
          'https://www.youtube.com/watch?v=w2OtwL5T1ow&list=PLzERW_Obpmv9-3dnYYYG639X6QiRF4Zp_'
  wait "$!"
  sleep 2s

  hc use 7
  hc cycle_layout 1 max

  firefox 'https://www.deeplearningbook.org/'  \
          'https://www.deeplearningbook.org/'
  wait "$!"
  sleep 2s

  firefox 'https://work.caltech.edu/lectures.html#lectures' \
          'https://home.work.caltech.edu/slides/slides01.pdf'
}

main() {
  options="TUM\n"
  options+="FreeRTOS\n"
  options+="EDX\n"
  options+="ESS\n"
  options+="ML\n"
  options+="Moodle\n"
  options+="Rocket\n"
  options+="Other"

  answ=$(echo -e "$options" | $custom_dmenu -i -p "Launch Sessions")
  [ -z "$ans" ] && exit 0

  case "$answ" in
  0)
    launch_tum
    ;;

  1)
    launch_FreeRTOS
    ;;

  2)
    launch_edx
    ;;

  3)
    launch_ESS
    ;;

  4)
    launch_ML
    ;;

  *)
    ;;
  esac
}

main "$@"
