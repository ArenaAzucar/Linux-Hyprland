runtime! archlinux.vim
" 修改默认方向键 hjk键
noremap i k
noremap k j
noremap j h

" 编辑器可以使用鼠标
set mouse=a
" 默认编码
set encoding=utf-8
" 不知道。。。
let &t_ut=''
" 修改tab缩进
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" 状态栏修改
set laststatus=2
" 让vim执行的命令只在vim打开时的当前目录生效
set autochdir
" vim记住当前文件打开的位置，下次打开还是在这个位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif



" 修改单个按键
noremap I 5k
noremap K 5j

" 字段映射：将S当作w,在输入大写S时会保存文档
map S :w<CR>
" 代码高亮
syntax on
" 显示行号
set number
" 行号 特殊
" set relativenumber
" 自动换行
set wrap
" vim普通模式下命令提示
set wildmenu
" 搜索时高亮
set hlsearch
" 搜索时一边输入一边高亮显示
set incsearch
" 搜索时忽略大小写
set ignorecase
" 搜索时智能大小写
set smartcase

" 由于以上配置，在vim搜索时下次打开vim都一直会高亮上次搜索的内容，所以需要以下
" 冒号执行后会执行的指令
exec "nohlsearch" 

""""""""""""分屏快捷键"""""""""""""" 
" 快捷键sl ， 向右边分屏
map sl :set splitright<CR>:vsplit<CR>  
" 快捷键sj ， 向左边分屏
map sj :set nosplitright<CR>:vsplit<CR>  
" 快捷键si ， 向上边分屏
map si :set nosplitbelow<CR>:split<CR>  
" 快捷键sk ， 向下边分屏
map sk :set splitbelow<CR>:split<CR>  
" 控制当前编辑的文本（光标在那个文本）
map <C-o>l <C-w>l       " 修改：将ctrl+w+k改为 空格+w
map <C-o>i <C-w>k       " 修改：将ctrl+w+h改为 空格+a
map <C-o>k <C-w>j       " 修改：将ctrl+w+j改为 空格+s
map <C-o>j <C-w>h       " 修改：将ctrl+w+j改为 空格+s
"" 修改分屏大小
map <up> :res+5<CR>
map <down> :res-5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>
""""""""""""""""""""""""""""""""""""

"""""""""""""""创建新的文件"""""""""""""""
" 创建新的文件
map tu :tabe<CR>
" th:标签页向左平移
map tj :-tabnext<CR>
" tl:标签页向右平移
map tl :+tabnext<CR>
""""""""""""""""""""""""""""""""""""""""""

""""""""""""" 插件使用按键修改"""""""""""""""""
""""""" nerdtree快捷键，按tt会有文件树
map tt :NERDTreeToggle<CR>
" 显示行号
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
" 显示书签列表
let NERDTreeShowBookmarks=1
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
let NERDChristmasTree=1 "显示增强
let NERDTreeHightCursorline=1 "高亮当前文件
let NERDTreeShowHidden=1 "显示隐藏文件
let NERDTreeWinSize=30 "窗口宽度
""""""""""""""""""""""""""""""""""""""""""""""""""


" python3 ---------------------------------------------------------------------
let g:python_highlight_all = 1


" 插件安装
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

        " 添加Markdown插件(弃用)
        " Plug 'plasticboy/vim-markdown'
        " Plug 'godlygeek/tabular'
        " Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
        " vim 状态栏和主题等，美化
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'morhetz/gruvbox'
    Plug 'connorholyday/vim-snazzy'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'ayu-theme/ayu-vim'
    Plug 'bling/vim-bufferline'
    
    " 左边添加文件树，类似vscode
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
    
    " 报错提示，告诉你报错了
    Plug 'w0rp/ale'
    
    " 代码补全，非常强大，必装
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
 
    " coc 代码片段补全
"    Plug 'honza/vim-snippets'
"    Plug 'SirVer/ultisnips'

    " 右边显示函数列表
    Plug 'majutsushi/tagbar', { 'on': 'TagbarOpenAutoClose' }
    
    " 以树形图的形式浏览文件历史，
    Plug 'mbbill/undotree/'

    " Python
    Plug 'vim-scripts/indentpython.vim'
    Plug 'vim-python/python-syntax'
    " Plug 'yaegassy/coc-pylsp', {'do': 'yarn install --frozen-lockfile'}

    " Markdown提示以及可视化
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
    Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
    Plug 'vimwiki/vimwiki'
    Plug 'iamcco/mathjax-support-for-mkdp'

    " HTML, CSS, JavaScript, PHP, JSON, etc.
    Plug 'elzr/vim-json'
    Plug 'hail2u/vim-css3-syntax'
    Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
    Plug 'gko/vim-coloresque', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
    Plug 'pangloss/vim-javascript', { 'for' :['javascript', 'vim-plug'] }
    Plug 'mattn/emmet-vim'
    
    " 这是go语言补全需要的插件
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }    
    
    " 其他美化方案，其他视觉增强
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'itchyny/vim-cursorword'
    Plug 'tmhedberg/SimpylFold'
    
    " 书签
    Plug 'kshenoy/vim-signature'

    " 可能需要的依赖
    Plug 'MarcWeber/vim-addon-mw-utils'
    Plug 'kana/vim-textobj-user'
    Plug 'fadein/vim-FIGlet'

    " 自动补全括号
    Plug 'jiangmiao/auto-pairs'

    " 注释插件
    Plug 'preservim/nerdcommenter'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""" vim 主题配置""""""""""""""""""""""
set termguicolors     " enable true colors support
let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" 设置snazzy主题
"colorscheme snazzy
"let g:SnazzyTransparent = 1
" 配置gruvbox主题
autocmd vimenter * ++nested colorscheme gruvbox
let g:gruvboxTransparent = 2
set background=dark
" 设置字体
"set guifont="Fantasque Sans Mono"
set guifont="Fira Mono"
"

"""状态栏配置"""
set laststatus=2  "永远显示状态栏
let g:airline_powerline_fonts = 1  " 支持 powerline 字体
let g:airline#extensions#tabline#enabled = 1 " 显示窗口tab和buffer
let g:airline_theme='murmur'  " murmur配色不错

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'

"""""""""""" markdown 编辑器默认打开浏览器""""""""""""""""
"let g:mkdp_browser = 'chromium'

let g:mkdp_browserfunc='MKDP_browserfunc_default' "preview 使用默认设置
let g:mkdp_auto_start=0 "markdown preview 开启时自动打开实施预览
let g:mkdp_auto_close=1 " 当切换东西时,自动关闭 Markdown实时预览
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 这两句是针对go插件的配置设定
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

""""""""""""""" Coc.nvim插件配置""""""""""""""""""
"""" Coc插件安装
"l"et g:coc_global_extensions = [
                ""\ 'coc-marketplace',    
                "\ 'coc-json', 
                "\ 'coc-vimlsp', 
                "\ 'coc-markdownlint',
                "\ 'coc-sh',   
                "\ 'coc-pyright',   
                "\ 'coc-python',   
                "\ 'coc-yaml', 
                "\ 'coc-tabnine', 
                "\ 'coc-translator',    
                "\ 'coc-snippets', 
                "\ 'coc-java',
                "\ 'coc-java-intellicode',  
                "\ 'coc-xml', 
                "\ 'coc-actions',
        "\]

"""
" let g:coc_global_extensions = [
"           \ 'coc-marketplace',    
"        " 命令模式下使用CocList marketplace命令查询Coc的所有插件
"               \ 'coc-json', 
"       " json补全插件
"               \ 'coc-vimlsp', 
"        " vim补全插件
"               \ 'coc-markdownlint',
"       " markdown补全插件
"               \ 'coc-sh',   
"        " shell补全插件
"               \ 'coc-pyright',   
"               \ 'coc-python',   
"        " python补全插件
"               \ 'coc-yaml', 
"        " yaml补全插件  
"               \ 'coc-tabnine', 
"        " 暂不知道
"               \ 'coc-translator',    
"        " 暂不知道
"               \ 'coc-snippets', 
"       " 片段补全
"               \ 'coc-java',
"        " java补全
"               \ 'coc-java-intellicode',  
"        " java补全
"               \ 'coc-xml',  " xml文件补全插件
"        \ 'coc-actions',       " 代码补全，应该是通用的
"        \]
"""

" 由于vim不能关闭未保存的文件，但是提供了缓冲区，这里设置的是在退出时将文件保存到缓冲区。
set hidden
" 让vim响应更快
set updatetime=100
" 让补全少输出一些无用的东西
set shortmess+=c
" 让左边的行号增加更多的提示，比如Git,
set signcolumn=number
" 在代码没有补全时，按space+q 来调出补全
" inoremap <silent><expr> <space>q coc#refresh()
" 用回车键来确认补全，用反向键确认需要补全的行，回车进行补全
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"""
" 用space+[或] 查找并跳转代码上一个报错或下一个报错 
" nmap <silent> <space>[ <Plug>(coc-diagnostic-prev)
" nmap <silent> <space>] <Plug>(coc-diagnostic-next)

" 跳转到这个函数的被定义的位置
" nmap <silent> <space>d <Plug>(coc-definition)
" nmap <silent> <space>y <Plug>(coc-type-definition)
" nmap <silent> <space>i <Plug>(coc-implementation)
" nmap <silent> <space>r <Plug>(coc-references)

" vim命令模式下，在想要查看文档的位置space+h，就能查看该字段的文档
nnoremap <space>h :call ShowDocumentation()<CR>

" function! ShowDocumentation()
"  if CocAction('hasProvider', 'hover')
"    call CocActionAsync('doHover')
"  else
"    call feedkeys('K', 'in')
"  endif
" endfunction

"  代码补全,不知道怎么搞，自己试试
" function! s:CocActionsOpenFromSelected(type) abort
"    execute 'CocCommand actions.open'.a:type
" endfunction
" xmap <silent> <space>a :<C-u>execute 'CocCommand actions.open'.visualmode()<CR>
" xmap <silent> <space>a :<C-u>set operatorfunc=<SID>CocActionsOpenFromSelected<CR>g@

""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""nerdcommenter代码补全插件快捷键修改""""""""""""""""""""""
" space+,注释     space+.取消注释
map <space>, \cc<CR>  
map <space>. \cu<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""snippets代码片段补全配置"""""""""""""""""""

" 插件使用时自动会带出一些注释，该功能可以在注释中直接填入自己的名称
let g:snips_author = 'ArenaNaranja'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



