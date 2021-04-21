" Clear the space indented code block region since this is rarely used
" and causes issues with nested multi-line lists
syntax clear markdownCodeBlock
" Dont render bold or italics since it doen't handle missing end characters
" properly
syntax clear markdownBold
syntax clear markdownItalic
syntax clear markdownBoldItalic
" Always sync markdown files from the start
syntax sync fromstart
