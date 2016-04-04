if has('nvim')
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

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
"Color Scheme Settings
let s:colors_dir = s:rc_dir . '/colors'
let s:colorscheme = 'kalisi'
let s:colorscheme_git_repos = 'freeo/vim-kalisi'
let s:colorscheme_path = s:colors_dir . '/' . s:colorscheme . '.vim'
let s:colorscheme_local_repos = s:rc_dir . '/.colorscheme_repos/' . s:colorscheme
"#if isdirectory(s:colors_dir)
"#	execute '!mkdir ' . s:colors_dir
"#endif
if !glob(s:colorscheme_path . '.vim')
	if !isdirectory(s:colorscheme_local_repos)
		execute '!git clone https://github.com/' . s:colorscheme_git_repos . ' ' . s:colorscheme_local_repos
		execute '!ln -s ' . s:colorscheme_local_repos . '/colors/ ' . s:rc_dir
	endif
endif
execute 'colorscheme ' . s:colorscheme
"set background=dark
"set t_Co=256

" in case t_Co alone doesn't work, add this as well:
"let &t_AB="\e[48;5;%dm"
"let &t_AF="\e[38;5;%dm"
