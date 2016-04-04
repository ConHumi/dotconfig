if has('nvim')
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

let g:python3_host_prog = expand('$HOME') . '/.pyenv/shims/python3'
let g:python_host_prog = expand('$HOME') . '/.pyenv/shims/python2'

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:rc_dir = expand('~/.config/nvim')
"let s:dein_dir = expand('~/.config/nvim/dein')
let s:dein_dir = s:rc_dir . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" なければ git clone "
if !isdirectory(s:dein_repo_dir)
	execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

" Required:
execute 'set runtimepath^=' . s:dein_repo_dir

" Required:
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	" 管理するプラグインを記述したファイル
	let s:toml = '~/.config/nvim/.dein.toml'
	let s:lazy_toml = '~/.config/nvim/.dein_lazy.toml'

	" 読み込み，キャッシュは :call dein#clear_cache() で消せる
	call dein#load_toml(s:toml, {'lazy':0})
	call dein#load_toml(s:lazy_toml, {'lazy':1}) 
	" Required: 
	call dein#end() 
	call dein#save_state() 
endif 
" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

syntax on
set number

