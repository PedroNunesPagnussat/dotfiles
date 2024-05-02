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

	symlink_file "tmux.conf"
	symlink_file "pylintrc"
	symlink_file "config/nvim"

	print_success "Done installing dotfiles!"
}

main "$@"
