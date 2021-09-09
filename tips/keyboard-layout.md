##### ref: https://discourse.lubuntu.me/t/lubuntu-20-04-lxqt-0-14-keyboard-layout-does-not-switch/1551/6
#### ISSUE: lxqt-config-input: any chosen element in “Keyboard Layouts → Key to change layout” doesn’t work properly (always resets to None).
### SOLUTION:
`options=grp:lalt_lshift_toggle` in `~/.config/lxqt/session.conf`
## HOWTO
nano ~/.config/lxqt/session.conf
```
[Keyboard]
layout="us,ca"
model=pc105
options=grp:lalt_lshift_toggle
variant=","
```
