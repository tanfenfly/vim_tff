"---------- bTag=help {{{1
"bTag=help= {{{2
:help cmdline.txt
:help motion.txt
:help key-codes 
:help terminal-key-codes
:help *VIM*<C-D>
:help i_<C-*>
:help function-list    |"(Write a Vim script)    =usr_41.txt=
:help eval.txt         |"(Expression evaluation)

:helpgrep ALLBUT 
"2}}}
"bTag=check status= {{{2

:abbreviate
:reg |:marks | :map | :tags | : echo taglist("xxx.*")
:function         | :scriptnames         | :autocmd
:verbose function | :verbose scriptnames | :verbose autocmd
:verbose set history?   |"list variable history where defined


:ls  | :buffers
:set | :let

:cexpr execute('scriptnames')

:echo &foldmethod   |"manual 
:echo $VIMRUNTIME
:E  |"open current dir
"2}}}
"bTag=vimRunOption= {{{2
"vim -u ~/.vimrc_perl
"ls|vim -
"vim -c 'ls|q'
"2}}}
"1}}}
"---------- bTag=vimScripts {{{1
"bTag=if= {{{2
:if getline(3) =~ '\v\s+'  | echo "xxx" | endif
"2}}}
"bTag=while= {{{2
:let i=0 | execute 'while i < 5 | echo i | let i = i + 1 | endwhile'
:let i=0 | while i < 5 | echo i | let i = i + 1 | endwhile 
"2}}}
"bTag=array= {{{2
:let LL1=['x1','x2','x3']    |echo string(LL1)          |"result=['x1', 'x2', 'x3'] 
:let LL1=['x1','x2','x3']    |echo join(LL1,'_')        |"result=x1_x2_x3
"2}}}
"bTag=function= {{{2

:function!   |"overide existing function
:endfunction |"must be in one single line


let s:pat01_IoDefine_1a='\v\s*(input|output)\s+(wire>|reg>)?\s*(\[[^]]*\])?\s*(\S+).*'
let s:pat01_IoDefine_1b='\v\s*(input|output)\s+(wire>|reg>)?\s*(\[[^]]*\])?\s*(\w+).*'
function! s:Verilog_DefineIO_format_02_usingPrint()
	let m1=matchlist(getline('.'),s:pat01_IoDefine_1a)
	if !empty(m1) 
			let newStr=printf("  %-10s %-10s %-30s %-50s //AutoGen",m1[1],m1[2],m1[3],m1[4])
			call setline('.',newStr)  | "call append('.',newStr)
	endif
endfunction
"2}}}
"bTag=operator for string= {{{2
:echo line(".") . " " . "yyy"
"2}}}
"bTag=buildin-functions=buffer/windows= {{{2

:echo bufwinnr("xxx.v")
:echo bufwinnr(5)
:echo winbufnr(2)

:echo bufexists("watch")
:echo bufname(5)
:bufloaded("watch")
:echo winheight(2)

echo escape("abca12b34",'ab')
echo shellescape("'xyz'")
echo fnameescape("xx/%yy.txt")
"2}}}
"bTag=buildin-functions=line/string/cursor= {{{2

:echo line(".")
:let t2=getline(".")
:let t2=getline(1,10)
:echo getbufline(bufnr(1), 1, "$")
:call append('$',t4)
:echo winline()                     |"cursor lineline

:call setline('.',"fistLine")
call append('.'+1,"2thLine")

:echo printf("%08x",0x11)
:echo repeat("_",100)

:echo matchlist("First Second Third", '\(\w\+\)\s\+\(\w\+\)')
:echo strlen(getline('.'))

call cursor(1,1)
"2}}}
"bTag=selfDefined-functions=  {{{2

function! ListBuffers()   
  let buffers = filter(range(1, bufnr('$')), 'bufexists(v:val)')
  for buffer in buffers
    if getbufvar(buffer, "&filetype") == 'help'
		  " this is a 'help' buffer, skipping
		  continue
    endif

    " ec is short version for command echo
    ec 'Having an opened buffer: ' . buffer
  endfor
endfunction

:call ListBuffers()


function!  Win_by_bufname(bufname)
    let bufmap = map(range(1, winnr('$')), '[bufname(winbufnr(v:val)), v:val]')
    let thewindow = filter(bufmap, 'v:val[0] =~ a:bufname')[0][1]
    execute thewindow 'wincmd w'
endfunction

:command! -nargs=* WinGo call Win_by_bufname(<q-args>)
:WinGo xx.txt

"https://vim.fandom.com/wiki/Easier_buffer_switching
function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
	if(bufexists(currbufnr))
	  let currbufname = bufname(currbufnr)
	  if(match(currbufname, a:pattern) > -1)
		echo currbufnr . ": ". bufname(currbufnr)
		let nummatches += 1
		let firstmatchingbufnr = currbufnr
	  endif
	endif
	let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
	execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
	let desiredbufnr = input("Enter buffer number: ")
	if(strlen(desiredbufnr) != 0)
	  execute ":buffer ". desiredbufnr
	endif
  else
	echo "No matching buffers"
  endif
endfunction

:command! -nargs=1 Bs :call BufSel("<args>")
:Bs help.txt
"2}}}
"1}}}
"---------- bTag=Normal operation {{{1
"bTag=copy/paste/delete=
"bTag=options {{{2

:set ruler
:set wildmenu
:set showcmd
:set cmdheight=1         " Height of the command bar

:set rnu
:set nowrap
:set foldmethod=marker foldenable

:set incsearch           "Incremental search
:set hlsearch            "Highlight search
:set showmatch

:set history=64          "Cmd history number

:syntax on
:syntax enable

:set wildignore=*.o,*~,*.pyc
:set ignorecase
:set encoding=utf8
:set magic

:set lazyredraw      |" Don't redraw while executing macros (good performance config)
:set nobackup
:set noswapfile

:set mouse=a
:set mouse=-a
:set path+=xxx/yy

:setlocal modifiable
:setlocal autoread

:setlocal buftype=nofile
:set shell=/bin/bash

:set guioptions-=T       "Hide Toolbar
:set guioptions+=T       "Show Toolbar
:set guioptions-=m       "Hide Menu bar
:set guioptions+=m       "Hide Menu bar
"2}}}
"bTag=maps {{{2
:map sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
:map sj :set splitbelow<CR>:split<CR>
:map sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
:map sl :set splitright<CR>:vsplit<CR>

:map <up> :res +5<CR>
:map <down> :res -5<CR>
:map <left> :vertical resize-5<CR>
:map <right> :vertical resize+5<CR>
:map <2-LeftMouse> gF


:help ALT
:map <M-=> <C-W>+
:map <M--> <C-W>-
:map <M-9> <C-W><
:map <M-0> <C-W>>

:vmap //  y/<C-R>"<CR>
:vmap  <silent>  //  y/<C-R>=escape(@",  '\\/. *$^~[]')<CR><CR>

nnoremap <buffer> <silent> <F9><F9> <Esc>yy:@0<CR>
nnoremap <buffer> <silent> <F1><F1> :exe 'help ' . expand('<cword>') <CR><CR>

map <F2>f :!perldoc -f   <cword> <CR>
map <F2>v :!perldoc -v   <cWORD> <CR>
map <F2>a :!perldoc -a   <cword> <CR>
map <F2>g :!grep --color -nur '<cWORD>'  /usr/lib/perl5/5.22/pods  <CR>

nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>tx :tabnext
map <leader>tp :tabpre
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
map <leader>cd :cd %:p:h<cr>:pwd<cr>

map <leader>bd :Bclose<cr>
map <leader>ba :1,888 bd!<cr>

map <leader>cd :cd %:p:h<cr>:pwd<cr>
"2}}}
"bTag=autocmd {{{2

" Auto change directory to current dir
:autocmd BufEnter * silent! lcd %:p:h
:autocmd QuickFixCmdPost *yyy*,*xxx* cwindow
:au BufNewFile,BufRead *.v,*.sv,*.svh,*.svi set sts=2
:au BufNewFile,BufRead *.v,*.sv,*.svh,*.svi set sw=2
"2}}}
"bTag=abbreviation= {{{2
:autocmd! BufEnter *.c,*.h abbr FOR for (i=0;i<3;i++)<CR><CR><ESC>O 
:autocmd! BufLeave *.c,*.h unabbr FOR 
"2}}}
"bTag=GUI/UserInteraction= {{{2

:amenu make.default :!make  <CR>
:amenu xxx.yyy :ls<CR>
:amenu icon=/xxPath/xx.png ToolBar.MyX1 :ls<CR>

:let choice = confirm("What do you want?", "&Apples\n&Oranges\n&Bananas", 2) |"return the number of choice
:let in1=input("Coffee or beer? ")  |"return input string
"2}}}
"bTag=grep= {{{2
:!grep xxx % 
:grep -nur 'ap' %:h  
:vimgrep ERROR\c %
:vimgrep // % 
"2}}}
"bTag=expand = {{{2

:w %:p.bk.01_origin
:echo expand('%:p')
"2}}}
"bTag=windows/buffers= {{{2

:b    partOfFileName #
:sball
:sb  partOfFileName 

:all
:only

:exe 'vnew __SubWatch' . system('date +%M%S%N')

:f watch    |"BufferName=watch

:tabnew | r !echo <c-r>=bufname("#")<cr>   |"NeedManualInput
:tabnew | exe 'b ' .  bufname("#")


:let cmd = winrestcmd()  |"save    windows size and position
:exe cmd                 |"restore windows size and position
"2}}}
"bTag=highlight= {{{2
:hi
:so $VIMRUNTIME/syntax/hitest.vim

:syn match cEnque display "enque.*"
:hi def link cEnque WildMenu


:highlight MyGroup_txtBlue term=bold cterm=bold ctermfg=4 gui=bold guifg=Blue
:2match MyGroup_txtBlue /\<F[0-9]\>/

:colorscheme evening
:colorscheme blue
"2}}}
"bTag=create new ExCmd= {{{2
:command! -nargs=* xxNewExCmdName call xxSelfDefinedFunction(<q-args>)

"2}}}
"bTag=misc= {{{2

:smile
"2}}}
"bTag=plugins {{{2
		"Omni completion 
        "$VIMRUNTIME/autoload/{filetype}complete.vim
        "https://github.com/vhda/verilog_systemverilog.vim
"2}}}
"bTag=emacs= {{{2
".xemacs/verilog-mode.el
".xemacs/site-lisp/vera-mode.el
".xemacs/site-lisp/line-numbers-mode.el
".xemacs/site-lisp/dcsh-mode.el
".xemacs/site-lisp/column_fill.el
".xemacs/init.el
".xemacs/p4.el
".xemacs/macros.el
"2}}}
"1}}}
"---------- bTag=vim <--> shell {{{1
"bTag=get vimExCmd output= {{{2
:cadde execute('cs help')
:cexpr execute('map') 
:cexpr execute('scriptnames')


:redir  @a
:redir! >  xFile
:redir! => xVar
:redir END

:let v1 = '' | redir! => v1 | silent ls | redir END | echo "v1=\n" v1 | put=v1
:redir  @*| sil  exec  'g#input#p'|redir  END
:nmap  ,z  :redir  @*<Bar>sil  exec 'g@\(xxx\<Bar>yyy\)@p'<Bar>redir END<CR>


:let cmd_shell='ls -l' | let stdOut=system(cmd_shell) | put=stdOut
"2}}}
"bTag=shell->vim= {{{2
vim -c 's#PID#ZZZ#g|wq'  zz01.txt
vim -c 'exe "r !ls -l"|wq'   zz02.txt;cat zz02.txt;rm -rf zz02.txt


ls | vim -
"2}}}
"bTag=vim->shell= {{{2
:'<,'>!xxShellCmd
:'<,'>w! >> xx.txt

:!{xxShellCmd}            "|
:r !{xxShellCmd}          "|use output       of xxShellCmd
:w !{xxShellCmd}          "|use input        of xxShellCmd
:[range]!{xxShellCmd}     "|use input/output of xxShellCmd

:'<,'>w !while read line;do if [ -e oo.txt ];then echo $line >> oo.txt;else echo $line >oo.txt;fi;done
:map <silent> <F2>  :'<,'>w !while read line;do if [ -e oo.txt ];then echo >/dev/null;else touch oo.txt;fi; if [[ -z $idx ]];then echo "">>oo.txt;echo "%:p">>oo.txt;idx="xxx";fi; echo $line >>oo.txt; done <CR> <CR>

:shell  |" luanch one new shell subprocess

:let cmd_shell='ls -l' | let stdOut=system(cmd_shell) | put=stdOut  |"use output of xxShellCmd
:redir  @a| sil  echo system('ls')|redir  END                       |"
"2}}}
"bTag=shell get stdin= {{{2
"str1=$(cat  < /dev/stdin); echo "${str1}"
"str1=$(tee); echo "${str1}"
"2}}}
"1}}}
"---------- bTag=othes FIX ME Later {{{1

function! CleverTab()
	if strpart(getline('.'),0,col('.')-1)
		return "\<Tab>"
	else
		return "\<C-N>"
	endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

"1}}}
