# My Neovim config

This is my [Neovim](https://neovim.io/) configuration — simple as that.



## Config

My Neovim config is designed to prioritize feature-rich functionality and familiar Windows conventions, even if it means sacrificing some portability and minimalism.

### General

- **Editor & Visuals:** Displays line numbers, a persistent tab bar, the cursor position and matching braces.

- **Search:** Case-insensitive search that becomes case-sensitive when you type a capital letter, with incremental search and highlighted results.

- **Indentation:** Automates smart formatting and standardizes spacing to 4 spaces.

- **Usability:** Enables full mouse support, extended undo history, intuitive backspace behavior and arrow keys that move across lines. Horizontal scrolling is inverted, like in any Windows app.

- **Clipboard:** Copies and pastes through the Windows clipboard (`clip.exe` and `powershell.exe`). That setup is only for WSL, on Linux and macOS you can remove it and Neovim will use your system clipboard.



### Keybindings

#### My custom keybindings

Custom keyboard shortcuts designed around familiar Windows conventions, just like in my WezTerm config.

| Keys | Action |
| ------------ | ------------ |
| `Ctrl + c` | Copies the selected text *(Visual mode)* |
| `Ctrl + x` | Cuts the selected text *(Visual mode)* |
| `Ctrl + v` | Pastes text from the clipboard *(handled by WezTerm)* |
| `Ctrl + z` | Undoes the last change |
| `Ctrl + y` | Redoes the last undone change |
| `Ctrl + a` | Selects all the text |
| `Ctrl + Shift + f` | Searches text in the whole file |
| `Enter` | Jumps to the next search result *(after a search)* |
| `Esc` | Clears the search highlighting |
| `Ctrl + Left/Right Arrow` | Moves the cursor one word left or right |
| `Ctrl + Backspace` | Deletes the word to the left of the cursor *(Insert mode)* |

> [!NOTE]
> `Ctrl + z`, `Ctrl + Shift + f`, `Ctrl + Left/Right Arrow` and `Ctrl + Backspace` rely on my WezTerm config, which translates these keys into sequences that Neovim understands.



#### Plugin keybindings

| Keys | Action |
| ------------ | ------------ |
| `Alt + g` | Toggles NERDTree |
| `Alt + h` | Toggles Tagbar *(needs [Tagbar](#tagbar))* |
| `Ctrl + n` | Selects the word under the cursor, press it again to select the next match |
| `Ctrl + Up/Down Arrow` | Adds a cursor above or below |
| `Shift + Left/Right Arrow` | Extends the selection of every cursor |
| `Ctrl + Left Click` | Adds a cursor where you click |
| `Tab` | Accepts the selected completion |
| `Ctrl + Space` | Opens the completion menu |
| `Ctrl + e` | Closes the completion menu |



### Plugins

Plugins are installed automatically on the first launch by Neovim's built-in plugin manager (`vim.pack`).

These work out of the box:

| Plugin | Description |
| ------------ | ------------ |
| [vim-airline](https://github.com/vim-airline/vim-airline) | Informative and prettier statusline |
| [NERDTree](https://github.com/preservim/nerdtree) | File explorer in a tree view |
| [vim-css-color](https://github.com/ap/vim-css-color) | Highlights color codes (like `#2f6a43`) |
| [vim-visual-multi](https://github.com/mg979/vim-visual-multi) | Multiple cursors |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Autocompletion |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Ready-made snippets for many languages |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Ready-made language server configs |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | Installs language servers (`lua_ls` by default) |
| [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | Connects Mason with nvim-lspconfig and enables the servers automatically |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Teaches the Lua language server about the Neovim API (like the `vim` variable) |

These are commented out in [`init.lua (no dependencies)`](init.lua (no dependencies)) because they need extra programs (see [Extra configs](#extra-configs)):

| Plugin | Description | Needs |
| ------------ | ------------ | ------------ |
| [vim-devicons](https://github.com/ryanoasis/vim-devicons) | File icons | [A Nerd Font](#vim-devicons) |
| [Tagbar](https://github.com/preservim/tagbar) | Outline of the current file | [ctags](#tagbar) |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting and colors | [A C compiler and the tree-sitter CLI](#treesitter) |
| `bashls` | Bash language server | [Node.js and npm](#bash-language-server) |
| `jdtls` | Java language server | [JDK 21 or newer](#java-language-server) |



## Setup step by step (full)

Use this if you want all the plugins enabled, without any commented line.

1. Install the latest stable version of [Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md "Neovim") if you don't already have it. It must be **0.12 or newer**, because the config uses its built-in plugin manager.

2. Install the dependencies available in `apt`:

    ```bash
    sudo apt install git curl tar gzip unzip build-essential universal-ctags openjdk-21-jdk
    ```

    Those are:
    - `git`, `curl`, `tar`, `gzip` and `unzip`: used by `vim.pack`, blink.cmp and Mason.
    - `build-essential`: the C compiler used by Treesitter.
    - `universal-ctags`: used by Tagbar.
    - `openjdk-21-jdk`: used by the Java language server.

3. Install [Node.js and npm](https://nodejs.org/en/download), used by the Bash language server.

4. Install the `tree-sitter` CLI (**0.26.1 or newer**, and not through `npm`), used by Treesitter:

    ```bash
    mkdir -p ~/.local/bin
    curl -fLo /tmp/tree-sitter.gz https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz
    gunzip -c /tmp/tree-sitter.gz > ~/.local/bin/tree-sitter
    chmod +x ~/.local/bin/tree-sitter
    ```

5. Make sure your terminal can show Nerd Font icons, used by vim-devicons. WezTerm already includes them, so if you use WezTerm, you can skip this step. Otherwise, install a [Nerd Font](https://www.nerdfonts.com/font-downloads) and set it as your terminal font.

6. Restart your terminal and check that everything is installed:

    ```bash
    node --version && ctags --version && java -version && tree-sitter --version
    ```

7. Download the [`init.lua (full)`](init.lua (full)) file, **rename it to `init.lua`** and place it in your Neovim config folder:

    <details>
    <summary><i>Windows</i></summary>

    > Place it here: `~/.config/nvim/init.lua` *(Inside WSL, not in a Windows folder)*

    </details>

    <details>
    <summary><i>Linux</i></summary>

    > Place it here: `~/.config/nvim/init.lua`

    > Remove the `vim.g.clipboard` block, it only works on WSL. Neovim finds your system clipboard tool by itself *(install `xclip` or `wl-clipboard`)*.

    </details>

    <details>
    <summary><i>macOS</i></summary>

    > Place it here: `~/.config/nvim/init.lua`

    > Remove the `vim.g.clipboard` block, it only works on WSL. Neovim uses your system clipboard by itself.

    </details>

8. Open Neovim and choose **Yes** on the installation prompt. The first launch takes longer than usual, because Treesitter compiles its parsers and Mason downloads the language servers. Wait until everything is installed, then restart Neovim.

9. That's it, enjoy!



## Setup step by step (no dependencies)

Use this if you don't want to install extra dependencies. The plugins that need them are commented out, and you can enable them later in [Extra configs](#extra-configs).

1. Install the latest stable version of [Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md "Neovim") if you don't already have it. It must be **0.12 or newer**, because the config uses its built-in plugin manager.

2. Install the basic tools used by `vim.pack`, blink.cmp and Mason if you don't already have it. Those tools are:
    - git
    - curl
    - tar
    - gzip
    - unzip

3. Download the [`init.lua (no dependencies)`](init.lua (no dependencies)) file, **rename it to `init.lua`** and place it in your Neovim config folder:

    <details>
    <summary><i>Windows</i></summary>

    > Place it here: `~/.config/nvim/init.lua` *(Inside WSL, not in a Windows folder)*

    </details>

    <details>
    <summary><i>Linux</i></summary>

    > Place it here: `~/.config/nvim/init.lua`

    > Remove the `vim.g.clipboard` block, it only works on WSL. Neovim finds your system clipboard tool by itself *(install `xclip` or `wl-clipboard`)*.
    
    </details>

    <details>
    <summary><i>macOS</i></summary>

    > Place it here: `~/.config/nvim/init.lua`

    > Remove the `vim.g.clipboard` block, it only works on WSL. Neovim uses your system clipboard by itself.

    </details>

4. Open Neovim and choose **Yes** on the installation prompt. Wait until everything is installed, then restart Neovim.

5. That's it, enjoy!



## Extra configs

> [!NOTE]
> This section is only useful if you downloaded the no dependencies version of `init.lua` and want to enable specific plugins. If you followed [Setup step by step (full)](#setup-step-by-step-full), everything is already enabled.

Some plugins need extra programs to work, so their lines are commented out in init.lua (each one has a Needs: comment). To enable any of them, read its specific section below for installation instructions and details on how to uncomment its lines.



### Vim-devicons

Adds file icons to NERDTree and the statusline.

1. Make sure your terminal can show Nerd Font icons. WezTerm already includes them, so if you use WezTerm, you can skip this step. Otherwise, install a [Nerd Font](https://www.nerdfonts.com/font-downloads) and set it as your terminal font.

2. Uncomment the `vim-devicons` line in the **Plugins** section of [`init.lua`](init.lua (no dependencies)).



### Tagbar

Shows an outline of the current file (classes, methods, functions and variables).

1. Install Universal Ctags:

    ```bash
    sudo apt install universal-ctags
    ```

2. Uncomment these lines in [`init.lua`](init.lua (no dependencies)):
    - The `tagbar` line in the **Plugins** section.
    - The `Alt + h` keybinding in the **Tagbar** section.



### Treesitter

Better syntax highlighting and colors.

1. Install a C compiler:

    ```bash
    sudo apt install build-essential
    ```

2. Install the `tree-sitter` CLI (**0.26.1 or newer**, and not through `npm`):

    ```bash
    mkdir -p ~/.local/bin
    curl -fLo /tmp/tree-sitter.gz https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz
    gunzip -c /tmp/tree-sitter.gz > ~/.local/bin/tree-sitter
    chmod +x ~/.local/bin/tree-sitter
    ```

    Restart your terminal and check that it works:

    ```bash
    tree-sitter --version
    ```

3. Uncomment these lines in [`init.lua`](init.lua (no dependencies)):
    - The `nvim-treesitter` line in the **Plugins** section.
    - The `install` block and the `FileType` autocmd in the **Treesitter** section.

> [!TIP]
> Add or remove languages in the `install` list. Check the [supported languages](https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md).



### Bash language server

Autocompletion and diagnostics for Bash scripts.

1. Install [Node.js and npm](https://nodejs.org/en/download).

2. Uncomment the `'bashls'` line in the **mason.nvim and mason-lspconfig.nvim** section of [`init.lua`](init.lua (no dependencies)).



### Java language server

Autocompletion and diagnostics for Java.

1. Install JDK 21 or newer:

    ```bash
    sudo apt install openjdk-21-jdk
    ```

2. Uncomment the `'jdtls'` line in the **mason.nvim and mason-lspconfig.nvim** section of [`init.lua`](init.lua (no dependencies)).

> [!NOTE]
> The Java language server only starts inside a project folder, one that has a `pom.xml`, a `build.gradle` or a `.git` folder.



### Want to Learn More?

For more details on how Neovim handles configs, check out the official [Neovim documentation](https://neovim.io/doc/user/), or run `:help vim.pack` inside Neovim.



## Why Neovim?

If you want to know the 'why' behind my Neovim config and decision-making, read this [discussion](../Discussion/README.md).