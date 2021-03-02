
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}

" localのeslintを使用
let g:ale_linters = {'javascript': ['eslint']}

" ファイル保存時に実行
let g:ale_fix_on_save = 1

" ローカルの設定ファイルを考慮する
let g:ale_javascript_prettier_use_local_config = 1

