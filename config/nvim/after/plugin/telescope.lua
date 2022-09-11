local nnoremap = require('victor.keymap').nnoremap

nnoremap('<C-f>', ':lua require("telescope.builtin").find_files()<CR>')

require("telescope").setup()

