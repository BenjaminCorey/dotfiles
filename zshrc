# VARIABLES
export SITES=~/Projects
export EDITOR='nvim'
export DOTFILES_DIR=~/dotfiles
export MYVIMRC=~/.vimrc
export MYZSHRC=~/.zshrc
export RBENV_ROOT=~/.rbenv
export JAVA8_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_51.jdk/Contents/Home
export JAVA7_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home
export JAVA_HOME=$JAVA8_HOME
export ROOKERY_DIR=$SITES/rookery
export DATA_INFRA_DIR=$SITES/data-infra
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
export PATH="/usr/local/sbin:$PATH"
export PATH=$JAVA_HOME/bin:$PATH
export PATH="${RBENV_ROOT}/bin:$PATH"
# RUBY
export RUBY_GC_HEAP_INIT_SLOTS=800000
export RUBY_GC_HEAP_FREE_SLOTS=1000000
export RUBY_GC_MALLOC_LIMIT=200000000
eval "$(rbenv init -)"

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
function search-service-indexer() {
  cd $SITES/treehouse/projects/search/lucene
  java -jar build/libs/lucene-all.jar indexer search.yaml
  cd -
}

function search-service-server() {
  cd $SITES/treehouse/projects/search/lucene
  java -jar build/libs/lucene-all.jar server search.yaml
  cd -
}

function aeon-service-server() {
  cd $SITES/treehouse/projects/aeon/service
  java -jar build/libs/service-all.jar server aeon.yaml
  cd -
}

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
