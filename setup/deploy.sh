#!/usr/bin/env bash

set -euo pipefail

readonly DOTPATH="${HOME}/.dotfiles"

# =============================================================================
# Functions
# =============================================================================

log_info() {
    echo "[INFO] $*"
}

log_skip() {
    echo "[SKIP] $*"
}

log_error() {
    echo "[ERROR] $*" >&2
}

# リンクが破損しているか確認
is_broken_link() {
    local link="$1"
    
    # リンクでない場合はfalse
    [[ ! -L "$link" ]] && return 1
    
    # リンク先が存在するかチェック
    [[ ! -e "$link" ]] && return 0  # 存在しない = 破損（true）
    
    return 1  # 存在する = 正常（false）
}

# 破損リンクを修正
fix_broken_link() {
    local source="$1"
    local target="$2"
    
    log_info "Fixing broken link: $target → $source"
    rm -f "$target"
    ln -s "$source" "$target"
}

# ターゲットが存在しない場合のみリンク作成
create_link_if_missing() {
    local source="$1"
    local target="$2"
    
    # ソース存在確認
    if [[ ! -e "$source" ]]; then
        log_skip "Source not found: $source"
        return 0
    fi
    
    # リンク親ディレクトリ確認
    local target_dir
    target_dir=$(dirname "$target")
    
    if [[ ! -d "$target_dir" ]]; then
        mkdir -p "$target_dir"
    fi
    
    # 既存判定
    if [[ -L "$target" ]]; then
        # シンボリンク（破損チェック）
        if is_broken_link "$target"; then
            fix_broken_link "$source" "$target"
        else
            log_skip "Already linked: $target"
        fi
    elif [[ -e "$target" ]]; then
        # 通常ファイル/ディレクトリ（既存優先）
        log_skip "Already exists (not replacing): $target"
    else
        # 存在しない（新規作成）
        log_info "Creating link: $target → $source"
        ln -s "$source" "$target"
    fi
}

# ディレクトリ内部のファイル/ディレクトリをリンク（新機能）
link_directory_contents() {
    local source_dir="$1"
    local target_dir="$2"
    
    # 【パターン1】ターゲットが存在しない → 全体をリンク
    if [[ ! -e "$target_dir" ]]; then
        log_info "Creating link: $target_dir → $source_dir"
        mkdir -p "$(dirname "$target_dir")"
        ln -s "$source_dir" "$target_dir"
        return 0
    fi
    
    # 【パターン2】ターゲットがシンボリンク → 破損チェック/修正
    if [[ -L "$target_dir" ]]; then
        if is_broken_link "$target_dir"; then
            fix_broken_link "$source_dir" "$target_dir"
        else
            log_skip "Already linked: $target_dir"
        fi
        return 0
    fi
    
    # 【パターン3】ターゲットが通常ディレクトリ → 内部をリンク（新機能）
    if [[ -d "$target_dir" ]]; then
        log_info "Target directory exists, linking contents: $target_dir"
        
        # ソースディレクトリ内のファイル/ディレクトリをリンク
        for item in "$source_dir"/*; do
            if [[ -e "$item" ]]; then
                item_name=$(basename "$item")
                target_item="${target_dir}/${item_name}"
                
                create_link_if_missing "$item" "$target_item"
            fi
        done
        
        return 0
    fi
    
    # 【パターン4】ターゲットが通常ファイル → 無視
    log_skip "Target is a file (not replacing): $target_dir"
}

# =============================================================================
# Main
# =============================================================================

main() {
    log_info "Starting dotfiles deployment"
    
    # dotfiles存在確認
    if [[ ! -d "$DOTPATH" ]]; then
        log_error "dotfiles directory not found: $DOTPATH"
        exit 1
    fi
    
    # ホームディレクトリへ移動
    cd "$HOME" || exit 1
    
    # =================================================================
    # 1. ドットファイル（ホーム直下）
    # =================================================================
    log_info "=== Linking dotfiles in home directory ==="
    
    find "$DOTPATH" -maxdepth 1 -type f -name ".*" \
        -not -name ".git*" \
        | while read -r source_file; do
        
        filename=$(basename "$source_file")
        target="${HOME}/${filename}"
        
        create_link_if_missing "$source_file" "$target"
    done
    
    # =================================================================
    # 2. ディレクトリ（.vim, .docker, .local など）
    # =================================================================
    log_info "=== Linking configuration directories ==="
    
    find "$DOTPATH" -maxdepth 1 -type d -name ".*" \
        -not -name ".git*" \
        -not -name ".dotfiles" \
        | while read -r source_dir; do
        
        dirname=$(basename "$source_dir")
        target="${HOME}/${dirname}"
        
        # 既存ディレクトリがある場合は内部をリンク
        link_directory_contents "$source_dir" "$target"
    done
    
    
    # =================================================================
    # 3. 設定反映
    # =================================================================
    log_info "=== Sourcing shell configuration ==="
    
    if [[ -f "${HOME}/.bash_profile" ]]; then
        # shellcheck disable=SC1091
        . "${HOME}/.bash_profile" 2>/dev/null || log_error "Failed to source .bash_profile"
    elif [[ -f "${HOME}/.bashrc" ]]; then
        # shellcheck disable=SC1091
        . "${HOME}/.bashrc" 2>/dev/null || log_error "Failed to source .bashrc"
    fi
    
    log_info "Deployment complete! ✓"
}

# =============================================================================
# Entry Point
# =============================================================================

main "$@"

