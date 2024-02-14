#!/bin/sh

is_charging(){
  status=`pmset -g batt | awk -F '; *' 'NR==2 { print $2 }'`
  if [ "$status" != "discharging" ]; then
    return
  fi
  false
}

charging_symbol(){
  remaining=$1
  if is_charging; then
    if [ "$remaining" -gt "95" ]; then 
      echo "󰂅"
    elif [ "$remaining" -gt "85" ]; then 
      echo "󰂋"
    elif [ "$remaining" -gt "75" ]; then
      echo "󰂊"
    elif [ "$remaining" -gt "65" ]; then
      echo "󰢞"
    elif [ "$remaining" -gt "55" ]; then 
      echo "󰂉"
    elif [ "$remaining" -gt "45" ]; then
      echo "󰢝"
    elif [ "$remaining" -gt "35" ]; then
      echo "󰂈"
    elif [ "$remaining" -gt "25" ]; then
      echo "󰂇"
    elif [ "$remaining" -gt "15" ]; then
      echo "󰂆"
    elif [ "$remaining" -gt "5" ]; then
      echo "󰢜"
    else
      echo "󰢟"
    fi
  else
    if [ "$remaining" -gt "95" ]; then 
      echo "󰁹"
    elif [ "$remaining" -gt "85" ]; then 
      echo "󰂂"
    elif [ "$remaining" -gt "75" ]; then
      echo "󰂁"
    elif [ "$remaining" -gt "65" ]; then
      echo "󰂀"
    elif [ "$remaining" -gt "55" ]; then 
      echo "󰁿"
    elif [ "$remaining" -gt "45" ]; then
      echo "󰁾"
    elif [ "$remaining" -gt "35" ]; then
      echo "󰁽"
    elif [ "$remaining" -gt "25" ]; then
      echo "󰁼"
    elif [ "$remaining" -gt "15" ]; then
      echo "󰁻"
    elif [ "$remaining" -gt "5" ]; then
      echo "󰁺"
    else
      echo "󰂎"
    fi
  fi
}

main(){
  remaining=`pmset -g batt | grep -o "[0-9]\{1,3\}%" | cut -d% -f1`
  symbol=$(charging_symbol $remaining)
  echo $symbol $remaining% 
}
main
