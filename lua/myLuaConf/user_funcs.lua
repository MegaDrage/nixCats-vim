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

-- function ExtractMethodsWithLSP()
--     -- Получаем текущий буфер и позицию курсора
--     local buf = vim.api.nvim_get_current_buf()
--     local pos = vim.api.nvim_win_get_cursor(0)
--     local row, col = pos[1] - 1, pos[2] -- LSP использует 0-based индексы
--
--     -- Запрашиваем LSP для получения информации о символе под курсором
--     local params = {
--         textDocument = vim.lsp.util.make_text_document_params(),
--         position = { line = row, character = col },
--     }
--
--     -- Используем LSP для поиска символа (например, класса)
--     vim.lsp.buf_request(buf, 'textDocument/documentSymbol', params, function(err, result, ctx)
--         if err then
--             vim.notify("LSP error: " .. err.message, vim.log.levels.ERROR)
--             return
--         end
--
--         if not result or #result == 0 then
--             vim.notify("No symbols found.", vim.log.levels.WARN)
--             return
--         end
--
--         -- Ищем класс под курсором
--         local class_symbol = nil
--         for _, symbol in ipairs(result) do
--             if symbol.kind == vim.lsp.protocol.SymbolKind.Class then
--                 class_symbol = symbol
--                 break
--             end
--         end
--
--         if not class_symbol then
--             vim.notify("No class found under cursor.", vim.log.levels.WARN)
--             return
--         end
--
--         -- Получаем имя класса
--         local class_name = class_symbol.name
--
--         -- Ищем методы внутри класса
--         local methods = {}
--         for _, symbol in ipairs(result) do
--             if symbol.kind == vim.lsp.protocol.SymbolKind.Method and
--                symbol.containerName == class_name then
--                 -- Получаем сигнатуру метода
--                 local method_text = symbol.name
--
--                 -- Добавляем имя класса и `::`
--                 if symbol.name == class_name then
--                     -- Конструктор
--                     method_text = class_name .. "::" .. method_text
--                 elseif symbol.name == "~" .. class_name then
--                     -- Деструктор
--                     method_text = class_name .. "::" .. method_text
--                 else
--                     -- Обычный метод
--                     method_text = class_name .. "::" .. method_text
--                 end
--
--                 -- Добавляем шаблонные параметры, если они есть
--                 if symbol.detail then
--                     method_text = symbol.detail .. " " .. method_text
--                 end
--
--                 table.insert(methods, method_text .. ";")
--             end
--         end
--
--         if #methods == 0 then
--             vim.notify("No methods found in class " .. class_name, vim.log.levels.WARN)
--             return
--         end
--
--         -- Формируем результат
--         local result_text = "// Methods of class " .. class_name .. "\n"
--         for _, method in ipairs(methods) do
--             result_text = result_text .. method .. "\n"
--         end
--
--         -- Создаем новый буфер и вставляем результат
--         local new_buf = vim.api.nvim_create_buf(true, false)
--         vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, vim.split(result_text, "\n"))
--         vim.api.nvim_command("vsplit")
--         vim.api.nvim_win_set_buf(0, new_buf)
--     end)
-- end
--
-- -- Привязываем функцию к команде Neovim
-- vim.api.nvim_create_user_command("ExtractMethodsWithLSP", ExtractMethodsWithLSP, {})
