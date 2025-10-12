" Better indent support for PHP by making it possible to indent HTML sections
" as well.
if exists("b:did_indent")
  finish
endif
" This script pulls in the default indent/php.vim with the :runtime command
" which could re-run this script recursively unless we catch that:
if exists('s:doing_indent_inits')
  finish
endif
let s:doing_indent_inits = 1
runtime! indent/html.vim
unlet b:did_indent
runtime! indent/php.vim
unlet s:doing_indent_inits
function! GetPhpHtmlIndent(lnum)
  if exists('*HtmlIndent')
    let html_ind = HtmlIndent()
  else
    let html_ind = HtmlIndentGet(a:lnum)
  endif
  let php_ind = GetPhpIndent()

  " ★追加: 行頭が <?php のときは、直前の非空行のインデントを優先して維持する
  " （PHP indent が 0 を返して HTML ネストが飛ぶのを防ぐ）
  if getline(a:lnum) =~# '^\s*<?php' && php_ind == 0
    let prev = prevnonblank(a:lnum - 1)
    if prev > 0 && getline(prev) !~# '^\s*<?php'
      return indent(prev)
    endif
    " 直前もPHPなら通常のphp_indにフォールバック
  endif

  " 既存: PHPのindent結果が有効なら優先
  if php_ind > -1
    return php_ind
  endif

  " 既存: HTML indentに委ねる。ただし <?...?> のワンライナー検出はそのまま
  if html_ind > -1
    if getline(a:lnum) =~ "^<?" && (0 < searchpair('<?', '', '?>', 'nWb')
          \ || 0 < searchpair('<?', '', '?>', 'nW'))
      return -1
    endif
    return html_ind
  endif

  return -1
endfunction
setlocal indentexpr=GetPhpHtmlIndent(v:lnum)
setlocal indentkeys+=<>>
