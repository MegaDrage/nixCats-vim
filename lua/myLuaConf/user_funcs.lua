-- NOTE: [[ CPPMAN ]]
local function CppMan()
    local old_isk = vim.bo.iskeyword
    vim.bo.iskeyword = old_isk .. ",:"
    local str = vim.fn.expand("<cword>")
    vim.bo.iskeyword = old_isk
    vim.cmd("Man " .. str)
end

vim.api.nvim_create_user_command("CppMan", CppMan, {})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp, hpp, cc, tpp, ipp, h",
    callback = function()
        vim.keymap.set("n", "K", ":CppMan<CR>", { buffer = true })
    end,
})
