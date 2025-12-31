# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000000
setopt notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sine/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# tmux
alias tmls='tmux list-sessions'
tms() {
    tmux switch -t "$1"
}
tmc() {
    tmux new -s "$1" -d && tms "$1"
}

tmk() {
    tmux kill-session -t "$1"
}

tmk9() {
    tmux kill-session -a
}

tmks() {
    tmux kill-server
}

lock() {
    /home/sine/.config/waybar/powermenu.sh
}

sshp() {
    ssh -o PasswordAuthentication=yes "$1"
}

gpush() {
    local branch

    # Determine branch
    if [ $# -eq 0 ]; then
        branch=$(git rev-parse --abbrev-ref HEAD)
        echo "No branch specified, using current branch: $branch"
    else
        branch="$1"
    fi

    # 1️⃣ Push to origin
    echo "Pushing branch '$branch' to origin..."
    git push origin "$branch"
    if [ $? -ne 0 ]; then
        echo "⚠️ Error pushing to origin"
        return 1
    fi

    # 2️⃣ Mirror push to forgejo
    if git remote get-url vcs > /dev/null 2>&1; then
        echo "Mirror-pushing to forgejo..."
        git push --mirror vcs
        if [ $? -ne 0 ]; then
            echo "⚠️ Error during mirror-push to forgejo"
            return 1
        fi
    else
        echo "⚠️ Remote 'forgejo' does not exist, skipping mirror-push"
    fi

    echo "✅ Branch '$branch' successfully pushed to both remotes."
}


gremote() {
    local REMOTE_NAME="vcs"
    local HOST="storage.local.com"
    local PORT=1111
    local USER="sine"
    local REPO_NAME

    # Prüfen, ob wir im Git-Repo sind
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "⚠️ No Git repository found"
        return 1
    fi

    # Repo-Name aus aktuellem Ordner
    REPO_NAME=$(basename "$(git rev-parse --show-toplevel)")

    # Prüfen, ob Remote schon existiert
    if git remote get-url "$REMOTE_NAME" > /dev/null 2>&1; then
        echo "Remote '$REMOTE_NAME' exists. Skipping ..."
        return 0
    fi

    # Remote URL zusammensetzen (SSH)
    local REMOTE_URL="ssh://git@$HOST/$USER/$REPO_NAME.git"

    # Remote hinzufügen
    git remote add "$REMOTE_NAME" "$REMOTE_URL"
    if [ $? -eq 0 ]; then
        echo "✅ Remote '$REMOTE_NAME' added:"
        echo "   $REMOTE_URL"
    else
        echo "⚠️ Could not add remote"
        return 1
    fi
}


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$PATH:/home/sine/.local/bin"

eval "$(oh-my-posh init zsh --config /home/sine/.config/powerlevel10k_classic.omp.json)"
