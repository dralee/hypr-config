-- the environments for work run environment

-- GT710
hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")
hl.env("WLR_DRM_NO_ATOMIC", "1")
hl.env("AQ_DRM_DEVICES", "/dev/dri/card0")
