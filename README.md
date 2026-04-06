# INTEGRAL Demos &ndash; Compound Documents

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)

This repository contains two examples designed to showcase the advanced capabilities of the **INTEGRAL Interpreter**: compound document creation, automatic tables of contents, advanced layout, figures, tables, math formulas, and more.

## Featured Demos

* **Simple Job Letter (`letter-job/make.i`):** A simple but professional-looking 2-page job recommendation letter.
* **Complex Publication (`journal-neural/make.i`):** A complex publication consisting of 20 pages and 4 articles that showcases the advantage of INTEGRAL's incremental build system.

## Prerequisites
- [INTEGRAL Desktop](https://integral.ws/download-desktop) (for Windows, macOS or Linux)

## Quick Start

### Download and Setup INTEGRAL Interpreter

1. Download [INTEGRAL Desktop](https://integral.ws/download-desktop) for your platform. Extract the downloaded ZIP to a directory of your choice. We'll refer to this directory as `PATH_TO_INTEGRAL_EXTRACT_DIR`.

2. Add INTEGRAL Interpreter to your system PATH using the commands below. When typing these commands, make sure you replace `/PATH_TO_INTEGRAL_EXTRACT_DIR` (or `C:\PATH_TO_INTEGRAL_EXTRACT_DIR` on Windows) with the path to your actual extraction folder.

**Windows (Command Prompt)**

```cmd
setx PATH "%PATH%;C:\PATH_TO_INTEGRAL_EXTRACT_DIR\exec"
```

**Windows (PowerShell)**

```powershell
[System.Environment]::SetEnvironmentVariable("PATH", $env:PATH + ";C:\PATH_TO_INTEGRAL_EXTRACT_DIR\exec", "User")
```

**macOS**

```bash
sudo ln -s /PATH_TO_INTEGRAL_EXTRACT_DIR/exec/integral-interp-osx /usr/local/bin/integral-interp-osx
```

**Linux**

```bash
sudo ln -s /PATH_TO_INTEGRAL_EXTRACT_DIR/exec/integral-interp-linux /usr/local/bin/integral-interp-linux
```

3. **Important:** Close and reopen your Terminal so the new PATH settings take effect. You can now run INTEGRAL Interpreter from any terminal window.

### Download and Execute INTEGRAL Demos

1. [Download](https://github.com/integral-system/docs-compound/archive/refs/heads/main.zip) or clone this repository (`docs-compound`):

```shell
git clone https://github.com/integral-system/docs-compound.git
```

2. Navigate to the repository's root directory (`docs-compound`) in a new terminal window.

```shell
cd docs-compound/
```

3. Execute the demos:

**Windows**

```cmd
integral-interp-win letter-job\make.i
integral-interp-win journal-neural\make.i
```

**macOS**

```bash
integral-interp-osx letter-job/make.i
integral-interp-osx journal-neural/make.i
```

**Linux**

```bash
integral-interp-linux letter-job/make.i
integral-interp-linux journal-neural/make.i
```

### View, Manipulate & Export

All these sample documents will open in **INTEGRAL Document Editor**, where they can be further manipulated or exported to **PDF** or **SVG** format.

![INTEGRAL Compound Document Screenshot - 1](https://github.com/user-attachments/assets/35965f53-8f56-4621-b4da-37550cca7967)

![INTEGRAL Compound Document Screenshot - 2](https://github.com/user-attachments/assets/8c4385bd-8664-4463-b547-0086df2ea657)

![INTEGRAL Compound Document Screenshot - 3](https://github.com/user-attachments/assets/668d2753-8bf5-4226-9d80-d2adfc2868dd)

### INTEGRAL Source Files

INTEGRAL is an extension of the Squirrel programming language. INTEGRAL source files are standard UTF-8 text files with a `.i` extension. To modify them, simply use your favorite text editor. For the best experience, set your editor's syntax highlighting to **Squirrel**; if that isn't available, **C++**, **C** or **Java** are suitable alternatives.

### Incremental Build System

The first time you run `journal-neural/make.i`, the **INTEGRAL Interpreter** may take a few seconds to compile and render the full 20-page document. 

However, subsequent runs will be nearly instantaneous. If you modify specific articles within this compound document, only the changed sections will be rebuilt. This **incremental build system** ensures a fast and efficient workflow, even when working with complex, multi-part publications.

> **Pro Tip:** To force a complete rebuild from scratch, simply delete the `.tmp` files located in the `letter-job/cache/` or `journal-neural/cache/` subdirectories.
