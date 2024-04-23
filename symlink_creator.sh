#!/usr/bin/env bash
set -o errexit
set -o nounset



print_header()    { printf "\e[1;37m${@}\e[0m"    ; }
print_success()   { printf "\e[1;32m[v]\e[0m ${@}"; }
print_error()     { printf "\e[1;31m[x]\e[0m ${@}"; }
print_info()      { printf "\e[1;36m[>]\e[0m ${@}"; }
print_ask()       { printf "\e[1;33m[?]\e[0m ${@}"; }


script_dir() { printf "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; }
is_root() { [[ "${EUID}" = 0 ]]; }

symlink_file()
{
    local src_name="${1}"
    local src_path="${dotfiles_dir}/${src_name}"
    local dst_path="${HOME}/.${src_name}"
    print_info "${src_path}\n"
    print_info "    Deleting ${dst_path}\n"
    rm -rf "${dst_path}"
    print_info "    Linking ${src_path} to ${dst_path}\n"
    ln -s "${src_path}" "${dst_path}"
    print_success "    ${src_path} --> ${dst_path}\n"
}


main()
{
    print_header "Gathering system information...\n"
    declare -r dotfiles_dir="$(script_dir)" 
    print_info "Home directory: ${HOME}\n"
    print_info "Dotfiles directory: ${dotfiles_dir}\n"
    print_header "Symlinking files...\n"
    
    symlink_file "bashrc"
    symlink_file "tmux.conf"


    print_success "Done installing dotfiles!\n"
}
main "${@}"

