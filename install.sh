#!/usr/bin/env bash
#
# gitGuard installer
#
# Install (one-liner, pipe to bash):
#   curl -fsSL https://raw.githubusercontent.com/segin-GH/gitGuard/main/install.sh | bash
#
# Uninstall:
#   curl -fsSL https://raw.githubusercontent.com/segin-GH/gitGuard/main/install.sh | bash -s -- --uninstall
#

set -euo pipefail

REPO_RAW_URL="https://raw.githubusercontent.com/segin-GH/gitGuard/main/src"
ZIP_URL="https://github.com/segin-GH/gitGuard/raw/main/dist/gitguard.zip"

# --- state -----------------------------------------------------------------

GIT_DIR=""
HOOKS_DIR=""
GITGUARD_DIR=""
TMP_DIR=""

cleanup() {
    if [ -n "$TMP_DIR" ] && [ -d "$TMP_DIR" ]; then
        rm -rf "$TMP_DIR"
    fi
}
trap cleanup EXIT

# --- pretty output ----------------------------------------------------------

if [ -t 1 ]; then
    BOLD=$'\033[1m'
    GREEN=$'\033[32m'
    YELLOW=$'\033[33m'
    RED=$'\033[31m'
    RESET=$'\033[0m'
else
    BOLD="" GREEN="" YELLOW="" RED="" RESET=""
fi

info()  { printf '%s\n' "${BOLD}[gitGuard]${RESET} $*"; }
ok()    { printf '%s\n' "${BOLD}${GREEN}[gitGuard]${RESET} $*"; }
warn()  { printf '%s\n' "${BOLD}${YELLOW}[gitGuard]${RESET} $*" >&2; }
fail()  { printf '%s\n' "${BOLD}${RED}[gitGuard]${RESET} $*" >&2; exit 1; }

# --- helpers ----------------------------------------------------------------

# gitGuard stamps its hook so we can tell it apart from user-written hooks.
hook_is_gitguard() {
    local hook_file="$1"
    [ -f "$hook_file" ] && grep -qi "gitguard" "$hook_file" 2>/dev/null
}

fetch_file() {
    # fetch_file <url> <destination>
    local url="$1" dest="$2"
    if command -v curl >/dev/null 2>&1; then
        curl -fsSL "$url" -o "$dest"
    elif command -v wget >/dev/null 2>&1; then
        wget -qO "$dest" "$url"
    else
        fail "Neither curl nor wget is available. Install one and retry."
    fi
}

require_git_repo() {
    GIT_DIR="$(git rev-parse --git-dir 2>/dev/null)" \
        || fail "Not inside a git repository. cd into a repo and try again."
    GIT_DIR="$(cd "$GIT_DIR" && pwd)"
    HOOKS_DIR="$(git rev-parse --git-path hooks 2>/dev/null)" \
        || fail "Could not determine the git hooks directory."
    HOOKS_DIR="$(mkdir -p -- "$HOOKS_DIR" && cd "$HOOKS_DIR" && pwd)"
}

# --- uninstall --------------------------------------------------------------

uninstall() {
    require_git_repo

    local hook_file="$HOOKS_DIR/commit-msg"
    if [ ! -e "$hook_file" ]; then
        info "No commit-msg hook found. Nothing to do."
        return 0
    fi

    if ! hook_is_gitguard "$hook_file"; then
        warn "commit-msg hook was not installed by gitGuard. Refusing to remove it."
        return 1
    fi

    rm -f "$hook_file"
    ok "Removed $hook_file"
    info "Note: the .gitguard/ directory (if present) was left in place."
    ok "gitGuard uninstalled."
}

# --- install ----------------------------------------------------------------

install_gitguard() {
    require_git_repo
    GITGUARD_DIR="$(pwd)/.gitguard"
    TMP_DIR="$(mktemp -d)"

    info "Installing gitGuard into: $GITGUARD_DIR"

    mkdir -p "$GITGUARD_DIR"

    # 1) Primary: fetch the two files directly (no unzip dependency).
    if fetch_file "$REPO_RAW_URL/commit-msg" "$TMP_DIR/commit-msg" \
        && fetch_file "$REPO_RAW_URL/gitguard.py" "$TMP_DIR/gitguard.py"; then
        cp "$TMP_DIR/commit-msg" "$GITGUARD_DIR/commit-msg"
        cp "$TMP_DIR/gitguard.py" "$GITGUARD_DIR/gitguard.py"
    else
        # 2) Fallback: dist zip.
        warn "Raw download failed, falling back to dist/gitguard.zip ..."
        fetch_file "$ZIP_URL" "$TMP_DIR/gitguard.zip"
        if ! command -v unzip >/dev/null 2>&1; then
            fail "unzip is required for the fallback download. Install unzip and retry."
        fi
        unzip -q "$TMP_DIR/gitguard.zip" -d "$TMP_DIR/extracted"
        if [ ! -f "$TMP_DIR/extracted/.gitguard/commit-msg" ]; then
            fail "Fallback archive is not in the expected format."
        fi
        cp "$TMP_DIR/extracted/.gitguard/"* "$GITGUARD_DIR/"
    fi

    chmod +x "$GITGUARD_DIR/commit-msg" "$GITGUARD_DIR/gitguard.py"
    ok "Downloaded gitGuard files to $GITGUARD_DIR"

    # 3) Install the hook.
    local hook_file="$HOOKS_DIR/commit-msg"
    if [ -e "$hook_file" ] && ! hook_is_gitguard "$hook_file"; then
        warn "An existing commit-msg hook was found and it is not gitGuard's."
        warn "Refusing to overwrite: $hook_file"
        exit 1
    fi

    cp "$GITGUARD_DIR/commit-msg" "$hook_file"
    chmod +x "$hook_file"
    ok "Installed commit-msg hook: $hook_file"

    ok "gitGuard is ready. Sloppy commits, meet your match."
}

# --- entry point ------------------------------------------------------------

case "${1:-}" in
    --uninstall)
        uninstall
        ;;
    -h|--help)
        printf '%s\n' "Usage: install.sh [--uninstall]"
        printf '%s\n' "  (no args)   install gitGuard commit-msg hook"
        printf '%s\n' "  --uninstall remove the gitGuard commit-msg hook"
        ;;
    "")
        install_gitguard
        ;;
    *)
        fail "Unknown option: $1 (try --help)"
        ;;
esac
