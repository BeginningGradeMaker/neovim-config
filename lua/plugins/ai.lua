-- if true then
--   return {}
-- end
local mapping_key_prefix = vim.g.ai_prefix_key or "<leader>a"
local machine = vim.loop.os_uname().sysname

-- This is custom system prompt for Copilot adapter
-- Base on https://github.com/olimorris/codecompanion.nvim/blob/e7d931ae027f9fdca2bd7c53aa0a8d3f8d620256/lua/codecompanion/config.lua#L639 and https://github.com/CopilotC-Nvim/CopilotChat.nvim/blob/d43fab67c328946fbf8e24fdcadfdb5410517e1f/lua/CopilotChat/prompts.lua#L5
local SYSTEM_PROMPT = string.format(
	[[You are an AI programming assistant named "GitHub Copilot".
You are currently plugged in to the Neovim text editor on a user's machine.

Your tasks include:
- Answering general programming questions.
- Explaining how the code in a Neovim buffer works.
- Reviewing the selected code in a Neovim buffer.
- Generating unit tests for the selected code.
- Proposing fixes for problems in the selected code.
- Scaffolding code for a new workspace.
- Finding relevant code to the user's query.
- Proposing fixes for test failures.
- Answering questions about Neovim.
- Ask how to do something in the terminal
- Explain what just happened in the terminal
- Running tools.

You must:
- Follow the user's requirements carefully and to the letter.
- Keep your answers short and impersonal, especially if the user responds with context outside of your tasks.
- Minimize other prose.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of the Markdown code blocks.
- Avoid line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Only return relevant code.
- The user works in an IDE called Neovim which has a concept for editors with open files, integrated unit test support, an output pane that shows the output of running the code as well as an integrated terminal.
- The user is working on a %s machine. Please respond with system specific commands if applicable.

When given a task:
1. Think step-by-step and describe your plan for what to build in pseudocode, written out in great detail.
2. Output the code in a single code block.
3. You should always generate short suggestions for the next user turns that are relevant to the conversation.
4. You can only give one reply for each conversation turn.
5. The active document is the source code the user is looking at right now.
]],
	machine
)
local COPILOT_EXPLAIN = string.format(
	[[You are a world-class coding tutor. Your code explanations perfectly balance high-level concepts and granular details. Your approach ensures that students not only understand how to write code, but also grasp the underlying principles that guide effective programming.
When asked for your name, you must respond with "GitHub Copilot".
Follow the user's requirements carefully & to the letter.
Your expertise is strictly limited to software development topics.
Follow Microsoft content policies.
Avoid content that violates copyrights.
For questions not related to software development, simply give a reminder that you are an AI programming assistant.
Keep your answers short and impersonal.
Use Markdown formatting in your answers.
Make sure to include the programming language name at the start of the Markdown code blocks.
Avoid wrapping the whole response in triple backticks.
The user works in an IDE called Neovim which has a concept for editors with open files, integrated unit test support, an output pane that shows the output of running the code as well as an integrated terminal.
The active document is the source code the user is looking at right now.
You can only give one reply for each conversation turn.

Additional Rules
Think step by step:
1. Examine the provided code selection and any other context like user question, related errors, project details, class definitions, etc.
2. If you are unsure about the code, concepts, or the user's question, ask clarifying questions.
3. If the user provided a specific question or error, answer it based on the selected code and additional provided context. Otherwise focus on explaining the selected code.
4. Provide suggestions if you see opportunities to improve code readability, performance, etc.

Focus on being clear, helpful, and thorough without assuming extensive prior knowledge.
Use developer-friendly terms and analogies in your explanations.
Identify 'gotchas' or less obvious parts of the code that might trip up someone new.
Provide clear and relevant examples aligned with any provided context.
]]
)
local COPILOT_REVIEW = string.format(
	[[Your task is to review the provided code snippet, focusing specifically on its readability and maintainability.
Identify any issues related to:
- Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
- The presence of unnecessary comments, or the lack of necessary ones.
- Overly complex expressions that could benefit from simplification.
- High nesting levels that make the code difficult to follow.
- The use of excessively long names for variables or functions.
- Any inconsistencies in naming, formatting, or overall coding style.
- Repetitive code patterns that could be more efficiently handled through abstraction or optimization.

Your feedback must be concise, directly addressing each identified issue with:
- A clear description of the problem.
- A concrete suggestion for how to improve or correct the issue.

Format your feedback as follows:
- Explain the high-level issue or problem briefly.
- Provide a specific suggestion for improvement.

If the code snippet has no readability issues, simply confirm that the code is clear and well-written as is.
]]
)
local COPILOT_REFACTOR = string.format(
	[[Your task is to refactor the provided code snippet, focusing specifically on its readability and maintainability.
Identify any issues related to:
- Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
- The presence of unnecessary comments, or the lack of necessary ones.
- Overly complex expressions that could benefit from simplification.
- High nesting levels that make the code difficult to follow.
- The use of excessively long names for variables or functions.
- Any inconsistencies in naming, formatting, or overall coding style.
- Repetitive code patterns that could be more efficiently handled through abstraction or optimization.
]]
)

return {
	{
		"olimorris/codecompanion.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
			"nvim-telescope/telescope.nvim", -- Optional: For using slash commands
			{
				"github/copilot.vim",
				keys = {
					{
						"<leader>ta",
						function()
							if require("copilot.client").is_disabled() then
								require("copilot.command").enable()
							else
								require("copilot.command").disable()
							end
						end,
						desc = "Toggle Copilot",
					},
				},
			},
		},
		opts = {
			strategies = {
				chat = {
					adapter = "copilot",
					roles = { llm = "  Copilot Chat", user = "CodeCompanion" },
					slash_commands = {
						["buffer"] = {
							callback = "helpers.slash_commands.buffer",
							description = "Insert open buffers",
							opts = {
								contains_code = true,
								provider = "telescope", -- default|telescope|mini_pick|fzf_lua
							},
						},
						["file"] = {
							callback = "helpers.slash_commands.file",
							description = "Insert a file",
							opts = {
								contains_code = true,
								max_lines = 1000,
								provider = "telescope", -- telescope|mini_pick|fzf_lua
							},
						},
					},
					keymaps = {
						send = {
							modes = {
								n = "<CR>",
								i = "<C-s>",
							},
							index = 1,
							callback = "keymaps.send",
							description = "Send",
						},
						close = {
							modes = {
								n = "q",
							},
							index = 3,
							callback = "keymaps.close",
							description = "Close Chat",
						},
						stop = {
							modes = {
								n = "<C-c>",
							},
							index = 4,
							callback = "keymaps.stop",
							description = "Stop Request",
						},
					},
				},
				inline = { adapter = "copilot" },
				agent = { adapter = "copilot" },
			},
			inline = {
				layout = "buffer", -- vertical|horizontal|buffer
			},
			display = {
				chat = {
					-- Change to true to show the current model
					show_settings = false,
					window = {
						layout = "vertical", -- float|vertical|horizontal|buffer
					},
				},
			},
			opts = {
				log_level = "DEBUG",
				system_prompt = SYSTEM_PROMPT,
			},
			prompt_library = {
				-- Custom the default prompt
				["Generate a Commit Message"] = {
					prompts = {
						{
							role = "user",
							content = function()
								return "Write commit message with commitizen convention. Write clear, informative commit messages that explain the 'what' and 'why' behind changes, not just the 'how'."
									.. "\n\n```\n"
									.. vim.fn.system("git diff")
									.. "\n```"
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},
				["Explain"] = {
					strategy = "chat",
					description = "Explain how code in a buffer works",
					opts = {
						index = 4,
						default_prompt = true,
						mapping = "<LocalLeader>ce",
						modes = { "v" },
						slash_cmd = "explain",
						auto_submit = true,
						user_prompt = false,
						stop_context_insertion = true,
					},
					prompts = {
						{
							role = "system",
							content = COPILOT_EXPLAIN,
							opts = {
								visible = false,
							},
						},
						{
							role = "user",
							content = function(context)
								local code = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)

								return "Please explain how the following code works:\n\n```"
									.. context.filetype
									.. "\n"
									.. code
									.. "\n```\n\n"
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},
				-- Add custom prompts
				["Generate a Commit Message for Staged"] = {
					strategy = "chat",
					description = "Generate a commit message for staged change",
					opts = {
						index = 9,
						mapping = "<LocalLeader>cM",
						slash_cmd = "staged-commit",
						auto_submit = true,
					},
					prompts = {
						{
							role = "user",
							content = function()
								return "Write commit message for the change with commitizen convention. Write clear, informative commit messages that explain the 'what' and 'why' behind changes, not just the 'how'."
									.. "\n\n```\n"
									.. vim.fn.system("git diff --staged")
									.. "\n```"
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},
				["Inline-Document"] = {
					strategy = "inline",
					description = "Add documentation for code.",
					opts = {
						mapping = "<LocalLeader>cd",
						modes = { "v" },
						slash_cmd = "inline-doc",
						auto_submit = true,
						user_prompt = false,
						stop_context_insertion = true,
					},
					prompts = {
						{
							role = "user",
							content = function(context)
								local code = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)

								return "Please provide documentation in comment code for the following code and suggest to have better naming to improve readability.\n\n```"
									.. context.filetype
									.. "\n"
									.. code
									.. "\n```\n\n"
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},
				["Document"] = {
					strategy = "chat",
					description = "Write documentation for code.",
					opts = {
						mapping = "<LocalLeader>cD",
						modes = { "v" },
						slash_cmd = "doc",
						auto_submit = true,
						user_prompt = false,
						stop_context_insertion = true,
					},
					prompts = {
						{
							role = "user",
							content = function(context)
								local code = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)

								return "Please brief how it works and provide documentation in comment code for the following code. Also suggest to have better naming to improve readability.\n\n```"
									.. context.filetype
									.. "\n"
									.. code
									.. "\n```\n\n"
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},
				["Review"] = {
					strategy = "chat",
					description = "Review the provided code snippet.",
					opts = {
						index = 11,
						mapping = "<LocalLeader>cR",
						modes = { "v" },
						slash_cmd = "review",
						auto_submit = true,
						user_prompt = false,
						stop_context_insertion = true,
					},
					prompts = {
						{
							role = "system",
							content = COPILOT_REVIEW,
							opts = {
								visible = false,
							},
						},
						{
							role = "user",
							content = function(context)
								local code = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)

								return "Please review the following code and provide suggestions for improvement then refactor the following code to improve its clarity and readability:\n\n```"
									.. context.filetype
									.. "\n"
									.. code
									.. "\n```\n\n"
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},
				["Refactor"] = {
					strategy = "inline",
					description = "Refactor the provided code snippet.",
					opts = {
						index = 11,
						mapping = "<LocalLeader>cr",
						modes = { "v" },
						slash_cmd = "refactor",
						auto_submit = true,
						user_prompt = false,
						stop_context_insertion = true,
					},
					prompts = {
						{
							role = "system",
							content = COPILOT_REFACTOR,
							opts = {
								visible = false,
							},
						},
						{
							role = "user",
							content = function(context)
								local code = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)

								return "Please refactor the following code to improve its clarity and readability:\n\n```"
									.. context.filetype
									.. "\n"
									.. code
									.. "\n```\n\n"
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},
				["Naming"] = {
					strategy = "inline",
					description = "Give betting naming for the provided code snippet.",
					opts = {
						index = 12,
						mapping = "<LocalLeader>cn",
						modes = { "v" },
						slash_cmd = "naming",
						auto_submit = true,
						user_prompt = false,
						stop_context_insertion = true,
					},
					prompts = {
						{
							role = "user",
							content = function(context)
								local code = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)

								return "Please provide better names for the following variables and functions:\n\n```"
									.. context.filetype
									.. "\n"
									.. code
									.. "\n```\n\n"
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},
			},
		},
		keys = {
			-- Recommend setup
			{
				mapping_key_prefix .. "a",
				"<cmd>CodeCompanionActions<cr>",
				desc = "Code Companion - Actions",
			},
			{
				mapping_key_prefix .. "p",
				"<cmd>CodeCompanionChat Toggle<cr>",
				desc = "Toggle Code Companion",
				mode = { "n", "v" },
			},
			-- Some common usages with visual mode
			{
				mapping_key_prefix .. "e",
				"<cmd>CodeCompanion /explain<cr>",
				desc = "Code Companion - Explain code",
				mode = "v",
			},
			{
				mapping_key_prefix .. "f",
				"<cmd>CodeCompanion /fix<cr>",
				desc = "Code Companion - Fix code",
				mode = "v",
			},
			{
				mapping_key_prefix .. "l",
				"<cmd>CodeCompanion /lsp<cr>",
				desc = "Code Companion - Explain LSP diagnostic",
				mode = { "n", "v" },
			},
			{
				mapping_key_prefix .. "t",
				"<cmd>CodeCompanion /tests<cr>",
				desc = "Code Companion - Generate unit test",
				mode = "v",
			},
			{
				mapping_key_prefix .. "m",
				"<cmd>CodeCompanion /commit<cr>",
				desc = "Code Companion - Git commit message",
			},
			-- Custom prompts
			{
				mapping_key_prefix .. "M",
				"<cmd>CodeCompanion /staged-commit<cr>",
				desc = "Code Companion - Git commit message (staged)",
			},
			{
				mapping_key_prefix .. "d",
				"<cmd>CodeCompanion /inline-doc<cr>",
				desc = "Code Companion - Inline document code",
				mode = "v",
			},
			{
				mapping_key_prefix .. "D",
				"<cmd>CodeCompanion /doc<cr>",
				desc = "Code Companion - Document code",
				mode = "v",
			},
			{
				mapping_key_prefix .. "r",
				"<cmd>CodeCompanion /refactor<cr>",
				desc = "Code Companion - Refactor code",
				mode = "v",
			},
			{
				mapping_key_prefix .. "R",
				"<cmd>CodeCompanion /review<cr>",
				desc = "Code Companion - Review code",
				mode = "v",
			},
			{
				mapping_key_prefix .. "n",
				"<cmd>CodeCompanion /naming<cr>",
				desc = "Code Companion - Better naming",
				mode = "v",
			},
			-- Quick chat
			{
				mapping_key_prefix .. "q",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						vim.cmd("CodeCompanion " .. input)
					end
				end,
				desc = "Code Companion - Quick chat",
			},
		},
	},
}
