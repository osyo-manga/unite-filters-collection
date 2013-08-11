scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


function! unite#filters#converter_file_firstline_abbr#define()
	return s:filters
endfunction

let s:filters = {
\	"name" : "converter_file_firstline_abbr",
\	"description" : "abbr to file first line"
\}


function! s:get_firstline(filepath)
	return filereadable(a:filepath) ? get(readfile(a:filepath), 0, "") : ""
endfunction


function! s:filters.filter(candidates, context)
	let candidates = deepcopy(a:candidates)
	for candidate in candidates
		let firstline = s:get_firstline(candidate.action__path)
		if !empty(firstline)
			let candidate.abbr = firstline
		endif
	endfor
	return candidates
endfunction



let &cpo = s:save_cpo
unlet s:save_cpo
