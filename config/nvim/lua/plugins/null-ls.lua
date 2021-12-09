local null_ls = require("null-ls")

local sources = {
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.diagnostics.write_good,
  null_ls.builtins.code_actions.gitsigns,
  null_ls.builtins.formatting.rubocop.with({ command = "/usr/local/bin/rubocop" }),
  null_ls.builtins.diagnostics.rubocop.with({ command = "/usr/local/bin/rubocop" }),
  null_ls.builtins.formatting.gofmt,
}

null_ls.config({ sources = sources })
