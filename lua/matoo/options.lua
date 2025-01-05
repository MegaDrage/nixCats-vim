-- enable relative line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- ensure tabs are always 4 spaces wide, and are actually tabs instead of spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = false

-- disable wrap by default, but if wrap is manually enabled, break between words
vim.opt.wrap = false
vim.opt.linebreak = true

-- ignore capitalization when searching etc, unless specified
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- automatically handle indentation
vim.opt.autoindent = true
vim.opt.smartindent = true

-- folding
vim.opt.foldcolumn = "0"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- dont show insert/visual/etc mode, deferred to status bar plugin
vim.opt.showmode = false

-- thin cursor in insert, block otherwise, and make it blink
vim.opt.guicursor = "n-v-r:block,i:ver25,a:blinkwait700-blinkoff400-blinkon250"

-- disable automatic backups, instead give undotree more access
vim.opt.swapfile = false
vim.opt.backup = false
-- this needs to be adjusted for NixOS
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- disable search highlighting (subject to change) and enable incremental search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- enable colors in the TUI and pull them from terminal if possible
vim.opt.termguicolors = true

-- minimum cursor distance to top/bottom when scrolling (unless BOF/EOF)
vim.opt.scrolloff = 15

-- always show sign column
vim.opt.signcolumn = "yes"

-- show bar at n chars to indicate long lines
vim.opt.colorcolumn = "81"

-- enable @ in file names
vim.opt.isfname:append("@-@")

-- fast updatetime
vim.opt.updatetime = 50

-- higher concealevel for obsidian, typst, etc.
vim.opt.conceallevel = 2
