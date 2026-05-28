-- monitors
local name = "default"
if Hypr_run_env == HYPR_RUN_PC_ENV.HOME then
    name = "home"
elseif Hypr_run_env == HYPR_RUN_PC_ENV.LAPTOP then
    name = "laptop"
end

Load_config("monitors", name)