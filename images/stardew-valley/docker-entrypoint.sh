#!/bin/bash


if [-e "/data/Stardew/Stardew Valley/Mods/Always On Server/config.json" ];then
  rm "/data/Stardew/Stardew Valley/Mods/Always On Server/config.json"
fi

ln -s /configs/alwayson.json "/data/Stardew/Stardew Valley/Mods/Always On Server/config.json"

if [-e "/data/Stardew/Stardew Valley/Mods/UnlimitedPlayers/config.json" ];then
  rm "/data/Stardew/Stardew Valley/Mods/UnlimitedPlayers/config.json"
fi
ln -s /configs/unlimitedplayers.json "/data/Stardew/Stardew Valley/Mods/UnlimitedPlayers/config.json"

if [-e "/data/Stardew/Stardew Valley/Mods/AutoLoadGame/config.json" ];then
  rm "/data/Stardew/Stardew Valley/Mods/AutoLoadGame/config.json"
fi

ln -s /configs/autoload.json "/data/Stardew/Stardew Valley/Mods/AutoLoadGame/config.json"

if [-e /root/.config/i3/config ];then
  rm /root/.config/i3/config
fi
ln -s /configs/i3-config /root/.config/i3/config


if [ -f /tmp/.X10-lock ]; then rm /tmp/.X10-lock; fi
Xvfb :10 -screen 0 1580x920x24 -ac &

while [ ! -z "`xdpyinfo -display :10 2>&1 | grep 'unable to open display'`" ]; do
  echo Waiting for display;
  sleep 5;
done

export DISPLAY=:10.0
x11vnc -display :10 -rfbport 5900 -rfbportv6 -1 -no6 -noipv6 -httpportv6 -1 -forever \
  -desktop StardewValley -cursor arrow -passwd $VNCPASS -shared &
sleep 5
i3 &
export XAUTHORITY=~/.Xauthority
TERM=xterm
/data/Stardew/Stardew\ Valley/StardewValley
