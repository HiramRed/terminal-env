-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny


-- to set vim options:
--     example:
--         vim.opt.{option} = {value}
vim.opt.shiftwidth = 4
vim.opt.tabstop = 8
vim.opt.wrap = false
vim.opt.nu = true
vim.opt.guicursor = "n-v-c-sm-i:block-blinkon0,ve:ver20,r-cr-o:hor20"
vim.opt.autoindent = true
vim.opt.scrolloff = 0
vim.opt.ic = true
vim.opt.clipboard = ""  -- disable lvim's access to system clipboard

lvim.builtin.autopairs.active = false
lvim.builtin.bufferline.active = false

-- to modify or ad a keymapping:
lvim.keys.normal_mode["<leader>t"] = ":r ~/template/"
lvim.keys.normal_mode["<C-h>"] = ""
lvim.keys.normal_mode["<C-l>"] = ""
lvim.keys.normal_mode["<C-j>"] = false
lvim.keys.normal_mode["<C-k>"] = false
lvim.keys.normal_mode["<leader>rn"] = ":lua vim.lsp.buf.rename()<cr>"
lvim.keys.normal_mode["[g"] = ":lua vim.diagnostic.goto_prev()<cr>"
lvim.keys.normal_mode["]g"] = ":lua vim.diagnostic.goto_next()<cr>"

lvim.keys.insert_mode["<C-e>"] = "<End>"
lvim.keys.insert_mode["<C-f>"] = "<Right>"
lvim.keys.insert_mode["<C-d>"] = "<Delete>"
lvim.keys.insert_mode["<C-a>"] = "<Home>"
lvim.keys.insert_mode["<C-b>"] = "<Left>"

lvim.keys.term_mode["<C-h>"] = "<Backspace>"
lvim.keys.term_mode["<C-l>"] = ""

local dap = require('dap')
dap.configurations.c = {
    {
        type = 'c';
        request = 'launch';
        name = "Launch c file";
        program = "${file}";
        clangPath = function()
            return '/usr/bin/clang'
        end;
    }
}
