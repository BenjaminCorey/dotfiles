DOTFILES_DIR=~/dotfiles
source $DOTFILES_DIR/antigen/antigen.zsh

antigen bundle git
# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
# Tell antigen that you're done.
antigen apply

export PATH="$HOME/.bin:$PATH"

# recommended by brew doctor
export PATH="/usr/local/bin:$PATH"
eval "$(rbenv init - --no-rehash zsh)"

# GOLDKEY
export SSH_AUTH_SOCK=$TMPDIR/ssh-agent-$USER.sock
if ! ps -cu $USER | grep ssh-agent &> /dev/null; then
  ssh-agent -a $SSH_AUTH_SOCK &> /dev/null
fi
alias rekey='killall ssh-agent; ssh-agent -a $SSH_AUTH_SOCK &> /dev/null; ssh-add -s /usr/local/lib/opensc-pkcs11.so'
