system_type=$(uname -s)

zmodload zsh/zprof
if [ "$SHLVL" = 1 ]; then
  export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="kennethreitz"
DISABLE_UNTRACKED_FILES_DIRTY="true"

zstyle ':omz:plugins:nvm' lazy yes

plugins=(
  git
  nvm
)
source $ZSH/oh-my-zsh.sh

# FZF
if [ "${system_type}" = "Linux" ]; then
  . /usr/share/fzf/key-bindings.zsh
  . /usr/share/fzf/completion.zsh
elif [ "${system_type}" = "Darwin" ]; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

export LANG=en_AU.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias vim=nvim
alias v=nvim
alias vdev="cd ~/.config/nvim && v"
alias zdev="cd && v ~/.zshrc"
alias ls=eza

function awsauth { ~/Library/aws-auth-bash/auth.sh "$@"; [[ -r "$HOME/.aws/sessiontoken" ]] && . "$HOME/.aws/sessiontoken"; }

if [ "$SHLVL" = 1 ]; then
  export PATH="$HOME/.poetry/bin:$PATH"
fi

export PYTHONBREAKPOINT=pudb.set_trace
export PYTHONDONTWRITEBYTECODE=1

if [ "$SHLVL" = 1 ]; then
  export PATH="$PATH:/Users/amckelvie/Library/miniconda/bin"
fi

export SHELL=/bin/zsh

[ -f "$HOME/.local/share/ghcup/env" ] && source "$HOME/.local/share/ghcup/env"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

if [ "${system_type}" = "Linux" ]; then
  export LD_LIBRARY_PATH=$HOME/.local/lib/arch-mojo:$LD_LIBRARY_PATH
elif [ "${system_type}" = "Darwin" ]; then
  export MODULAR_HOME="~/.modular"
  export PATH="~/.modular/pkg/packages.modular.com_mojo/bin:$PATH"
fi

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
if [ "${system_type}" = "Darwin" ]; then
  complete -C aws_completer aws
fi
