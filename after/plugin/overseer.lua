require('overseer').setup({
    component_aliases = {
        default = {
            { "display_duration", detail_level = 2 },
            "on_output_summarize",
            "on_exit_set_status",
            { "on_complete_notify", statuses = { "FAILURE" } }, -- Disable success notifications.
            "on_complete_dispose",
        },
    },
})

