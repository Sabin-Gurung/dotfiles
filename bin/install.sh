TOOLS=(
  # git
  # curl
  # wget
  # tmux
  # neovim
  # ripgrep
  # fd
  # fzf
  # node
  # python3
  # yazi
  # lf
)

install_mac() {
    echo "🍎 macOS detected"

    # if ! command -v brew >/dev/null 2>&1; then
    #     echo "📦 Installing Homebrew..."
    #     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # fi

    for tool in "${TOOLS[@]}"; do
        echo "📦 brew install $tool"
        brew install "$tool" || true
    done
}

install_mac
