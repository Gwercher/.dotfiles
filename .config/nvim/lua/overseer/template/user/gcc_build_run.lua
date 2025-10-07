return {
  name = "gcc build and run",
  builder = function()
    local file = vim.fn.expand("%:p")
    local outfile = vim.fn.expand("%:p:r")
    return {
      cmd = { "sh", "-c" },
      args = {
        string.format("gcc '%s' -o '%s' -Wall -Wextra -Werror -Wpedantic -std=c18 && '%s'", file, outfile, outfile),
      },
      components = {
        { "on_output_quickfix", open = true },
        "default",
      },
    }
  end,
  condition = {
    filetype = { "c" },
  },
}
