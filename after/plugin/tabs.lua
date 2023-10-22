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
            return {
                line.sep('', hl, theme.fill),
                tab.number(),
                line.wins_in_tab(tab.id).foreach(function(window)
                    if window.is_current() then
                        return window.buf_name()
                    end
                end),
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
