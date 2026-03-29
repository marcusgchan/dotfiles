# Init or install zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"

# === Plugins ===
zinit light zsh-users/zsh-syntax-highlighting

# load completion plugin and configure
zinit ice blockf atpull'zinit creinstall -q .' # reinstall when plugin updated
zinit light zsh-users/zsh-completions

zinit ice as'completion' pick'_bun'
zinit light /Users/marcus/.bun

# Snippets
zinit snippet OMZP::git

autoload -Uz compinit
compinit -q
zinit cdreplay -q

zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# === Plugins end ===


# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Keybindings
bindkey -v
bindkey '^n' history-search-forward
bindkey '^p' history-search-backward
bindkey '^y' autosuggest-accept

# Completion config
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias tsx=~/.config/scripts/tmux-session-dispensary.sh

# pnpm
export PNPM_HOME="/Users/marcus/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/marcus/.lmstudio/bin"
# End of LM Studio CLI section

# add Pulumi to the PATH
export PATH=$PATH:/Users/marcus/.pulumi/bin

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fnm
eval "$(fnm env --use-on-cd --shell zsh)"

eval "$(direnv hook zsh)"

eval "$(fzf --zsh)"
