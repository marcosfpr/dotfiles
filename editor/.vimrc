"Vim configuration file"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"term gui colors"
set termguicolors

"enable mouse support"
set mouse=a
set ttymouse=xterm2

"leader key"
let mapleader = " "

"line numbers"
set number

"backup settings
set nobackup
set nowb
set noswapfile

"tab settings
set tabstop=4 "tabs expand to 4 spaces
set shiftwidth=4
set softtabstop=4
set expandtab

"line break"
set lbr
set tw=500

"identation"
set ai
set si
set wrap

"stop auto commenting, this is hurtful more then it is useful
set formatoptions-=cro

"highlight search pattern"
set hlsearch 

"smartcase sensivity"
set ignorecase
set smartcase

"don't redraw while executing macros (good performance config)
set lazyredraw

"for regular expressions turn magic on
set magic

"sets how many lines of history VIM has to remember"
set history=500

try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

"enable filetype plugins"
filetype plugin on
filetype indent on

"set to auto read when a file is changed from the outside"
set autoread
au FocusGained,BufEnter * silent! checktime

nmap <leader>w :w!<cr>

":W sudo saves the file"
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

"no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>e :Ex<CR>

set so=7

let $LANG='en'
set langmenu=en

set wildmenu

"ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"buffer becomes hidden when it is abandoned
set hid

"configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on

set regexpengine=0
set encoding=utf8
let g:theme = "light"

try
    if g:theme == "dark"
        set background=dark
        colorscheme habamax
    else
        set background=light
        colorscheme wildcharm
    endif
    
    highlight SpecialComment ctermfg=Grey guifg=#A0A0A0
    highlight Special guifg=#A0A0A0 ctermfg=Grey
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual Mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <leader>b :ls<CR>:b<Space>

map <S-L> :tabnext<cr>
map <S-H> :tabprevious<cr>

"switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

"specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

"return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Move text up and down (Visual mode)
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Move text up and down (Visual Block mode)
xnoremap J :move '>+1<CR>gv-gv
xnoremap K :move '<-2<CR>gv-gv

vnoremap $) <esc>`>a)<esc>`<i(<esc>
vnoremap $] <esc>`>a]<esc>`<i[<esc>
vnoremap $} <esc>`>a}<esc>`<i{<esc>
vnoremap $" <esc>`>a"<esc>`<i"<esc>
vnoremap $' <esc>`>a'<esc>`<i'<esc>
vnoremap $` <esc>`>a`<esc>`<i`<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cno $h e ~/
cno $p e ~/Genesis
cno $o e ~/Genesis/org
cno $c e <C-\>eCurrentFileDir("e")<CR>

"delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

let t:is_transparent = 0

function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        let t:is_transparent = 0
    endif
endfunction

map <leader>tb :call Toggle_transparent()<CR>

function! ReloadTheme()
    try
        source $MYVIMRC
        redraw!
        echo "Theme reloaded: " . g:theme
    catch
        echoerr "Failed to reload theme"
    endtry
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Coc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

""""""""""""""""""""""""""""""
" => Copilot 
""""""""""""""""""""""""""""""
imap <silent><script><expr> <Right> copilot#Accept("\<CR>")
imap <silent><script><expr> <Up> copilot#Next()
let g:copilot_no_tab_map = v:true

""""""""""""""""""""""""""""""
" => Man
""""""""""""""""""""""""""""""
runtime ftplugin/man.vim


""""""""""""""""""""""""""""""
" => Commentary
""""""""""""""""""""""""""""""
filetype plugin indent on


""""""""""""""""""""""""""""""
" => Ctrl-P 
""""""""""""""""""""""""""""""

let g:ctrlp_working_path_mode = 0

" Quickly find and open a file in the current working directory
let g:ctrlp_map = '<C-f>'
map <leader>f :CtrlP<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v(node_modules|\.git|target)',
  \ 'file': '\v(\.DS_Store|\.coffee)'
\ }


""""""""""""""""""""""""""""""
" => C-Tags 
""""""""""""""""""""""""""""""
"Not doing anything specific for tags. Just the default usage"

" Jump to tag under the cursor
nnoremap <leader>gt <C-]>

" List matching tags and select
nnoremap <leader>lt g<C-]>

" Navigate the tag stack
nnoremap <leader>tn :tn<CR>
nnoremap <leader>tp :tp<CR>
nnoremap <leader>tf :tfirst<CR>
nnoremap <leader>tl :tlast<CR>


"""""""""""""""""""""""""""""""
" => Coc
"
"""""""""""""""""""""""""""""""

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-@> to trigger completion
inoremap <silent><expr> <c-@> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)


" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>ce  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>cc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>co  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>cs  :<C-u>CocList -I symbols<cr>


"""""""""""""""""""""""""""""""
" => Rust
"
"""""""""""""""""""""""""""""""
command! CargoCheck :CocCommand rust-analyzer.runFlycheck
nmap <leader>rr :CocCommand rust-analyzer.run<CR>

"""""""""""""""""""""""""""""""
" => Disable highlighting 
"""""""""""""""""""""""""""""""

" No syntax highlighting
syntax on

" No cursor line for netrw
autocmd FileType netrw setlocal nocursorline

" No background color for tabline
highlight TabLine      cterm=NONE ctermbg=NONE guibg=NONE
highlight TabLineFill  cterm=NONE ctermbg=NONE guibg=NONE

" Transparent background
call Toggle_transparent()
