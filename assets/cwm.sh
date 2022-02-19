#!/bin/sh
feh --bg-fill $HOME/doc/bg.png

notify() {
	sleep 1
	notify-send '<launched>'
}

polybar time &
polybar painted &
notify &
picom &
cwm
