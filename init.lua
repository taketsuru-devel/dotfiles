-- terminal設定
-- https://qiita.com/rakudalms/items/e7aa4d2d55622a5dd7ab
-- https://sy-base.com/myrobotics/vim/neovim-settings/

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes

-- nerd fontのインストール
-- brew tap caskroom/fonts
-- brew cask install font-hack-nerd-font
-- その後ターミナルのfont設定でHack Nerd Font Regularを選択

-- リーダーキーをスペースに設定
vim.g.mapleader = " "

-- 24ビットカラー（truecolor）を有効化
vim.opt.termguicolors = true

vim.opt.relativenumber = true
vim.opt.number = true
-- vim.opt.statuscolumn = "%s %l %r "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- https://zenn.dev/botamotch/articles/21073d78bc68bf

-- package manager
-- require("packer").startup(function()
require("lazy").setup({
--  use 'wbthomason/packer.nvim'
  'Xuyuanp/scrollbar.nvim',

  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/vim-vsnip",

  "tpope/vim-fugitive",
  "cohama/agit.vim",

  "simeji/winresizer",

  { "nvim-tree/nvim-web-devicons", lazy = false },

  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("lualine").setup {}
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      -- on_attach 関数の定義
      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")
     
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
     
        -- 1. デフォルトのキーバインドをすべて適用
        api.config.mappings.default_on_attach(bufnr)
     
        -- 2. 不要なデフォルトバインドを削除 (v: 垂直分割, x: 水平分割)
        -- これにより v と x が Vim 本来の挙動に戻ります
        -- バインドがなくてもエラーにならないようにpcallを使用
        pcall(vim.keymap.del, 'n', 'v', { buffer = bufnr })
        pcall(vim.keymap.del, 'n', 'x', { buffer = bufnr })
     
        -- 3. 新しいキーバインドを設定
        -- s: 垂直分割 (vertical), i: 水平分割 (horizontal)
        vim.keymap.set('n', 's', api.node.open.vertical,   opts('Open: Vertical Split'))
        vim.keymap.set('n', 'i', api.node.open.horizontal, opts('Open: Horizontal Split'))
        
        -- (任意) t で新しいタブで開く
        vim.keymap.set('n', 't', api.node.open.tab,        opts('Open: New Tab'))
      end

      require("nvim-tree").setup {
        on_attach = my_on_attach,
        git = {
          enable = true,
          ignore = false,
        },
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            }
          }
        },
      }
      vim.cmd([[NvimTreeToggle]])
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },


  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<C-e>",  -- Ctrl+e で補完をクリア（直感的）
          accept_word = "<C-j>",
        },
        ignore_filetypes = { cpp = true },
        color = {
          suggestion_color = "#5f87af",  -- 落ち着いた青色（見やすい）
          cterm = 67,
        },
        debounce = 1000,  -- 1秒（1000ms）待ってから補完を表示
      })
    end,
  },

  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },


  -- use "hrsh7th/cmp-path"
  -- use "hrsh7th/cmp-buffer"
  -- use "hrsh7th/cmp-cmdline"
--end)
})


-- 1. LSP Sever management
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'pyright',     -- Python
    'terraformls', -- Terraform
  },
  handlers = {
    function(server)
      local opt = {
        -- -- Function executed when the LSP server startup
        -- on_attach = function(client, bufnr)
        --   local opts = { noremap=true, silent=true }
        --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
        -- end,
        capabilities = require('cmp_nvim_lsp').default_capabilities(
          vim.lsp.protocol.make_client_capabilities()
        )
      }
      require('lspconfig')[server].setup(opt)
    end,
  },
})

-- info: C-k
-- tab: C-t
-- vertical: C-v
-- horizontal: C-x
vim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", {silent = true, noremap = true})


-- 2. build-in LSP function
-- keyboard shortcut
vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- Reference highlight
vim.cmd [[
set updatetime=500
highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
]]

-- Reference highlight with capability check
vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  group = 'lsp_document_highlight',
  callback = function()
    -- Check if any attached LSP client supports documentHighlight
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    for _, client in ipairs(clients) do
      if client.server_capabilities.documentHighlightProvider then
        vim.lsp.buf.document_highlight()
        return
      end
    end
  end,
})
vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  group = 'lsp_document_highlight',
  callback = function()
    vim.lsp.buf.clear_references()
  end,
})

-- 3. completion (hrsh7th/nvim-cmp)
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    -- { name = "buffer" },
    -- { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})
-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })
-- cmp.setup.cmdline(":", {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = "path" },
--     { name = "cmdline" },
--   },
-- })

-- ターミナルモードからノーマルモードに戻る
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- ターミナルモードで Ctrl-w を使ってウィンドウ移動（Escを押さずに済む）
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { noremap = true, silent = true })

-- ターミナルを開く
vim.keymap.set('n', '<leader>t', '<cmd>split | terminal<cr>', { noremap = true, silent = true })  -- 水平分割でターミナル
vim.keymap.set('n', '<leader>vt', '<cmd>vsplit | terminal<cr>', { noremap = true, silent = true }) -- 垂直分割でターミナル

-- ノーマルモードでカーソル下の単語を:Ggrepで検索
vim.keymap.set('n', '<C-g>', function()
  local word = vim.fn.expand('<cword>')
  vim.cmd('Ggrep ' .. word .. ' * | cw')
end, { noremap = true, silent = true })
