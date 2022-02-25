local actions = require('telescope.actions')
require('telescope').setup{
    defaults = {
        --mappings = {
          --  n = {
           --     ['<C-j'] = action.move_selection_previous
           -- }
       -- }
    }
}
require('telescope').load_extension('fzf')
