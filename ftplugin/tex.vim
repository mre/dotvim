" setlocal iskeyword+=:,-
setlocal makeprg=pdflatex\ -file-line-error\ -interaction=nonstopmode\ %

" Automatically insert closing brackets
" inoremap <buffer> { {}<ESC>i
" inoremap <buffer> [ []<ESC>i

" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
" set iskeyword+=:

