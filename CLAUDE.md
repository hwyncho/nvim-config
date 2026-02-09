# Claude Code Rules

> This document defines the rules that Claude Code must follow when working in this repository.

---

## Git Rules

- The Git rules for this repository are defined in `CONTRIBUTING.md` under "[Git Rules](./CONTRIBUTING.md#git-rules)" and act as the single source of truth. Branch naming, commit messages, and PR title/description must follow it.

- Branch names: `main`, `issue/{ISSUE}[-{SUMMARY}]`.
- Commit messages: `[<TYPE>] <Summary>`, then a blank line, then bullet details.
  - Types: `feat`, `enhance`, `refactor`, `docs`, `fix`, `style`, `chore`.
  - Summary: ≤ 50 characters, English, imperative, no trailing period.
  - Details: wrap at 72 chars, written in Korean or English.
  - Example:

    ```
    [feat] Add user authentication system

    - GitHub OAuth 2.0 PKCE 플로우 구현
    - JWT 토큰 기반 인증 미들웨어 추가
    - 사용자 세션 관리 기능
    ```

- PR title: `#<ISSUE_NUMBER> [<TYPE>] <Summary>` and must be in English.
  - Example: `#123 [feat] Add user authentication system`
- PR description: use the template provided in `CONTRIBUTING.md` and fill in the required sections.
- If any discrepancy arises, `CONTRIBUTING.md` takes precedence.

**Reference**: For more details, see [`CONTRIBUTING.md`](./CONTRIBUTING.md).

---

## Project Overview

This is a Neovim configuration project for full-stack developers. It uses:

- **Plugin Manager**: lazy.nvim
- **Language**: Lua
- **Formatter**: stylua
- **Dual Environment**: Pure Neovim and VSCode Neovim extension

### Project Structure

```
├── init.lua                 # Entry point (lazy.nvim bootstrap)
├── lua/
│   ├── config/              # Core settings
│   │   ├── options.lua      # Vim options
│   │   ├── keymaps.lua      # Key mappings
│   │   └── autocmds.lua     # Autocommands
│   ├── plugins/             # Plugin specifications (lazy.nvim)
│   │   ├── ui.lua           # UI/theme/statusline
│   │   ├── lsp.lua          # LSP, Mason, mason-tool-installer
│   │   ├── completion.lua   # Autocompletion
│   │   ├── navigation.lua   # File/buffer navigation
│   │   ├── editing.lua      # Editing tools
│   │   ├── git.lua          # Git integration
│   │   ├── formatting.lua   # Code formatting
│   │   ├── linting.lua      # Code linting
│   │   ├── treesitter.lua   # Syntax parsing
│   │   ├── debugging.lua    # DAP debugging
│   │   ├── terminal.lua     # Terminal
│   │   └── ai.lua           # AI/Claude integration
│   └── vscode-neovim/       # VSCode Neovim extension settings
├── docs/                    # Documentation
│   ├── key-bindings.md      # Key binding reference
│   ├── supported-languages.md
│   └── external-tools.md
└── .stylua.toml             # Lua formatter config
```

## Lua Code Style

Follow the stylua configuration (`.stylua.toml`):

- **Column width**: 120
- **Indent**: 4 spaces
- **Quotes**: Prefer double quotes
- **Call parentheses**: None (e.g., `require "plugin"` not `require("plugin")`)
- **Line endings**: Unix (LF)

Example:

```lua
-- Good
local map = vim.keymap.set
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "File Explorer" })

-- Bad
local map = vim.keymap.set
map('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'File Explorer' })
```

## Plugin Rules

### Adding New Plugins

1. Add plugin spec to the appropriate file in `lua/plugins/`
2. Use lazy loading when possible (`event`, `cmd`, `ft`, `keys`)
3. Include `dependencies` if required
4. Add key mappings in `lua/config/keymaps.lua` with `desc` for which-key

### Plugin Spec Format

```lua
{
    "author/plugin-name",
    event = "VeryLazy",           -- or cmd, ft, keys
    dependencies = { "dep/name" },
    opts = {},                    -- or config = function() end
}
```

## Key Mapping Rules

1. All custom mappings go in `lua/config/keymaps.lua`
2. Use `<leader>` prefix for custom mappings
3. Always include `desc` for which-key integration
4. Group related mappings under a common prefix:
   - `<leader>f` - Telescope/find
   - `<leader>g` - Git
   - `<leader>b` - Buffer
   - `<leader>t` - Terminal
   - `<leader>x` - Trouble/diagnostics
   - `<leader>a` - AI/Claude
   - `<leader>d` - Diagnostics

## Documentation Rules

1. Update `docs/` when adding features that affect:
   - Key bindings → `docs/key-bindings.md`
   - Language support → `docs/supported-languages.md`
   - External tools → `docs/external-tools.md`
2. Keep README.md concise; detailed info goes in `docs/`
3. Maintain both English (`README.md`) and Korean (`README.ko.md`) versions
