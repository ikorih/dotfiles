
" https://github.com/terryma/vim-expand-region
" Default settings. (NOTE: Remove comments in dictionary before sourcing)
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i]'  :1, 
      \ 'ib'  :1, 
      \ 'iB'  :1, 
      \ 'il'  :0, 
      \ 'ip'  :0,
      \ 'ie'  :0, 
      \ }

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" vを押して、1文字を選択する
" もう1回vを押して、選択範囲を単語に拡大する
" さらに1回vを押して、選択範囲を段落に拡大する
" （以下省略）
" 範囲を拡大しすぎた場合は、<C-v>を押して前回の選択範囲に戻す
"
