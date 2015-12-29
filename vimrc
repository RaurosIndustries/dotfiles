"
" ╻ ╻╻┏┳┓┏━┓┏━╸   ┏━╸╻╻  ┏━╸
" ┃┏┛┃┃┃┃┣┳┛┃     ┣╸ ┃┃  ┣╸
" ┗┛ ╹╹ ╹╹┗╸┗━╸   ╹  ╹┗━╸┗━╸
"                       -- by Rauros

" GENERAL {{{
let mapleader = " " " Define <leader> key

set mouse= " Really dude?

set autoread " Re-read file if changed outside
set autowrite " Automatically save before commands like :next and :make

filetype indent on " enable indentation per language

" }}}
" BEHAVIOR {{{
set scrolloff=7 " Define the offset with the cursor when moving vertically
set backspace=2 " Make <BACKSPACE> do what it should do

" create a backup of existing files, delete afterwards
set noswapfile
set nowritebackup
set nobackup
set undofile
set undodir=$HOME/.vim/undo

set paste
set virtualedit=block " make visual blocks easier to understand

set tags+=~/.vim/systags " used for omnicompletion
set path=.,,inc,src,/usr/include,/usr/local/include " improve vim path
set nohlsearch " don't hiligh search results

set gdefault

" }}}
" DISPLAY {{{
syntax on" Enable syntax

set encoding=utf-8  " Use UTF-8 for file/term encoding
set wildmenu        " Use the wildmenu
set modeline        " Use modeline, also

"call matchadd('ColorColumn', '\%81v', 100) " show column 80 ONLY when necessary

set statusline=─
set laststatus=0 noruler " rulerformat=%-28(%=%M%H%R\ %t%<\ %l,%c%V%8(%)%P%)

set list lcs=tab:│\ ,nbsp:¬
set fillchars=vert:│,fold:-,stl:─,stlnc:┈
set number

" ┏━┓╺┳╸┏━┓╺┳╸╻ ╻┏━┓╻  ╻┏┓╻┏━╸
" ┗━┓ ┃ ┣━┫ ┃ ┃ ┃┗━┓┃  ┃┃┗┫┣╸ 
" ┗━┛ ╹ ╹ ╹ ╹ ┗━┛┗━┛┗━╸╹╹ ╹┗━╸
" █▓▒░ wizard status line
set laststatus=2

hi BgColor guibg=#3A3A3A guifg=#ffffff ctermbg=237 ctermfg=255
hi ModColor guibg=#3A3A3A guifg=#afaf00 ctermbg=237 ctermfg=142
hi StatColor guibg=#3a3a3a guifg=#ffffff ctermbg=237 ctermfg=255
hi GitColor guibg=#4e4e4e guifg=#ffffff ctermbg=239 ctermfg=255
hi VoidColor guibg=#222222 guifg=#4e4e4e ctermbg=NONE ctermfg=239
hi TypeColor guibg=#D78700 guifg=#262626 ctermbg=66 ctermfg=235
hi PosColor guibg=#8787AF guifg=#262626 ctermbg=103 ctermfg=235

function! WizardStatus(mode)
    let statusline="%#BgColor#"
    if &modified == 1
    let statusline.="%#ModColor# »» "
    else
        let statusline.="    "
    endif
    if &readonly != ''
        hi StatColor guifg=#af0000 ctermfg=124
    endif
    let statusline.="%#StatColor#%F "
      let statusline .= '%#VoidColor#▒░ '
    let statusline .= "%=%h%w\ %#TypeColor#▓"
    if &filetype != ''
        let statusline .="▒ %Y "
    endif
    let statusline .="▒ %{&encoding}:%{&fileformat} %#PosColor#▒ %p%% ░ %l/%L\.\%c\ ▒"
    return statusline
endfunction

au WinEnter * setlocal statusline=%!WizardStatus('Enter')
au WinLeave * setlocal statusline=%!WizardStatus('Leave')
set statusline=%!WizardStatus('Enter')

function! Colorize(mode)
  if a:mode == 'i'
    hi StatColor guibg=#D78700 guifg=#222222 ctermbg=110 ctermfg=235
  elseif a:mode == 'r'
    hi StatColor guibg=#D78700 guifg=#222222 ctermbg=172 ctermfg=235
  elseif a:mode == 'v'
    hi StatColor guibg=#D78700 guifg=#222222 ctermbg=172 ctermfg=235
  else
    hi StatColor guibg=#af0000 guifg=#222222 ctermbg=124  ctermfg=235
  endif
endfunction

au InsertEnter * call Colorize(v:insertmode)
au InsertLeave * hi StatColor guibg=#3a3a3a guifg=#ffffff ctermbg=237 ctermfg=255

" }}}
" FORMATTING {{{
set smartindent         " smart indent (also toggle autoident on)
set expandtab           " no tabs for me there
set shiftwidth=2        " indentation is 4 spaces
set softtabstop=2       " Do your best, but I want 4 spaces

set lbr                 " enable line break
set sbr=>               " line break indicator
"set cinoptions={1s,f1s  " whitesmith C style indentation

set splitright          " Open vsplits on the right
set foldmethod=syntax   " Define how to fold files in general
" }}}
" MAPPING {{{

" make; work like : for commands (lazy shifting)
nnoremap ; :
" Treat broken lines as multiple lines with j/k
map j gj
map k gk

" Center the cursor on the search word when using 'n'
nmap n nzz
nmap N Nzz

nmap <Space> :nohl<CR>

" Keep selection when using indentation
vnoremap > >gv
vnoremap < <gv

vnoremap <C-a> :call Incr()<CR>
inoremap <Tab> <C-R>=CleverTab()<CR>

nnoremap <leader>g :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>h :find %:t:s,.c,.ga,:s,.h,.c,:s,.ga,.h,<CR>
map      <leader>w :let &textwidth = &tw == 0 ? 80 : 0<CR>:set tw<CR>
nmap     <leader>c :call ToggleCCompiler()<CR>
nmap     <leader>d mz:exe append(line("."), strftime("%d %B, %Y"))<CR>'zJ
nmap     <leader>l :echomsg line('.')<CR>
nmap     <leader>s :echomsg line('$')<CR>
nmap     <leader>f :echomsg expand('%:p')<CR>
nmap     <leader>t :set et! et?<CR>

" copy and paste
vnoremap <silent> <leader>y :w !xsel -i -b<CR>
nnoremap <silent> <leader>y V:w !xsel -i -b<CR>
nnoremap <silent> <leader>p :silent :r !xsel -o -b<CR>

" Underline the current line with either a specific char
nmap     <leader>= yyp:s/./=/g<CR>
nmap     <leader>- yyp:s/./-/g<CR>

" comment out lines
nmap    <leader># I# <ESC>
nmap    <leader>/ I/* <ESC>A */<ESC>

" same for blocks
vmap    <leader># :s/^\s*/&# /<CR>
nmap    <leader>/ <ESC>'<O/*<ESC>'>o */<ESC>:'<,'>s/^\s*/& * /<CR>

" upload to sprunge.us (without range, upload the whole file)
command! -range=% Sprunge <line1>,<line2>w !curl -F 'sprunge=<-' http://sprunge.us
" }}}
" AUTOCOMMANDS {{{
au FileType             make set noet
au Filetype             html ab --- &mdash;
au Filetype             html ab </ </<C-X><C-o>
au Filetype             mail set tw=80 fdm=marker
au FileType             c set sw=8 ts=8 sts=8 noet
au BufWritePost         *Xresources !xrdb -I$HOME/etc/theme %
au BufWritePost         *weird !xrdb -I$HOME/etc/theme ~/etc/Xresources
au VimEnter             * call ViewTips()

set omnifunc=syntaxcomplete#Complete
au FileType c          set omnifunc=ccomplete#Complete
au FileType cpp        set omnifunc=ccomplete#Complete
au FileType html       set omnifunc=htmlcomplete#CompleteTags
au FileType css        set omnifunc=csscomplete#CompleteCSS
" }}}
" FUNCTIONS {{{
" Increment a column of number
fu! Incr()
    let a = line('.') - line("'<")
    let c = virtcol("'<")
    if a > 0
        execute 'normal! '.c.'|'.a."\<C-a>"
    endif
    normal `<
endfu

" Display a tips
fu! ViewTips()
    " Note that this require the 'fortune' program to be installed on
    " your system, as well as the 'vimtweets' fortune file.
    "   $ wget http://bfontaine.net/fortunes/vimtweets
    "   $ strfile vimtweets vimtweets.dat
    "   # mv vimtweets* /usr/share/fortune/
    if filereadable('/usr/bin/fortune')
        if filereadable('/usr/share/fortune/vimtweets')
            echomsg system('/usr/bin/fortune vimtweets')
        endif
    endif
endfu

" Insert <Tab> or i_CTRL_N depending on the context
fu! CleverTab()
    if strpart(getline('.'), col('.')-2, 1)  =~ '^\s*$'
        return "\<Tab>"
    else
        return "\<C-N>"
    endif
endfu

" Toggle between make and cc for compiling with :make
fu! ToggleCCompiler()
    if &makeprg =~ '^make*$'
        set makeprg=tcc\ %
    else
        set makeprg=make
    endif
    set makeprg
endfu

" escape every HTML char in the line/selection
fu! EscapeHTML()
    silent! s/</\&lt;/g
    silent! s/>/\&gt;/g
    silent! s/"/\&quot;/g
endfu

" insert the TOhtml version of the selection
fu! CodeHTML(newft)
    let oldft = &ft         " remember current filetype
    let ft = a:newft        " filetype to be used
    '<,'>TOhtml             " convert the selection to HTML
    /^<pre/+1,/^<\/pre>/-1d " get the code in between <pre> tags
    bd!                     " remove the HTML temporary buffer
    norm gvp                " copy that in place of the old text
    let ft = &oldft          " recall the saved filetype
endfu

" }}}

" vim: fdm=marker
