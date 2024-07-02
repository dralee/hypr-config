### laptop waybar style
use the config-laptop => config
use the style-laptop.css => style.css

#### the icon is too small
https://github.com/Alexays/Waybar/issues/3207

There are different ways, either using the specific selectors on the buttons
``` css
/* .active on hyprland, .focused on sway */
#workspaces button.active label,
#workspaces button.persistent label {
  font-size: 25px;
}
Just on label to make it default to everything

#workspaces label {
  font-size: 25px;
}
Or with pango markups in your config file.

"format-icons": {
      "1": "<span font='25'>1</span>"
      ...
}
```
