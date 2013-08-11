scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


function! unite#filters#converter_file_firstline_word#define()
	return s:filters
endfunction

let s:filters = {
\	"name" : "converter_file_firstline_word",
\	"description" : "word to file first line"
\}


function! s:get_firstline(filepath)
	return filereadable(a:filepath) ? get(readfile(a:filepath), 0, "") : ""
endfunction


function! s:filters.filter(candidates, context)
	for candidate in a:candidates
		let firstline = s:get_firstline(candidate.action__path)
		if !empty(firstline)
			let candidate.word = firstline
		endif
	endfor
	return a:candidates
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
