" .vimrc
" An assortment of little vim tricks collected from numerous sources.
" Most functionality comes from these authors:
"
" -------------------------------------------------------------------------
" Author: janus Vim Distribution
" Source: https://github.com/carlhuda/janus
" -------------------------------------------------------------------------
" -------------------------------------------------------------------------
" Author: Frew
" Source: http://stackoverflow.com/questions/164847/what-is-in-your-vimrc
" -------------------------------------------------------------------------
" -------------------------------------------------------------------------
" Author: Steve Losh <steve@stevelosh.com>
" Source: http://bitbucket.org/sjl/dotfiles/src/tip/vim/
" -------------------------------------------------------------------------

" General settings {{{

  " The basics
  set nocompatible
  set number
  set ruler
  set tabstop=2
  syntax on
  set shiftwidth=2
  set softtabstop=2
  set list listchars=tab:\ \ ,trail:·
  set expandtab

  " Default color scheme
  "colorscheme mirodark " Everybody likes shiny colors!
  color desert
  set transparency=10

  " Set encoding
  set encoding=utf-8
  set enc=utf-8

  " Start in fullscreen mode
  set fullscreen

  " Tab completion
  " set wildmode=list:longest,list:full
  " set wildignore+=*.o,*.obj,.git,*.rbc

  " Status bar
  set laststatus=2

  " allow backspacing over everything in insert mode
  set backspace=indent,eol,start

  " Use modeline overrides
  set modeline
  set modelines=10

  " This shows what you are typing as a command.
  set showcmd

  set cursorline
  set ttyfast
  set history=1000
  set undofile
  set undoreload=10000
  set splitbelow
  set splitright
  set autoread
  set dictionary=/usr/share/dict/words

  " Resize splits when the window is resized
  au VimResized * exe "normal! \<c-w>="

  set undodir=~/.vim/tmp/undo//     " undo files
  "set backupdir=~/.vim/tmp/backup// " backups

" }}}
" Movement {{{

  set scrolloff=6
  set sidescroll=1
  set sidescrolloff=10

" }}}
" MacVIM Settings {{{

  " Show toolbar in MacVIM
  if has("gui_running")
    set guioptions+=T

    "set guifont=Menlo:h12
    set guifont=Inconsolata:h14

    " Remove all the UI cruft
    "set go-=T
    "set go-=l
    "set go-=L
    "set go-=r
    "set go-=R

    highlight SpellBad term=underline gui=undercurl guisp=Orange

    " Different cursors for different modes.
    "set guicursor=n-c:block-Cursor-blinkon0
    "et guicursor+=v:block-vCursor-blinkon0
    "et guicursor+=i-ci:ver20-iCursor

    if has("gui_macvim")
        " Full screen means FULL screen
        set fuoptions=maxvert,maxhorz
    else
        " Non-MacVim GUI, like Gvim
    end
  else
    " Console Vim
  endif

" }}}
" German Keyboard options {{{

  " Change default modifier key (German keyboard)
  let  mapleader=","

  " Jump to above/below paragraph with t/T
  " This is useful for German Keyboards, since
  " the curly brackets are hidden behind some meta-key
  noremap Ö {
  noremap ö }

"}}}
" Folding options {{{

  set foldtext=MyFoldText()

  function! MyFoldText()
    " do whatever processing you want here
    " the function will be called for each folded line visible on screen
    " the line number of each fold's "head" line will be in v:foldstart
    " last line of fold in v:foldend
    " can do whatever processing you want, then return text you want
    " displayed:
    let line = getline(v:foldstart)
    " Remove comment characters and gibberish
    let line = substitute(line, "{,\\=[^,]*$", "", "g")
    let foldedlinecount = v:foldend - v:foldstart
    return '+-'.line.'['.foldedlinecount.']'
  endfunction

  au BufWinLeave *.* mkview           " Remember manual foldings
  au BufWinEnter *.* silent loadview  " Load foldings on startup
  "set foldminlines=5 " Minimum lines to create fold

  set foldlevelstart=0

  " Space to toggle folds.
  nnoremap <Space> za
  vnoremap <Space> za

  " Make zO recursively open whatever top level fold we're in, no matter where the
  " cursor happens to be.
  nnoremap zO zCzO

  " Use ,z to "focus" the current fold.
  nnoremap <leader>z zMzvzz

  "function! MyFoldText() " {{{
  "    let line = getline(v:foldstart)
  "
  "    let nucolwidth = &fdc + &number * &numberwidth
  "    let windowwidth = winwidth(0) - nucolwidth - 3
  "    let foldedlinecount = v:foldend - v:foldstart
  "
  "    " expand tabs into spaces
  "    let onetab = strpart('          ', 0, &tabstop)
  "    let line = substitute(line, '\t', onetab, 'g')
  "
  "    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  "    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  "    return line . 'â€¦' . repeat(" ",fillcharcount) . foldedlinecount . 'â€¦' . ' '
  "endfunction " }}}
  "set foldtext=MyFoldText()


" }}}
" Mappings {{{

  " Don't switch to insert mode after inserting a new line
  nnoremap * maO<esc>`a
  nnoremap + mao<esc>`a

  " Move through wrapped lines as expected
  noremap  <buffer> <silent> k gk
  noremap  <buffer> <silent> j gj
  noremap  <buffer> <silent> 0 g0
  noremap  <buffer> <silent> $ g$

  " Opens an edit command with the path of the currently edited file filled in
  " Normal mode: <Leader>e
  map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

  " Opens a tab edit command with the path of the currently edited file filled in
  " Normal mode: <Leader>t
  map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

  " Inserts the path of the currently edited file into a command
  " Command mode: Ctrl+P
  cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

  " Unimpaired configuration
  " Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv
  " Map up and down keys to page scrolling
  map <Down> <c-e>
  map <Up> <c-y>
  map <S-Down> j
  map <S-Up> k

  " Remap jj to escape in insert mode.
  inoremap jj <Esc>
  nnoremap JJJJ <Nop>

  " Open Url on this line with the browser \w
  map <Leader>w :call Browser ()<CR>

  " Open the Project Plugin <F2>
  nnoremap <silent> <F2> :Project<CR>
  nnoremap <silent> <Leader>pal  :Project .vimproject<CR>

  " Up and down are more logical with g..
  inoremap <silent> <Up> <Esc>gka
  inoremap <silent> <Down> <Esc>gja

  " Create Blank Newlines and stay in Normal mode
  nnoremap <silent> zj o<Esc>
  nnoremap <silent> zk O<Esc>

  " Search mappings: These will make it so that going to the next one in a
  " search will center on the line it's found in.
  map N Nzz
  map n nzz
  " Rainbox Parentheses {{{

  nnoremap <leader>R :RainbowParenthesesToggle<cr>
  let g:rbpt_colorpairs = [
      \ ['brown',       'RoyalBlue3'],
      \ ['Darkblue',    'SeaGreen3'],
      \ ['darkgray',    'DarkOrchid3'],
      \ ['darkgreen',   'firebrick3'],
      \ ['darkcyan',    'RoyalBlue3'],
      \ ['darkred',     'SeaGreen3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['brown',       'firebrick3'],
      \ ['gray',        'RoyalBlue3'],
      \ ['black',       'SeaGreen3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['Darkblue',    'firebrick3'],
      \ ['darkgreen',   'RoyalBlue3'],
      \ ['darkcyan',    'SeaGreen3'],
      \ ['darkred',     'DarkOrchid3'],
      \ ['red',         'firebrick3'],
      \ ]
  let g:rbpt_max = 16


  " }}}

  " Easy filetype switching {{{
  nnoremap _md :set ft=markdown<CR>
  nnoremap _hd :set ft=htmldjango<CR>
  nnoremap _jt :set ft=htmljinja<CR>
  nnoremap _cw :set ft=confluencewiki<CR>
  nnoremap _pd :set ft=python.django<CR>
  nnoremap _d  :set ft=diff<CR>

" }}}
"}}}
" Searching {{{

set hlsearch
set incsearch
set ignorecase
set smartcase

"}}}
" Tricks {{{

  " Remember last location in file
  if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal g'\"" | endif
  endif

  " Fix common typos
  :command WQ wq
  :command Wq wq
  :command W w
  :command Q q

  " Set off the other paren
  highlight MatchParen ctermbg=4

  " Keep search matches in the middle of the window and pulse the line when moving
  " to them.
  nnoremap n nzzzv:call PulseCursorLine()<cr>
  nnoremap N Nzzzv:call PulseCursorLine()<cr>
  " Split/Join {{{
    "
    " Basically this splits the current line into two new ones at the cursor position,
    " then joins the second one with whatever comes next.
    "
    " Example:                      Cursor Here
    "                                    |
    "                                    V
    " foo = ('hello', 'world', 'a', 'b', 'c',
    "        'd', 'e')
    "
    "            becomes
    "
    " foo = ('hello', 'world', 'a', 'b',
    "        'c', 'd', 'e')
    "
    " Especially useful for adding items in the middle of long lists/tuples in Python
    " while maintaining a sane text width.
    nnoremap K h/[^ ]<cr>"zd$jyyP^v$h"zpJk:s/\v +$//<cr>:noh<cr>j^
  " }}}
" Next and last text object {{{

" Motion for "next/last object". For example, "din(" would go to the next "()" pair
" and delete its contents.

onoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>

onoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>

function! s:NextTextObject(motion, dir)
  let c = nr2char(getchar())

  if c ==# "b"
      let c = "("
  elseif c ==# "B"
      let c = "{"
  elseif c ==# "d"
      let c = "["
  endif

  exe "normal! ".a:dir.c."v".a:motion.c
endfunction

" }}}

" }}}
" Filetype-specific settings {{{

  " load the plugin and indent settings for the detected filetype
  filetype plugin indent on
  " C {{{

  augroup ft_c
      au!
      au FileType c setlocal foldmethod=syntax
  augroup END

  " }}}
  " Clojure {{{

  let g:slimv_leader = '\'
  let g:slimv_keybindings = 2

  augroup ft_clojure
      au!

      au FileType clojure call TurnOnClojureFolding()
      au FileType clojure compiler clojure
      au FileType clojure setlocal report=100000
      au FileType clojure nnoremap <buffer> o jI<cr><esc>kA
      au FileType clojure nnoremap <buffer> O I<cr><esc>kA

      au BufWinEnter        Slimv.REPL.clj setlocal winfixwidth
      au BufNewFile,BufRead Slimv.REPL.clj setlocal nowrap
      au BufNewFile,BufRead Slimv.REPL.clj setlocal foldlevel=99
      au BufNewFile,BufRead Slimv.REPL.clj nnoremap <buffer> A GA
      au BufNewFile,BufRead Slimv.REPL.clj nnoremap <buffer> <localleader>R :emenu REPL.<Tab>

      " Fix the eval mapping.
      au FileType clojure nmap <buffer> \ee \ed

      " Indent top-level form.
      au FileType clojure nmap <buffer> <localleader>= v((((((((((((=%

      " Use a swank command that works, and doesn't require new app windows.
      au FileType clojure let g:slimv_swank_cmd='!dtach -n /tmp/dtach-swank.sock -r winch lein swank'
  augroup END

  " }}}
  " CSS and LessCSS {{{

  augroup ft_css
      au!

      au BufNewFile,BufRead *.less setlocal filetype=less

      au Filetype less,css setlocal foldmethod=marker
      au Filetype less,css setlocal foldmarker={,}
      au Filetype less,css setlocal omnifunc=csscomplete#CompleteCSS
      au Filetype less,css setlocal iskeyword+=-

      " Use <leader>S to sort properties.  Turns this:
      "
      "     p {
      "         width: 200px;
      "         height: 100px;
      "         background: red;
      "
      "         ...
      "     }
      "
      " into this:

      "     p {
      "         background: red;
      "         height: 100px;
      "         width: 200px;
      "
      "         ...
      "     }
      au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

      " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
      " positioned inside of them AND the following code doesn't get unfolded.
      au BufNewFile,BufRead *.less,*.css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
  augroup END

  " }}}
  " HTML and HTMLDjango {{{

  augroup ft_html
      au!

      au BufNewFile,BufRead *.html setlocal filetype=htmldjango
      au FileType html,jinja,htmldjango setlocal foldmethod=manual

      " Use <localleader>f to fold the current tag.
      au FileType html,jinja,htmldjango nnoremap <buffer> <localleader>f Vatzf

      " Use Shift-Return to turn this:
      "     <tag>|</tag>
      "
      " into this:
      "     <tag>
      "         |
      "     </tag>
      au FileType html,jinja,htmldjango nnoremap <buffer> <s-cr> vit<esc>a<cr><esc>vito<esc>i<cr><esc>

      " Smarter pasting
      " au FileType html,jinja,htmldjango nnoremap <buffer> p :<C-U>YRPaste 'p'<CR>v`]=`]
      " au FileType html,jinja,htmldjango nnoremap <buffer> P :<C-U>YRPaste 'P'<CR>v`]=`]
      " au FileType html,jinja,htmldjango nnoremap <buffer> Ï€ :<C-U>YRPaste 'p'<CR>
      " au FileType html,jinja,htmldjango nnoremap <buffer> âˆ :<C-U>YRPaste 'P'<CR>

      " Django tags
      au FileType jinja,htmldjango inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>

      " Django variables
      au FileType jinja,htmldjango inoremap <buffer> <c-f> {{<space><space>}}<left><left><left>
  augroup END

  " }}}
  " Java {{{

  augroup ft_java
      au!

      au FileType java setlocal foldmethod=marker
      au FileType java setlocal foldmarker={,}
  augroup END

  " }}}
  " Javascript {{{

  augroup ft_javascript
      au!

      au FileType javascript setlocal foldmethod=marker
      au FileType javascript setlocal foldmarker={,}
  augroup END

  " }}}
  " Latex {{{
  " Disable vimspell in latex because
  " the cursor will me misplaced when entering a dot or a comma.
  "augroup ft_tex
  "    au!
  "    au FileType tex let loaded_vimspell=1
  "augroup END
  let loaded_vimspell=1

  " }}}
  " Lisp {{{

    augroup ft_lisp
        au!
        au FileType lisp call TurnOnLispFolding()
    augroup END

    let g:lisp_rainbow = 1

  " }}}
  " Markdown {{{

  augroup ft_markdown
      au!

      au BufNewFile,BufRead *.m*down setlocal filetype=markdown

      " Use <localleader>1/2/3 to add headings.
      au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=
      au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-
      au Filetype markdown nnoremap <buffer> <localleader>3 I### <ESC>
  augroup END

  " md, markdown, and mk are markdown and define buffer-local preview
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

  " }}}
  " Nginx {{{

  augroup ft_nginx
      au!

      au BufRead,BufNewFile /etc/nginx/conf/*                      set ft=nginx
      au BufRead,BufNewFile /etc/nginx/sites-available/*           set ft=nginx
      au BufRead,BufNewFile /usr/local/etc/nginx/sites-available/* set ft=nginx
      au BufRead,BufNewFile vhost.nginx                            set ft=nginx

      au FileType nginx setlocal foldmethod=marker foldmarker={,}
  augroup END

  " }}}
  " OrgMode {{{

  augroup ft_org
      au!

      au Filetype org nmap <buffer> Q vahjgq
  augroup END

  " }}}
  " Pentadactyl {{{

  augroup ft_pentadactyl
      au!
      au BufNewFile,BufRead .pentadactylrc set filetype=pentadactyl
      au BufNewFile,BufRead ~/Library/Caches/TemporaryItems/pentadactyl-*.tmp set nolist wrap linebreak columns=100 colorcolumn=0
  augroup END

  " }}}
  " Plaintext {{{
    au BufRead,BufNewFile *.txt call s:setupWrapping()
  "}}}
  " Puppet {{{

  augroup ft_puppet
      au!

      au Filetype puppet setlocal foldmethod=marker
      au Filetype puppet setlocal foldmarker={,}
  augroup END

  " }}}
  " Python {{{

  augroup ft_python
      au!

      au Filetype python noremap  <buffer> <localleader>rr :RopeRename<CR>
      au Filetype python vnoremap <buffer> <localleader>rm :RopeExtractMethod<CR>
      au Filetype python noremap  <buffer> <localleader>ri :RopeOrganizeImports<CR>

      au FileType python setlocal omnifunc=pythoncomplete#Complete
      au FileType python setlocal define=^\s*\\(def\\\\|class\\)
      au FileType python compiler nose
      au FileType man nnoremap <buffer> <cr> :q<cr>
  augroup END

  " }}}
  " QuickFix {{{

  augroup ft_quickfix
      au!
      au Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap
  augroup END

  " }}}
  " ReStructuredText {{{

  augroup ft_rest
      au!

      au Filetype rst nnoremap <buffer> <localleader>1 yypVr=
      au Filetype rst nnoremap <buffer> <localleader>2 yypVr-
      au Filetype rst nnoremap <buffer> <localleader>3 yypVr~
      au Filetype rst nnoremap <buffer> <localleader>4 yypVr`
  augroup END

  " }}}
  " Ruby {{{

  augroup ft_ruby
      au!
      au Filetype ruby setlocal foldmethod=syntax
  augroup END

  " }}}
  " Thorfile, Rakefile and Gemfile {{{
    au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby
  " }}}
  " Vagrant {{{

  augroup ft_vagrant
      au!
      au BufRead,BufNewFile Vagrantfile set ft=ruby
  augroup END

  " }}}
  " Vim {{{

  augroup ft_vim
      au!

      au FileType vim setlocal foldmethod=marker
      au FileType help setlocal textwidth=78
      au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
  augroup END

  " }}}
" }}}
" Swap files {{{

  "Directories for swp files
  set backupdir=~/.vim/backup
  set directory=~/.vim/backup

"}}}
" Coding options {{{
  " This enables automatic indentation as you type.
  filetype indent on
" }}}
" Auto Commands {{{

  " Automatically cd into the directory that the file is in
  " autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
  set autochdir

  " Remove any trailing whitespace that is in the file
  autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

  " Restore cursor position to where it was before
  augroup JumpCursorOnEdit
     au!
     autocmd BufReadPost *
              \ if expand("<afile>:p:h") !=? $TEMP |
              \   if line("'\"") > 1 && line("'\"") <= line("$") |
              \     let JumpCursorOnEdit_foo = line("'\"") |
              \     let b:doopenfold = 1 |
              \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
              \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
              \        let b:doopenfold = 2 |
              \     endif |
              \     exe JumpCursorOnEdit_foo |
              \   endif |
              \ endif
     " Need to postpone using "zv" until after reading the modelines.
     autocmd BufWinEnter *
              \ if exists("b:doopenfold") |
              \   exe "normal zv" |
              \   if(b:doopenfold > 1) |
              \       exe  "+".1 |
              \   endif |
              \   unlet b:doopenfold |
              \ endif
  augroup END

"}}}
" Functions {{{
  " Wrapping (used by Markdown) {{{
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=72
  endfunction
  " }}}
  " Markup leader (used by Markdown) {{{

      function s:setupMarkup()
        call s:setupWrapping()
        map <buffer> <Leader>p :Mm <CR>
      endfunction

  "}}}
  " Handle URL {{{
    " Stolen from https://github.com/askedrelic/homedir/blob/master/.vimrc
    " OSX only: Open a web-browser with the URL in the current line
    function! HandleURI()
        let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
        echo s:uri
        if s:uri != ""
            exec "!open \"" . s:uri . "\""
        else
            echo "No URI found in line."
        endif
    endfunction
    map <leader>u :call HandleURI()<CR>
  " }}}
  " Indent Guides {{{

    let g:indentguides_state = 0
    function! IndentGuides() " {{{
        if g:indentguides_state
            let g:indentguides_state = 0
            2match None
        else
            let g:indentguides_state = 1
            execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
        endif
    endfunction " }}}
    nnoremap <leader>i :call IndentGuides()<cr>

  " }}}
  " Block Colors {{{

    let g:blockcolor_state = 0
    function! BlockColor() " {{{
        if g:blockcolor_state
            let g:blockcolor_state = 0
            call matchdelete(77880)
            call matchdelete(77881)
            call matchdelete(77882)
            call matchdelete(77883)
        else
            let g:blockcolor_state = 1
            call matchadd("BlockColor1", '^ \{4}.*', 1, 77880)
            call matchadd("BlockColor2", '^ \{8}.*', 2, 77881)
            call matchadd("BlockColor3", '^ \{12}.*', 3, 77882)
            call matchadd("BlockColor4", '^ \{16}.*', 4, 77883)
        endif
    endfunction " }}}
    nnoremap <leader>B :call BlockColor()<cr>

  " }}}
  " Pulse ------------------------------------------------------------------- {{{

  function! PulseCursorLine()
      let current_window = winnr()

      windo set nocursorline
      execute current_window . 'wincmd w'

      setlocal cursorline

      redir => old_hi
          silent execute 'hi CursorLine'
      redir END
      let old_hi = split(old_hi, '\n')[0]
      let old_hi = substitute(old_hi, 'xxx', '', '')

      hi CursorLine guibg=#2a2a2a ctermbg=233
      redraw
      sleep 20m

      hi CursorLine guibg=#333333 ctermbg=235
      redraw
      sleep 20m

      hi CursorLine guibg=#3a3a3a ctermbg=237
      redraw
      sleep 20m

      hi CursorLine guibg=#444444 ctermbg=239
      redraw
      sleep 20m

      hi CursorLine guibg=#3a3a3a ctermbg=237
      redraw
      sleep 20m

      hi CursorLine guibg=#333333 ctermbg=235
      redraw
      sleep 20m

      hi CursorLine guibg=#2a2a2a ctermbg=233
      redraw
      sleep 20m

      execute 'hi ' . old_hi

      windo set cursorline
      execute current_window . 'wincmd w'
  endfunction

  " }}}
"}}}
" Status line {{{

augroup ft_statuslinecolor
    au!

    au InsertEnter * hi StatusLine ctermfg=196 guifg=#FF3145
    au InsertLeave * hi StatusLine ctermfg=130 guifg=#CD5907
augroup END

set statusline=%f    " Path.
set statusline+=%m   " Modified flag.
set statusline+=%r   " Readonly flag.
set statusline+=%w   " Preview window flag.

set statusline+=\    " Space.

set statusline+=%#redbar#                " Highlight the following as a warning.
"set statusline+=%{SyntasticStatuslineFlag()} " Syntastic errors.
set statusline+=%*                           " Reset highlighting.

set statusline+=%=   " Right align.

" File format, encoding and type.  Ex: "(unix/utf-8/python)"
set statusline+=(
set statusline+=%{&ff}                        " Format (unix/DOS).
set statusline+=/
set statusline+=%{strlen(&fenc)?&fenc:&enc}   " Encoding (utf-8).
set statusline+=/
set statusline+=%{&ft}                        " Type (python).
set statusline+=)

" Line and column position and counts.
set statusline+=\ (line\ %l\/%L,\ col\ %03c)

" }}}
" Plugin Config {{{
  " NERDTree configuration {{{
    let NERDTreeShowHidden=1

    " Shorcut to open NerdTree
    let NERDTreeIgnore=['\.rbc$', '\~$']
    map <Leader>n :NERDTreeToggle<CR>
  " }}}
  " Command-T configuration {{{
    let g:CommandTMaxHeight=20
  " }}}
  " ZoomWin configuration {{{
      " Without setting this, ZoomWin restores windows in a way that causes
      " equalalways behavior to be triggered the next time CommandT is used.
      " This is likely a bludgeon to solve some other issue, but it works
      set noequalalways
      map <Leader><Leader> :ZoomWin<CR>
  " }}}
  " CTags {{{
    map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
  " }}}
  " Vundle Package Manager {{{

    filetype off " This is needed for Vundle Package manager
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    " let Vundle manage Vundle, which seems odd, but is required!
    Bundle 'gmarik/vundle'
    Bundle 'douglascrockford/JSLint'
    Bundle 'vimspell'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'kien/rainbow_parentheses.vim'

  "}}}
  " Spelling options (including Vimspell) {{{
    let spell_language_list = "english"
    let spell_auto_type = "all" " Check every filetype
    highlight SpellErrors ctermfg=Red guifg=Red
    \ cterm=underline gui=underline term=reverse

    " Use english for spellchecking, but don't spellcheck by default
    if version >= 700
       set spl=en spell
       set nospell
    endif
  " }}}
  " Latex stuff {{{
    let g:tex_flavor = "latex"
    set suffixes+=.log,.aux,.bbl,.blg,.idx,.ilg,.ind,.out,.pdf
    " REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
    filetype plugin on

    " grep will sometimes skip displaying the file name if you
    " search in a singe file. This will confuse Latex-Suite. Set your grep
    " program to always generate a file-name.
    set grepprg=grep\ -nH\ $*

    " Starting with Vim 7, the filetype of empty .tex files defaults to
    " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
    " The following changes the default filetype back to 'tex':
    let g:tex_flavor='latex'
  " }}}
  " Rainbow Parentheses {{{
      au VimEnter * RainbowParenthesesToggle
      "au Syntax * RainbowParenthesesLoadRound " automatic loading
      au Syntax * RainbowParenthesesLoadSquare
      au Syntax * RainbowParenthesesLoadBraces
      au Syntax * RainbowParenthesesLoadChevrons
  " }}}
"}}}
" Sandbox (Experimental/Testing) {{{

  " make and python use real tabs
  " au FileType make set noexpandtab
  " au FileType python set noexpandtab
  "

  " Use Node.js for JavaScript interpretation
  " This removes the following error message:
  " 'Unable to invoke JSlint'
  let $JS_CMD='node'
  " set nowrap

  " Up and down keys for wrapped text
  "nnoremap <silent> k gk
  "nnoremap <silent> j gj

  " Quickreturn
  "inoremap <c-cr> <esc>A<cr>
  "inoremap <s-cr> <esc>A:<cr>

  " Insert Mode Completion
  " inoremap <c-l> <c-x><c-l>
  " inoremap <c-f> <c-x><c-f>

"}}}
