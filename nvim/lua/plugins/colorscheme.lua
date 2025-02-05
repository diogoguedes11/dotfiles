return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = false,
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "moon",
      styles = {
        keywords = { italic = false },
        functions = { italic = false },
        variables = { italic = false, bold = true },
        comments = { italic = false },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
      styles = {
        keywords = { italic = false },
        functions = { italic = false },
        variables = { italic = false, bold = true },
        comments = { italic = false },
      },
    },
  },
}
