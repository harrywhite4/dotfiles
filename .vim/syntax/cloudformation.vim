" Vim syntax file
" Language: Cloudformation yaml
" Maintainer: Harry White
" Latest Revision: 18 July 2019

if exists("b:current_syntax")
  finish
endif

" Read yaml syntax file
runtime! syntax/yaml.vim
unlet! b:current_syntax

let b:current_syntax = "cloudformation"
