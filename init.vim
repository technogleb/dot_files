set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

" sets path to the python with installed pynvim module, this allows to avoid installing
" pynvim module in each virtual environment I use (see ':h g:python3_host_prog')
let g:python3_host_prog = '~/.config/nvim/nvim_env/bin/python'

