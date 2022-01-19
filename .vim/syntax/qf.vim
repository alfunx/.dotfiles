" Vim syntax file
" Language:	Quickfix window
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2001 Jan 15

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" A bunch of useful C keywords
syn match	qfFileName	"^[^|]*" nextgroup=qfSeparator
syn match	qfSeparator	"|" nextgroup=qfLineNr contained
syn match	qfLineNr	"[^|]*" contained contains=qfError,qfWarn,qfInfo,qfHint,qfNote
syn match	qfError		"error" contained
syn match	qfWarn		"warn\(ing\)\?" contained
syn match	qfInfo		"info" contained
syn match	qfHint		"hint" contained
syn match	qfNote		"note" contained

" The default highlighting.
hi def link qfFileName	Directory
hi def link qfLineNr	LineNr
hi def link qfError	Error
hi def link qfWarn	Warn
hi def link qfInfo	Info
hi def link qfHint	Hint
hi def link qfNote	Note

let b:current_syntax = "qf"

" vim: ts=8
