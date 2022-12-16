
"------------------------------------------------------------
""" Configurations

let mapleader = "\<Space>" " <Leader>キーの割り当て

" 一般設定 ----------------------
set nocompatible " Vi互換モードをオフ（Vimの拡張機能を有効）
set nrformats= " 10進数に
set encoding =UTF-8 "標準文字コードをUTF-8に指定する
scriptencoding utf-8 "script内でマルチバイト文字を使う場合
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決
if exists('&ambw')
	set ambiwidth=single " □や○文字が崩れる問題を解決
endif
set nobackup " バックアップファイルを作らない
set nowritebackup
set noswapfile " スワップファイルを作らない
set updatetime=300 "記号が更新されるタイミング



" 色設定 ----------------------
set t_Co=256
syntax enable " enable は現在の色設定を変更しない。そのため、このコマンドを使用する前後にコマンド ':highlight' で好みの色を設定することができる。現在の設定を破棄して、デフォルトの色を設定させたい場合は次のコマンドを使用する 'on'


" UI系----------------------------------  
set number " 行番号を表示
set relativenumber " 表示順をrelative
set cursorline "カーソル行の強調表示
" set nocursorline
set showmatch " 括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する
set splitbelow " プレビュー画面を下部に表示
set display     =lastline  " Show as much as possible of the last line.


" ファイル操作系-----------------------
set autoread "ファイル内容が変更されると自動読み込みする
set hidden " バッファを保存しなくても他のバッファを表示できるようにする
set confirm " バッファが変更されているとき、コマンドをエラーにするのでなく、保存するかどうか確認を求める

filetype indent plugin on " ファイル名と内容によってファイルタイプを判別し、ファイルタイププラグインを有効にする

" 検索系 --------------------------
set ignorecase " 検索時に大文字・小文字を区別しない。
set smartcase "ただし、検索後に大文字小文字が混在しているときは区別する
set wrapscan " 最後尾まで検索を終えたら次の検索で先頭に移る
set inccommand=split "置換時にプレビューする 
set hlsearch " 検索語を強調表示
set incsearch              " Highlight while searching with / or ?.
nnoremap <C-L> :nohl<CR><C-L>  "（<C-L>を押すと現在の強調表示を解除する）


" 操作系 --------------------------
set nostartofline " 移動コマンドを使ったとき、行頭に移動しない
set notimeout ttimeout ttimeoutlen=200 " Quickly time out on keycodes, but never time out on mappings
set pastetoggle=<F11> " Use <F11> to toggle between 'paste' and 'nopaste'
set clipboard^=unnamed,unnamedplus " ヤンクをクリップボードにコピー
if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif

" 貼り付け時にペーストバッファが上書きされないようにする
" 参考: https://postd.cc/how-to-boost-your-vim-productivity/
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

nnoremap <Leader>w :w<CR> "<Space>wを押してファイルを保存する（:w<Enter>よりずっと速い）

" コマンド系 --------------------------
set wildmenu " コマンドライン補完を便利に
set showcmd " タイプ途中のコマンドを画面最下行に表示
set cmdheight=2 " Set the command window height to 2 lines, to avoid many cases of having to press <Enter> to continue"

set visualbell " ビープの代わりにビジュアルベル（画面フラッシュ）を使う
set t_vb= " そしてビジュアルベルも無効化する


" インデント系 ----------------------
set backspace=indent,eol,start " オートインデント、改行、インサートモード開始直後にバックスペースキーで削除できるようにする。
set autoindent " オートインデント
set smartindent " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set noexpandtab " tabを押しても半角spaceでインデント
set list " インデント & 改行の可視化
set listchars=eol:¬,tab:¦\ ,trail:-,nbsp:%
set cindent  "C言語のインデントに従って高度な自動インデントを行う
set smarttab  "行頭の余白内でTabを打ち込むと、'shiftwidth'の数だけインデントする
set shiftwidth  =2
set tabstop     =2 "タブの文字数を設定する
set softtabstop =4 "ファイル内のTabが対応する空白の数


" Window & Pane操作系 --------------------------
" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
" Move window
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
" Switch tab
" nmap <S-Tab> :tabprev<Return>
" nmap <Tab> :tabnext<Return>


" 入力補助系 ----------------------------------
" 隣接した{}で改行したらインデント
function! IndentBraces()
  let nowletter = getline(".")[col(".")-1]    " 今いるカーソルの文字
  let beforeletter = getline(".")[col(".")-2] " 1つ前の文字
  " カーソルの位置の括弧が隣接している場合
  if nowletter == "}" && beforeletter == "{"
  return "\n\t\n\<UP>\<RIGHT>"
  else
  return "\n"
  endif
endfunction
" Enterに割り当て
inoremap <silent> <expr> <CR> IndentBraces()

inoremap { {}<LEFT>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

inoremap <silent> jk <ESC>" insertモードから抜ける

" </ と打つと自動で補完
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype php inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype jinja inoremap <buffer> </ </<C-x><C-o>
augroup END


" 対象が1件しかなくても常に補完ウィンドウを表示していて、noinsertで補完ウィンドウを表示時に挿入しない
" set completeopt += menuone,noinsert
" set completeopt+=noinsert,menuone
" set completeopt=menu,menuone,noinsert,noselect

" 補完表示時のEnterで改行をしない
" inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

" inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
" inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

" もっさり対策----------------------------------
set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set synmaxcol=256 " syntaxを探索する行数/列数を限定する事で高速化
set report      =0         " Always report changed lines.
syntax sync minlines=256


" カスタム
autocmd BufNewFile,BufRead *.njk  set filetype=html
set pumheight=10 "auto completeのpopupの高さを10に




"------------------------------------------------------------
""" dein.vim dark power

let s:dein_dir = expand('~/.cache/nvim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

set nocompatible
if !isdirectory(s:dein_repo_dir)
  echo "install dein.vim..."
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.config/nvim')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on



"" 自動python3の仮想インストール
if has('nvim')
  let s:python3 = system('which python3')
  if strlen(s:python3) != 0
    let s:python3_dir = $HOME . '/.cache/nvim/python3'
    if ! isdirectory(s:python3_dir)
      call system('python3 -m venv ' . s:python3_dir)
      call system('source ' . s:python3_dir . '/bin/activate && pip install pynvim neovim flake8 jedi')
    endif
    let g:python3_host_prog = s:python3_dir . '/bin/python'
    let $PATH = s:python3_dir . '/bin:' . $PATH
  endif
endif






"------------------------------------------------------------
""" プラグイン毎の設定


" " vim-colors-solarized
" source ~/.config/nvim/plugins/vim-colors-solarized.rc.vim

" gruvbox
source ~/.config/nvim/plugins/gruvbox.rc.vim

" vim-airline
source ~/.config/nvim/plugins/vim-airline.rc.vim

" vim-fzf
source ~/.config/nvim/plugins/fzf.rc.vim

" ale : 非同期コードチェック
source ~/.config/nvim/plugins/ale.rc.vim

" indentLine
source ~/.config/nvim/plugins/indentLine.rc.vim

" editorconfig-vim
source ~/.config/nvim/plugins/editorconfig-vim.rc.vim

" emmet-vim
source ~/.config/nvim/plugins/emmet-vim.rc.vim

" coc.nvim 
source ~/.config/nvim/plugins/coc.rc.vim

" vim-vue
source ~/.config/nvim/plugins/vim-vue.rc.vim

" vim-vue
source ~/.config/nvim/plugins/vim-vue-plugin.rc.vim

" vim-gitgutter
source ~/.config/nvim/plugins/vim-gitgutter.rc.vim

" vim-expand-region
source ~/.config/nvim/plugins/vim-expand-region.rc.vim

" tcommen_vim
source ~/.config/nvim/plugins/tcomment.rc.vim



" 初期状態はcursorlineを表示しない
" 以下の一行は必ずcolorschemeの設定後に追加すること
hi clear CursorLine

" 'cursorline' を必要な時にだけ有効にする
" http://d.hatena.ne.jp/thinca/20090530/1243615055
" を少し改造、number の highlight は常に有効にする
augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  setlocal cursorline
  hi clear CursorLine

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      hi CursorLine term=underline cterm=underline guibg=Grey90 " ADD
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
      hi clear CursorLine " ADD
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          " setlocal nocursorline
          hi clear CursorLine " ADD
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      " setlocal cursorline
      hi CursorLine term=underline cterm=underline guibg=Grey90 " ADD
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END


" :SyntaxInfoというコマンドが使用可能になり，実際にカーソルの下にあるコードのハイライトグループがわかる
" https://cohama.hateblo.jp/entry/2013/08/11/020849
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

