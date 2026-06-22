---
title: "Terminal guide for new users"
source: "https://code.claude.com/docs/en/terminal-guide#windows"
author:
published:
created: 2026-05-30
description: "A step-by-step guide to installing Claude Code for first-time terminal users on macOS and Windows."
tags:
  - "clippings"
---
You can use Claude Code even if you’ve never used a terminal before. This guide walks you through opening a terminal, installing Claude Code, and your first interactions.

Don’t want to use the terminal? The Claude Code desktop app lets you skip the terminal entirely. Download it for [macOS](https://claude.ai/api/desktop/darwin/universal/dmg/latest/redirect?utm_source=claude_code&utm_medium=docs) or [Windows](https://claude.com/download?utm_source=claude_code&utm_medium=docs), then see the [Desktop quickstart](https://code.claude.com/docs/en/desktop-quickstart) to get started.

## macOS and Linux

Follow these steps to install and start Claude Code from a macOS or Linux terminal. Claude Code requires macOS 13.0 or later. See the [system requirements](https://code.claude.com/docs/en/setup#system-requirements) for supported Linux distributions.

---

## Windows

Follow these steps to optionally install Git for Windows, set up PowerShell, and start Claude Code on Windows. Claude Code requires Windows 10 version 1809 or later. See the [system requirements](https://code.claude.com/docs/en/setup#system-requirements) for full details.

---

## What’s next?

Once you see the Claude Code welcome screen, you’re ready to go. You don’t need to know how to code. Describe what you want in plain English, and Claude writes the code for you.

### Build something

Claude can create projects from a description:

```text
make me a simple webpage that says hello world
```

Claude creates the files for you. Double-click the HTML file to open it in your browser.

### Work with files on your computer

Claude can read and organize files you already have:

```text
look at the screenshots on my Desktop and rename them based on what's in each image
```

### Ask questions

Claude can explain things, help you learn, or plan out a project:

```text
I want to build a personal budget tracker. What would I need?
```

If you don’t have a project yet, that’s fine. Claude can help you start a new one.

### Other ways to use Claude Code

You don’t have to use the terminal. Claude Code is also available in:

- [VS Code](https://code.claude.com/docs/en/vs-code) and [JetBrains IDEs](https://code.claude.com/docs/en/jetbrains) as editor extensions
- The [desktop app](https://code.claude.com/docs/en/desktop-quickstart), with no terminal required
- The [web](https://code.claude.com/docs/en/claude-code-on-the-web) at claude.ai/code for remote sessions
- [GitHub Actions](https://code.claude.com/docs/en/github-actions) and [GitLab CI/CD](https://code.claude.com/docs/en/gitlab-ci-cd) for automation

### Learn more

- [Quickstart](https://code.claude.com/docs/en/quickstart): a guided walkthrough of your first project with Claude Code
- [How Claude Code works](https://code.claude.com/docs/en/how-claude-code-works): understand how Claude reads your files, runs commands, and makes edits
- [Best practices](https://code.claude.com/docs/en/best-practices): get better results with effective prompting and project setup
- [Common workflows](https://code.claude.com/docs/en/common-workflows): step-by-step guides for debugging, testing, refactoring, and more
- [Terminal configuration](https://code.claude.com/docs/en/terminal-config): customize your terminal for the best Claude Code experience

---

## Troubleshooting

### macOS and Linux troubleshooting

If you run into problems installing on macOS or Linux, check these common issues:

'command not found: claude'

If you see `command not found: claude` after installing, your terminal needs to reload its settings. Close the Terminal window and open a new one, then try `claude` again.

If it still doesn’t work, add the install directory to your PATH. Run the command for your shell:

```shellscript
# Zsh (macOS default)
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Bash (Linux default)
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Then try `claude` again. For more details, see [fix your PATH](https://code.claude.com/docs/en/troubleshoot-install#verify-your-path).

Error with HTML code or 'syntax error near unexpected token'

If you see `bash: line 1: syntax error near unexpected token '<'` or HTML code like `<!DOCTYPE html>` in your terminal, the install URL returned a web page instead of the installer script.

If the page says “App unavailable in region,” Claude Code is not available in your country. See [supported countries](https://www.anthropic.com/supported-countries).

Otherwise, try running the command again. If it keeps happening, install with [Homebrew](https://brew.sh/) instead:

```shellscript
brew install --cask claude-code
```

'dyld' error or 'built for Mac OS X 13.0'

For other errors, see the full [installation troubleshooting guide](https://code.claude.com/docs/en/troubleshoot-install).

### Windows troubleshooting

If you run into problems installing on Windows, check these common issues:

'irm is not recognized'

You’re in CMD, not PowerShell. Close this window and open PowerShell instead (`Win + X` then select Windows PowerShell).

Alternatively, use the CMD install command:

```bat
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd
```

SSL/TLS error or 'Could not create SSL/TLS secure channel'

This usually happens on older Windows 10 systems. Run this line first, then retry the install:

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
irm https://claude.ai/install.ps1 | iex
```

'Claude Code on Windows requires either Git for Windows (for bash) or PowerShell'

Neither PowerShell nor Git Bash was found. Claude Code needs at least one shell.

1. Ensure `powershell.exe` is on your `PATH`. Its default location is `C:\Windows\System32\WindowsPowerShell\v1.0\`. Alternatively, install [PowerShell 7](https://aka.ms/powershell), which provides `pwsh`.
2. If you’d rather use Git Bash, install [Git for Windows](https://git-scm.com/downloads/win) per the [first step in the Windows section](#windows).
3. If Git is installed but Claude Code can’t find it, tell it where to look:
	```powershell
	$env:CLAUDE_CODE_GIT_BASH_PATH="C:\Program Files\Git\bin\bash.exe"
	```
	Then run `claude` again. If your Git is installed somewhere else, find the path by running:
	```powershell
	Get-Command git | Select-Object Source
	```
	Look for the `Git\bin` folder in that path and use it instead.

To make this permanent so you don’t have to set it every time, see [configure Git Bash path](https://code.claude.com/docs/en/troubleshoot-install#claude-code-on-windows-requires-either-git-for-windows-for-bash-or-powershell).

'claude is not recognized'

Restart your computer and try again. This usually fixes the problem.

If restarting didn’t help, run these commands to add Claude Code to your PATH:

```powershell
$currentPath = [Environment]::GetEnvironmentVariable('PATH', 'User')
[Environment]::SetEnvironmentVariable('PATH', "$currentPath;$env:USERPROFILE\.local\bin", 'User')
```

Close PowerShell, open a new window, and try `claude` again. See [verify your PATH](https://code.claude.com/docs/en/troubleshoot-install#verify-your-path) for more details.

For other errors, see the full [installation troubleshooting guide](https://code.claude.com/docs/en/troubleshoot-install).