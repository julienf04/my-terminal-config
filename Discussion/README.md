# Discussion

This section breaks down the design philosophy behind my configurations and explains why I chose these specific tools for my development setup.


## Why WezTerm?

[WezTerm](../WezTerm-config/README.md) is blazingly fast, lightweight, and incredibly configurable. While deep configuration can require a small learning curve, it gives me complete control to shape my terminal environment exactly the way I want it.

### WezTerm vs. Warp

[Warp](https://www.warp.dev/terminal) is another impressive terminal, and I initially gave it a try. However, in my experience running [WSL](https://learn.microsoft.com/windows/wsl/), it suffered severe performance slowdowns-feeling orders of magnitude slower than WezTerm. Speed and responsiveness are non-negotiable for me in a terminal; when I'm firing off rapid sequences of commands, I need instant execution. While Warp offers great out-of-the-box features without requiring extra setup, WezTerm's raw performance makes it the clear winner for my workflow.

### WezTerm vs. Everything Else

Why choose WezTerm over other alternatives? It hits the sweet spot: mature software, excellent documentation, and outstanding cross-platform support across Windows, Linux, and macOS.


## Why Vim?

Because sometimes, simplicity is king. My [Vim](../Vim-config/README.md) setup is deliberately minimalist-zero plugins, zero external dependencies, and just a few general built-in options. When I need to make a quick, lightweight tweak to a file, Vim opens instantly and provides everything I need for the task without any unnecessary overhead.


## Why Neovim?

[Neovim](../Neovim-config/README.md) is my heavy-duty editor for complex tasks and project-level work. Equipped with a curated set of modern plugins, it transforms into a powerful development environment.
My primary use case for Neovim is code supervision alongside AI coding agents: the AI generates code, while I use Neovim to inspect the repository structure, review changes, and step in with manual edits whenever necessary.


## Vim vs. Neovim config philosophy

- [Vim config](../Vim-config/README.md): Engineered to be as portable and minimalist as possible-completely plugin-free with only essential, built-in settings.

- [Neovim config](../Neovim-config/README.md): Prioritizes rich functionality and modern workflow tools, trading strict minimalism, high portability, and raw speed for a more powerful editor experience.
