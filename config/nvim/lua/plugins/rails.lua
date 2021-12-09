vim.cmd [[
  let g:rails_projections = {
  \ "test/integration/*_test.rb": {
  \   "type": "integration test",
  \   "alternate": "app/controllers/{}.rb"
  \ },
  \ "app/controllers/*_controller.rb": {
  \    "affinity": "controller",
  \    "template": [
  \      "class {camelcase|capitalize|colons}Controller < ApplicationController",
  \      "end"
  \    ],
  \    "type": "controller",
  \    "alternate": "test/integration/{}_controller_test.rb"
  \ }
  \}

  let g:rspec_command = "Tbro bin/rails test {spec}"
  let g:test#custom_strategies = {'tbro': function('tbro#send')}
  let g:test#strategy = 'tbro'
  let test#ruby#rails#executable = 'bin/rails test'
]]
