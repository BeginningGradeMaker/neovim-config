return {
  {
    "Shatur/neovim-session-manager",
    event = "BufWritePost",
    keys = {
      {
        "<leader>Ss",
        "<cmd>SessionManager! save_current_session<cr>",
        desc = "Save current session",
      },
      {
        "<leader>Sl",
        "<cmd>SessionManager! load_last_session<cr>",
        desc = "Load last session",
      },
      {
        "<leader>Sd",
        "<cmd>SessionManager! delete_session<cr>",
        desc = "Delete sessions",
      },
      {
        "<leader>Sf",
        "<cmd>SessionManager! load_session<cr>",
        desc = "Search sessions",
      },
      {
        "<leader>Sc",
        "<cmd>SessionManager! load_current_dir_session<cr>",
        desc = "Load current directory session",
      },
    },
  }
}
