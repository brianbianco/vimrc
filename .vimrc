"-----------------------------------------------------------------------------
".vimrc -> brian.bianco@gmail.com
"
" Plugins used:
" ------------
" Pathogen:
"   Download: 
"     https://github.com/tpope/vim-pathogen
"   Install:
"     mkdir -p ~/.vim/autoload ~/.vim/bundle; \
"     curl -so ~/.vim/autoload/pathogen.vim \
"     https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim
" 
" NerdTree:
"   Download:
"     https://github.com/scrooloose/
"   Install:
"     cd ~/.vim/bundle
"     git clone https://github.com/scrooloose/nerdtree.git
" ----------------------------------------------------------------------------

"Set the xterm type
set t_Co=256

"Turn syntax highlighting on
syntax on

"Use a friendlier colorscheme for dark backgrounds
colorscheme desert

"Use pathogen for plugin management
call pathogen#infect()
call pathogen#helptags()

"map \ to the NERD file browser
map \ :NERDTreeToggle<CR>

"Tell NerdTree to show hidden files
let NERDTreeShowHidden=1

"Setup tabs as spaces, and limit to 2
set expandtab
set tabstop=2

"Enable line numbering
set number
set numberwidth=3

"Change line number color to grey
highlight LineNr ctermfg=grey

"Set json syntax highlighting as javascript
autocmd BufNewFile,BufRead *.json set ft=javascript

"Set Apache buildr buildfile's to highlight as ruby
autocmd BufNewFile,BufRead buildfile set syntax=ruby

"Change swap directory to /tmp
set directory=/tmp

"Map Control+T <direction arrow> to assorted tab commands
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>
