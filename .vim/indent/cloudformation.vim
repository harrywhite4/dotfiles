" Vim indent file
" Language: Cloudformation yaml
" Maintainer: Harry White
" Latest Revision: 19 July 2019

" Only load this indent file when no other was loaded.
if exists('b:did_indent')
  finish
endif

" Read yaml indent file
runtime! indent/yaml.vim

let b:did_indent = 1
