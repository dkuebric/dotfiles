:syntax on
:set ruler
:set sm
:set expandtab
:set tabstop=4
:set shiftwidth=4
:set mouse=a

""" search
:set hlsearch
:set ignorecase
:set smartcase

:set background=dark

""" avoid using your pinky too much
:imap jj <esc>
:imap kk <esc>:w<CR>i
:imap jk <esc>:wq<CR>

:set viminfo='10,\"100,:20,%,n~/.viminfo

""" restore cursor position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

nmap <silent> <leader>s :set nolist!<CR>

func GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)

func GitGrepWord()
  normal! "zyiw
  call GitGrep('-w -e ', getreg('z'))
endf
nmap <C-x>G :call GitGrepWord()<CR>

""" whitepsace nazi
match Todo /\s\+$/
autocmd BufWritePre *.py,*.js,*.r,*.sh :%s/\s\+$//e

""" line-length nazi
:set colorcolumn=100

""" syntax plugins
au BufRead,BufNewFile *.thrift set filetype=thrift
au! Syntax thrift source ~/.vim/thrift.vim

au BufNewFile,BufRead *.html set filetype=htmljinja
au BufNewFile,BufRead *.less set filetype=less

au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown

""" cscope
source ~/.vim/cscope_macros.vim
" http://vim.wikia.com/wiki/Autoloading_Cscope_Database
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()

""" pathogen
execute pathogen#infect()

""" syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 0
let g:syntastic_enable_highlighting = 1
