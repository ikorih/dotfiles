"====================
" emmet-vim 設定
"====================

let g:user_emmet_leader_key='<C-Z>'
autocmd FileType html,jinja,php,vue,scss imap <buffer><expr><c-e>
			\ emmet#isExpandable() ? "\<plug>(emmet-expand-abbr)" :
			\ "\<c-e>"

