-- windows
local name = "default"
Load_config("windows", name)

local custom_name = "custom"
Load_config("windows", custom_name)

local other_name = "other"
Load_config("windows", other_name)

local custom_place = "custom-place"
if Hypr_run_env == HYPR_RUN_PC_ENV.HOME or Hypr_run_env == HYPR_RUN_PC_ENV.LAPTOP then
    custom_place = "custom-place-home"
end
Load_config("windows", custom_place)
