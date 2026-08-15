# AGENTS.md

This file provides guidance to ai agents when working with code in this repository.

## Code Architecture

This is a LazyVim-based Neovim configuration that extends the LazyVim starter template. The configuration follows a standard LazyVim directory structure:

- `init.lua` - Entry point that bootstraps the configuration via `config.lazy`
- `lua/config/` - Core configuration files (lazy.lua, options.lua, keymaps.lua, autocmds.lua)
- `lua/plugins/` - Plugin specifications and overrides

### Plugin Management

The configuration uses lazy.nvim as the plugin manager with LazyVim as the base. Plugin specifications are defined in `lua/plugins/plugins.lua`, which imports LazyVim's default plugins and adds custom overrides.

Key architectural patterns:

- LazyVim extras are enabled via `lazyvim.json` rather than directly in the lazy setup
- Plugin overrides use the `opts` table to modify default configurations
- Some plugins are explicitly disabled with `enabled = false`

### Language Support

The configuration has specific support for:

- **Nix**: Custom nixd LSP configuration with nixfmt formatting
- **Rust**: Rustaceanvim plugin with rust-analyzer excludeDirs for .direnv
- **Zig**: Basic syntax support via zig.vim
- **Orgmode**: Configured with default notes file at ~/org/refile.org

### AI Integration

Multiple AI tools are configured (some disabled):

- **Avante.nvim**: Primary AI assistant with Gemini as default provider
- **Parrot.nvim**: Disabled AI chat interface
- **ChatGPT.nvim**: Disabled OpenAI integration
- **Copilot**: Disabled GitHub Copilot integration

## Development Commands

### Code Formatting

```bash
stylua . --config-path stylua.toml
```

The configuration uses StyLua for Lua formatting with 2-space indentation and 120 column width.

### Plugin Management

```bash
nvim --headless -c "Lazy! sync" -c "qa"  # Sync plugins headless
```

Use `:Lazy` within Neovim for interactive plugin management.

## Configuration Modification Guidelines

- Add new plugins to `lua/plugins/plugins.lua`
- Enable LazyVim extras in `lazyvim.json` rather than directly in config files
- Custom keymaps go in `lua/config/keymaps.lua`
- Custom options go in `lua/config/options.lua`
- LSP server configurations should be added to the `nvim-lspconfig` opts.servers table
- Use `enabled = false` to disable unwanted plugins rather than removing them entirely

