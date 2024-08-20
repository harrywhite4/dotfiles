-- Load vimrc
vim.cmd [[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc
]]

-- Faster cursorhold time
vim.opt.updatetime = 300

-- Diagnostic Mappings
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- LSP setup
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- This is on by default, may want to turn it off in future
  vim.diagnostic.config({
    virtual_text = true
  })

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>]', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>ld', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders))
  end, bufopts)
  vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, bufopts)
  -- This needs to be updated as buf.formatting is deprecated
  -- vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting, bufopts)


  -- Print diagnostics to message area
  -- Adapted from https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
  local cleared = true
  function PrintDiagnostics(opts, bufnr, line_nr, client_id)
    opts = opts or {}
  
    bufnr = bufnr or 0
    line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
  
    local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
    if vim.tbl_isempty(line_diagnostics) then 
        if not cleared then
            vim.api.nvim_echo({{"", "Error"}}, false, {})
            cleared = true
        end
        return
    end
  
    -- Echo the first error
    local diagnostic = line_diagnostics[1]
    if diagnostic ~= nil then
        vim.api.nvim_echo({{string.format("Diagnostic: %s", diagnostic.message or ""), "Error"}}, false, {})
        cleared = false
    end
  end
  
  -- Disabled for now as doesn't work well with long diagnostic messages
  -- vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'gopls', 'hls', 'pyright' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- Auto format go files on save
vim.cmd [[ autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync() ]]

-- Turn off neomake for languages we use lsp's for
vim.g.neomake_c_enabled_makers = {}
vim.g.neomake_go_enabled_makers = {}
vim.g.neomake_haskell_enabled_makers = {}
vim.g.neomake_python_enabled_makers = {}
