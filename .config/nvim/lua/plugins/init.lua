return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

   {
   	"nvim-treesitter/nvim-treesitter",
   	oopts = {
   		ensure_installed = {
   			"lua", 
        "javascript", 
        "typescript", 
        "tsx",
   	  },
   	},
   },

   {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "prettierd",
        "tailwindcss-language-server",
        "typescript-language-server",
      },
    },
   },

   {
    "roobert/tailwindcss-colorizer-cmp.nvim",
  -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
      color_square_width = 2,
      })
    end
   },

   {
    "windwp/nvim-ts-autotag",
    ft = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
    config = function()
      require("nvim-ts-autotag").setup()
    end,
   },

  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.null-ls"
    end,
  },
}
