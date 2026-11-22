#!/bin/sh
# install.sh - portable installer for newfile (works with or without make)
set -eu

PROGRAM=newfile
SOURCE=./newfile

if [ ! -f "$SOURCE" ]; then
    echo "Error: $SOURCE not found. Run this script from the repository directory." >&2
    exit 1
fi

command -v sh >/dev/null 2>&1 || { echo "Error: POSIX sh is required." >&2; exit 1; }
sh -n "$SOURCE"

# Default to /usr/local when run as root, otherwise ~/.local
if [ -z "${PREFIX:-}" ]; then
    if [ "$(id -u)" -eq 0 ]; then
        PREFIX=/usr/local
    else
        PREFIX="$HOME/.local"
    fi
fi

BINDIR=${BINDIR:-"$PREFIX/bin"}
TARGET="$BINDIR/$PROGRAM"

mkdir -p "$BINDIR"
install -m 755 "$SOURCE" "$TARGET"
echo "Installed $PROGRAM to $TARGET"

case ":$PATH:" in
    *":$BINDIR:"*) ;;
    *)
        if [ "$BINDIR" = "$HOME/.local/bin" ]; then
            LINE='export PATH="$HOME/.local/bin:$PATH"'
            UPDATED=""
            for rc in "$HOME/.profile" "$HOME/.bashrc" "$HOME/.zshrc"; do
                if [ -f "$rc" ] || [ "$rc" = "$HOME/.profile" ]; then
                    if ! grep -F '.local/bin' "$rc" >/dev/null 2>&1; then
                        printf '\n# Added by newfile installer\n%s\n' "$LINE" >> "$rc"
                        UPDATED="$UPDATED $rc"
                    fi
                fi
            done
            if [ -n "$UPDATED" ]; then
                echo "Added $BINDIR to PATH in:$UPDATED"
                echo "Run 'export PATH=\"\$HOME/.local/bin:\$PATH\"' or open a new terminal to use $PROGRAM."
            else
                echo "Note: ensure $BINDIR is in your PATH, then open a new terminal."
            fi
        else
            echo "Note: add $BINDIR to your PATH if the command is not found."
        fi
        ;;
esac