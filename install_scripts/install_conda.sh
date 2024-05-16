INSTALL_DIR="$HOME/miniconda"
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $INSTALL_DIR
rm miniconda.sh
$INSTALL_DIR/bin/conda init

if command -v zsh >/dev/null 2>&1; then
    # Initialize conda for zsh
    $INSTALL_DIR/bin/conda init zsh
fi
