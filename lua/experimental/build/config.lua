local M
M = {
    projects_path = {

    },
    -- script_path = "/home/tech/work_repos/test/VSK_BM_SM_QNX/build.sh",
    -- scripts_path = "/home/tech/.config/nvim_pokemon/scripts/",

    scripts_path = "C:/Users/s.fedotova/AppData/Local/nvim/lua/experimental/scripts/",

    configs = {
        { name = "Make",          opt = "" },
        { name = "Make clean",    opt = "" },
        { name = "QMake x86 qpa", opt = "x86 qpa" },
        { name = "QMake x86 qws", opt = "x86 qws" },
        { name = "QMake ppc qpa", opt = "ppc qpa" },
        { name = "QMake ppc qws", opt = "ppc qws" },
        {}
    },
}
return M
