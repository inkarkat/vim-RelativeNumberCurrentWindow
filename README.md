RELATIVE NUMBER CURRENT WINDOW
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

The 'relativenumber' setting helps you use the [|count|] for even quicker
navigation and manipulation, but it's only useful in the current window, where
the cursor is. For all other windows, the absolute line numbers offer a better
orientation (e.g. when you have the same buffer in splits above and below your
current window, and you need to decide which contains a location you want to
go to).

This plugin sets up autocmds to show relative numbers only in the current
window, and switches them to absolute numbers when the window is left. Windows
that do not have 'relativenumber' set are left as-is.

### SEE ALSO

- The CursorLineCurrentWindow plugin ([vimscript #4178](http://www.vim.org/scripts/script.php?script_id=4178)) enables the
  'cursorline' setting only for the current window.

### RELATED WORKS

- RelOps ([vimscript #4212](http://www.vim.org/scripts/script.php?script_id=4212)) switches to relative numbering only when in
  operator-pending mode.
- vim-numbertoggle (http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/)
  turns off relative numbering in insert mode, or when the focus is lost.
- numbers.vim (https://github.com/myusuf3/numbers.vim) will alternate between
  relative numbering in normal mode and absolute in insert mode.

USAGE
------------------------------------------------------------------------------

    Globally enable 'relativenumber' in your vimrc via
        :set relativenumber
    After sourcing this plugin, 'relativenumber' will only be active for the
    current window. So with multiple split windows, only one of them, the one
    where the cursor is in, will have the 'relativenumber'; all others will have
    'number' set.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-RelativeNumberCurrentWindow
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim RelativeNumberCurrentWindow*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.

CONFIGURATION
------------------------------------------------------------------------------

For the relative numbers, the necessary space is determined by the window
height; for absolute numbers, it's the number of lines in the buffer. This
discrepancy can lead to changes in the width of the number column when
switching from one setting to the other. Because this shifting of the buffer
contents is visually distracting, the plugin sets up an autocmd that presets
'numberwidth' to a high-enough value so that this doesn't happen. If you don't
want this, set:

    let g:RelativeNumberCurrentWindow_SameNumberWidth = 0

The relative numbers don't help when Vim isn't the active application, but
absolute numbers can be beneficial, because compiler or test output may refer
to lines currently open in Vim. Therefore, relative numbers for the current
window are switched to absolute when Vim loses the focus FocusLost. If you
don't want this, set:

    let g:RelativeNumberCurrentWindow_OnFocus = 0

Likewise, in insert mode, relative numbers are useless, as you rarely do
movements in that mode and cannot prepend a [count], anyway. Absolute numbers
require less screen updates and provide better orientation, so relative
numbers are switched to absolute when in insert mode. To disable this, set:

    let g:RelativeNumberCurrentWindow_OnInsert = 0

CONTRIBUTING
------------------------------------------------------------------------------

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-RelativeNumberCurrentWindow/issues or email
(address below).

HISTORY
------------------------------------------------------------------------------

##### 1.11    RELEASEME
- Compatibility: Use TermOpen event in Neovim. Thanks for Gee19 for providing
  a patch.

##### 1.10    09-Feb-2015
- Plugin was broken by Vim 7.3.861, which fixed the resetting of 'rnu' when
  'nu' is set. Add implementation that omits the workaround.
- Handle combination of 'nu' and 'rnu' that results in different current line
  display since 7.3.1115.

##### 1.00    04-Mar-2013
- First published version.

##### 0.01    04-Sep-2012
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2012-2022 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;
