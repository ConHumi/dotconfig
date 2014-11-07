" 共通設定
" ------------------------------------------------------------
set autoread
set clipboard+=unnamed
set number
set browsedir=buffer
set backup
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
set undodir=~/.vim/tmp
set undofile
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0
set autoindent
set nowrap
" ESCでハイライトをオフ
nnoremap <silent> <ESC> <ESC>:noh<CR>
" ------------------------------------------------------------ 

" NeoBundleの設定
" ------------------------------------------------------------
if has('vim_starting')
	set nocompatible               " Be iMproved
	" Required:
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here: 

" Common Tools
" ------------------------------
" neosnippet スニペット補完をしてくれる
NeoBundleLazy 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
" neocomplete 補完機能強化
NeoBundleLazy 'Shougo/neocomplete.vim'
" indentLine インデントラインだぜ
NeoBundle 'Yggdroot/indentLine'
" autoclose 閉じ括弧自動入力
NeoBundle 'Townk/vim-autoclose'
" vimfiler vimで使えるエクスプローラみたいなやつ
NeoBundle 'Shougo/vimfiler.vim'
" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
" unite.vim
NeoBundle 'Shougo/unite.vim'
" Unite.vim で最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neomru.vim'
" ファイルをtree表示してくれる
NeoBundle 'scrooloose/nerdtree'
" カラースキーム一覧表示に Unite.vim を使う
NeoBundle 'ujihisa/unite-colorscheme'
" 色の設定
NeoBundle 'w0ng/vim-hybrid'
" surround.vim
NeoBundle 'tpope/vim-surround'
" ------------------------------

" Python関連
" ------------------------------
" jedi-vim neocompleteを使ってPythonの補完をする
NeoBundleLazy 'davidhalter/jedi-vim'
" vim-python-pep8-indent Pythonのインデント支援
NeoBundleLazy 'hynek/vim-python-pep8-indent'
" ------------------------------

" WEB開発関連
" ------------------------------
" emmet-vim zencoding後継
NeoBundleLazy 'mattn/emmet-vim'
NeoBundleLazy 'hail2u/vim-css3-syntax'
NeoBundleLazy 'taichouchou2/html5.vim'
NeoBundleLazy 'taichouchou2/vim-javascript'
NeoBundleLazy 'kchmck/vim-coffee-script'
" ------------------------------
"
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
" ------------------------------------------------------------ 

"neocomplete の設定
" ------------------------------------------------------------
if neobundle#tap('neocomplete.vim')
	call neobundle#config({"autoload": {"insert": 1}, 'on_source': ['jedi-vim']})
	function! neobundle#tapped.hooks.on_source(bundle)
		""""""""""""""" NeoCompleteの設定 
		"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
		" Disable AutoComplPop.
		let g:acp_enableAtStartup = 0
		" Use neocomplete.
		let g:neocomplete#enable_at_startup = 1
		" Use smartcase.
		let g:neocomplete#enable_smart_case = 1
		" Set minimum syntax keyword length.
		let g:neocomplete#sources#syntax#min_keyword_length = 3
		let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
		" Define dictionary.
		let g:neocomplete#sources#dictionary#dictionaries = {
					\ 'default' : '',
					\ 'vimshell' : $HOME.'/.vimshell_hist',
					\ 'scheme' : $HOME.'/.gosh_completions'
					\ }
		" Define keyword.
		if !exists('g:neocomplete#keyword_patterns')
			let g:neocomplete#keyword_patterns = {}
		endif
		let g:neocomplete#keyword_patterns['default'] = '\h\w*'
		" Plugin key-mappings.
		inoremap <expr><C-g>     neocomplete#undo_completion()
		inoremap <expr><C-l>     neocomplete#complete_common_string()
		" Recommended key-mappings.
		" <CR>: close popup and save indent.
		inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
		function! s:my_cr_function()
			return neocomplete#close_popup() . "\<CR>"
			" For no inserting <CR> key.
			"return pumvisible() ? neocomplete#close_popup() : "\<CR>"
		endfunction
		" <TAB>: completion.
		inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
		" <C-h>, <BS>: close popup and delete backword char.
		inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
		inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
		inoremap <expr><C-y>  neocomplete#close_popup()
		inoremap <expr><C-e>  neocomplete#cancel_popup()
		" Close popup by <Space>.
		"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
		" For cursor moving in insert mode(Not recommended)
		"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
		"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
		"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
		"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
		" Or set this.
		"let g:neocomplete#enable_cursor_hold_i = 1
		" Or set this.
		"let g:neocomplete#enable_insert_char_pre = 1
		" AutoComplPop like behavior.
		"let g:neocomplete#enable_auto_select = 1
		" Shell like behavior(not recommended).
		"set completeopt+=longest
		"let g:neocomplete#enable_auto_select = 1
		"let g:neocomplete#disable_auto_complete = 1
		"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
		" Enable omni completion.
		autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
		autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
		autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
		"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
		autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
		" Enable heavy omni completion.
		if !exists('g:neocomplete#sources#omni#input_patterns')
			let g:neocomplete#sources#omni#input_patterns = {}
		endif
		"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
		"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
		"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
		" For perlomni.vim setting.
		" https://github.com/c9s/perlomni.vim
		let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
	endfunction
	call neobundle#untap()
endif
" ------------------------------------------------------------

" NeoSnippetの設定
" ------------------------------------------------------------
if neobundle#tap('neosnippet.vim')
	call neobundle#config({"autoload": {"insert": 1}})
	function! neobundle#tapped.hooks.on_source(bundle)
		" Plugin key-mappings.
		imap <C-k>     <Plug>(neosnippet_expand_or_jump)
		smap <C-k>     <Plug>(neosnippet_expand_or_jump)
		xmap <C-k>     <Plug>(neosnippet_expand_target)
		" SuperTab like snippets behavior.
		imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)": pumvisible() ? "\<C-n>" : "\<TAB>"
		smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)": "\<TAB>"
		" For snippet_complete marker.
		if has('conceal')
			set conceallevel=2 concealcursor=i
		endif
	endfunction
	call neobundle#untap()
endif
" ------------------------------------------------------------
" Unite.vim の設定
" ------------------------------------------------------------
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" ------------------------------------------------------------

" indentLine の設定
" ------------------------------------------------------------
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#A4E57E'
let g:indentLine_color_tty_light = 7
let g:indentLine_color_dark = 1
set list listchars=tab:\|\ 
" ------------------------------------------------------------

" VimFilerの設定
" ------------------------------------------------------------
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern='\(^\.\|\~$\|\.pyc$\|\.[oad]$\)'
" ------------------------------------------------------------

" NERDTree の設定
" ------------------------------------------------------------
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize=20
if !argc()
	autocmd VimEnter * NERDTree|normal gg3j
endif
" ------------------------------------------------------------

" Python関係の設定
" ------------------------------------------------------------
" Ctr+PでPythonを実行するらしい
"function! s:Exec()
"	exe "!" . &ft . " %"        
"endfunction         
"command! Exec call <SID>Exec() 
"map <silent> <C-P> :call <SID>Exec()<CR>
nmap <F5> : !C:\Python27\python.exe %

" vim-python-pep8-indent の設定
if neobundle#tap('vim-python-pep8-indent')
	call neobundle#config({"autoload": {"filetypes": ["python", "python3"]}})
	call neobundle#untap()
endif
"jedi-vimの設定
if neobundle#tap('jedi-vim')
	call neobundle#config({"autoload": {"filetypes": ["python", "python3", "djangohtml"]}})
	function! neobundle#tapped.hooks.on_source(bundle)

		autocmd FileType python setlocal omnifunc=jedi#completions
		let g:jedi#completions_enabled = 0
		let g:jedi#auto_vim_configuration = 0
		"let g:jedi#popup_select_first = 0
		let g:jedi#rename_command = "<leader>R"
		if !exists('g:neocomplete#force_omni_input_patterns')
			let g:neocomplete#force_omni_input_patterns = {}
		endif
		let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
	endfunction
	call neobundle#untap()
endif
" ------------------------------------------------------------

" WEB関係の設定
" ------------------------------------------------------------
" コマンドを打つと展開してくれるやつ
if neobundle#tap('emmet-vim')
	call neobundle#config({"autoload": {"filetypes": ["php", "html", "ruby", "css"]}})
	function! neobundle#tapped.hooks.on_source(bundle)
		let g:user_emmet_mode = 'iv'
		let g:user_emmet_leader_key = '<C-Y>'
		let g:use_emmet_complete_tag = 1
		let g:user_emmet_settings = {
			\	'lang' : 'ja',
			\	'html' : {'filters' : 'html', },
			\	'css' : { 'filters' : 'fc', }, 
			\	'php' : { 'extends' : 'html', 'filters' : 'html', },
			\	}
	endfunction
	call neobundle#untap()
endif
" surround.vim タグを色々出来る
if neobundle#tap('vim-surround')
	call neobundle#config({"autoload": {"filetypes": ["php", "html", "javascript",]}})
	function! neobundle#tapped.hooks.on_source(bundle)

	endfunction
	call neobundle#untap()
endif

if neobundle#tap('vim-css3-syntax')
	call neobundle#config({"autoload": {"filetypes": ["php", "html"]}})
	function! neobundle#tapped.hooks.on_source(bundle)

	endfunction
	call neobundle#untap()
endif

if neobundle#tap('html5.vim')
	call neobundle#config({"autoload": {"filetypes": ["php", "html"]}})
	function! neobundle#tapped.hooks.on_source(bundle)

	endfunction
	call neobundle#untap()
endif

if neobundle#tap('vim-javascript')
	call neobundle#config({"autoload": {"filetypes": ["php", "html", "javascript"]}})
	function! neobundle#tapped.hooks.on_source(bundle)

	endfunction
	call neobundle#untap()
endif

if neobundle#tap('vim-coffee-script')
	call neobundle#config({"autoload": {"filetypes": ["php", "html"]}})
	function! neobundle#tapped.hooks.on_source(bundle)

	endfunction
	call neobundle#untap()
endif
" ------------------------------------------------------------ 
