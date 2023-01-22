local nnoremap = require('victor.keymap').nnoremap

-- Ctrl + add
nnoremap('<C-a>', ':lua require("harpoon.mark").add_file()<CR>')
-- Ctrl + harpoon
nnoremap('<C-h>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
-- Ctrl + [1..9]
for i = 1,9
do
    nnoremap('<C-'..i..'>', ':lua require("harpoon.ui").nav_file('..i..')<CR>')
end
