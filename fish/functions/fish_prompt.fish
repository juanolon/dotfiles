# :file[(repository)]/path/continues> (I: W: ?: )
# [uhr] user:folder (repository)>
# $ 
##############
#
# set normal (set_color normal)
# set magenta (set_color magenta)
# set yellow (set_color yellow)
# set green (set_color green)
# set gray (set_color -o black)
# set hg_promptstring "< on $magenta<branch>$normal>< at $yellow<tags|$normal, $yellow>$normal>$green<status|modified|unknown><update>$normal<
# patches: <patches|join( → )|pre_applied($yellow)|post_applied($normal)|pre_unapplied($gray)|post_unapplied($normal)>>" 2>/dev/null
# 
# function hg_prompt
#     # hg prompt --angle-brackets $hg_promptstring 2>/dev/null
# end
# 
# function git_prompt_status
#   set INDEX (git status --porcelain ^ /dev/null)
#   set STATUS ""
# 
#   if echo "$INDEX" | grep '^?? ' > /dev/null ^&1
#   echo "$INDEX"
#     echo trolololol
#     set STATUS "lololol$STATUS"
#   end
# 
#   if echo "$INDEX" | grep '^A  ' > /dev/null ^&1
#     set STATUS "+$STATUS"
#   else
#     if echo "$INDEX" | grep '^M  ' > /dev/null ^&1
#         set STATUS "+$STATUS"
#     end
#   end
# 
#   if echo "$INDEX" | grep '^ M ' > /dev/null ^&1
#     set STATUS "!$STATUS"
#   else
#     if echo "$INDEX" | grep '^AM ' > /dev/null ^&1
#         set STATUS "!$STATUS"
#     else
#         if echo "$INDEX" | grep '^ T ' > /dev/null ^&1
#             set STATUS "!$STATUS"
#         end
#     end
#   end
# 
#   if echo "$INDEX" | grep '^R  ' > /dev/null ^&1
#     set STATUS ">$STATUS"
#   end
# 
#   if echo "$INDEX" | grep '^ D ' > /dev/null ^&1
#     set STATUS "-$STATUS"
#   else
#     if echo "$INDEX" | grep '^AD ' > /dev/null ^&1
#         set STATUS "-$STATUS"
#     end
#   end
# 
#   if echo "$INDEX" | grep '^UU ' > /dev/null ^&1
#     set STATUS "C$STATUS"
#   end
# 
#   echo -n $STATUS
# end
# 
# function git_prompt
#     if git root >/dev/null 2>&1
#         set_color normal
#         printf ' on '
#         set_color magenta
#         printf '%s' (git currentbranch ^/dev/null)
#         set_color green
#         # git_prompt_status
#         set_color normal
#     end
# end
# 
# function fish_prompt
#     # z --add "$PWD"
# 
#     echo
# 
#     set_color magenta
#     printf '%s' (whoami)
#     set_color normal
#     printf ' at '
# 
#     set_color yellow
#     printf '%s' (hostname|cut -d . -f 1)
#     set_color normal
#     printf ' in '
# 
#     set_color $fish_color_cwd
#     printf '%s' (prompt_pwd)
#     set_color normal
# 
#     hg_prompt
#     git_prompt
# 
#     echo
# 
#     set_color white -o
#     printf '><> '
# 
#     set_color normal
# end
######################
# function fish_prompt --description 'Write out the prompt'
#     # Just calculate these once, to save a few cycles when displaying the prompt
#     if not set -q __fish_prompt_hostname
#         set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
#     end
# 
#     if not set -q __fish_prompt_normal
#         set -g __fish_prompt_normal (set_color normal)
#     end
# 
#     if not set -q __git_cb
#         set __git_cb ":"(set_color brown)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)""
#     end
# 
#     switch $USER
#         case root
#             if not set -q __fish_prompt_cwd
#                 if set -q fish_color_cwd_root
#                     set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
#                 else
#                     set -g __fish_prompt_cwd (set_color $fish_color_cwd)
#                 end
#             end
# 
#             printf '%s@%s:%s%s%s%s# ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb
# 
#         case '*'
# 
#             if not set -q __fish_prompt_cwd
#                 set -g __fish_prompt_cwd (set_color $fish_color_cwd)
#             end
# 
#             printf '%s@%s:%s%s%s%s$ ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb
#     end
# end
############
# https://gist.github.com/2902198
set fish_git_dirty_color red
function parse_git_dirty
         git diff --quiet HEAD ^&-
         if test $status = 1
            echo (set_color $fish_git_dirty_color)"Δ"(set_color normal)
         end
end
function parse_git_branch
         # git branch outputs lines, the current branch is prefixed with a *                                                                                                                                                               
         set -l branch (git rev-parse --abbrev-ref HEAD)
         echo $branch (parse_git_dirty)
end

function fish_prompt
         printf '%s@%s %s%s%s $ '  (whoami) (hostname|cut -d . -f 1) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
         # if test -z (git branch --quiet 2>| awk '/fatal:/ {print "no git"}')
         #     printf '%s@%s %s%s%s (%s) $ ' (whoami) (hostname|cut -d . -f 1) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch)
         # else
         #    printf '%s@%s %s%s%s $ '  (whoami) (hostname|cut -d . -f 1) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
         # end
end
