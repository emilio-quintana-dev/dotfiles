--  ____ ____ ____ ____ ____ ____ ____ ____
-- ||s |||e |||t |||t |||i |||n |||g |||s ||
-- ||__|||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|


vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.termguicolors = true
vim.opt.background = "dark"
vim.opt.spellfile = os.getenv("HOME") .. "/.vim-spell-en.utf-8.add"
vim.g.is_posix = 1    -- When the type of shell script is /bin/sh, assume a POSIX-compatible shell for syntax highlighting purposes.
vim.g.mapleader = " " -- Set Leader key to <Space> bar
vim.g.python3_host_prog = (vim.env.HOME .. "/.asdf/shims/python")
vim.o.autowriteall = true
vim.o.backspace = "2"           -- Backspace deletes like most programs in insert mode
vim.o.backup = false            -- Don't make a backup before overwriting a file
vim.o.backupcopy = "yes"
vim.o.clipboard = "unnamedplus" -- copy paste to system clipboard
vim.o.expandtab = true          -- Use the appropriate number of spaces to insert a <Tab>.
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵]]
vim.o.foldcolumn = "0"
vim.o.foldenable = false
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.formatprg = "fmt"
vim.o.gdefault = true -- Replace all matches on a line instead of just the first
vim.o.grepformat = "%f:%l:%c:%m"
vim.o.grepprg = "rg --vimgrep --no-heading --smart-case --column --with-filename --line-number"
vim.o.ignorecase = true    -- case insensitive pattern matching
vim.o.inccommand = "split" -- this is necessary for using this %s with a quickfix window in nvim
vim.o.joinspaces = false   -- Insert one space after a '.', '?' and '!' with a join command.
vim.o.matchtime = 0        -- Speed up escape after (){} chars
vim.o.pumheight = 10       -- limit size of popup menu
vim.o.pumblend = 20
vim.o.scrolloff = 3        -- show 3 lines above and below cursor
vim.o.shiftround = true    -- Round indent to multiple of 'shiftwidth'.
vim.o.shiftwidth = 2       -- Returns the effective value of 'shiftwidth'
vim.o.showmode = false     -- If in Insert, Replace or Visual mode don't put a message on the last line.
vim.o.showtabline = 0
vim.o.smartcase = true     -- overrides ignorecase if pattern contains upcase
vim.o.spelllang = "en_us"  -- Set region to US English
vim.o.splitbelow = true    -- When on, splitting a window will put the new window below the current one.
vim.o.splitright = true    -- When on, splitting a window will put the new window right of the current one.
vim.o.swapfile = false     -- Do not create a swapfile for a new buffer.
vim.o.synmaxcol = 200
vim.o.tabstop = 2          -- Number of spaces that a <Tab> in the file counts for.
vim.o.textwidth = 120      -- Maximum width of text that is being inserted. A longer line will be broken after white space to get this width.
vim.o.undofile = true      -- Automatically saves undo history to an undo file when writing a buffer to a file, and restores undo history from the same file on buffer read.
vim.o.undolevels = 500
vim.o.undoreload = 500
vim.o.updatetime = 100
vim.o.wildignore = "tmp/**"            -- Ignore stuff that can't be opened
vim.o.wildmode = "list:longest,list:full"
vim.o.writebackup = false              -- Don't make a backup before overwriting a file.
vim.opt.colorcolumn = "+1"             -- highlight column after 'textwidth
vim.opt.diffopt:append({ "vertical" }) -- Start diff mode with vertical splits
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.path:append({ ".,,", "node_modules" })
vim.opt.shortmess = "fxtToOFc" -- vim default with 'c' appended (don't give |ins-completion-menu| messages)
vim.wo.cursorline = false
vim.wo.number = true           -- Turn on line numbers
vim.wo.numberwidth = 1         -- Minimal number of columns to use for the line number.
vim.wo.signcolumn = "yes"      -- Leave signcolumn enabled otherwise it's a little jarring
vim.wo.wrap = false            -- Don't wrap lines longer than the width of the window
vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

--  ____ ____ ____ ____ ____ ____ ____
-- ||p |||l |||u |||g |||i |||n |||s ||
-- ||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\|

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- === colorscheme(s) ===
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme catppuccin')
    end
  },
  -- === completion ===
  {
    "https://github.com/ms-jpq/coq_nvim.git",
  },
  {
    "https://github.com/neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true }),
      vim.keymap.set("n", "ge", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true }),
      vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true }),
    },
    dependencies = {
      "https://github.com/folke/neodev.nvim",
      "https://github.com/williamboman/mason.nvim",
      "https://github.com/williamboman/mason-lspconfig.nvim",
      "https://github.com/hrsh7th/cmp-nvim-lsp",
    },
  },
  {
    "https://github.com/williamboman/mason.nvim",
    build = ":MasonUpdate",
    dependencies = {
      "https://github.com/williamboman/mason-lspconfig.nvim",
      config = function()
        require("neodev").setup()
        require("mason").setup()

        local mason_lspconfig = require("mason-lspconfig")
        local lsp = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local coq = require 'coq'

        mason_lspconfig.setup({
          ensure_installed = {
            "astro",
            "bashls",
            "codeqlls",
            "cssls",
            "cssmodules_ls",
            "dockerls",
            "docker_compose_language_service",
            "eslint",
            "graphql",
            "html",
            "jsonls",
            "marksman",
            "prismals",
            "pyright",
            "rust_analyzer",
            "solargraph",
            "sqlls",
            "stylelint_lsp",
            "lua_ls",
            "tailwindcss",
            "terraformls",
            "tflint",
            "tsserver",
            "yamlls",
          },
          automatic_installation = true,
        })

        mason_lspconfig.setup_handlers({
          lsp.astro.setup({ capabilities = capabilities }),
          lsp.bashls.setup({ capabilities = capabilities }),
          lsp.codeqlls.setup({ capabilities = capabilities }),
          lsp.cssls.setup({ capabilities = capabilities }),
          lsp.cssmodules_ls.setup({ capabilities = capabilities }),
          lsp.dockerls.setup({ capabilities = capabilities }),
          lsp.docker_compose_language_service.setup({ capabilities = capabilities }),
          lsp.eslint.setup({ capabilities = capabilities }),
          lsp.graphql.setup({ capabilities = capabilities }),
          lsp.html.setup({ capabilities = capabilities }),
          lsp.jsonls.setup({ capabilities = capabilities }),

          lsp.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                },
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                telemetry = {
                  enable = false,
                },
              },
            },
          }),

          lsp.marksman.setup({ capabilities = capabilities }),
          lsp.prismals.setup({ capabilities = capabilities }),
          lsp.pyright.setup({ capabilities = capabilities }),
          lsp.rust_analyzer.setup({ capabilities = capabilities }),
          lsp.solargraph.setup({ capabilities = capabilities }),
          lsp.sqlls.setup({ capabilities = capabilities }),
          lsp.stylelint_lsp.setup({ capabilities = capabilities }),
          lsp.tailwindcss.setup({ capabilities = capabilities }),
          lsp.terraformls.setup({ capabilities = capabilities }),
          lsp.tflint.setup({ capabilities = capabilities }),
          lsp.tsserver.setup({ capabilities = capabilities }),
          lsp.yamlls.setup({ capabilities = capabilities }),
          lsp.diagnosticls.setup(coq.lsp_ensure_capabilities {
            filetypes = {
              'javascript',
              'javascriptreact',
              'python',
              'ruby',
              'sh',
              'typescript',
              'typescriptreact',
            },
            init_options = {
              linters = {
                eslint = {
                  command = 'eslint_d',
                  rootPatterns = { '.git' },
                  debounce = 100,
                  args = {
                    '--cache',
                    '--stdin',
                    '--stdin-filename',
                    '%filepath',
                    '--format',
                    'json'
                  },
                  sourceName = 'eslint',
                  parseJson = {
                    errorsRoot = '[0].messages',
                    line = 'line',
                    column = 'column',
                    endLine = 'endLine',
                    endColumn = 'endColumn',
                    message = '[eslint] ${message} [${ruleId}]',
                    security = 'severity'
                  },
                  securities = {
                    [2] = 'error',
                    [1] = 'warning'
                  }
                },
                flake8 = {
                  command = 'flake8',
                  debounce = 100,
                  args = { '--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s, -' },
                  offsetLine = 0,
                  offsetColumn = 0,
                  sourceName = 'flake8',
                  formatLines = 1,
                  formatPattern = {
                    '(\\d+),(\\d+),([A-Z]),(.*)(\\r|\\n)*$',
                    {
                      line = 1,
                      column = 2,
                      security = 3,
                      message = 4
                    }
                  },
                  securities = {
                    W = 'warning',
                    E = 'error',
                    F = 'error',
                    C = 'error',
                    N = 'error',
                  }
                },
                pylint = {
                  sourceName = 'pylint',
                  command = 'pylint',
                  args = {
                    '--output-format',
                    'text',
                    '--score',
                    'no',
                    '--msg-template',
                    '"{line}:{column}:{category}:{msg} ({msg_id}:{symbol})"',
                    '%file'
                  },
                  formatPattern = {
                    '^(\\d+?):(\\d+?):([a-z]+?):(.*)$',
                    {
                      line = 1,
                      column = 2,
                      security = 3,
                      message = 4
                    }
                  },
                  rootPatterns = { '.git', 'pyproject.toml', 'setup.py' },
                  securities = {
                    informational = 'hint',
                    refactor = 'info',
                    convention = 'info',
                    warning = 'warning',
                    error = 'error',
                    fatal = 'error'
                  },
                  offsetColumn = 1,
                  formatLines = 1
                },
                rubocop = {
                  command = 'bundle',
                  sourceName = 'rubocop',
                  rootPatterns = { '.git' },
                  debounce = 100,
                  args = {
                    'exec',
                    'rubocop',
                    '--format',
                    'json',
                    '--force-exclusion',
                    '--stdin',
                    '%filepath'
                  },
                  parseJson = {
                    errorsRoot = 'files[0].offenses',
                    line = 'location.start_line',
                    endLine = 'location.last_line',
                    column = 'location.start_column',
                    endColumn = 'location.end_column',
                    message = '[${cop_name}] ${message}',
                    security = 'severity'
                  },
                  securities = {
                    fatal = 'error',
                    error = 'error',
                    warning = 'warning',
                    convention = 'info',
                    refactor = 'info',
                    info = 'info'
                  }
                },
                shellcheck = {
                  command = 'shellcheck',
                  debounce = 100,
                  args = {
                    '--format',
                    'json',
                    '-'
                  },
                  sourceName = 'shellcheck',
                  parseJson = {
                    line = 'line',
                    column = 'column',
                    endLine = 'endLine',
                    endColumn = 'endColumn',
                    message = '${message} [${code}]',
                    security = 'level'
                  },
                  securities = {
                    error = 'error',
                    warning = 'warning',
                    info = 'info',
                    style = 'hint'
                  }
                }
              },
              filetypes = {
                javascript = 'eslint',
                javascriptreact = 'eslint',
                python = { 'pylint', 'flake8' },
                ruby = 'rubocop',
                sh = 'shellcheck',
                typescript = 'eslint',
                typescriptreact = 'eslint',
              },
              formatters = {
                prettier = {
                  command = 'prettier',
                  args = { '--stdin-filepath', '%filename' }
                },
                yapf = {
                  command = 'yapf',
                  args = { '--quiet' },
                },
                isort = {
                  command = 'isort',
                  args = { '--quiet', '-' }
                },
              },
              formatFiletypes = {
                css = 'prettier',
                javascript = 'prettier',
                javascriptreact = 'prettier',
                json = 'prettier',
                python = { 'yapf', 'isort' },
                ruby = 'rubocop',
                scss = 'prettier',
                typescript = 'prettier',
                typescriptreact = 'prettier'
              },
              formatOnSaveFileTypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
            }
          })
        })
      end,
    },
  },
  {
    "https://github.com/hrsh7th/nvim-cmp",
    dependencies = {
      "https://github.com/hrsh7th/cmp-buffer",
      "https://github.com/hrsh7th/cmp-path",
      "https://github.com/saadparwaiz1/cmp_luasnip",
      "https://github.com/hrsh7th/cmp-nvim-lsp",
      "https://github.com/hrsh7th/cmp-nvim-lua",
      "https://github.com/hrsh7th/cmp-cmdline",
      "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help",
      {
        "https://github.com/L3MON4D3/LuaSnip",
        dependencies = "https://github.com/rafamadriz/friendly-snippets",
        opts = {
          history = true,
          delete_check_events = "TextChanged",
        },
      },
    },
    opts = function()
      local cmp = require("cmp")

      local has_words_before = function()
        unpack = unpack
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
      end

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),
          ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),
          ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp",                group_index = 2 },
          { name = "nvim_lsp_signature_help", group_index = 2 },
          { name = "luasnip",                 group_index = 2 },
          { name = "nvim_lua",                group_index = 2 },
          { name = "buffer",                  group_index = 2 },
          { name = "path",                    group_index = 2 },
        }),
        experimental = {
          ghost_text = {
            hl_group = "Comment",
          },
        },
      }
    end,
  },
  { "https://github.com/nvim-lua/plenary.nvim", lazy = true },
  { "https://github.com/nvim-lua/popup.nvim" },
  -- === experiments ===
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = true, auto_trigger = true },
      panel = { enabled = false },
      keymap = {
        accept = "<C-j>",
      },
    },
  },
  {
    "https://github.com/stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    "https://github.com/kevinhwang91/nvim-bqf",
    ft = "qf",
    dependencies = { "https://github.com/junegunn/fzf", build = "./install --bin" },
  },
  {
    "https://github.com/natecraddock/workspaces.nvim",
    event = "VeryLazy",
    opts = {
      cd_type = "local",
      hooks = { open = { "FzfLua files" } },
    },
  },
  {
    "https://github.com/stevearc/overseer.nvim",
    event = "VeryLazy",
    config = function()
      require("overseer").setup()
    end,
  },
  {
    "https://github.com/james1236/backseat.nvim",
    event = "VeryLazy",
    opts = {
      openai_model_id = "gpt-3.5-turbo", --gpt-4
      split_threshold = 100,
      highlight = {
        icon = "",
        group = "Comment",
      },
    },
  },
  {
    "https://github.com/nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/debugloop/telescope-undo.nvim",
      "https://github.com/nvim-treesitter/nvim-treesitter",
      "https://github.com/nvim-tree/nvim-web-devicons",
      {
        "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    opts = {
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        undo = {
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.8,
          },
        },
      },
    },
    config = function()
      local telescope = require("telescope")

      telescope.load_extension("fzf")
      telescope.load_extension("undo")
    end,
    keys = {
      vim.keymap.set("n", "<Leader>u", "<cmd>Telescope undo<cr>", { noremap = true, silent = true }),
    },
  },
  {
    "https://github.com/folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    },
    dependencies = {
      "https://github.com/MunifTanjim/nui.nvim",
      "https://github.com/rcarriga/nvim-notify",
    },
  },
  {
    "https://github.com/rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },
  {
    "https://github.com/nmac427/guess-indent.nvim",
    event = "VeryLazy",
    config = function()
      require("guess-indent").setup()
    end,
  },

  -- === find ===
  { "https://github.com/junegunn/fzf",                build = "./install --bin" },
  { "https://github.com/nvim-tree/nvim-web-devicons", lazy = true },
  { "https://github.com/MunifTanjim/nui.nvim",        lazy = true },
  {
    "https://github.com/ibhagwan/fzf-lua",
    dependencies = { "https://github.com/nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({ "default" })
    end,
    keys = {
      vim.keymap.set('i', "jk", "<ESC>", { noremap = true }),
      vim.keymap.set("n", "<C-p>", "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true }),
      vim.keymap.set("n", "<C-b>", "<cmd>lua require('fzf-lua').buffers()<CR>", { noremap = true, silent = true }),
      vim.keymap.set("n", "<Leader>p", "<cmd>lua require('fzf-lua').blines()<CR>", { noremap = true, silent = true }),
      vim.keymap.set("n", "<Leader>gc", "<cmd>lua require('fzf-lua').commits()<CR>", { noremap = true, silent = true }),
      vim.keymap.set(
        "n",
        "<Leader>bgc",
        "<cmd>lua require('fzf-lua').bcommits()<CR>",
        { noremap = true, silent = true }
      ),

      vim.keymap.set(
        "n",
        "<Leader>hi",
        "<cmd>lua require('fzf-lua').oldfiles()<CR>",
        { noremap = true, silent = true }
      ),

      vim.keymap.set("n", "gw", "<cmd>lua require('fzf-lua').grep_cword()<CR>", { noremap = true, silent = true }),

      -- query | *fileextension*
      vim.keymap.set(
        "n",
        "<Leader>;",
        "<cmd>lua require('fzf-lua').live_grep_glob()<CR>",
        { noremap = true, silent = true }
      ),

      vim.keymap.set("n", "'", "<cmd>lua require('fzf-lua').registers()<CR>", { noremap = true, silent = true }),
      vim.keymap.set(
        "v",
        "<Leader>ca",
        "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>",
        { noremap = true, silent = true }
      ),

      vim.keymap.set(
        { "n", "v", "i" },
        "<C-x><C-f>",
        '<cmd>lua require("fzf-lua").complete_path()<CR>',
        { noremap = true, silent = true, desc = "Fuzzy complete path" }
      ),
    },
  },
  {
    "https://github.com/nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/nvim-tree/nvim-web-devicons",
      "https://github.com/MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    keys = {
      vim.keymap.set("n", "<Leader>vi", ":Neotree $HOME/dotfiles/<CR>", { noremap = true }),
      vim.keymap.set("n", "<Leader>ve", ":NeoTreeRevealToggle<CR>", { noremap = true }),
    },
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
        },
      },
      window = {
        mappings = {
          ["-"] = "navigate_up",
        },
      },
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
  },

  -- === git ===
  {
    "https://github.com/lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- === language plugins ===
  { "https://github.com/wuelnerdotexe/vim-astro", ft = "astro" },
  { "https://github.com/hashivim/vim-terraform",  ft = "terraform" },
  {
    "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
  },
  {
    "https://github.com/echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      mappings = {
        comment_line = "<C-\\>",
        comment = "<C-\\>",
      },
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },
  {
    "https://github.com/echasnovski/mini.cursorword",
    event = "VeryLazy",
    config = function()
      require("mini.cursorword").setup()
    end,
  },
  {
    "https://github.com/echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")
      return {
        resize = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
      }
    end,
    config = function(_, opts)
      require("mini.animate").setup(opts)
    end,
  },
  {
    "https://github.com/echasnovski/mini.trailspace",
    event = "VeryLazy",
    config = function()
      local mini_trailspace = require("mini.trailspace")
      mini_trailspace.setup()

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("vim_trim", { clear = true }),
        callback = function()
          mini_trailspace.trim()
          mini_trailspace.trim_last_lines()
        end,
      })
    end,
  },
  {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { "https://github.com/RRethy/nvim-treesitter-endwise" },
      {
        "https://github.com/windwp/nvim-autopairs",
        config = function()
          local remap = vim.api.nvim_set_keymap
          local npairs = require("nvim-autopairs")

          npairs.setup({ map_bs = false })

          _G.MUtils = {}

          MUtils.CR = function()
            if vim.fn.pumvisible() ~= 0 then
              if vim.fn.complete_info({ "selected" }).selected ~= -1 then
                return npairs.esc("<c-y>")
              else
                return npairs.esc("<c-e>") .. npairs.autopairs_cr()
              end
            else
              return npairs.autopairs_cr()
            end
          end
          remap("i", "<cr>", "v:lua.MUtils.CR()", { expr = true, noremap = true })

          MUtils.BS = function()
            if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
              return npairs.esc("<c-e>") .. npairs.autopairs_bs()
            else
              return npairs.autopairs_bs()
            end
          end
          remap("i", "<bs>", "v:lua.MUtils.BS()", { expr = true, noremap = true })
        end,
      },
      {
        "https://github.com/windwp/nvim-ts-autotag",
        ft = { "astro", "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
      },
      {
        "https://github.com/kevinhwang91/nvim-ufo",
        dependencies = "https://github.com/kevinhwang91/promise-async",
      },
      { "https://github.com/nvim-treesitter/nvim-treesitter-refactor" },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = false,
        disable = function(buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        ensure_installed = {
          "bash",
          "comment",
          "css",
          "dockerfile",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "go",
          "graphql",
          "html",
          "http",
          "javascript",
          "jsdoc",
          "json",
          "json5",
          "jsonc",
          "kdl",
          "lua",
          "luadoc",
          "luap",
          "make",
          "markdown",
          "markdown_inline",
          "prisma",
          "python",
          "regex",
          "ruby",
          "rust",
          "scss",
          "sql",
          "swift",
          "terraform",
          "todotxt",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        endwise = {
          enable = true,
        },
        refactor = {
          enable = true,
          clear_on_cursor_move = false,
        },
      })

      require("ufo").setup({
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
      })
    end,
  },

  {
    "https://github.com/iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  { "https://github.com/Vimjas/vim-python-pep8-indent", ft = { "python" } },
  { "https://github.com/rust-lang/rust.vim",            ft = { "rust" } },

  -- === other ===
  {
    "https://github.com/princejoogie/chafa.nvim",
    event = "VeryLazy",
    dependencies = {
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/m00qek/baleia.nvim",
    },
    opts = {
      render = {
        min_padding = 5,
        show_label = true,
      },
      events = {
        update_on_nvim_resize = true,
      },
    },
  },
  {
    "https://github.com/stevearc/aerial.nvim",
    event = { "BufReadPre" },
    opts = {
      on_attach = function(bufnr)
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    },
  },
  {
    "https://github.com/DanilaMihailov/beacon.nvim",
    event = "VeryLazy",
  },
  {
    "https://github.com/chrishrb/gx.nvim",
    event = { "BufEnter" },
    config = true,
  },
  {
    "https://github.com/laytan/cloak.nvim",
    event = { "BufReadPre" },
    ft = { "sh" },
    config = function()
      require("cloak").setup()
    end,
  },
  { "https://github.com/stefandtw/quickfix-reflector.vim", event = "VeryLazy" },
  {
    "https://github.com/norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "https://github.com/rhysd/devdocs.vim",
    event = "VeryLazy",
    keys = {
      vim.keymap.set("n", "K", "<Plug>(devdocs-under-cursor)", { silent = true }),
    },
  },
  {
    "https://github.com/janko-m/vim-test",
    event = "VeryLazy",
    keys = {
      vim.keymap.set("n", "<Leader>t", ":wa<CR>:TestFile<CR>", { noremap = true, silent = true }),
      vim.keymap.set("n", "<Leader>s", ":wa<CR>:TestNearest<CR>", { noremap = true, silent = true }),
      vim.keymap.set("n", "<Leader>l", ":wa<CR>:TestLast<CR>", { noremap = true, silent = true }),
      vim.keymap.set("n", "<Leader>a", ":wa<CR>:TestSuite<CR>", { noremap = true, silent = true }),
      vim.keymap.set("n", "<Leader>gt", ":wa<CR>:TestVisit<CR>", { noremap = true, silent = true }),
    },
  },
  { "https://github.com/folke/neodev.nvim" },
  { "https://github.com/romainl/vim-cool" },
  {
    "https://github.com/tpope/vim-fugitive",
    config = function()
      vim.cmd("command! -nargs=1 Browse silent exec '!open \"<args>\"'")
    end,
  },
  { "https://github.com/tpope/vim-rails",  ft = { "ruby" } },
  { "https://github.com/tpope/vim-rhubarb" },
  { "https://github.com/tpope/vim-rsi" },
  {
    "https://github.com/hoob3rt/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "https://github.com/nvim-tree/nvim-web-devicons" },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'catppuccin',
        }
      }
    end
  },
  {
    "https://github.com/folke/trouble.nvim",
    dependencies = "https://github.com/nvim-tree/nvim-web-devicons",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      auto_close = true,
      use_diagnostic_signs = true,
    },
    keys = {
      vim.keymap.set(
        "n",
        "<Leader>xx",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        { silent = true, noremap = true }
      ),
    },
  },
}, {
  checker = { enabled = false },
  rtp = { disabled_plugins = { "netrwPlugin" } },
})

--  ____ ____ ____ ____ ____ ____  ____ ____ ___
-- ||f |||u |||n |||c |||t |||i |||o |||n |||s ||
-- ||__|||__|||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

local function augroup(name)
  return vim.api.nvim_create_augroup("devinnvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("CursorHold", {
  group = augroup("show_diagnostics"),
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    }

    local _, winnr = vim.diagnostic.open_float(nil, opts)
    if winnr then
      vim.api.nvim_win_set_option(winnr, "winblend", 10)
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ timeout = 250 })
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup("no_terminal_numbers"),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  group = augroup("terminal_exit_status"),
  callback = function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true)
  end,
})

-- When editing a file, always jump to the last known cursor position.
-- Don't do it for commit messages, when the position is invalid, or when
-- inside an event handler.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_known_cursor_position"),
  callback = function()
    if vim.bo.filetype ~= "gitcommit" and vim.fn.line('"') > 0 and vim.fn.line('"') <= vim.fn.line("$") then
      vim.api.nvim_feedkeys('g`""', "n", true)
    end
  end,
})

-- === vim-test ===
vim.cmd([[
function! NeoSplit(cmd) abort
  let opts = {'suffix': ' # vim-test'}
  function! opts.close_terminal()
    if bufnr(self.suffix) != -1
      execute 'bdelete!' bufnr(self.suffix)
    end
  endfunction
  call opts.close_terminal()
  split new
  call termopen(a:cmd . opts.suffix, opts)
  au BufDelete <buffer> wincmd p
  stopinsert
endfunction
let g:test#custom_strategies = {'neosplit': function('NeoSplit')}
let g:test#strategy = 'neosplit'
" let test#ruby#rspec#executable = 'docker-compose exec app bundle exec rspec'
]])

-- === debugging ===
vim.g.loaded_pry = 1
vim.g.debug_map = {
  ["ruby"] = 'require "pry"; binding.pry',
  ["javascript"] = "debugger;",
  ["typescript"] = "debugger;",
  ["javascriptreact"] = "debugger;",
  ["typescriptreact"] = "debugger;",
  ["python"] = "import ipdb; ipdb.set_trace()",
}

vim.cmd([[
function! InsertDebug()
  if has_key(g:debug_map, &filetype)
    let text = get(g:debug_map, &filetype)
    call feedkeys('o', 'i')
    call feedkeys(text)
    call feedkeys("\<Esc>")
  endif
endfunction
]])

-- vim.cmd([[
--   command! -bang -nargs=* Rg
--         \ call fzf#vim#grep(
--         \   'rg --column --line-number --no-heading --smart-case --color=always '.(<q-args>), 1,
--         \   <bang>0 ? fzf#vim#with_preview('up:60%')
--         \           : fzf#vim#with_preview('right:50%:hidden', '?'),
--         \   <bang>0)
--
--   command! -bang -nargs=? -complete=dir Files
--         \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
-- ]])

vim.cmd([[
  function! FloatingFZF(width, height, border_highlight)
    function! s:create_float(hl, opts)
      let buf = nvim_create_buf(v:false, v:true)
      let opts = extend({'relative': 'editor', 'style': 'minimal'}, a:opts)
      let win = nvim_open_win(buf, v:true, opts)
      call setwinvar(win, '&winhighlight', 'NormalFloat:'.a:hl)
      call setwinvar(win, '&colorcolumn', '')
      return buf
    endfunction

    " Size and position
    let width = float2nr(&columns * a:width)
    let height = float2nr(&lines * a:height)
    let row = float2nr((&lines - height) / 2)
    let col = float2nr((&columns - width) / 2)

    " Border
    let top = '╭' . repeat('─', width - 2) . '╮'
    let mid = '│' . repeat(' ', width - 2) . '│'
    let bot = '╰' . repeat('─', width - 2) . '╯'
    let border = [top] + repeat([mid], height - 2) + [bot]

    " Draw frame
    let s:frame = s:create_float(a:border_highlight, {'row': row, 'col': col, 'width': width, 'height': height})
    call nvim_buf_set_lines(s:frame, 0, -1, v:true, border)

    " Draw viewport
    call s:create_float('Normal', {'row': row + 1, 'col': col + 2, 'width': width - 4, 'height': height - 2})
    autocmd BufWipeout <buffer> execute 'bwipeout' s:frame
  endfunction
]])

vim.g.fzf_layout = {
  ["window"] = 'call FloatingFZF(0.9, 0.6, "Comment")',
}

--  ____ ____ ____ ____
-- ||m |||a |||p |||s ||
-- ||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|

-- === format on save ===
vim.api.nvim_command [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
-- vim.api.nvim_command [[autocmd BufWritePre *.rb lua vim.lsp.buf.format({ async = true })]]

-- === zoom a vim pane ===
vim.keymap.set("n", "<Leader>-", ":wincmd _<CR>:wincmd |<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>=", ":wincmd =<CR>", { noremap = true })

-- === terminal mappings ===
vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h", { noremap = true })
vim.keymap.set("t", "<C-w>j", "<C-\\><C-n><C-w>j", { noremap = true })
vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-w>k", { noremap = true })
vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l", { noremap = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set("t", "<A-[>", "<Esc><Esc>", { noremap = true })
vim.keymap.set("t", "<C-w>-", "<C-\\><C-n>:sp<CR>:terminal<CR>i", { noremap = true })
vim.keymap.set("t", "<C-w>\\", "<C-\\><C-n>:vsp<CR>:terminal<CR>i", { noremap = true })
vim.keymap.set("n", "<C-w>-", ":20sp<CR>:terminal<CR>i", { noremap = true })
vim.keymap.set("n", "<C-w>\\", ":vsp<CR>:terminal<CR>i", { noremap = true })
vim.keymap.set("n", "<C-w>c", ":tabnew<CR>:terminal<CR>i", { noremap = true })

-- === Move up and down by visible lines if current line is wrapped ===
vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })

-- === add current word under cursor to :%s ===
vim.keymap.set("n", "<Leader>n", ':%s/\\(<c-r>=expand("<cword>")<CR>\\)/', { noremap = true })

-- === Pre-populate a split command with the current directory ===
vim.keymap.set("n", "<Leader>e", ':vsp <C-r>=expand("%:p:h") . "/" <CR><C-d>', { noremap = true })
vim.keymap.set("n", "<Leader>mv", ':!mv % <C-r>=expand("%:p:h") . "/" <CR><C-d>', { noremap = true })
vim.keymap.set("n", "<Leader>cp", ':!cp % <C-r>=expand("%:p:h") . "/" <CR><C-d>', { noremap = true })

-- === debugging ===
vim.keymap.set("n", "<Leader>d", ":call InsertDebug()<CR>", { noremap = true })
