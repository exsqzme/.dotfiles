require('gitsigns').setup {
    -- Highlights just the number part of the number column
    numhl = true,

    -- Highlights the _whole_ line.
    --    Instead, use gitsigns.toggle_linehl()
    linehl = false,

    -- Highlights just the part of the line that has changed
    --    Instead, use gitsigns.toggle_word_diff()
    word_diff = false,
}
