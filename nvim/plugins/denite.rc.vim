 "====================
 " Denite.nvim 設定
 "====================

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction


autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  " 一つ上のディレクトリを開き直す
  inoremap <silent><buffer><expr> <BS> denite#do_map('move_up_path')
  " imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
  " Deniteを閉じる
  inoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
  nnoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
endfunction

" 参考:  https://zaief.jp/vims/denite/
nmap  ,f :Denite file/rec
nmap  ,g :Denite grep
nmap  ,b :Denite buffer
nmap  ,l :Denite line
