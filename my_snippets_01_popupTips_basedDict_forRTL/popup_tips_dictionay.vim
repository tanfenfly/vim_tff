
"{{{1 setting for dict
"au BufNewFile,BufRead *.v,*.sv setlocal dictionary=~/github/vim_tff/my_snippets/verilog.dict
echo &dictionary
"setlocal dictionary=''
"setlocal tags=''
"setlocal dictionary+='/home/hehe/github/vim_tff/my_popup/perl.dict'
"setlocal dictionary+='~/github/vim_tff/my_popup/perl.dict'
"1}}}
"{{{1 function 01
function! s:xx_feed_popup()
	"let matches = matchlist(expand('<cword>'),'\(\k\{3,}\)$')
	let str1=getline('.')
	let matches = matchlist(str1,'\(\k\{3,}\)$')

	"echo "xxx12"
	if pumvisible()

		"echo "xxx12"
		if empty(matches)
			silent! call feedkeys("\<c-e>", 'n')
			echo "xxx13"
			return 0
		endif
	elseif empty(matches)
		"echo "xxx14"
		return 0
	else
		"echo "xxx14"
		silent! call feedkeys("\<c-x>\<c-k>", 'n')
		return 0
	endif
endfunc
"au! CursorMovedI <buffer> nested silent! call s:xx_feed_popup()
"au! CursorMovedI <buffer> silent! call s:xx_feed_popup()
"1}}}


let s1=system('cat verilog.dict')
echo s1
let s2=split(s1)
echo s2

function! Log01_usingShell(ts1)
    "let a:str1
   "silent! exe "!./log_for_vim.sh " . a:ts1
   normal <CR>
   "silent! call feedkeys("\<cr>", 'n')
   "system("eval ./log_for_vim " . a:ts1)
endfunc


function! Xx02_feed_popup()
	"let matches = matchlist(expand('<cword>'),'\(\k\{3,}\)$')
	"let matches = matchlist(str1,'\(\k\{3,}\)$')
	let str1=getline('.')
    let str2=matchstr(str1,'\w\+$')
    "let v1='' | redir! => v1 | silent echo str1 | redir END | call Log01_usingShell(v1)
    "let v1='' | redir! => v1 | silent echo str2 | redir END | call Log01_usingShell(v1)
    "let in1=input("Input AnyKey....")
    "echo str1 | echo str2
    "caddexpr str1
    "caddexpr str2
    "let v1='' | redir! => v1 | silent echo 'str1=' . str1 | redir END | caddexpr v1
    "let v1='' | redir! => v1 | silent echo 'str2=' . str2 | redir END | caddexpr v1
    caddexpr "start........ s1 "
    caddexpr g:s1
    caddexpr "start........ s2 "
    caddexpr g:s2
    caddexpr 'str1=' . str1  . ",  str2=" . str2

    if empty(str2)
            caddexpr "xx1_empty"
            return 0
    endif

    "let matches = filter(g:s2,'v:val =~ str2') |" this will change g:s2
    let ta1=deepcopy(g:s2)
    let matches = filter(ta1,'v:val =~ str2')
    if empty(matches)
            caddexpr "xx2_empty"
            return 0
    endif

	cadde "xxx12"
	cadde matches
	if pumvisible()

		cadde "xxx13"
		if empty(matches)
			silent! call feedkeys("\<c-e>", 'n')
			cadde "xxx13a"
			return 0
		endif
	elseif empty(matches)
		cadde "xxx14"
		return 0
	else
		cadde "xxx14"
		silent! call feedkeys("\<c-x>\<c-k>", 'n')
		return 0
	endif
endfunc

"must set noselect 
set completeopt=menu,menuone,noselect
au! CursorMovedI <buffer> nested  call Xx02_feed_popup()
