ZSH_GIT_PROMPT_FORCE_BLANK=1
ZSH_GIT_PROMPT_SHOW_UPSTREAM="yes"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_no_bold[white]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_no_bold[white]%}) "
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg_no_bold[cyan]%}:"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_no_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL="%{$fg_bold[yellow]%}^ "
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX="%{$fg[red]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX="%{$fg[red]%})"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_no_bold[white]%}↓"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_no_bold[white]%}↑"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[yellow]%}•"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[blue]%}+"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}U"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}☐"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✓"

__fish_pwd() {
  local pwd="${PWD/#$HOME/~}"

  if [[ "$pwd" == "~" ]]; then
    echo "~"
    return
  fi

  local -a parts

  parts=("${(@s:/:)pwd}")

  if [[ -z "${parts[1]}" ]]; then
    parts=("${parts[@]:1}")
    local prefix="/"
  else
    local prefix=""
  fi

  if (( ${#parts[@]} <= 1 )); then
    echo "${prefix}${parts[1]}"
    return
  fi

  local result=""
  local i

  for (( i=1; i < ${#parts[@]}; i++ )); do
    local part="${parts[$i]}"
    if [[ "$part" == "~" ]]; then
      result+="~/"
    elif [[ "$part" == .* ]]; then
      result+="${part:0:2}/"
    else
      result+="${part:0:1}/"
    fi
  done

  result+="${parts[-1]}"

  echo "${prefix}${result}"
}

PROMPT=$'%F{cyan}$(__fish_pwd)%f %F{242}$(gitprompt)%f%(12V.%F{242}%12v%f .)%(?.%F{white}.%F{white})%%%f '
