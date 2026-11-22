# newfile
A lightweight, POSIX-compliant CLI utility to generate source files with pre-formatted documentation headers across C/C++, Python, Shell, Verilog/VHDL, HTML/CSS, SQL, Lua, Assembly, and more.

## Installation

### Option 1: Using `make`

```sh
git clone [https://github.com/](https://github.com/)<your-username>/newfile.git
cd newfile
make install
````
### Option 2: Without `make` (Alpine / minimal Linux / WSL / macOS)

```sh
git clone [https://github.com/](https://github.com/)<your-username>/newfile.git
cd newfile
./install.sh
```

> **Note:** When run without `sudo`, `newfile` installs to `~/.local/bin` and adds it to your shell profile. Open a new terminal (or run `export PATH="$HOME/.local/bin:$PATH"`) once after first install. To install globally for all users immediately, run `sudo ./install.sh` or `sudo make install`.
## Usage

```sh
newfile main.c          # Create main.c with an interactive header
newfile --config        # Configure global defaults (~/.config/newfile/config)
newfile --show-config   # View current global defaults
newfile --list-languages # List supported extensions and comment styles
```
