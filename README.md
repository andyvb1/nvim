# ⚡ Neovim Configuration

> A feature-rich Neovim setup

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

---

## ⚠️ Critical Prerequisites

- Neovim 0.11.5+ with a true-color terminal
- Git on `PATH` (for `lazy.nvim` bootstrap, `gitsigns.nvim`, `neo-tree` git status)
- Nerd Font installed for icons used by `nvim-web-devicons`/`lualine.nvim`
- Clipboard provider because `clipboard=unnamedplus`: `xclip` (X11) or `wl-clipboard` (Wayland)
- Java runtime: set `JAVA_HOME=/path/to/jdk-21` (or newer) to match the runtimes referenced in `lua/plugins/config/jdtls.lua`
- DAP networking: ensure `/etc/hosts` contains `localhost   127.0.0.1`

---

## 📦 External Dependencies (per feature)

### Language runtimes, LSPs, and DAP

| Dependency | Used by | Notes |
|------------|--------|-------|
| `openjdk-21`+ | `mfussenegger/nvim-jdtls`, Java DAP/tests | Required for JDT LS; config expects installed JDKs under `/usr/lib/jvm/*`. |
| `java-debug-adapter` & `java-test` (via `:Mason`) | `nvim-dap`, Java testing | Mason packages are loaded in `lua/plugins/config/jdtls.lua` for debugging and test discovery. |
| `nodejs` (>=18) + `npm` | `mason-lspconfig.nvim` servers `pyright`, `eslint` | Pyright and ESLint LSPs run on Node; projects still need their own `eslint` install. |
| `python3` | Editing Python; Pyright | Needed to execute Python files and for the Pyright LSP. |
| `rustc` + `cargo` | `rust_analyzer` | Recommended for rust-analyzer to find the toolchain/standard library. |

### Search, build, and editor tooling

| Dependency | Used by | Notes |
|------------|--------|-------|
| `ripgrep` | `nvim-pack/nvim-spectre`, `telescope.nvim` | Required for live grep/search. |
| `sed` (GNU) | `nvim-pack/nvim-spectre` | Default replace command (`sed`). |
| `fd`/`fdfind` | `telescope.nvim` | Optional but recommended for faster file picking. |
| `bat` | `telescope.nvim` | Optional for rich previews. |
| `gcc`/`clang` + `make` | `nvim-treesitter` | Needed to compile parsers; `tree-sitter` CLI is optional. |
| `ImageMagick` (`magick` CLI) | `3rd/image.nvim`, `neo-tree` previews | Required for the configured `magick_cli` processor. |
| `kitty` (graphics protocol enabled) | `3rd/image.nvim`, `neo-tree` image preview | Required because the backend is set to `kitty`. |

### UI, VCS, and cloud features

| Dependency | Used by | Notes |
|------------|--------|-------|
| `git` | `gitsigns.nvim`, `neo-tree` git status, lazy bootstrap | Must be available in PATH. |

---

## 🚀 Quick Install

### Arch Linux

```bash
sudo pacman -S git ripgrep fd bat sed gcc make nodejs npm python python-pip rustup cargo jdk-openjdk imagemagick kitty
# Clipboard (pick one): sudo pacman -S wl-clipboard   # Wayland
#                       sudo pacman -S xclip          # X11
```

### Debian/Ubuntu

```bash
sudo apt install git ripgrep fd-find bat sed build-essential nodejs npm python3 python3-pip rustc cargo openjdk-21-jdk imagemagick kitty
# Clipboard (pick one): sudo apt install wl-clipboard  # Wayland
#                       sudo apt install xclip         # X11
# fd-find installs as fdfind; optionally symlink: ln -sf $(command -v fdfind) ~/.local/bin/fd
```

---

## 📝 Notes

- Tested on neovim 0.11.5-0.12.0 .
- Mason manages LSP/DAP installs (`lua_ls`, `pyright`, `rust_analyzer`, `jdtls`, `eslint`, Java debug/test).
- Treesitter parsers compile on-demand (requires a working compiler toolchain).
- **Recommended Nerd Font:** [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads)

---

<div align="center">
  <sub>🐢</sub>
</div>
