return {
  name = "gcc build and run",
  builder = function()
    local file = vim.fn.expand("%:p")
    local outfile = vim.fn.expand("%:p:r") .. ".out"
    return {
      cmd = { outfile },
      components = {
        { "dependencies", task_names = { { cmd = "gcc", args = { file, "-o", outfile } } } },
        { "on_output_quickfix", open = true },
        "default",
      },
    }
  end,
  condition = {
    filetype = { "c" },
  },
}
