# VARIABLES
export EDITOR='nvim'
export DOTFILES_DIR=~/dotfiles
export MYZSHRC=~/.zshrc

# ANTIGEN
source $DOTFILES_DIR/antigen/antigen.zsh
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
antigen apply

# PROMPT
autoload -U colors
colors

export CLICOLOR=1
unsetopt nomatch

# PATH
export PATH="$HOME/.bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# RUBY
eval "$(rbenv init - --no-rehash zsh)"

# GOLDKEY
export SSH_AUTH_SOCK=$TMPDIR/ssh-agent-$USER.sock
if ! ps -cu $USER | grep ssh-agent &> /dev/null; then
  ssh-agent -a $SSH_AUTH_SOCK &> /dev/null
fi

# ALIASES
alias rekey='killall ssh-agent; ssh-agent -a $SSH_AUTH_SOCK &> /dev/null; ssh-add -s /usr/local/lib/opensc-pkcs11.so'
alias ll='ls -la'
alias vi='nvim'
alias vim='nvim'
