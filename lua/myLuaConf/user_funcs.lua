vim.g.openbrowser_search_engines = vim.tbl_extend(
  "keep",
  vim.g.openbrowser_search_engines or {},
  {
    cppreference = "https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search={query}",
    qt = "https://doc.qt.io/qt-5/search-results.html?q={query}",
    grepapp = "https://grep.app/search?q={query}",
    debcodesearch = "https://codesearch.debian.net/search?q={query}",
  }
)

vim.g.openbrowser_browser_commands = {
  {
    name = "w3m",
    args = { "{browser}", "{uri}" }
  }
}

local function search_with_engine(engine, query)
  query = query or vim.fn.expand("<cword>")
  local url = vim.g.openbrowser_search_engines[engine]
  if not url then
    vim.notify("Search'" .. engine .. "' not found!", vim.log.levels.ERROR)
    return
  end
  url = url:gsub("{query}", vim.fn.escape(query, ":/"))
  vim.fn["openbrowser#smart_search"](url)
end

vim.api.nvim_set_keymap("n", "<leader>osx", "", {
  noremap = true,
  silent = true,
  callback = function()
    search_with_engine("cppreference")
  end,
})

vim.api.nvim_set_keymap("n", "<leader>osq", "", {
  noremap = true,
  silent = true,
  callback = function()
    search_with_engine("qt")
  end,
})

vim.api.nvim_set_keymap("n", "<leader>osg", "", {
  noremap = true,
  silent = true,
  callback = function()
    search_with_engine("grepapp")
  end,
})

vim.api.nvim_set_keymap("n", "<leader>osd", "", {
  noremap = true,
  silent = true,
  callback = function()
    search_with_engine("debcodesearch")
  end,
})
