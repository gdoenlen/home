# sunaku zsh theme: https://github.com/AffanIndo/sunaku-zen

# My variation of the "sunaku" theme.

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[red]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[red]%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}?"

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

local user_color='green'
test $UID -eq 0 && user_color='red'

PROMPT='%(?..%{$fg_bold[red]%}exit %?
%{$reset_color%})'\
'%{$bold_color%}$(git_prompt_status)%{$reset_color%}'\
'$(git_prompt_info)'\
'%{$fg_bold[$user_color]%}%~%{$reset_color%}'\
'%(!.#. $) '

PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
