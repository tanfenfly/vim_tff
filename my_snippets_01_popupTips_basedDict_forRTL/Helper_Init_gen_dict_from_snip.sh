#!/usr/bin/env sh

cp -f verilog.snippets ~/.vim/plugged/vim-snippets/UltiSnips/verilog.snippets
cat verilog.snippets |egrep '^\s*snippet\s+\S+' -o |egrep '\S+$' -o > verilog.dict

