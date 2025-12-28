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

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$PATH:/home/sine/.local/bin"

eval "$(oh-my-posh init zsh --config /home/sine/.config/powerlevel10k_classic.omp.json)"
