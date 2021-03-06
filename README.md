# Emacs Config:

### To Use My Emacs Config:
```bash
sudo apt-get install git emacs 
cd ~/
git clone https://github.com/Bwall72/editors.git
mv editors/.emacs.d ~/
cd ~/.emacs.d
git clone https://github.com/joaotavora/autopair.git
```
To check installation:
```bash
ls -a
```
### init.el:
* 1 Set window name while in Emacs
* 14 Evil
    * Vim style text editor in Emacs
    * To disable: C-z, change line 16 to (evil-mode 0)
* 19 Interactively Do Things Mode
    * [Link](https://github.com/joaotavora/autopair.git)
* 24 [Theme](https://github.com/juba/color-theme-tangotango)
* 30 Prevent text in shell (before $) from being deleted
    * eshell, and term are better anyway
* 42 In C, tab is 4 spaces, with Linux style
* 46 Shift tab removes 4 spaces
* 72 Allows shell to be cleared
    * 79 bind to C-f   
* 93, 98 C-x C-s to enter text in invisible mode
* 102 Shell appears in same window (Eamcs 25+) 
    * Just use Eshell
* 110 C-x C-j to enter block comment (C or C++)
    * 134 M-j for next line
* 140,141 Highlight matching delimiter with 0 delay
* 144 Disable top menu
* 147 Disable tool bar
* 150 Disable scroll bar
* 154 Winner mode allows undoing and redoing window moves and closes
* 157 yes/no confirmations changed to y/n
* 161 C switch statement style
* 164 Write over selected text
* 182 Powerline bottom bar
* 191 which-key: displays available shortcuts 
* 195 Magit, git operations in Emacs
