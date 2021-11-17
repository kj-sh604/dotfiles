-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
-- local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
xdg_menu = require("xdgmenu")
menubar.cache_entries = true

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_configuration_dir() .. "/themes/default/theme.lua")
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "vide")
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "qterminal"
editor = os.getenv("EDITOR") or "gedit"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max,
-- awful.layout.suit.fair,
-- awful.layout.suit.tile.left,
-- awful.layout.suit.tile.bottom,
-- awful.layout.suit.tile.top,
-- awful.layout.suit.fair.horizontal,
-- awful.layout.suit.spiral,
-- awful.layout.suit.spiral.dwindle,
-- awful.layout.suit.max.fullscreen,
-- awful.layout.suit.magnifier,
-- awful.layout.suit.corner.nw,
-- awful.layout.suit.corner.ne,
-- awful.layout.suit.corner.sw,
-- awful.layout.suit.corner.se,
-- awful.layout.suit.floating,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
  { "show hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  --   { "manual", terminal .. " -e man awesome" },
  { "config file", editor .. " " .. awesome.conffile },
  { "picom config", function() awful.spawn.easy_async_with_shell("sh -c 'gedit $HOME/.config/picom.conf'") end },
  { "change wallpaper", function() awful.spawn.easy_async_with_shell("sh -c 'nitrogen'") end },
  { "xdg_menu refresh", function() awful.spawn.easy_async_with_shell("sh -c 'xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu > ~/.config/awesome/xdgmenu.lua'") end, },
  { "refresh", awesome.restart },
  { "reboot" , function() awful.spawn("sh -c 'gksudo reboot now'") end },
  --   { "quit", function() awesome.quit() end },
  { "shutdown", function() awful.spawn("sh -c 'gksudo shutdown now'") end},
  { "suspend", function() awful.spawn.easy_async_with_shell("sh -c 'systemctl suspend'") end},
  { "logout", function () awful.spawn("sh -c 'pkill -9 -u $USER'") end },
  { "lock", function() awful.spawn.easy_async_with_shell("sh -c 'xflock4'") end},
}

mymainmenu = awful.menu({ items = { { "applications", xdgmenu, beautiful.awesome_icon },
  { "system stuff", myawesomemenu },
  { "open terminal", terminal },
  { "run prompt", function () awful.screen.focused().mypromptbox:run() end}
}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
  menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock(" %m/%d (%a) %H%M ")

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        {raise = true}
      )
    end
  end),
  awful.button({ }, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({ }, 4, function ()
    awful.client.focus.byidx(1)
  end),
  awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)
  end))

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      mylauncher,
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      mykeyboardlayout,
      wibox.widget.systray(),
      mytextclock,
      s.mylayoutbox,
    },
  }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
  awful.button({ }, 3, function () mymainmenu:toggle() end) --,
--awful.button({ }, 4, awful.tag.viewnext),
--awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
  awful.key({ modkey,           }, "h",      hotkeys_popup.show_help,
    {description="show help", group="awesome"}),
  awful.key({ "Control", "Mod1"           }, "Left",   awful.tag.viewprev,
    {description = "view previous", group = "tag"}),
  awful.key({ "Control", "Mod1"           }, "Right",  awful.tag.viewnext,
    {description = "view next", group = "tag"}),
  awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
    {description = "go back", group = "tag"}),

  -- Change window focus in maximized layout
  awful.key({ modkey,           }, "Tab",
    function ()
      awful.client.focus.byidx( 1)
    end,
    {description = "focus next by index", group = "client"}
  ),
  awful.key({ modkey, "Shift"           }, "Tab",
    function ()
      awful.client.focus.byidx(-1)
    end,
    {description = "focus previous by index", group = "client"}
  ),

  -- --------------------------------------------------------------

  awful.key({ modkey,           }, "Menu", function () mymainmenu:show() end,
    {description = "show main menu", group = "awesome"}),

  -- Old Layout manipulation
  --[[awful.key({ modkey,  "Control" }, "Down", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey,   "Control"}, "Up", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),]]--

  -- Move window by direction in tiling layout
  awful.key({ modkey, "Control" }, "Down", function (c) awful.client.swap.global_bydirection("down") c:raise() end,
    {description = "swap with next window up", group = "client"}),
  awful.key({ modkey, "Control" }, "Up", function (c) awful.client.swap.global_bydirection("up") c:raise() end,
    {description = "swap with next window down", group = "client"}),
  awful.key({ modkey, "Control" }, "Right", function (c) awful.client.swap.global_bydirection("right") c:raise() end,
    {description = "swap with next window right", group = "client"}),
  awful.key({ modkey, "Control" }, "Left", function (c) awful.client.swap.global_bydirection("left") c:raise() end,
    {description = "swap with next window left", group = "client"}),

  -- Move window FOCUS by direction in tiling layout
  awful.key({ modkey, "Mod1" }, "Down", function (c) awful.client.focus.global_bydirection("down") c:lower() end,
    {description = "focus to next window up", group = "client"}),
  awful.key({ modkey, "Mod1" }, "Up", function (c) awful.client.focus.global_bydirection("up") c:lower() end,
    {description = "focus to next window down", group = "client"}),
  awful.key({ modkey, "Mod1" }, "Right", function (c) awful.client.focus.global_bydirection("right") c:lower() end,
    {description = "focus to next window right", group = "client"}),
  awful.key({ modkey, "Mod1" }, "Left", function (c) awful.client.focus.global_bydirection("left") c:lower() end,
    {description = "focus to next window left", group = "client"}),

  -- Alt-Tab functionality in maximized layout
  awful.key({ "Mod1",           }, "Tab",
    function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    {description = "go back", group = "client"}),
  -- Application Hotkeys
  --[[ Template
      awful.key({ [KEY], [KEY]          }, [KEY], function () awful.spawn("[APPLICATION_NAME]") end,
                {description = "open a terminal", group = "launcher"}),
      ]]--
  awful.key({ "Control", "Mod1"          }, "t", function () awful.spawn(terminal) end,
    {description = "open a terminal", group = "launcher"}),
  awful.key({ modkey,          }, "s", function () awful.spawn("fsearch") end,
    {description = "search the filesystem", group = "launcher"}),
  awful.key({ modkey,          }, "e", function () awful.spawn("thunar") end,
    {description = "open a file manager", group = "launcher"}),
  awful.key({          }, "Print", function () awful.spawn.easy_async_with_shell("xfce4-screenshooter -f --mouse") end,
    {description = "take a screenshot of the fullscreen", group = "launcher"}),
  awful.key({ modkey         }, "Print", function () awful.spawn.easy_async_with_shell("xfce4-screenshooter -w --mouse") end,
    {description = "take a screenshot of the active window", group = "launcher"}),
  awful.key({ "Shift"          }, "Print", function () awful.spawn.easy_async_with_shell("xfce4-screenshooter -r --mouse") end,
    {description = "take a screenshot of an area of the screen", group = "launcher"}),
  awful.key({ "Shift", "Control"          }, "x", function () awful.spawn.easy_async_with_shell("xkill") end,
    {description = "kill a window by brute force", group = "launcher"}),
  awful.key({ "Control", "Mod1"          }, "Delete", function () awful.spawn("qterminal -e 'htop' --title 'Task Manager'") end,
    {description = "Launch HTOP", group = "launcher"}),

  -- Brightness Hotkeys
  awful.key({ }, "XF86MonBrightnessDown", function () awful.spawn.easy_async_with_shell("xbacklight -dec 15") end),
  awful.key({ }, "XF86MonBrightnessUp", function () awful.spawn.easy_async_with_shell("xbacklight -inc 15") end),

  -- Emoji Picker
  awful.key({ modkey }, "q", function () awful.spawn.easy_async_with_shell("sh -c '/home/kylert/.local/share/Blista-Kanjo-Emoji/blista-emoji-picker'") end,
    {description = "Launch Emoji Chooser", group = "launcher"}),

  -- Clipboard Manager
  awful.key({ modkey }, "grave", function () awful.spawn.easy_async_with_shell("xfce4-clipman-history") end,
                {description = "open clipboard history", group = "launcher"}),

  -- awesome window manager Controls
  awful.key({ "Control", "Mod1" }, "BackSpace", awesome.restart,
    {description = "reload awesome", group = "awesome"}),
  --[[awful.key({ "Control", "Shift"   }, "Delete", awesome.quit
              {description = "quit awesome", group = "awesome"}),]]--

  --[[    awful.key({ "Control", "Mod1"          }, "BackSpace", function () awful.spawn("sh -c 'pkill -9 -u $USER'") end,
              {description = "quit awesome", group = "launcher"}), ]]--

  awful.key({ "Control", "Shift"          }, "Delete", function () awful.spawn("gnome-system-monitor") end,
    {description = "gnome-system-monitor", group = "launcher"}),



  -- Tiled Window Sizing and Client count/columns

  awful.key({ modkey }, "Right",     function () awful.tag.incmwfact( 0.05)          end,
    {description = "increase master width factor", group = "layout"}),
  awful.key({ modkey }, "Left",     function () awful.tag.incmwfact(-0.05)          end,
    {description = "decrease master width factor", group = "layout"}),

  awful.key({ modkey }, "Up",     function () awful.client.incwfact( 0.05)          end,
    {description = "increase master height factor", group = "layout"}),
  awful.key({ modkey }, "Down",     function () awful.client.incwfact(-0.05)          end,
    {description = "decrease master height factor", group = "layout"}),


  awful.key({ modkey }, "minus",     function () awful.tag.incnmaster( 1, nil, true) end,
    {description = "increase the number of master clients", group = "layout"}),
  awful.key({ modkey }, "equal",     function () awful.tag.incnmaster(-1, nil, true) end,
    {description = "decrease the number of master clients", group = "layout"}),
  awful.key({ modkey }, "[",     function () awful.tag.incncol( 1, nil, true)    end,
    {description = "increase the number of columns", group = "layout"}),
  awful.key({ modkey }, "]",     function () awful.tag.incncol(-1, nil, true)    end,
    {description = "decrease the number of columns", group = "layout"}),
  awful.key({ modkey }, "j", function () awful.layout.inc( 1)                end,
    {description = "select next", group = "layout"}),
  awful.key({ modkey }, "k", function () awful.layout.inc(-1)                end,
    {description = "select previous", group = "layout"}),

  awful.key({ modkey }, ",",
    function ()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal(
          "request::activate", "key.unminimize", {raise = true}
        )
      end
    end,
    {description = "restore minimized", group = "client"}),

  -- Prompt
  awful.key({ "Mod1" },            "F2",     function () awful.screen.focused().mypromptbox:run() end,
    {description = "run prompt", group = "launcher"}),

  awful.key({ modkey }, "x",
    function ()
      awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    {description = "lua execute prompt", group = "awesome"}),
  -- Menubar
  awful.key({ "Shift" }, "space", function() menubar.refresh() menubar.show() end,
    {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
  awful.key({ modkey,           }, "f",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}),
  awful.key({ "Mod1" }, "F4",      function (c) c:kill() end,
    {description = "close", group = "client"}),
  awful.key({ "Shift", "Control" }, "space",  awful.client.floating.toggle,
    {description = "toggle floating", group = "client"}),

  -- Sticky Window and Always on top toggle
  awful.key({ modkey }, ".", function(c) c.ontop = not c.ontop end,
    {description = "toggle always on top", group = "client"}),
  awful.key({ modkey }, "slash",   function (c) c.sticky = not c.sticky  end,
    {description = "toggle sticky", group = "client"}),

  -- Original Keep On Top Function

  --[[awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),]]--

  -- End Original Function

  -- _____________________________________________________________

  awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
    {description = "move to master", group = "client"}),
  awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
    {description = "move to screen", group = "client"}),
  awful.key({ modkey }, "m",
    function (c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end ,
    {description = "minimize", group = "client"}),
  awful.key({ modkey }, "Return",
    function (c)
      c.maximized = not c.maximized
      c:raise()
    end ,
    {description = "(un)maximize", group = "client"}),
  awful.key({ modkey, "Control" }, "Return",
    function (c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end ,
    {description = "(un)maximize vertically", group = "client"}),
  awful.key({ modkey, "Mod1"   }, "Return",
    function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end ,
    {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ "Control", "Mod1" }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      {description = "view tag #"..i, group = "tag"}),
    -- Toggle tag display.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      {description = "move focused client to tag #"..i, group = "tag"}),
    -- Move client to prev/next tag and switch to it
    awful.key({ modkey, "Shift" }, "Left",
      function ()
        -- get current tag
        local t = client.focus and client.focus.first_tag or nil
        if t == nil then
          return
        end
        -- get previous tag (modulo 9 excluding 0 to wrap from 1 to 9)
        local tag = client.focus.screen.tags[(t.name - 2) % 9 + 1]
        awful.client.movetotag(tag)
        awful.tag.viewprev()
      end,
      {description = "move client to previous tag and switch to it", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Right",
      function ()
        -- get current tag
        local t = client.focus and client.focus.first_tag or nil
        if t == nil then
          return
        end
        -- get next tag (modulo 9 excluding 0 to wrap from 9 to 1)
        local tag = client.focus.screen.tags[(t.name % 9) + 1]
        awful.client.movetotag(tag)
        awful.tag.viewnext()
      end,
      {description = "move client to next tag and switch to it", group = "tag"})

  --[[        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"}) ]]--
  )
end

clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ modkey }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ "Mod1" }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = { border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  { rule_any = {
    instance = {
      "DTA",  -- Firefox addon DownThemAll.
      "copyq",  -- Includes session name in class.
      "pinentry",
    },
    class = {
      "Arandr",
      "Blueman-manager",
      "Gpick",
      "Gnome-calculator",
      "Kruler",
      "MessageWin",  -- kalarm.
      "Sxiv",
      "Steam",
      "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
      "Wpa_gui",
      "veromix",
      "xtightvncviewer",
      "zoom"},

    -- Note that the name property shown in xprop might be set slightly after creation of the client
    -- and the name shown there might not match defined rules here.
    name = {
      "Event Tester",  -- xev.
      "Task Manager"
    },
    role = {
      "AlarmWindow",  -- Thunderbird's calendar.
      "ConfigManager",  -- Thunderbird's about:config.
      "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
    }
  }, properties = { floating = true }},

--[[ Add titlebars to normal clients and dialogs
{ rule_any = {type = { "normal", "dialog" }
}, properties = { titlebars_enabled = true }
}, ]]--

-- Set Firefox to always map on the tag named "2" on screen 1.
-- { rule = { class = "Firefox" },
--   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
--[[client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end) ]]--

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Gaps
beautiful.useless_gap = 5

-- Run garbage collector regularly to prevent memory leaks
gears.timer {
  timeout = 30,
  autostart = true,
  callback = function() collectgarbage() end
}


-- Autostart

-- awful.spawn.with_shell("")
-- awful.spawn.easy_async_with_shell("")
awful.spawn("/home/kylert/.config/awesome/autorun.sh")
