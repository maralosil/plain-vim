# Plain Vim
I like Vim because it is light, fast and very configurable.

This document summarizes a plain set of topics about Vim which I think to be
helpful for anyone starting to learn Vim.

This is a working in progress and some sections were not finished yet.

# Table of Contents
[Basic](#basic)

[Cut, Copy and Paste](#cut-copy-and-paste)

[Search](#search)

[Replace](#replace)

[Move Along a Line](#move-along-a-line)

[Change Case](#change-case)

[Windows and Buffers](#windows-and-buffers)

[Shell](#shell)

[Remapping Keys](#remapping-keys)

[Keyboard Macros](#keyboard-macros)

[Special Characters](#special-characters)

[Indentation](#identation)

[Registers](#registers)

[Custom Commands](#custom-commands)

[Color Schemes](#color-schemes)

[Ctags](#ctags)

[Cscope](#cscope)

[Plugins](#plugins)

[Encoding](#encoding)

[Script](#script)

[Sample .vimrc](#.vimrc)

# Basic
Below is a summary list of basic commands.

Command       | Description
------------- | ---------------
ESC           | command mode
I             | insert mode 
h             | move cursor 1 char left
l             | move cursor 1 char right
j             | move cursor 1 line down (but you can also use the arrows)
k             | move cursor 1 line up
$             | move cursor to the end of the current line
0             | move cursor to the beginning of the current line
b             | back one word
w             | forward one word
e             | moves to the end of the next word
ge            | moves to the end of the previous word
:q!           | quit (without save)
ZZ            | quit and save
:w            | save
yy            | copy the current line
p             | copy the current line to cursor position
u             | undo
Ctrl - R      | redo all
$             | go to end the of the line
G             | go to the end of the buffer
1G            | go to the first line
nG            | go to the n-th line
gg            | go to the first line
a             | add after the cursor position
$             | to move to the end of the line, then p to add after the last char
dd            | erase the current line (in truth, cut)
dw            | delete word under cursor (cut) (no punctuation)
dW            | delete word under cursor (cut) (with punctuation)
d$            | delete from cursor to the end of the line
D             | delete from cursor to the end of the line
x             | delete the char under cursor
cw            | change from cursor to the end of the word
c$            | change from cursor to the end of the line
O             | insert a line above
o             | insert a line below
Ctrl - u      | scroll up
Ctrl - d      | scroll down
j             | join the current line with next one
xj            | join the current line with next x ones
Ctrl - n      | auto complete popup (enter to insert the option)
%             | match braces, parentheses, etc

# Cut, Copy and Paste

v highlight region
x cut
y copy
P insert the text before the cursor
p insert the text after the cursor

# Search

/text
n find next (forward search)
N find previous (backward search)
/ (Up) history

/regex

., *, \, [, ], ^, and $ are metacharacters.
+, ?, |, {, }, (, and ) must be escaped to use their special function.
\/ is / (use backslash + forward slash to search for forward slash)
\t is tab, \s is whitespace
\n is newline, \r is CR (carriage return = Ctrl-M = ^M)
\{#\} is used for repetition. /foo.\{2\} will match foo and the two following characters. 
The \ is not required on the closing } so /foo.\{2} will do the same thing.

\(foo\) makes a backreference to foo. Parenthesis without escapes are literally matched. Here the \ is required for the closing \).

# Replace

[address]s/search_pattern/replacement string/[flags]

address can be

.         current line (optional)
%         all lines
5,12  from lines 5 to 12
.+3   3 lines below the current line
.-3   3 lines before the current line
$         last line

### Examples:

:s/foo/bar/g    replace all occurrences of foo and replace each with bar (in the current line)
:%s/foo/bar/g   replace all occurrences of foo and replace each with bar (in all lines,  % means all lines)
:5,12s/foo/bar/g replace all occurrences of foo and replace each with bar (from lines 5 to 12)

Use <> for exact match

%s/\<foo\>//g delete all exact matches of foo

When replacing remember:

\r is newline, \n is a null byte (0x00).
\& is ampersand (& is the text that matches the search pattern).
\0 inserts the text matched by the entire pattern
\1 inserts the text of the first backreference. \2 inserts the second backreference, and so on.

Example:
:%s/^\s\+$//g                  remove all spaces in line containing only spaces characters

It is also possible to use the global command :g

:[range]g/pattern/cmd

## Examples:

:g/^\s*$/d    deletes all blank lines - d means delete command

:g!/pattern/d    deletes all the lines that do not match the pattern
:v/pattern/d     same as g! - v comes from inverse 

# Move Along a Line

fx x is the character to look for


fx move to the first char x
Fx move to the previous char of x 

For example, the sentence
To err is human.

Type fh to position the cursor on h of human.

# Changing Case

You can change the case of text using the commands:

g~<mov>  toggles the case, e.g, changes "HellO" to "hELLo"
gu<mov>  lowercase, e.g, changes "HellO" to "hello"
gU<mov> uppercase, e.g, changes "HellO" to "HELLO"

where <mov> is a vim movement such as w, 3w, $, 0, etc

For example,

guw changes the current word to lowercase
gU3w changes the 3 next words to uppercase    

The g~, gu, gU commands can be also using in visual mode in which the selected region will be affected.

More examples of commands from the vim wiki on switching case:


~            toggles case of the character under the cursor, or all visually-selected characters.


3~            toggles case of the next three characters.


g~3w    toggles case of the next three words.


g~iw        toggles case of the current word (inner word – cursor anywhere in word).


g~$         toggles case of all characters to end of line.


g~~         toggle case of the current line (same as V~).


U           uppercase the visually-selected text.
First press v or V then move to select text.
If you don't select text, pressing U will undo all changes to the current line.


gUU changes the current line to uppercase (same as VU).

gUiw
Change current word to uppercase.


u          lowercase the visually-selected text. If you don't select text, pressing u will undo the last change.


guu      changes the current line to lowercase (same as Vu).




# Windows and Buffers


When you open a file in Vim its content is loaded in a buffer. A window is a view of a buffer. You can have several windows viewing the same buffer (but that does not seem something useful).


:ed file              open a file as a buffer of the current window         
:e file                (short form)  
:split                horizontal split in a new window (same buffer)
:split file           horizontal split in a new window (buffer with file content)
:sp                   (short form)
:sp file              (short form)


:vsplit               vertical split
:vs                   vertical split (short form!)


:new                  horizontal split but with an empty buffer
:view                 like split but read/only


:only                 keep the current window, close others
:hide                 hide the current window


You can list buffers with


:buffers
:files
:ls (short form)


Selecting buffers


:buffer number
:b number        (short form)
:buffer file         (use filename)
:blast                   (last buffer in the list)
:bnext           (next buffer in the list)
:bprevious           (previous buffer)


Delete a buffer
:bd number                 delete buffer with number (short form)
:bd file                        delete buffer with the filename
:bdelete number
:bdelete file
:3,5 bd                        delete buffers in the range 3-5
:bd file1 file2 file3        delete multiple files


Put a buffer in a new window


:vert sbuffer number
:vert sb number (short form)
:vert belowright sb number


# Shell

You can invoke shell inside Vim using:

:shell
:sh (short form)

To close your shell session use type exit and you will be back to your previous
vim session.

However, you don’t need to drop to shell in order to execute shell commands.
You can use the bang ! command to run commands directly:

:! find . -name “*.c” | xargs grep “main”


:r ! ls -l /home/marcelo (reads the command output into a new buffer)


Off course, you can choose a different shell


First, you can check which shell Vim is using


:set shell ?


The answer will probably be shell=/bin/bash


But you can also set the path to other shell


:set shell=/path/shell


# Remapping Keys


TODO: describe about key remapping


10 Keyboard Macros


TODO: describe about macros


# Special Characters

It is also possible to enter any character (which can be displayed in your
current 'encoding'), even a character for which no digraph is defined, if you
know the character value, as follows (where ^V means "hit Ctrl-V, except if you
use Ctrl-V to paste, in which case you should hit Ctrl-Q instead):

By decimal value: ^Vnnn (with 000 <= nnn <= 255)
By octal value: ^VOnnn or ^Vonnn (with 000 <= nnn <= 377)
By hex value: ^VXnn or ^Vxnn (with 00 <= nn <= FF)
By hex value for BMP Unicode codepoints: ^Vunnnn (with 0000 <= nnnn <= FFFF)
By hex value for any Unicode codepoint: ^VUnnnnnnnn (with 00000000 <= nnnnnnnn <= 7FFFFFFF)

Notes:

In all cases, initial zeros may be omitted if the next character typed is not a digit in the given base (except, of course, that the value zero must be entered as at least one zero).
Hex digits A-F, when used, can be typed in upper or lower case, or even in any mixture of them.

# Indenting

Some variables you might want to set:

TODO: how to indent with tab ?

??? :set shiftwidth=4  - indenting is 4 spaces
:set autoindent                turns it on
:set smartindent                does the right thing (mostly) in programs
:set cindent                stricter rules for C programs

I like having auto on, but smart does funny things based on keywords.
To indent the current line, or a visual block:
Ctrl-t, Ctrl-d  - indent current line forward, backwards 
                 (insert mode)
visual > or <   - indent block by sw (repeat with . )

To stop indenting when pasting with the mouse, add this to your .vimrc:
:set pastetoggle=<f5>

then try hitting the F5 key while in insert mode (or just :set paste). 

80 characters limit
set textwidth
:set wrap


Fixing Indentation (gg=G)

It's possible to reformat an entire file, or a section of a file, using Vim's built-in = filter. Vim veterans often find this operator to be one of the most useful in their repertoire, but so common that it becomes second-nature and is rarely mentioned.
In normal mode, typing gg=G will reindent the entire file. This is a special case; = is an operator. Just like d or y, it will act on any text that you move over with a cursor motion command. In this case, gg positions the cursor on the first line, then =G re-indents from the current cursor position to the end of the buffer.
In visual mode, typing = will fix indentation of the current section. Thus, an equivalent but less efficient command to accomplish the same as gg=G in normal mode, would be ggVG to select the entire buffer in visual mode, followed by = to re-indent the entire selection.
The power of = is certainly not limited to the entire file. == will re-indent just the current line, or the = operator can be combined with text-objects for very powerful results.
If you often re-indent large areas (like the entire file, or a large text object), it can be useful to map a key to do it for you, using marks to restore your position. To format and return the same line where you were, just add this mapping to your vimrc:
map <F7> mzgg=G`z<CR>

Now, just press <F7> whenever you want to format your file.
Note, the = operator works using whatever automatic indentation settings you have turned on. If you don't have this set up, see indenting source code before using.


Format with gq


Use the gq command to format text.
Type ggVG to select the entire buffer in visual mode, then type gq to format.


TODO. Explain better gq command, formatoptions, etc


:help gq

# Custom Commands

:command! Eq :normal o\begin{equation*}<ESC>o\end{equation*}<ESC>O
:command! It :normal o\begin{itemize}<ESC>o\end{itemize}<ESC>O


:command! Fr :normal o\begin{frame}{}<ESC>o\end{frame}<ESC>O


13 Registers


Registers are spaces in memory that are used to store some text.
Every register name is preceded by “ (double quotation marks)


The are 10 types of registers:
1. The unnamed register “” stores the deleted or yanked text.
2. 10 numbered registers “0 to “9 which store the previous deleted and yanked text.
3. Small delete register “- contains text from deleted text less than one line.
4. 26 named registers “a to “z or “A to “Z to be used on you own.
5.  4 read only registers:
“. last inserted text
“% current file path
“: last command
“# last edited file
       6. Expression register “=
       7. Last search register “/
       8. Black hole register “_. It can be use for deletion without affect normal registers.


Normal mode


“ryw  saves the yanked word into register r
“ayy saves the yanked line into register a
“Ayy append the yanked line into register a
“rp paste the content in register to buffer


Insert mode


Ctrl+R a  paste the content in register a into buffer
Ctrl+R %  paste the content in register % into buffer


Also, we can use the :let command to write to register


To set the register “r with some text:
:let @r = ”some text”


To set the unnamed register “” use @@
:let @@ = ”some text”
14 Custom Commands


:command! Eq :normal o\begin{equation*}<ESC>o\end{equation*}<ESC>O
:command! It :normal o\begin{itemize}<ESC>o\end{itemize}<ESC>O


:command! Fr :normal o\begin{frame}{}<ESC>o\end{frame}<ESC>O


15 Color Schemes


Color schemes must be placed in this directory:


~.vim/colors/


Download nice vim colorschemes like monokai.vim, wombat.vim, solarized.vim, etc and place in this folder. Then make sure to change your .vimrc to include the lines:


syntax enable 
colorscheme monokai




You can download several color schemes at
https://github.com/flazz/vim-colorschemes/tree/master/colors


Your own 256 color scheme
http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim


Do you want more fonts options for your editor?
If your are running vim so your font setting is from your terminal. However, you can set a specific font if you are running gvim.


You can create a script install_font.sh to easily install a new font in your Ubuntu installation as follows:


marcelo@pateta:~$ cat install_font.sh
#!/bin/bash


URL=$1
FILENAME=${URL##*/}
FONT_DIR=/usr/share/fonts/truetype/custom/


echo $FILENAME
echo $FONT_DIR


echo "Start install"
sudo mkdir -p $FONT_DIR


echo "Downloading font"
wget -c $URL


echo "Installing font"
mv $FILENAME $FONT_DIR


echo "Updating font cache"
sudo fc-cache -f -v


echo "Enjoy"


Look  at https://github.com/cstrap/monaco-font for more scripts!


16 Ctags


sudo apt-get install exuberant-ctags
cd linux (root src dir)
ctags -R . (generates ctags)


:set tags+=/home/marcelo/linux/tags


Ctrl - ]        find the tag under cursor position
Ctrl - T        return to previous position


:tn[ext]        goes to the next tag, 
:tp[revious] goes to the previous one.
:ts[elect] gives you a list to choose from.
:help tag-matchlist for more fun and exciting things to try!



:tag function_name
:ta function_name

These commands will also accept regular expressions, so, for example, :tag /^asserts_* would find all tags that start with ‘asserts_‘. By default vim will jump to the first result, but a number of commands can be used to sort through the list of tags:
* :ts or :tselect shows the list
* :tn or :tnext goes to the next tag in that list
* :tp or :tprev goes to the previous tag in that list
* :tf or :tfirst goes to the first tag of the list
* :tl or :tlast goes to the last tag of the list
To show the tags you’ve traversed since you opened vim, run :tags.


Vim + Ctags + Ctrlp


If you’re using the Ctrlp plugin for vim, running :CtrlPTag will let you search through your tags file and jump to where tags are defined. Very useful when you need to jump around a project in a hurry.
It’s also handy to bind this to a keyboard shortcut. I use this in my ~/.vimrc:




17 File Encoding


Discover file encoding
:set fileenconding
fileenconding=utf8


18 Plugins




You don't need a plugin manager; it just makes management and updates easier [when you have several plugins]. A plugin manager will allow you to keep the plugins in separate directories. Pathogen is one of the simplest and earliest. You can use git to directly clone and update from GitHub; Pathogen extends Vim's 'runtimepath' so that these additional directories (called bundles) are considered.


Nerd Tree


The simplest (and still perfectly valid) way is to just unzip the plugin(s) into a ~/.vim directory.
1. Go to the plugin's GitHub page, and click "Download ZIP".
2. Unzip to ~/.vim:
$ mkdir ~/.vim
$ unzip path/to/nerdtree-master.zip -d /tmp
$ mv /tmp/nerdtree-master/* ~/.vim/
$ rmdir /tmp/nerdtree-master

Ensure that the directory structure (autoload, plugin etc.) is directly inside ~/.vim!




19 Using Vim as a C/C++ IDE


http://www.alexeyshmalko.com/2014/using-vim-as-c-cpp-ide/


20 Tmux


TODO. Add info about tmux, basic commands, cheat sheet
http://stackoverflow.com/questions/10158508/lose-vim-colorscheme-in-tmux-mode




I'm running iterm2 and when I'm in tmux mode the colorscheme I have set in vim does not show up. Only the color scheme I've set in iterm. If I run vim from shell the colorscheme appears correct - its only when I'm in tmux mode.
I've tried setting :colorscheme molokai when in vim (see screenshot below) and it doesn't change - again, the default colorscheme for iterm2 remains.
Am I missing some setting to iterm or tmux.conf? My dotfles are up on github here.
Any help would be grand :)




184 down vote accepted
I had the same problem. Only difference was I am using solarize rather then molokai.
To fix the issue, I have set up an alias in ~/.bashrc:
alias tmux="TERM=screen-256color-bce tmux"

And set up the default-terminal option in ~/.tmux.conf:
set -g default-terminal "xterm"

Lastly, do $ source ~/.bashrc to load new alias.


	21 Vimscript


TODO.
22 vimrc Configuration


.vimrc example


" Simple .vimrc file
“ 
“ @author Marcelo Silva
“ @version 1.0
“ @date 11.12.2014


" Insert line numbers
set number


" Set the number of visual spaces per tab
set tabstop=8


" Number of spaces in tab when editing
set softtabstop=8


" Tabs are spaces
"set expandtab


" Shows command in bottom bar
set showcmd


" Color scheme
"colorscheme badwolf


" Sintax enable
syntax enable


" Highlight the current line
"set cursorline


" Highlight match
set showmatch


" Incremental search
set incsearch


" Highlight search
set hlsearch


" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>


" Use the same symbols as TextMate for tabstops and EOLs
“set listchars=tab:▸\ ,eol:¬
set listchars=tab:»\ ,eol:¶


" Set list
set list

