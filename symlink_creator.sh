#!/usr/bin/env bash
set -o errexit
set -o nounset

# Logging functions for colored output
print_header() { printf "\e[1;37m%s\e[0m\n" "$@"; }
print_success() { printf "\e[1;32m[v]\e[0m %s\n" "$@"; }
print_error() {
	printf "\e[1;31m[x]\e[0m %s\n" "$@"
	exit 1
}
print_info() { printf "\e[1;36m[>]\e[0m %s\n" "$@"; }
print_ask() { printf "\e[1;33m[?]\e[0m %s" "$@"; }

script_dir() { printf "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; }

is_root() { [[ "${EUID}" = 0 ]]; }

symlink_file() {
	local src_name="${1}"
	local src_path="${dotfiles_dir}/${src_name}"
	local dst_path="${HOME}/.${src_name}"

	print_info "Removing existing file: ${dst_path}"
	rm -rf "${dst_path}"

	print_info "Linking ${src_path} to ${dst_path}"

	ln -s "${src_path}" "${dst_path}"

	print_success "Linked: ${src_path} --> ${dst_path}"
}

# Main function to orchestrate dotfiles installation
main() {
	print_header "Gathering system information..."
	local dotfiles_dir="$(script_dir)"
	print_info "Home directory: ${HOME}"
	print_info "Dotfiles directory: ${dotfiles_dir}"

	print_header "Symlinking files..."

  # MISC
  symlink_file "tmux.conf"
  symlink_file "pylintrc"
  symlink_file "wallpapers"
  # SHELL
  symlink_file "zshrc" 
  symlink_file "zshrc_aliases"
  symlink_file "zshrc_extratools"
  # CONFIG
	symlink_file "config/nvim"
  symlink_file "config/picom"
  symlink_file "config/rofi"
  symlink_file "config/polybar"
	symlink_file "config/i3"
	symlink_file "config/kitty"
	symlink_file "config/ghostty"
	symlink_file "config/terminator"
	symlink_file "config/bat"
	symlink_file "config/ohmyposh"
	symlink_file "config/lf"
  symlink_file "Xmodmap"
  # Custom scripts
  symlink_file "local/bin/greenclip"
  symlink_file "local/bin/power-menu"
  symlink_file "local/bin/autotiling"
  symlink_file "local/bin/display-teia"


  print_success "Done installing dotfiles!"
}

main "$@"
