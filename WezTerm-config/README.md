# My WezTerm config

This is my WezTerm configuration — simple as that.



## Config

### Color and appearance

Visual preferences and styling options for the terminal interface:
* **Typography:** Uses *JetBrains Mono* at size 12 with ligatures disabled (`calt=0`, `clig=0`, `liga=0`).
* **Scrollback:** Keeps a history buffer of 10 000 lines per pane.
* **Inactive Panes:** Applies custom dimming (`inactive_pane_hsb`) to non-active panes.



### Keybindigs

#### My custom keybindings

Custom keyboard shortcuts designed around familiar Windows conventions for a more intuitive everyday workflow.

| Keys | Action |
| ------------ | ------------ |
| `Ctrl + c` | Copies text if selected; otherwise, sends SIGINT (standard terminal interrupt) |
| `Ctrl + v` | Pastes text from the clipboard |
| `Ctrl + z` | Undoes the last edit |
| `Ctrl + Shift + z` | Suspends the foreground process |
| `Ctrl + Left/Right Arrow` | Moves the cursor one word left or right |
| `Ctrl + Backspace` | Deletes the word to the left of the cursor |
| `Ctrl + Shift + f` | Searches text |
| `Ctrl + Alt + Arrow` | Creates a new pane in the specified direction |
| `Alt + Arrow` | Activates the pane in the specified direction |
| `Ctrl + Shift + k` | Moves the active pane to a new tab |
| `Ctrl + Shift + Left/Right Arrow` | Navigates between tabs |
| `Shift + Alt + Left/Right Arrow` | Moves or swaps the current tab position |



#### Useful WezTerm default keybindings

These aren't part of my custom config. They are built-in WezTerm defaults, but they're very useful to keep in mind.

| Keys | Action |
| ------------ | ------------ |
| `Ctrl + Shift + n` | Spawns a new WezTerm window |
| `Ctrl + Shift + t` | Spawns a new tab |
| `Ctrl + Shift + Alt + Arrow` | Adjusts pane size |
| `Alt + Enter` | Toggles full screen |
| `Ctrl + -` | Decreases the font size for the current window |
| `Ctrl + +` | Increases the font size for the current window |
| `Ctrl + 0` | Resets the font size to the default |
| `Ctrl + Shift + Number 1-8` | Navigates to the corresponding tab (1–8) |
| `Ctrl + Shift + 9` | Navigates to the last tab |
| `Ctrl + Shift + u` | Opens the emoji picker |


> [!TIP]
> As a general rule in this config, **`Alt`** is used for managing panes, while **`Shift`** is used for managing tabs.



#### Full WezTerm default keybindings

For a full list of shortcuts, check out the [WezTerm Default Keybindings documentation](https://wezterm.org/config/default-keys.html).



## Setup step by step

1. Install the latest stable version of [WezTerm](https://wezterm.org/installation.html "WezTerm") if you don't already have it.

2. Download the `.wezterm.lua` file and place it in your home directory:

    <details>
    <summary><i>Windows</i></summary>

    > Place it here: `C:\Users\<YourUser>\.wezterm.lua` *(Replace `<YourUser>` with your actual username)*

    </details>

    <details>
    <summary><i>Linux</i></summary>

    > Place it here: `~/.wezterm.lua`
    
    </details>

    <details>
    <summary><i>macOS</i></summary>

    > Place it here: `/Users/<YourUser>/.wezterm.lua` *(Replace `<YourUser>` with your actual username)*

    </details>

3. That's it, enjoy!



## Extra configs

### Default terminal domain

By default, WezTerm opens your local machine's shell. If you are on Windows and want **WSL (Ubuntu)** to open automatically as your default environment:

1. Open your `.wezterm.lua` file and locate the **Environment** section.

2. Uncomment the following line:
   ```lua
   config.default_domain = 'WSL:Ubuntu'
   ```

If you use a different Linux distribution or prefer the standard local terminal, you can leave this line commented out or adjust it to match your preferred domain.



### Background image

My personal setup includes a custom [background image](chill-guy.png). Because file paths vary per computer, you will need to configure this manually if you want to use it:

1. Download the image and save it anywhere on your computer.

2. Open your `.wezterm.lua` file and navigate to **Color and Appearance** $\rightarrow$ **Background image** section.

3. Uncomment and update this line with the absolute path to your downloaded image:

    ```lua
    config.window_background_image = '/absolute/path/to/your/chill-guy.png'
    ```



### Want to Learn More?

For more details on how WezTerm handles configs, check out the official [WezTerm config documentation](https://wezterm.org/config/files.html).



## Why WezTerm?

If you want to know the 'why' behind my WezTerm config and decision-making, read this discussion. (in word 'discussion', link to the discussion.md file that explain the decision-making)