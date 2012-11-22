" RelativeNumberCurrentWindow.vim: Only show relative numbers in the currently active window.
"
" DEPENDENCIES:
"
" Copyright: (C) 2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	002	06-Sep-2012	Add autocmd to adapt 'numberwidth' to the buffer
"				size, so that the width of the number column
"				doesn't change when switching windows, because
"				that is visually distracting.
"	001	04-Sep-2012	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_RelativeNumberCurrentWindow') || (v:version < 700) || ! exists('+relativenumber')
    finish
endif
let g:loaded_RelativeNumberCurrentWindow = 1

"- configuration ---------------------------------------------------------------

if ! exists('g:RelativeNumberCurrentWindow_SameNumberWidth')
    let g:RelativeNumberCurrentWindow_SameNumberWidth = 1
endif


"- functions -------------------------------------------------------------------

function! s:LocalNumber()
    return (&l:relativenumber ? 2 : (&l:number ? 1 : 0))
endfunction
function! s:RelativeNumberOnEnter()
    if exists('w:relativenumber') && s:LocalNumber() == 1
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

    if g:RelativeNumberCurrentWindow_SameNumberWidth
	" For 'relativenumber', take the maximum possible number of 'lines', not
	" the actual 'winheight', so that (frequently occurring) window
	" resizings do not cause width changes, neither.
	autocmd VimEnter,WinEnter,BufWinEnter * let &l:numberwidth = max([len(string(&lines)), len(string(line('$')))]) + 1
    endif
augroup END

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
