
let s:save_cpo = &cpo
set cpo&vim

function! unite#filters#matcher_file_name#define()
  return s:matcher
endfunction

let s:matcher = {
      \ 'name' : 'matcher_file_name',
      \ 'description' : 'file name matcher',
      \}

function! s:matcher.filter(candidates, context)
  if a:context.input == ''
    return a:candidates
  endif

  let candidates = a:candidates
  for input in split(a:context.input, '\\\@<! ')
    let input = substitute(input, '\\ ', ' ', 'g')

    let input = substitute(substitute(unite#util#escape_match(input),
          \ '[[:alnum:]._-]', '\0.*', 'g'), '\*\*', '*', 'g')

    let expr = 'fnamemodify(v:val.word, ":t") =~' . string(input)
    let candidates = unite#filters#filter_matcher(candidates, expr, a:context)
  endfor

  return candidates
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

