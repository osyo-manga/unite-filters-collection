scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! unite#filters#converter_add_ftime_word#define()
	return s:converter
endfunction



let s:converter = {
\	"name" : "converter_add_ftime_word",
\	"description" : "Add getftime() to word"
\}


function! s:getftime(candidate)
	return has_key(a:candidate, "action__path")      ? getftime(a:candidate.action__path)
\		 : has_key(a:candidate, "action__directory") ? getftime(a:candidate.action__directory)
\		 : 0
endfunction


function! s:converter.filter(candidates, context)
	let candidates = a:candidates
	let format = "(%Y/%m/%d %H:%M:%S)"
	for candidate in candidates
		if !has_key(candidate, "converter_add_ftime_word_base")
			let candidate.converter_add_ftime_word_base = candidate.word
		endif
		let word = get(candidate, "converter_add_ftime_word_base", candidate.action__path)
		let candidate.word = strftime(format, s:getftime(candidate)) . " " . word
	endfor
	return candidates
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
