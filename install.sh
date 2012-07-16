#!/bin/sh
echo -e "Hi you again!/nWe will now install your files! :D"

echo "setting up your environment"

KEYBOARD_DIR='/Library/Keyboard Layouts'
HERE=`pwd`
HOME='/Users/juanolon/test_home'

# TODO: check wich OS run
files=( "HOME:gitconfig:.gitconfig"
        "HOME:vim/vimrc:.vimrc" 
        "HOME:vim/vimrc:.vimrc" 
        "HOME:vim/vimrc:.vimrc" 
        "KEYBOARD_DIR:custom_us_ukelele.keylayout:custom_us.keylayout" )

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
    if [ -f $targetfile ] || [ -L $targetfile ]; then
        echo "File "$targetfile" already exists"
        echo "do you want to [R]eplace or make a [B]ackup of the file?"
        read action

        if [ "$action" == "R" ]
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
