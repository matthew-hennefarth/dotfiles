#!/bin/zsh

main(){
  echo ${${(%):-`hostname`}%.local}
}
main
