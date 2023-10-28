local theme = {
    fill = 'TabLineFill',
    head = 'TabLine',
    current_tab = 'TabLineSel',
    tab = 'TabLine',
    window = 'TabLine',
    tail = 'TabLine',
}

require('tabby.tabline').set(function(line)
    return {
        {
            { '', hl = theme.head },
            line.sep('', theme.head, theme.fill),
        },
        line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            local tab_name = "[ No Name ]"
            local windows = line.wins_in_tab(tab.id).wins
            for _, window in pairs(windows) do
                if window.is_current() then
                    tab_name = window.buf_name()
                    break
                end
            end
            return {
                line.sep('', hl, theme.fill),
                tab.number(),
                tab_name,
                line.sep('', hl, theme.fill),
                hl = hl,
                margin = ' ',
            }
        end),
        line.spacer(),
        {
            line.sep('', theme.tail, theme.fill),
            { '', hl = theme.tail },
        },
        hl = theme.fill,
    }
end)
