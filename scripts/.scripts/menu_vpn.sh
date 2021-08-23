#!/bin/bash
#
# Menu script to launch specific projects.

custom_dmenu='rofi -dmenu'

ssh_cp() {
  rnd_sds=$(($RANDOM%10))
  rnd_sysc=$(($RANDOM%89))
  rnd_sysc=$(($RANDOM%9))

  options="SDS Computer[${rnd_sds}]\n"
  options+="SystemC Computer[${rnd_sysc}]\n"
  options+="SEC Computer[0${rnd_sysc}]\n"
  options+="Other\n"

  answ=$(echo -e "$options" | $custom_dmenu -i -p "VPN Sessions")

  case "$answ" in
  SDS*)
    echo "scp ga74ped@sds${rnd_sds}.regent.e-technik.tu-muenchen.de:" | xclip -i -sel clip
    ;;

  SystemC*)
    echo "scp ga74ped@linux${rnd_sysc}.eikon.tum.de" | xclip -i -sel clip
    ;;

  SEC*)
    echo "scp -X ga74ped@tueisec-Pra0${rnd_sysc}.sec.ei.tum.de" | xclip -i -sel clip
    ;;

  *)
    ;;
  esac

}

ssh_choose() {
  rnd_sds=$(($RANDOM%10))
  rnd_sysc=$(($RANDOM%89))
  rnd_sysc=$(($RANDOM%9))

  options="SDS Computer[${rnd_sds}]\n"
  options+="SystemC Computer[${rnd_sysc}]\n"
  options+="SEC Computer[0${rnd_sysc}]\n"
  options+="Other\n"

  answ=$(echo -e "$options" | $custom_dmenu -i -p "VPN Sessions")

  case "$answ" in
  SDS*)
    echo "ssh ga74ped@sds${rnd_sds}.regent.e-technik.tu-muenchen.de" | xclip -i -sel clip
    ;;

  SystemC*)
    echo "ssh ga74ped@linux${rnd_sysc}.eikon.tum.de" | xclip -i -sel clip
    ;;

  SEC*)
    echo "ssh -X ga74ped@tueisec-Pra0${rnd_sysc}.sec.ei.tum.de" | xclip -i -sel clip
    ;;

  *)
    ;;
  esac

}

ssh_prep_credentials() {
  protocol=""
  username=ga74ped
  passwd=$(pass vpn)

  echo -e "${protocol}\n${username}\n${passwd}" > $HOME/.config/i3/tmp/vpn
}

ssh_clean_credentials() {
  rm $HOME/.config/i3/tmp/vpn
}

main() {
  ssh_prep_credentials
  options="asa-cluster.lrz.de\n"
  options+="SCP\n"
  options+="Other\n"

  answ=$(echo -e "$options" | $custom_dmenu -i -p "VPN Sessions")

  case "$answ" in
  asa-cluster*)
    /opt/cisco/anyconnect/bin/vpn -s < $HOME/.config/lemonbar/tmp/vpn connect "asa-cluster.lrz.de"
    ssh_choose
    ;;
  SCP*)
    ssh_cp
    ;;

  *)
    ;;
  esac
  ssh_clean_credentials
}

main "$@"
