set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

Plugin 'tpope/vim-sensible'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'mileszs/ack.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'scrooloose/nerdcommenter'
Plugin 'YankRing.vim'
Plugin 'tpope/vim-surround'
Plugin 'sjl/gundo.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'Conque-Shell'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-fugitive'
Plugin 'deb.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'python-mode/python-mode'
Plugin 'StanAngeloff/php.vim'
Plugin 'TaskList.vim'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tomlion/vim-solidity'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" c/c++ plugins
"Plugin 'craigemery/vim-autotag'
"Plugin 'OmniCppComplete'
"Plugin 'WolfgangMehner/vim-plugins'

" java plugins
"Plugin 'pmd.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" ========== Plugins Configuration ========== 

" netrw
let g:netrw_liststyle = 3           " 0=thin 1=long 2=wide 3=tree

" ctrlp
let g:ctrlp_map = '<leader>f'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 100
set wildignore+=*.pyc

" easymotion
"let g:EasyMotion_leader_key = '<Leader>'

" NERDTree plugin
"let g:NERDTreeHijackNetrw=0
"map <C-n> :NERDTreeToggle<CR>
" open a NERDTree automatically when vim starts up if no files were specified
"autocmd vimenter * if !argc() | NERDTree | endif
" close vim if the only window left open is a NERDTree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" When changing into a project directory with C, tell VIM to change to that same directory
"let g:NERDTreeChDirMode=2

" yankring
let g:yankring_history_dir = '~/.local/share/vim'

" Gundo
"nnoremap <F5> :GundoToggle<CR>

" tagbar
"nmap <F8> :TagbarToggle<CR>
" See https://github.com/majutsushi/tagbar/wiki#markdown
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '/usr/local/bin/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
command MarkdownTags :set filetype=markdown | TagbarOpen

" Powerline
" enable when Powerline_cache_file or Powerline_cache_dir can take paths
" relative to home directory
let g:Powerline_cache_enabled = 0

" ConqueShell
let g:ConqueTerm_CloseOnEnd = 1

" Supertab
" See https://github.com/ervandew/supertab/blob/master/doc/supertab.txt
let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabClosePreviewOnPopupClose = 1
" below two mappings work only in gvim
"let g:SuperTabMappingForward = '<c-space>'
"let g:SuperTabMappingBackward = '<s-c-space>'
" Internally nul is converted to c-space in console vim
"let g:SuperTabMappingForward = '<nul>'
"let g:SuperTabMappingBackward = '<s-nul>'
"let g:SuperTabMappingTabLiteral = '<tab>'

" pyclewn
let g:pyclewn_args = "--window=bottom"

" python-mode
let g:pymode_lint_checker = "pylint"
let g:pymode_lint_ignore = "W"
let g:pymode_lint_maxheight = 6
let g:pymode_lint_maxheight = 15
let g:pymode_folding = 0
" Rename to avoid conflict with jedi
let g:pymode_run_key = '<F11>'
" prefer python-mode documentation
let g:pymode_doc = 1
" set pymode_rope = 1 if you want to use any rope feature such as refactoring
" also create .ropeproject in project root folder if rope is enabled
let g:pymode_rope = 0
" leave pymode_rope_vim_completion = 0 as we will always use jedi for
" auto-completion
let g:pymode_rope_vim_completion = 0

" jedi-vim
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0

" ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" vim-markdown
let g:vim_markdown_folding_disabled = 1

" Eclim (See http://eclim.org/cheatsheet.html)
"autocmd FileType java let g:SuperTabContextDefaultCompletionType = '<c-x><c-u>'
"nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
"nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
"nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>
"autocmd FileType java nnoremap <silent> <buffer> <leader>mc :Mvn compile<cr>
"autocmd FileType java nnoremap <silent> <buffer> <leader>mp :Mvn package<cr>
"autocmd FileType java nnoremap <silent> <buffer> <leader>r :Java %<cr>
"autocmd FileType java nnoremap <silent> <buffer> <leader>c :!javac %<cr>
"autocmd FileType java nnoremap <silent> <buffer> <leader>e :!java $(basename % \| sed 's/.java$//')<cr>

" pmd
"let g:Pmd_Cmd = "/opt/pmd/bin/run.sh"
"let g:Pmd_Rulesets = "./prj/style/pmd/vizury_java_ruleset.xml -version 1.7 -language java"


"========== General configuration ==========

set nobackup
set hidden
set hlsearch
"set number
"set mouse=a
"colorscheme terminal
"set nuw=4
"set smartcase
"set smartindent

" Useful but already provided as part of vim-sensible plugin.
"set backspace=indent,eol,start
"set history=50		" keep 50 lines of command line history
"set ruler		" show the cursor position all the time
"set showcmd		" display incomplete commands
"set incsearch		" do incremental searching
"set laststatus=2

" colorscheme for vimdiff
if &diff
    "colorscheme desert
    highlight DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=white
    highlight DiffChange term=reverse cterm=bold ctermbg=cyan ctermfg=black
    highlight DiffText term=reverse cterm=bold ctermbg=gray ctermfg=black
    highlight DiffDelete term=reverse cterm=bold ctermbg=red ctermfg=black
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Increase vim register size
set viminfo='10,<1000,s10,h

" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
"set viminfo='10,\"100,:20,%,n~/.viminfo

" vmap <C-C> "*y<CR>
" vmap <C-X> "*d<CR>
" map <C-V> "*p<CR>
" nmap <C-V> "*p<CR>
" imap <C-V> <ESC>"*pi<CR>

" automatically focus the window on new nerd tree tabs
autocmd BufNew * wincmd l

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Bash-like autocomplete
set wildmode=longest,list


"========== Gvim ==========

" Remove menu bar
"set guioptions-=m

" Remove toolbar
set guioptions-=T


"========== External Command ==========

" Taken from http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize ' . line('$')
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)


"========== Buffers, Windows & Tabs ==========

" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tips from http://vim.wikia.com/wiki/Easier_buffer_switching 
function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  else
    echo "No matching buffers"
  endif
endfunction

"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")
nnoremap <F5> :buffers<CR>:edit<Space>#


"========== Programming ==========

" Autocompletion
" See http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
"set completeopt=longest,menuone,preview
set completeopt=longest,menuone

" See http://superuser.com/questions/305945/gvim-omni-completion-preview-window-doesnt-go-away
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Preview window on the bottom of vim
" See http://vim-settings.googlecode.com/svn-history/r25/trunk/.vimrc
"function! PreviewDown()
"   if !&previewwindow
"       silent! wincmd P
"   endif
"   if &previewwindow
"       silent! wincmd J
"       silent! wincmd p
"   endif
"endf 
"au BufWinEnter * call PreviewDown()
" Simpler
"set splitbelow

" Python
autocmd FileType python setlocal shiftwidth=4 expandtab tabstop=4 autoindent wrap colorcolumn=80
"autocmd FileType python TagbarOpen
" Use more advanced types of auto-completion such as rope / jedi
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

" C/C++
autocmd FileType c setlocal shiftwidth=2 expandtab tabstop=2 autoindent
autocmd FileType cpp setlocal shiftwidth=2 expandtab tabstop=2 autoindent

" PHP
autocmd FileType php setlocal shiftwidth=4 expandtab tabstop=4 autoindent wrap colorcolumn=80

" Shell
autocmd FileType sh setlocal shiftwidth=2 expandtab tabstop=2 autoindent

" HTML
autocmd FileType html setlocal shiftwidth=2 expandtab tabstop=2 autoindent

" Javascript
if !exists("env")
  autocmd FileType javascript setlocal shiftwidth=2 expandtab tabstop=2 autoindent
elseif env == "khoros"
  autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 autoindent wrap colorcolumn=121
endif

" XML
if !exists("env")
  autocmd FileType xml setlocal shiftwidth=2 expandtab tabstop=2 autoindent
elseif env == "khoros"
  autocmd FileType xml setlocal shiftwidth=4 tabstop=4 autoindent wrap colorcolumn=121
endif

" Markdown
nmap <leader>md :%!/usr/bin/redcarpet --parse-no_intra_emphasis --parse-autolink --render-hard_wrap --parse-fenced_code_blocks<cr><cr>

" Text files
autocmd BufRead,BufNewFile *.txt set spell paste

" Vagrantfile
autocmd BufRead,BufNewFile Vagrantfile setlocal shiftwidth=2 expandtab tabstop=2 autoindent

" Fix for 'crontab -e' not working in OS X
"autocmd filetype crontab setlocal nobackup nowritebackup

" Java
if !exists("env")
  autocmd FileType java setlocal shiftwidth=4 expandtab tabstop=4 autoindent wrap colorcolumn=81
elseif env == "khoros"
  autocmd FileType java setlocal shiftwidth=4 tabstop=4 autoindent wrap colorcolumn=121
endif

" autocmd is not supported in IntelliJ. Hence inferring filetype using
" file extension.
if expand('%:e') == "java"
  noremap <leader>cc :s/^\(\s*\)/\1\/\/<cr>:noh<cr>
  noremap <leader>cu :s/^\(\s*\)\/\//\1/<cr>:noh<cr>

  " Below mappigns are useful in coding contests where square brackets are
  " used for arrays and we want to replace them with curly brackets.
  " See https://vim.fandom.com/wiki/Search_and_replace_in_a_visual_selection
  " and https://vi.stackexchange.com/questions/20622/how-do-i-map-multiple-replace-commands-in-visual-mode
  " and https://stackoverflow.com/questions/24782903/vim-mapping-for-visual-line-mode
  " Note that <bar> doesn't seem to work in IntelliJ. Hence using <cr> for executing
  " multiple commands. Not sure what are the pros/cons of using <bar> vs <cr>
  " though.
  nnoremap <leader>rsc :s/\[/{/g<cr>:s/{\]/[]/g<cr>:s/\]/}/g<cr>:s/\[}/[]/g<cr>:noh<cr>
  noremap <leader>rsc :s/\%V\[/{/g<cr>:'<,'>s/\%V\]/}/g<cr>:noh<cr>
endif
