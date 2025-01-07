local auto_pairs = require 'nvim-autopairs'
auto_pairs.setup {
    disabled_filetype = {
        "TelescopePrompt",
        "chatgpt-input",
        "off",
    },
}

local rule = require 'nvim-autopairs.rule'
local conditions = require 'nvim-autopairs.conds'

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
auto_pairs.add_rules {
    -- Rule for a pair with left-side ' ' and right side ' '
    rule(' ', ' ')
    -- Pair will only occur if the conditional function returns true
        :with_pair(function(options)
            -- We are checking if we are inserting a space in (), [], or {}
            local pair = options.line:sub(options.col - 1, options.col)
            return vim.tbl_contains({
                brackets[1][1] .. brackets[1][2],
                brackets[2][1] .. brackets[2][2],
                brackets[3][1] .. brackets[3][2]
            }, pair)
        end)
        :with_move(conditions.none())
        :with_cr(conditions.none())
    -- We only want to delete the pair of spaces when the cursor is as such: ( | )
        :with_del(function(options)
            local column = vim.api.nvim_win_get_cursor(0)[2]
            local context = options.line:sub(column - 1, column + 2)
            return vim.tbl_contains({
                brackets[1][1] .. '  ' .. brackets[1][2],
                brackets[2][1] .. '  ' .. brackets[2][2],
                brackets[3][1] .. '  ' .. brackets[3][2]
            }, context)
        end)
}

-- For each pair of brackets we will add another rule
for _, bracket in pairs(brackets) do
    auto_pairs.add_rules {
        -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
        rule(bracket[1] .. ' ', ' ' .. bracket[2])
            :with_pair(conditions.none())
            :with_move(function(options) return options.char == bracket[2] end)
            :with_del(conditions.none())
            :use_key(bracket[2])
        -- Removes the trailing whitespace that can occur without this
            :replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
    }
end

auto_pairs.add_rule(rule('<', '>', {}):with_pair(
-- Regex will make it so that it will auto-pair on
-- `a<` but not `a <`
-- The `:?:?` part makes it also
-- work on Rust generics like `foo::<T>()`
    conditions.before_regex('%a+:?:?$', 3)
):with_move(function(options)
    return options.char == '>'
end))
