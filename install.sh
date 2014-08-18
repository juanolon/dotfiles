#!/bin/sh
echo -e "Hi you again!/nWe will now install your files! :D"

echo "setting up your environment"

HOME='/Users/juanolon'
KEYBOARD_DIR=$HOME'/Library/Keyboard Layouts'
KEYREMAP_DIR=$HOME'/Library/Application Support/KeyRemap4MacBook'
HERE=`pwd`

# TODO: check wich OS run
# target folder : file (relative to this script : target file name
files=( "HOME:gitconfig:.gitconfig"
        "HOME:vim/vimrc:.vimrc"
        "HOME:vim:.vim"
        "HOME:vimperator:.vimperator"
        "HOME:bash:.bash"
        "HOME:bash/bash_profile:.bash_profile"
        "HOME:bash/bashrc:.bashrc"
        "HOME:zsh/zshrc:.zshrc"
        "HOME:dir_colors:.dir_colors"
        "KEYBOARD_DIR:custom_us_ukelele.keylayout:custom_us.keylayout"
        "KEYREMAP_DIR:KeyRemap4MacBook/private.xml:private.xml"
        "HOME:tmux/tmux.conf:.tmux.conf"
        "HOME:tmux/tmuxcolors.conf:.tmuxcolors.conf"
        "HOME:ctags:.ctags"
        "HOME:slate:.slate"
        "HOME:tmux-vim.conf:.tmux-vim.conf"
        "HOME:tigrc:.tigrc"
        "HOME:bin/:.bin" )

for i in "${files[@]}"
do
    targetfolder="${i%%:*}"
    sourcefile="${i#*:}"
    sourcefile=$HERE/"${sourcefile%%:*}"
    targetfile=$(echo "${!targetfolder}")/"${i#*:*:}"
    # echo "targetfolder:" $targetfolder
    # echo "sourcefile" $sourcefile
    # echo "targetfile: " $targetfile
    # http://www.linuxjournal.com/article/8919
    # echo $(echo ${!targetfolder})
    if [[ -f "$targetfile" ]] || [[ -L "$targetfile" ]]; then
        echo "File "$targetfile" already exists"
        echo "do you want to [R]eplace or make a [B]ackup of the file?"
        read action

        if [[ "$action" == "R" ]]
        then
            rm "$targetfile"
            echo "${targetfile}" "was removed"
        else
            mv "$targetfile" "${targetfile}".bak
            echo "backup located on "${targetfile}".bak"
        fi

        action=""
    fi

    ln -s "$sourcefile" "$targetfile"
    echo "created file" "${targetfile}"
done
