local awful = require("awful")
local wibox = require("wibox")

function setNewIcon(button)
    listsinkscommand = 'pacmd list-sinks | grep -e \'* index:\' -A 1'
    awful.spawn.easy_async_with_shell(listsinkscommand, function(stdout, stderr, reason, exit_code)
        if string.find(stdout, "Lapdesk") then
            button:set_image("/usr/share/icons/custom/sound-speakers.png")
        elseif string.find(stdout, "Jabra") then
            button:set_image("/usr/share/icons/custom/sound-headset.png")
        else
            button:set_image("/usr/share/icons/custom/sound-laptop.png")
        end
    end
    )
end

local audiosinkbutton = wibox.widget {
    resize = true,
    forced_height = 20,
    widget = wibox.widget.imagebox
}
setNewIcon(audiosinkbutton)

audiosinkbutton:connect_signal("button::press", function(c) 
                    awful.spawn.easy_async_with_shell("source ~/.zshrc; toggleaudiosink", function(stdout, stderr, reason, exit_code)
                        setNewIcon(audiosinkbutton) 
                    end)
                end)

return audiosinkbutton
