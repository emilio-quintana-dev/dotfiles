# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands
- Linting: `ru` for Ruby (Rubocop), Neovim LSPs handle other languages
- Tests: `ber` for Ruby tests (Bundle exec rspec)
- JS/TS: `yi` (yarn install), `yb` (yarn build-local), `yw` (yarn watch)
- Python: `pvenv` (create venv), `apvenv` (activate), `runserver` (start server)

## Code Style
- Indentation: 2 spaces for all files, no tabs
- Ruby: Follow Rubocop rules, use Solargraph for completion
- JS/TS: Use ESLint and Prettier
- Naming: Follow existing patterns in each file
- Git: Use existing aliases (`g`, `gcb`, `gcs`), respect git hooks
- Error handling: Handle errors appropriately for each language
- Imports: Group by type and sort alphabetically

## Neovim Config
- Lazy package manager
- LazyVim as base configuration
- Use Lua for all configurations
- Key mappings defined in config/keymaps.lua