FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip"
FONT_DIR="$HOME/.local/share/fonts"

mkdir -p "$FONT_DIR"

wget -q -O "$FONT_DIR/JetBrainsMono.zip" $FONT_URL
unzip -o "$FONT_DIR/JetBrainsMono.zip" -d "$FONT_DIR"
rm "$FONT_DIR/JetBrainsMono.zip"
fc-cache -f -v
