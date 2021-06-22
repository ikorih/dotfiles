" 
" tcommentで使用する形式を追加
if !exists('g:tcomment_types')
  let g:tcomment_types = {}
endif

  let g:tcomment_types['eruby'] = '<%# %s %>'
  let g:tcomment_types['erb'] = '<%# %s %>'
  let g:tcomment_types['scss'] = '// %s'
  let g:tcomment_types['pug'] = '// %s'
  let g:tcomment_types['toml'] = '# %s'
  let g:tcomment_types['jinja'] = '{# %s #}'

