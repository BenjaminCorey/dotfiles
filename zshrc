# VARIABLES
export SITES=~/Projects
export EDITOR='nvim'
export DOTFILES_DIR=~/dotfiles
export MYVIMRC=~/.vimrc
export MYZSHRC=~/.zshrc

# ANTIGEN
source $DOTFILES_DIR/antigen/antigen.zsh
antigen bundle rails
antigen bundle zeus
antigen bundle brew
antigen bundle git
antigen bundle web-search
antigen bundle rand-quote
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
export RUBY_HEAP_MIN_SLOTS=800000
export RUBY_FREE_MIN=1000000
export RUBY_GC_MALLOC_LIMIT=200000000
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
alias vimconfig="nvim $MYVIMRC"
alias zshconfig="nvim $MYZSHRC"

# VI MODE
function zle-keymap-select zle-line-init
{
    # change cursor shape in iTerm2
    case $KEYMAP in
        vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # block cursor
        viins|main) print -n -- "\E]50;CursorShape=1\C-G";;  # line cursor
    esac

    zle reset-prompt
    zle -R
}

function zle-line-finish
{
    print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
