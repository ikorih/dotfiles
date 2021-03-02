
let g:LanguageClient_serverCommands = {}

" 言語ごとに設定する
if executable('vls')
	let g:LanguageClient_serverCommands['vue'] = ['vls']
endif
if executable('javascript-typescript-stdio')
	let g:LanguageClient_serverCommands['javascript'] = ['javascript-typescript-stdio']
endif

augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted setlocal signcolumn=yes
    autocmd User LanguageClientStopped setlocal signcolumn=auto
augroup END

let g:LanguageClient_autoStart = 1
nnoremap <Leader>lh :call LanguageClient_textDocument_hover()<CR>
nnoremap <Leader>ld :call LanguageClient_textDocument_definition()<CR>
nnoremap <Leader>lr :call LanguageClient_textDocument_rename()<CR>
nnoremap <Leader>lf :call LanguageClient_textDocument_formatting()<CR>

