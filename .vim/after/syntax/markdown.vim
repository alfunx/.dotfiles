" Vim syntax file
" Language:	Markdown
" Maintainer:	Alphonse Mariya <alphonse.mariya@hotmail.com>
" Last change:	2019-12-01

syntax match markdownHeader /^+++\_.\{-}+++$\|^---\_.\{-}---$/

highlight default link markdownHeader Comment

highlight link mkdCodeStart Comment
highlight link mkdCodeEnd Comment
highlight link mkdCodeDelimiter Comment
