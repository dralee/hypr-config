-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/
-- 2026.5.28 by dralee


------------------
---- Custom Functions ----
------------------
require("functions")

------------------
---- MONITORS ----
------------------
require("conf.monitor")

-----------------------
---- ENVIRONMENT ----
-----------------------
require("conf.environment")

-----------------------
---- DECORATIONS ----
-----------------------
require("conf.decoration")

-----------------------
---- ANIMATIONS ----
-----------------------
require("conf.animation")

-----------------------
---- LAYOUTS ----
-----------------------
require("conf.input")

-----------------------
--- LAYOUTS ----
-----------------------
require("conf.layout")

-----------------------
---- MISC ----
-----------------------
require("conf.misc")

-----------------------
---- KEYBINDINGS ----
-----------------------
require("conf.keybinding")

-----------------------
---- GESTURES DEVICE----
-----------------------
require("conf.gesture_device")

-----------------------
---- WORKSPACES ----
-----------------------
require("conf.workspace")

-----------------------
---- WINDOW ----
require("conf.window")

-----------------------
---- AUTORUN ----
-----------------------
require("conf.autorun")
