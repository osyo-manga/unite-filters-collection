let s:save_cpo = &cpo
set cpo&vim

function! unite#filters#matcher_ngram#define()
  return deepcopy(s:matcher)
endfunction

let s:matcher = {
      \ 'name' : 'matcher_ngram',
      \ 'description' : 'N-gram matcher',
      \ 'n' : 3,
      \}

function! s:matcher.filter(candidates, context)
  if empty(a:context.input)
    return a:candidates
  endif

  let candidates = a:candidates
  for input in split(a:context.input, '\\\@<! ')
    let input = substitute(input, '\\ ', ' ', 'g')

    let expr = 'v:val.word =~#' . string('\%(' . join(s:split(self.n, input), '\|') . '\)')
    let candidates = unite#filters#filter_matcher(candidates, expr, a:context)
  endfor

  return candidates
endfunction

function! s:split(n, input)
  let letters = split(a:input, '\zs')
  let length = len(letters)

  if length < a:n
    return [a:input]
  endif

  " n = 3, input = 'enjoy'
  " ['enj', 'njo', 'joy']
  let list = []

  for i in range(0, length - a:n)
    let subletters = letters[i : i + (a:n - 1)]

    call add(list, join(subletters, ''))
  endfor

  return list
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
