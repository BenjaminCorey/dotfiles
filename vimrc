function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'bling/vim-airline'
Plug 'briancollins/vim-jst'
Plug 'chriskempson/base16-vim'
Plug 'othree/html5.vim'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'pmsorhaindo/syntastic-local-eslint.vim'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'cakebaker/scss-syntax.vim'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
call plug#end()

set nocompatible
set number
set numberwidth=5
" set relativenumber
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set nowrap
set modelines=0
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set background=dark
" Neovim Settings
set termguicolors
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Replay macros in the q register with Q
noremap Q @q

noremap <leader>e :Explore<cr>
" Map Leader to ,
let mapleader = ","

" Use eshint for Syntastic
let g:syntastic_javascript_checkers = ['eslint']
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Copy and paste to the system clipboard
vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P
" Open the alternate buffer with Leader Leader
nnoremap <leader>a <C-^>
" Visual line mode with leader v
noremap <Leader>v V

" Split Keys
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Open new split panes to right and bottom, which feels more natural

set splitbelow
set splitright

" White Space
set list
set listchars=tab:▸\ ,eol:¬,trail:.,extends:#,nbsp:.

set ruler " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Customize FZF
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
" - window (nvim only)
let g:fzf_layout = { 'down': '~30%' }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <c-p> :FZF<cr>

let g:deoplete#enable_at_startup = 1

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
       \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal g`\"" |
  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
colorscheme base16-default-dark
let g:airline_powerline_fonts = 1
set guifont=Menlo_for_Powerline:h14

" Numbers
set number
set numberwidth=5

set wildmode=list:longest,list:full

" Index ctags from any project, including those outside Rails
noremap <Leader>ct :!ctags -R .<CR>

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1

" Always use vertical diffs
set diffopt+=vertical

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_eruby_ruby_quiet_messages = {'regex': 'possibly useless use of a variable in void context'}

" Snippet key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

function! s:neosnippet_complete()
   if pumvisible()
    return "\<c-n>"
    else
    if neosnippet#expandable_or_jumpable() 
      return "\<Plug>(neosnippet_expand_or_jump)"
    endif
    return "\<tab>"
  endif
endfunction

imap <expr><TAB> <SID>neosnippet_complete()

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'

" Working Directory Functions
" follow symlinked file
function! FollowSymlink()
  let current_file = expand('%:p')
  " check if file type is a symlink
  if getftype(current_file) == 'link'
    " if it is a symlink resolve to the actual file path
    "   and open the actual file
    let actual_file = resolve(current_file)
    silent! execute 'file ' . actual_file
  end
endfunction

" set working directory to git project root
" or directory of current file if not git project
function! SetProjectRoot()
  " default to the current file's directory
  lcd %:p:h
  let git_dir = system("git rev-parse --show-toplevel")
  " See if the command output starts with 'fatal' (if it does, not in a git repo)
  let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
  " if git project, change local directory to git project root
  if empty(is_not_git_dir)
    lcd `=git_dir`
  endif
endfunction

" follow symlink and set working directory
autocmd BufRead *
  \ call FollowSymlink() |
  \ call SetProjectRoot()

" netrw: follow symlink and set working directory
autocmd CursorMoved silent *
  " short circuit for non-netrw files
  \ if &filetype == 'netrw' |
  \   call FollowSymlink() |
  \   call SetProjectRoot() |
  \ endif
