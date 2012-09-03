" RelativeNumberCurrentWindow.vim: Only highlight the screen line of the cursor in the currently active window.
"
" DEPENDENCIES:
"
" Copyright: (C) 2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.00.001	08-Jun-2012	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_RelativeNumberCurrentWindow') || (v:version < 700)
    finish
endif
let g:loaded_RelativeNumberCurrentWindow = 1

"- functions -------------------------------------------------------------------

" Note: We use both global and local values of 'relativenumber' to store the states,
" though 'relativenumber' is window-local and only the &l:relativenumber value
" effectively determines the visibility of the highlighting. This makes for a
" better value inheritance when splitting windows than a separate window-local
" variable would.

function! s:LocalNumber()
    return (&l:relativenumber ? 2 : (&l:number ? 1 : 0))
endfunction
function! s:RelativeNumberOnEnter()
    if &g:relativenumber && exists('w:relativenumber') && s:LocalNumber() == 1
	setlocal relativenumber
    endif
endfunction
function! s:RelativeNumberOnLeave()
    if s:LocalNumber() == 2
	setlocal number
	let w:relativenumber = 1
    else
	unlet! w:relativenumber
    endif
endfunction


"- autocmds --------------------------------------------------------------------

augroup RelativeNumber
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RelativeNumberOnEnter()
    autocmd WinLeave                      * call <SID>RelativeNumberOnLeave()
augroup END

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
