"====================
" emmet-vim 設定
"====================

 autocmd FileType html,jinja,php,vue,scss imap <buffer><expr><c-e>
			 \ emmet#isExpandable() ? "\<plug>(emmet-expand-abbr)" :
			 \ "\<c-e>"

