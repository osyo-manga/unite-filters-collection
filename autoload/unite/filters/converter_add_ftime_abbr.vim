scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! unite#filters#converter_add_ftime_abbr#define()
	return s:converter
endfunction


function! s:getftime(candidate)
	return has_key(a:candidate, "action__path")      ? getftime(expand(a:candidate.action__path))
\		 : has_key(a:candidate, "action__directory") ? getftime(expand(a:candidate.action__directory))
\		 : 0
endfunction


let s:converter = {
\	"name" : "converter_add_ftime_abbr",
\	"description" : "Add getftime() to abbr"
\}


function! s:converter.filter(candidates, context)
	let candidates = deepcopy(a:candidates)
	let format = "(%Y/%m/%d %H:%M:%S)"
	for candidate in candidates
		let abbr = get(candidate, "abbr", get(candidate, "word", candidate.action__path))
		let candidate.abbr = strftime(format, s:getftime(candidate)) . " " . abbr
	endfor
	return candidates
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
