#
# ~/.xprofile
#
# sourced by /etc/lxdm/Xsession
#

if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

# Environment variables
#
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"


xsetroot -name 2bwm

# set wallpaper using hardlinked wallpaper
hsetroot -fill ~/usr/img/wp/bg.png
xsetroot -cursor_name left_ptr

# set keyboard rate
xset r rate 300 30

xrdb -load .Xresources_noct
compton -Cf -D7 &

xbindkeys &
xmodmap ~/.Xmodmap &
xautolock -time 5 -locker screenlock -detectsleep &

[[ -z $(pgrep -xU $UID mpd) ]] && mpd &
[[ -z $(pgrep -xU $UID mpdscribble) ]] && mpdscribble &
[[ -z $(pgrep -xU $UID musicupdate) ]] && musicupdate &
[[ -z $(pgrep -xU $UID urxvtd) ]] && urxvtd &

# UNIX mail checker
maillist &

# statusbar
wrapbar & 

exec 2bwm
