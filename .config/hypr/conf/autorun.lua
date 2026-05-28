-- auto run app
local name = "default"
Load_config("autoruns", name)


if Hypr_run_env == HYPR_RUN_PC_ENV.WORK then
    name = "work"
    Load_config("autoruns", name)
end