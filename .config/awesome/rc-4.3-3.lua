pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
pcall(require, "xdgmenu")

-- {{{ variable definitions
-- themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_configuration_dir() .. "/themes/default/theme.lua")
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "adwaita")
beautiful.init(theme_path)

-- this is used later as the default terminal and editor to run.
terminal = "xfce4-terminal"
editor = "xfce4-terminal -x nvim" or os.getenv("EDITOR")
editor_cmd = terminal .. " -x " .. editor

-- default modkey.
modkey = "Mod4"

-- table of layouts to cover with awful.layout.inc, order matters. (-git compatible)
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.top,
}
-- }}}

-- {{{ sub-menus
-- create sub-menus for different system functions
s_menu = {
    { "off",        function() awful.spawn.easy_async_with_shell("xset s off off") end },
    { "10 # 10s",   function() awful.spawn.easy_async_with_shell("xset s 10 0") end },
    { "30 # 30s",   function() awful.spawn.easy_async_with_shell("xset s 30 0") end },
    { "60 # 1m",    function() awful.spawn.easy_async_with_shell("xset s 60 0") end },
    { "180 # 3m",   function() awful.spawn.easy_async_with_shell("xset s 180 0") end },
    { "300 # 5m",   function() awful.spawn.easy_async_with_shell("xset s 300 0") end },
    { "600 # 10m",  function() awful.spawn.easy_async_with_shell("xset s 600 0") end },
    { "900 # 15m",  function() awful.spawn.easy_async_with_shell("xset s 900 0") end },
    { "1800 # 30m", function() awful.spawn.easy_async_with_shell("xset s 1800 0") end },
    { "2700 # 45m", function() awful.spawn.easy_async_with_shell("xset s 2700 0") end },
    { "3600 # 1h",  function() awful.spawn.easy_async_with_shell("xset s 3600 0") end },
    { "7200 # 2h",  function() awful.spawn.easy_async_with_shell("xset s 7200 0") end },
    { "10800 # 3h", function() awful.spawn.easy_async_with_shell("xset s 10800 0") end },
    { "14400 # 4h", function() awful.spawn.easy_async_with_shell("xset s 14400 0") end },
    { "21600 # 6h", function() awful.spawn.easy_async_with_shell("xset s 21600 0") end },
}

dpms_menu = {
    { "off",        function() awful.spawn.easy_async_with_shell("xset -dpms") end },
    { "10 # 10s",   function() awful.spawn.easy_async_with_shell("xset dpms 0 0 10") end },
    { "30 # 30s",   function() awful.spawn.easy_async_with_shell("xset dpms 0 0 30") end },
    { "60 # 1m",    function() awful.spawn.easy_async_with_shell("xset dpms 0 0 60") end },
    { "180 # 3m",   function() awful.spawn.easy_async_with_shell("xset dpms 0 0 180") end },
    { "300 # 5m",   function() awful.spawn.easy_async_with_shell("xset dpms 0 0 300") end },
    { "600 # 10m",  function() awful.spawn.easy_async_with_shell("xset dpms 0 0 600") end },
    { "900 # 15m",  function() awful.spawn.easy_async_with_shell("xset dpms 0 0 900") end },
    { "1800 # 30m", function() awful.spawn.easy_async_with_shell("xset dpms 0 0 1800") end },
    { "2700 # 45m", function() awful.spawn.easy_async_with_shell("xset dpms 0 0 2700") end },
    { "3600 # 1h",  function() awful.spawn.easy_async_with_shell("xset dpms 0 0 3600") end },
    { "7200 # 2h",  function() awful.spawn.easy_async_with_shell("xset dpms 0 0 7200") end },
    { "10800 # 3h", function() awful.spawn.easy_async_with_shell("xset dpms 0 0 10800") end },
    { "14400 # 4h", function() awful.spawn.easy_async_with_shell("xset dpms 0 0 14400") end },
    { "21600 # 6h", function() awful.spawn.easy_async_with_shell("xset dpms 0 0 21600") end },
}

dunst_menu = {
    { "set-paused",  function() awful.spawn.easy_async_with_shell("sh -c '~/.local/bin/toggle-dunst-notifications'") end },
    { "history-pop", function() awful.spawn.easy_async_with_shell("dunstctl history-pop") end },
}
-- }}}

-- {{{ menu
-- create a launcher widget and a main menu
myawesomemenu = {
    { "show hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    --   { "manual", terminal .. " -e man awesome" },
    { "xset s",           s_menu },
    { "xset dpms",        dpms_menu },
    { "dunstctl",         dunst_menu },
    { "config file",      editor .. " " .. awesome.conffile },
    { "picom config",     function() awful.spawn.easy_async_with_shell("xfce4-terminal -x nvim $HOME/.config/picom.conf") end },
    { "set date & time",  function() awful.spawn.easy_async_with_shell("~/.local/bin/GUI-dateTime") end },
    { "change wallpaper", function() awful.spawn.easy_async_with_shell("sh -c 'nitrogen'") end },
    { "xdg_menu refresh",
        function()
            awful.spawn.easy_async_with_shell(
                "sh -c 'xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu > ~/.config/awesome/xdgmenu.lua'")
        end },
    { "soft-reboot", function() awful.spawn("sh -c 'systemctl soft-reboot'") end },
    { "reboot",      function() awful.spawn("sh -c 'systemctl reboot'") end },
    { "refresh",     awesome.restart },
    --   { "quit", function() awesome.quit() end },
    { "poweroff",    function() awful.spawn("sh -c 'systemctl poweroff'") end },
    { "stagnate",    function() awful.spawn.easy_async_with_shell("sh -c 'systemctl hibernate'") end },
    { "suspend",     function() awful.spawn.easy_async_with_shell("sh -c 'systemctl suspend'") end },
    { "logout",      function() awful.spawn("sh -c 'pkill -9 -u $USER'") end },
    { "lock",        function() awful.spawn.easy_async_with_shell("sh -c 'slock'") end },
}

mymainmenu = awful.menu({
    items = { { "applications", xdgmenu, beautiful.awesome_icon },
        { "system stuff",  myawesomemenu },
        { "open terminal", terminal },
        { "run prompt",    function() awful.screen.focused().mypromptbox:run() end }
    }
})

mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

-- menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
menubar.cache_entries = true
menubar.utils.lookup_icon = function() end
-- }}}

-- keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ wibar
-- create a textclock widget
mytextclock = wibox.widget.textclock(" %m/%d (%a) %H%M ")

-- create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                { raise = true }
            )
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end))

local function set_wallpaper(s)
    -- wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- if wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- wallpaper
    set_wallpaper(s)

    -- each screen has its own tag table.
    awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 " }, s, awful.layout.layouts[1])

    -- create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- create an imagebox widget which will contain an icon indicating which layout we're using.
    -- we need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)))
    -- create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 18 })

    -- add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- middle widget
        {             -- right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ mouse bindings
root.buttons(gears.table.join(
    awful.button({}, 3, function() mymainmenu:toggle() end) --,
--awful.button({ }, 4, awful.tag.viewnext),
--awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ key bindings
globalkeys = gears.table.join(
    awful.key({ modkey, }, "s", hotkeys_popup.show_help,
        { description = "show shortcuts", group = "awesome" }),
    awful.key({ "Control", "Mod1" }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),
    awful.key({ "Control", "Mod1" }, "Right", awful.tag.viewnext,
        { description = "view next", group = "tag" }),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
        { description = "go back", group = "tag" }),
    awful.key({ modkey }, "b",
        function()
            myscreen = awful.screen.focused()
            myscreen.mywibox.visible = not myscreen.mywibox.visible
        end,
        { description = "toggle wibar", group = "awesome" }
    ),

    -- change window focus in maximized layout
    awful.key({ modkey, }, "Tab",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ modkey, "Shift" }, "Tab",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ),

    -- change window focus in maximized layout (alternate keybinds)
    awful.key({ modkey, "Mod1" }, "j",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ modkey, "Mod1" }, "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ),

    -- --------------------------------------------------------------

    awful.key({ modkey, }, "Menu", function() mymainmenu:show() end,
        { description = "show main menu", group = "awesome" }),

    awful.key({ modkey, "Shift" }, "F10", function() mymainmenu:show() end,
        { description = "show main menu", group = "awesome" }),

    -- move window by index in tiling layout
    awful.key({ modkey, "Control" }, "j", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, "Control" }, "k", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),

    -- move window by direction in tiling layout
    awful.key({ modkey, "Control" }, "Down",
        function()
            awful.client.swap.global_bydirection("down")
            client.focus:raise()
        end,
        { description = "swap with next client up", group = "client" }),
    awful.key({ modkey, "Control" }, "Up",
        function()
            awful.client.swap.global_bydirection("up")
            client.focus:raise()
        end,
        { description = "swap with next client down", group = "client" }),
    awful.key({ modkey, "Control" }, "Right",
        function()
            awful.client.swap.global_bydirection("right")
            client.focus:raise()
        end,
        { description = "swap with next client right", group = "client" }),
    awful.key({ modkey, "Control" }, "Left",
        function()
            awful.client.swap.global_bydirection("left")
            client.focus:raise()
        end,
        { description = "swap with next client left", group = "client" }),
    -- additional h,l binds
    -- (in practice, this will work just like the arrow keybinds when pairing
    -- the h,l directional keybinds with j,k "by index" keybinds)
    awful.key({ modkey, "Control" }, "l",
        function()
            awful.client.swap.global_bydirection("right")
            client.focus:raise()
        end,
        { description = "swap with next client right", group = "client" }),
    awful.key({ modkey, "Control" }, "h",
        function()
            awful.client.swap.global_bydirection("left")
            client.focus:raise()
        end,
        { description = "swap with next client left", group = "client" }),

    -- move window focus by direction in tiling layout
    awful.key({ modkey, "Mod1" }, "Down",
        function()
            awful.client.focus.global_bydirection("down")
            client.focus:raise()
        end,
        { description = "focus to next client up", group = "client" }),
    awful.key({ modkey, "Mod1" }, "Up", function()
            awful.client.focus.global_bydirection("up")
            client.focus:raise()
        end,
        { description = "focus to next client down", group = "client" }),
    awful.key({ modkey, "Mod1" }, "Right",
        function()
            awful.client.focus.global_bydirection("right")
            client.focus:raise()
        end,
        { description = "focus to next client right", group = "client" }),
    awful.key({ modkey, "Mod1" }, "Left",
        function()
            awful.client.focus.global_bydirection("left")
            client.focus:raise()
        end,
        { description = "focus to next client left", group = "client" }),
    -- additional h,l binds
    -- (in practice, this will work just like the arrow keybinds when pairing
    -- the h,l directional keybinds with j,k "by index" keybinds)
    awful.key({ modkey, "Mod1" }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            client.focus:raise()
        end,
        { description = "focus to next client right", group = "client" }),
    awful.key({ modkey, "Mod1" }, "h", function()
            awful.client.focus.global_bydirection("left")
            client.focus:raise()
        end,
        { description = "focus to next client left", group = "client" }),

    -- go back to previous focused client
    awful.key({ "Mod1", }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = "go back to previous client", group = "client" }),
    awful.key({ modkey }, "grave",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = "go back to previous client", group = "client" }),

    -- application hotkeys
    -- example:
    -- awful.key({ [KEY], [KEY]}, [KEY], function () awful.spawn("[APPLICATION_NAME]") end,
    --   {description = "open a terminal", group = "launcher"}),

    awful.key({ "Control", "Mod1" }, "t", function() awful.spawn(terminal) end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey, }, "slash", function() awful.spawn("fsearch") end,
        { description = "search the filesystem", group = "launcher" }),
    awful.key({ modkey, }, "e", function() awful.spawn("thunar") end,
        { description = "open a file manager", group = "launcher" }),
    awful.key({}, "Print", function() awful.spawn.easy_async_with_shell("xfce4-screenshooter -f --mouse") end,
        { description = "take a screenshot of the fullscreen", group = "launcher" }),
    awful.key({ modkey }, "Print",
        function() awful.spawn.easy_async_with_shell("xfce4-screenshooter -w --mouse --no-border") end,
        { description = "take a screenshot of the active client", group = "launcher" }),
    awful.key({ "Shift" }, "Print", function() awful.spawn.easy_async_with_shell("xfce4-screenshooter -r --mouse") end,
        { description = "take a screenshot of an area of the screen", group = "launcher" }),
    awful.key({ modkey }, "x", function() awful.spawn.easy_async_with_shell("xkill") end,
        { description = "kill a client by brute force", group = "launcher" }),
    awful.key({ "Control", "Mod1" }, "Delete", function() awful.spawn("xfce4-terminal -T 'Task Manager' -x 'htop'") end,
        { description = "launch HTOP", group = "launcher" }),

    -- brightness hotkeys
    awful.key({}, "XF86MonBrightnessDown", function() awful.spawn.easy_async_with_shell("xbacklight -dec 10") end),
    awful.key({}, "XF86MonBrightnessUp", function() awful.spawn.easy_async_with_shell("xbacklight -inc 10") end),

    -- emoji picker
    awful.key({ modkey }, ".", function() awful.spawn.easy_async_with_shell("~/.local/bin/dmenu-emoji-picker") end,
        { description = "launch emoji chooser", group = "launcher" }),

    -- spell checker (single word)
    awful.key({ modkey }, "comma", function() awful.spawn.easy_async_with_shell("~/.local/bin/dmenu-dym") end,
        { description = "launch single word spell checker", group = "launcher" }),

    -- reset to default display configuration
    awful.key({ modkey, "Shift" }, "o", function() awful.spawn.easy_async_with_shell("~/.local/bin/awesome-xrandr") end,
        { description = "reset to default monitor configuration", group = "launcher" }),

    -- awesome window manager controls
    awful.key({ "Control", "Mod1" }, "BackSpace", awesome.restart,
        { description = "reload awesome", group = "awesome" }),

    -- gui task manager / system monitor
    awful.key({ modkey, "Control" }, "Delete", function() awful.spawn("gnome-system-monitor") end,
        { description = "GTK system monitor", group = "launcher" }),
    awful.key({ "Control", "Shift" }, "Escape", function() awful.spawn("gnome-system-monitor") end,
        { description = "GTK system monitor", group = "launcher" }),

    -- clipboard manager
    awful.key({ modkey }, "v", function() awful.spawn.easy_async_with_shell("xfce4-clipman-history") end,
        { description = "open clipboard history", group = "launcher" }),

    -- on-the-fly window gaps configuration
    awful.key({ modkey }, "'", function() awful.tag.incgap(2) end,
        { description = "increase client gaps", group = "client" }),
    awful.key({ modkey }, ";", function() awful.tag.incgap(-2) end,
        { description = "decrease client gaps", group = "client" }),
    awful.key({ modkey }, "backslash", function() awful.screen.focused().selected_tag.gap = 0 end,
        { description = "reset client gaps", group = "client" }),

    -- launch choose-xrandr-gui
    awful.key({ modkey }, "p", function() awful.spawn.easy_async_with_shell("~/.local/bin/choose-xrandr-gui") end,
        { description = "choose an xrandr gui for display configuration", group = "launcher" }),

    -- toggle dunst notifications
    awful.key({ modkey }, "n",
        function() awful.spawn.easy_async_with_shell("~/.local/bin/toggle-dunst-notifications") end,
        { description = "toggle dunst notifications", group = "launcher" }),

    -- run boomer (requires boomer-git from AUR)
    awful.key({ modkey }, "z", function () awful.spawn.easy_async_with_shell("boomer") end,
      {description = "run boomer (zoomer application for Linux)", group = "launcher"}),

    -- tiled client resizing
    -- h,j,k,l binds
    awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }),
    awful.key({ modkey }, "j", function() awful.client.incwfact(0.05) end,
        { description = "increase master height factor", group = "layout" }),
    awful.key({ modkey }, "k", function() awful.client.incwfact(-0.05) end,
        { description = "decrease master height factor", group = "layout" }),
    -- arrow key binds
    awful.key({ modkey }, "Right", function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey }, "Left", function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }),
    awful.key({ modkey }, "Up", function() awful.client.incwfact(0.05) end,
        { description = "increase master height factor", group = "layout" }),
    awful.key({ modkey }, "Down", function() awful.client.incwfact(-0.05) end,
        { description = "decrease master height factor", group = "layout" }),

    -- client count/columns manipulation
    awful.key({ modkey }, "minus", function() awful.tag.incnmaster(1, nil, true) end,
        { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey }, "equal", function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ modkey }, "[", function() awful.tag.incncol(1, nil, true) end,
        { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey }, "]", function() awful.tag.incncol(-1, nil, true) end,
        { description = "decrease the number of columns", group = "layout" }),
    awful.key({ modkey }, "u", function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }),
    awful.key({ modkey }, "i", function() awful.layout.inc(-1) end,
        { description = "select previous", group = "layout" }),

    awful.key({ modkey, "Shift" }, "m",
        function()
            local c = awful.client.restore()
            -- focus restored client
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", { raise = true }
                )
            end
        end,
        { description = "restore minimized", group = "client" }),

    -- run prompt
    awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
        { description = "run prompt", group = "launcher" }),

    -- run prompt (alternate keybind)
    awful.key({ "Mod1" }, "F2", function() awful.screen.focused().mypromptbox:run() end,
        { description = "run prompt", group = "launcher" }),

    -- lua prompt
    awful.key({ modkey, "Mod1" }, "r",
        function()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        { description = "lua execute prompt", group = "awesome" }),

    -- lua prompt (alternate keybind)
    awful.key({ "Mod1" }, "F3",
        function()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        { description = "lua execute prompt", group = "awesome" }),

    -- menubar
    awful.key({ "Shift" }, "space", function()
            menubar.refresh()
            menubar.show()
        end,
        { description = "show the menubar", group = "launcher" })
)

clientkeys = gears.table.join(
    awful.key({ modkey }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey }, "Return",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }),
    awful.key({ "Mod1" }, "F4", function(c) c:kill() end,
        { description = "close", group = "client" }),
    awful.key({ modkey }, "q", function(c) c:kill() end,
        { description = "close", group = "client" }),
    awful.key({ modkey }, "a", awful.client.floating.toggle,
        { description = "toggle client anchor (floating/tiling)", group = "client" }),

    -- sticky window and always on top toggle
    awful.key({ modkey }, "t", function(c) c.ontop = not c.ontop end,
        { description = "toggle always on top", group = "client" }),
    awful.key({ modkey }, "y", function(c) c.sticky = not c.sticky end,
        { description = "toggle sticky", group = "client" }),


    -- _____________________________________________________________

    awful.key({ modkey }, "Home", function(c) c:swap(awful.client.getmaster()) end,
        { description = "move to master", group = "client" }),
    awful.key({ modkey, }, "o", function(c) c:move_to_screen() end,
        { description = "move to screen", group = "client" }),
    awful.key({ modkey }, "m",
        function(c)
            -- the client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        { description = "minimize", group = "client" }),
    awful.key({ modkey, "Shift" }, "Return",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        { description = "(un)maximize", group = "client" }),
    awful.key({ modkey, "Control" }, "Return",
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        { description = "(un)maximize vertically", group = "client" }),
    awful.key({ modkey, "Mod1" }, "Return",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        { description = "(un)maximize horizontally", group = "client" })
)

-- bind all key numbers to tags.
-- be careful: we use keycodes to make it work on any keyboard layout.
-- this should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- view tag only.
        awful.key({ "Control", "Mod1" }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. i, group = "tag" }),
        -- toggle tag display.
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = "toggle tag #" .. i, group = "tag" }),
        -- move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" }),
        -- move client to prev/next tag and switch to it
        awful.key({ modkey, "Shift" }, "Left",
            function()
                local t = client.focus and client.focus.first_tag or nil
                if t == nil then
                    return
                end

                local tag = client.focus.screen.tags[(t.name - 2) % 9 + 1]
                client.focus:move_to_tag(tag)
                awful.tag.viewprev()
            end,
            { description = "move client to previous tag and switch to it", group = "tag" }),
        awful.key({ modkey, "Shift" }, "Right",
            function()
                local t = client.focus and client.focus.first_tag or nil
                if t == nil then
                    return
                end

                local tag = client.focus.screen.tags[(t.name % 9) + 1]
                client.focus:move_to_tag(tag)
                awful.tag.viewnext()
            end,
            { description = "move client to next tag and switch to it", group = "tag" })
    )
end

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey, "Mod1" }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

-- set keys
root.keys(globalkeys)
-- }}}

-- {{{ rules
-- rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- all clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },

    -- floating clients.
    {
        rule_any = {
            instance = {
                "DTA",   -- firefox addon downthemall.
                "copyq", -- includes session name in class.
                "pinentry",
            },
            class = {
                "Agave",
                "Arandr",
                "Blueman-manager",
                "DateTime.py",
                "Evolution-alarm-notify",
                "Gnome-calculator",
                "Gnome-system-monitor",
                "Gpick",
                "Kruler",
                "Mate-system-monitor",
                "MessageWin",      -- kalarm.
                "Mullvad Browser", -- needs a fixed window size to avoid fingerprinting by screen size.
                "Qalculate-gtk",
                "Steam",
                "Sxiv",
                "Tor Browser", -- same as mullvadbrowser.
                "Wpa_gui",
                "gnome-calculator",
                "gnome-system-monitor",
                "mate-system-monitor",
                "mullvadbrowser",  -- needs a fixed window size to avoid fingerprinting by screen size.
                "qalculate-qt",
                "screengrab",
                "veromix",
                "xtightvncviewer",
                "zoom",
            },
            name = {
                "^Event Tester$",            -- xev.
                "^File Operation Progress$", -- fix for latest version of thunar.
                "^password manager$",
                "^Task Manager$",
            },
            role = {
                "AlarmWindow",   -- thunderbird's calendar.
                "ConfigManager", -- thunderbird's about:config.
                "pop-up",        -- e.g. google chrome's (detached) developer tools.
            }
        },
        properties = { floating = true }
    },
}
-- }}}

-- {{{ signals
-- signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- run garbage collector regularly to prevent memory leaks
gears.timer {
    timeout = 30,
    autostart = true,
    callback = function() collectgarbage() end
}

-- autostart
awful.spawn.easy_async_with_shell("~/.local/bin/awesome-autorun")
