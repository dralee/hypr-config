-- other window rules

-- 其他规则配置
-- Enable blur for waybar
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })

-- Named layer rule
local selectionRule = hl.layer_rule({
  name      = "no-anim-for-selection",
  match     = { namespace = "selection" },
  no_anim   = true,
})

-- Enable blur and ignore_alpha for rofi
hl.layer_rule({
  match        = { namespace = "rofi" },
  blur         = true,
  ignore_alpha = 0.5,
})


-- 让通知层支持模糊
local myLayerRule = hl.layer_rule({
	name = "notifications",
	blur= true,
	blur_popups = true,
	animation= "slide",
	match = { namespace = "notifications" }
})

--myLayerRule:set_enabled(true)