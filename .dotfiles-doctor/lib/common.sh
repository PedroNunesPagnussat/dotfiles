#!/usr/bin/env bash
# Shared helpers for all smoke tests.
# Output contract: exit 0 on pass, non-zero on fail.
# Each test prints one-line status to stdout; detailed errors to stderr.

if [[ -t 1 ]]; then
  C_RED=$'\033[31m'; C_GRN=$'\033[32m'; C_YLW=$'\033[33m'; C_DIM=$'\033[2m'; C_RST=$'\033[0m'
else
  C_RED=""; C_GRN=""; C_YLW=""; C_DIM=""; C_RST=""
fi

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

pass() { printf "%sPASS%s  %s\n" "$C_GRN" "$C_RST" "$1"; }
fail() { printf "%sFAIL%s  %s\n" "$C_RED" "$C_RST" "$1"; [[ -n "${2:-}" ]] && printf "      %s%s%s\n" "$C_DIM" "$2" "$C_RST"; }
skip() { printf "%sSKIP%s  %s\n" "$C_YLW" "$C_RST" "$1"; }
warn() { printf "%sWARN%s  %s\n" "$C_YLW" "$C_RST" "$1"; }

have() { command -v "$1" >/dev/null 2>&1; }
