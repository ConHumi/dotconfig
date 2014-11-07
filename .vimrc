" ���ʐݒ�
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
" ESC�Ńn�C���C�g���I�t
nnoremap <silent> <ESC> <ESC>:noh<CR>
" ------------------------------------------------------------ 

" NeoBundle�̐ݒ�
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
" neosnippet �X�j�y�b�g�⊮�����Ă����
NeoBundleLazy 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
" neocomplete �⊮�@�\����
NeoBundleLazy 'Shougo/neocomplete.vim'
" indentLine �C���f���g���C������
NeoBundle 'Yggdroot/indentLine'
" autoclose �����ʎ�������
NeoBundle 'Townk/vim-autoclose'
" vimfiler vim�Ŏg����G�N�X�v���[���݂����Ȃ��
NeoBundle 'Shougo/vimfiler.vim'
" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
" unite.vim
NeoBundle 'Shougo/unite.vim'
" Unite.vim �ōŋߎg�����t�@�C����\���ł���悤�ɂ���
NeoBundle 'Shougo/neomru.vim'
" �t�@�C����tree�\�����Ă����
NeoBundle 'scrooloose/nerdtree'
" �J���[�X�L�[���ꗗ�\���� Unite.vim ���g��
NeoBundle 'ujihisa/unite-colorscheme'
" �F�̐ݒ�
NeoBundle 'w0ng/vim-hybrid'
" surround.vim
NeoBundle 'tpope/vim-surround'
" ------------------------------

" Python�֘A
" ------------------------------
" jedi-vim neocomplete���g����Python�̕⊮������
NeoBundleLazy 'davidhalter/jedi-vim'
" vim-python-pep8-indent Python�̃C���f���g�x��
NeoBundleLazy 'hynek/vim-python-pep8-indent'
" ------------------------------

" WEB�J���֘A
" ------------------------------
" emmet-vim zencoding��p
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

"neocomplete �̐ݒ�
" ------------------------------------------------------------
if neobundle#tap('neocomplete.vim')
	call neobundle#config({"autoload": {"insert": 1}, 'on_source': ['jedi-vim']})
	function! neobundle#tapped.hooks.on_source(bundle)
		""""""""""""""" NeoComplete�̐ݒ� 
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

" NeoSnippet�̐ݒ�
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
" Unite.vim �̐ݒ�
" ------------------------------------------------------------
" ���̓��[�h�ŊJ�n����
let g:unite_enable_start_insert=1
" �o�b�t�@�ꗗ
noremap <C-P> :Unite buffer<CR>
" �t�@�C���ꗗ
noremap <C-N> :Unite -buffer-name=file file<CR>
" �ŋߎg�����t�@�C���̈ꗗ
noremap <C-Z> :Unite file_mru<CR>
" sources���u���J���Ă���t�@�C���̃f�B���N�g���v�Ƃ���
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" �E�B���h�E�𕪊����ĊJ��
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" �E�B���h�E���c�ɕ������ĊJ��
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESC�L�[��2�񉟂��ƏI������
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" ------------------------------------------------------------

" indentLine �̐ݒ�
" ------------------------------------------------------------
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#A4E57E'
let g:indentLine_color_tty_light = 7
let g:indentLine_color_dark = 1
set list listchars=tab:\|\ 
" ------------------------------------------------------------

" VimFiler�̐ݒ�
" ------------------------------------------------------------
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern='\(^\.\|\~$\|\.pyc$\|\.[oad]$\)'
" ------------------------------------------------------------

" NERDTree �̐ݒ�
" ------------------------------------------------------------
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize=20
if !argc()
	autocmd VimEnter * NERDTree|normal gg3j
endif
" ------------------------------------------------------------

" Python�֌W�̐ݒ�
" ------------------------------------------------------------
" Ctr+P��Python�����s����炵��
"function! s:Exec()
"	exe "!" . &ft . " %"        
"endfunction         
"command! Exec call <SID>Exec() 
"map <silent> <C-P> :call <SID>Exec()<CR>
nmap <F5> : !C:\Python27\python.exe %

" vim-python-pep8-indent �̐ݒ�
if neobundle#tap('vim-python-pep8-indent')
	call neobundle#config({"autoload": {"filetypes": ["python", "python3"]}})
	call neobundle#untap()
endif
"jedi-vim�̐ݒ�
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

" WEB�֌W�̐ݒ�
" ------------------------------------------------------------
" �R�}���h��łƓW�J���Ă������
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
" surround.vim �^�O��F�X�o����
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
