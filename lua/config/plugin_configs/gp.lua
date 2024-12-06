require("gp").setup({
    providers = {
        openai = {
            endpoint = "http://45.138.74.123:9000/v1/chat/completions",
            secret = { "cat", "/home/sorokinoleg/gpt_api_key.txt" },
        },
    },
    chat_finder_pattern = "# topic: ",
    chat_conceal_model_params = false,
    agents = {
        {
            name = "ChatGPT4o, prompt engineered, temperature = 0.5",
            chat = true,
            command = false,
            model = { model = "gpt-4o", temperature = 0.5, top_p = 1 },
            system_prompt = "You are a general AI assistant.\n\n"
                .. "The user provided the additional info about how they would like you to respond:\n\n"
                .. "- If you're unsure don't guess and say you don't know instead.\n"
                .. "- Ask question if you need clarification to provide better answer.\n"
                .. "- Think deeply and carefully from first principles step by step.\n"
                .. "- Zoom out first to see the big picture and then zoom in to details.\n"
                .. "- Use Socratic method to improve your thinking and coding skills.\n"
                .. "- Don't elide any code from your output if the answer requires coding.\n"
                .. "- Take a deep breath; You've got this!\n",
        },
        {
            name = "ChatGPT4o, clean, temperature = 0.5",
            chat = true,
            command = false,
            model = { model = "gpt-4o", temperature = 0.5, top_p = 1 },
            system_prompt = "You are a general AI assistant.",
        },
        {
            name = "ChatGPT4o, clean, temperature = 0",
            chat = true,
            command = false,
            model = { model = "gpt-4o", temperature = 0, top_p = 1 },
            system_prompt = "You are a general AI assistant.",
        },
        {
            name = "ChatGPT3-5",
            disable = true,
        },
        {
            name = "CodeGPT4o, temperature = 0",
            chat = false,
            command = true,
            model = { model = "gpt-4o", temperature = 0, top_p = 1 },
            system_prompt = "You are an AI working as a code editor.\n\n"
                .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
                .. "START AND END YOUR ANSWER WITH:\n\n```",
        },
        {
            name = "CodeGPT3-5",
            disable = true,
        },
    },
})

local function keymapOptions()
    return {
        noremap = true,
        silent = true,
        nowait = true,
    }
end

vim.keymap.set({ "n", "i", "v" }, "<C-g>", "<NOP>", {})

-- Chat commands.

vim.keymap.set({ "n", "i" }, "<C-g>c", "<cmd>GpChatNew<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g>t", "<cmd>GpChatToggle<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g>f", "<cmd>GpChatFinder<cr>", keymapOptions())

vim.keymap.set("v", "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions())

vim.keymap.set({ "n", "i" }, "<C-g><C-x>", "<cmd>GpChatNew split<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions())

vim.keymap.set("v", "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions())
vim.keymap.set("v", "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions())
vim.keymap.set("v", "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions())

-- Prompt commands.

vim.keymap.set({ "n", "i" }, "<C-g>r", "<cmd>GpRewrite<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g>a", "<cmd>GpAppend<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g>b", "<cmd>GpPrepend<cr>", keymapOptions())

vim.keymap.set("v", "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", keymapOptions())

vim.keymap.set({ "n", "i" }, "<C-g>gp", "<cmd>GpPopup<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g>ge", "<cmd>GpEnew<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g>gn", "<cmd>GpNew<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g>gv", "<cmd>GpVnew<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g>gt", "<cmd>GpTabnew<cr>", keymapOptions())

vim.keymap.set("v", "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions())

vim.keymap.set({ "n", "i" }, "<C-g>x", "<cmd>GpContext<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>x", ":<C-u>'<,'>GpContext<cr>", keymapOptions())

vim.keymap.set({ "n", "i", "v", "x" }, "<C-g>s", "<cmd>GpStop<cr>", keymapOptions())
vim.keymap.set({ "n", "i", "v", "x" }, "<C-g>n", "<cmd>GpNextAgent<cr>", keymapOptions())

-- Whisper commands.

vim.keymap.set({ "n", "i" }, "<C-g>ww", "<cmd>GpWhisper<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>ww", ":<C-u>'<,'>GpWhisper<cr>", keymapOptions())

vim.keymap.set({ "n", "i" }, "<C-g>wr", "<cmd>GpWhisperRewrite<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g>wa", "<cmd>GpWhisperAppend<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g>wb", "<cmd>GpWhisperPrepend<cr>", keymapOptions())

vim.keymap.set("v", "<C-g>wr", ":<C-u>'<,'>GpWhisperRewrite<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>wa", ":<C-u>'<,'>GpWhisperAppend<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>wb", ":<C-u>'<,'>GpWhisperPrepend<cr>", keymapOptions())

vim.keymap.set({ "n", "i" }, "<C-g>wp", "<cmd>GpWhisperPopup<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g>we", "<cmd>GpWhisperEnew<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g>wn", "<cmd>GpWhisperNew<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g>wv", "<cmd>GpWhisperVnew<cr>", keymapOptions())
vim.keymap.set({ "n", "i" }, "<C-g>wt", "<cmd>GpWhisperTabnew<cr>", keymapOptions())

vim.keymap.set("v", "<C-g>wp", ":<C-u>'<,'>GpWhisperPopup<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>we", ":<C-u>'<,'>GpWhisperEnew<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>wn", ":<C-u>'<,'>GpWhisperNew<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>wv", ":<C-u>'<,'>GpWhisperVnew<cr>", keymapOptions())
vim.keymap.set("v", "<C-g>wt", ":<C-u>'<,'>GpWhisperTabnew<cr>", keymapOptions())
