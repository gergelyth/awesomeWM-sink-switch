# awesomeWM-sink-switch

*Note that this is the result of some quick work and scripting. I'm sure that things can be improved here, but it works in the current state and that was good enough for now.*

Follow the steps below to add a sink switcher widget to your awesomeWM configuration.
I use `zsh`, but it is not a prerequisite.

Script is written for my use case, where I have three (usable) audio devices: a lapdesk with a built-in speaker, the default output of the laptop and a headset (separate from the laptop, i.e. not wired). I also have a HDMI output which I want to ignore while looping through the sinks.

Icons are free and downloaded from https://www.iconarchive.com/show/100-flat-icons-by-graphicloads.html

Put the icons to your `/usr/share/icons/custom` directory. Or any other path, but then modify the strings in `audio-sink-button.lua`.

Put the `audio-sink-button.lua` file to your `.config/awesome/widgets` directory and import it in your `rc.lua` as
```lua
local audiosinkbutton = require("widgets/audio-sink-button")
```
Add `audiosinkbutton` to your `wibox`.

Finally, put the contents of `sink-switch.zsh` to your `.zshrc` file.
Restart awesomeWM and check that it works.

*Optional:*

I also have a shortcut defined in `.xbindkeysrc`. You can use the command
```sh
awesome-client 'require("widgets/audio-sink-button"):emit_signal("button::press", {button = 1})'
```
to trigger a button press event (therefore switch the audio sink and update the button icon).
