# Enable shared history across all
# terminal sessions and tmux panes
HISTFILE=~/.histfile_zsh
HISTSIZE=1000000
SAVEHIST=10000000
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
export HISTCONTROL=ignoredups:erasedups:ignorespaces
setopt APPEND_HISTORY
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export HISTTIMEFORMAT="%F %T "


export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH=/Users/mzi/Library:$PATH
export PATH=/User/marekzidek/.pyenv/versions/3.7.7/bin/:$PATH
export PATH=~/.pyenv/versions/3.7.7/bin/:$PATH
export PATH=~/.pyenv/versions/3.7.7/bin:$PATH

# If vim could not be complied with +clipboard
# alias vim='vimx'

alias vim='nvim'

# Get a full path to a file
alias lsp='ls -d "$PWD"/*'


export HOMEBREW_NO_AUTO_UPDATE=1

alias k='kubectl'
alias c='clear'
#source <(kubectl completion zsh | sed 's/kubectl/k/g')

alias gs='git status'
alias gd='git diff'
alias gl='git log'
alias ga='git add'
alias gc='git commit'

alias env_add='set -a && source .env && set +a'
# Another possibility is https://github.com/theskumar/python-dotenv

# Prompt setup
#PROMPT='%F{178}%n@%m%f %F{43}%2~%f%F{173}:%f '
#
#autoload -Uz vcs_info
#precmd_vcs_info() { vcs_info }
#precmd_functions+=( precmd_vcs_info )
#setopt prompt_subst
#RPROMPT=\$vcs_info_msg_0_
#zstyle ':vcs_info:git:*' formats '%F{240}[%b]%f'
#zstyle ':vcs_info:*' enable git

# Enamble colors and change prompt
autoload -U colors && colors

# prompt setup
setopt prompt_subst

# Echoes a username/host string when connected over SSH (empty otherwise)
ssh_info() {
  [[ "$SSH_CONNECTION" != '' ]] && echo '%(!.%{$fg[red]%}.%{$fg[yellow]%})%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:' || echo ''
}

# Echoes information about Git repository status when inside a Git repository
git_info() {

  # Exit if not inside a Git repository
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  # Git branch/tag, or name-rev if on detached head
  local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

  local AHEAD="%F{160}⇡NUM%f"
  local BEHIND="%{$fg[cyan]%}⇣NUM%{$reset_color%}"
  local MERGING="%{$fg[magenta]%}⚡︎%{$reset_color%}"
  local UNTRACKED="%F{160}●%f"
  local MODIFIED="%F{226}●%f"
  local STAGED="%{$fg[green]%}●%{$reset_color%}"

  local -a DIVERGENCES
  local -a FLAGS

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    DIVERGENCES+=( "${AHEAD//NUM/$NUM_AHEAD}" )
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    DIVERGENCES+=( "${BEHIND//NUM/$NUM_BEHIND}" )
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    FLAGS+=( "$MERGING" )
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    FLAGS+=( "$UNTRACKED" )
  fi

  if ! git diff --quiet 2> /dev/null; then
    FLAGS+=( "$MODIFIED" )
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    FLAGS+=( "$STAGED" )
  fi

  local -a GIT_INFO
  [ -n "$GIT_STATUS" ] && GIT_INFO+=( "$GIT_STATUS" )
  [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
  [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
  GIT_INFO+=( "%F{240}[$GIT_LOCATION]%f" )
  echo "${GIT_INFO}"

}

# Use ❯ as the non-root prompt character; # for root
# Change the prompt character color if the last command had a nonzero exit code
PROMPT='$(git_info)$(ssh_info) %F{12}%2~%f%u %F{173}❯%f '

#RPROMPT='$(git_info)'
#
#

source ~/.env

# Vim keybindings and remappings
bindkey -v
# bindkey '^R' history-incremental-search-backward

bindkey kj vi-cmd-mode
bindkey jk vi-cmd-mode


# Autocomplete
autoload -U compinit -C
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -C
_comp_options+=(globdots)


#if echo $OSTYPE | grep "darwin" > /dev/null; then
#        # Use brew installed vim, because the basic is not compiled with +clipboard
#        alias vim=/usr/local/bin/vim
#fi

if echo $OSTYPE | grep "darwin" > /dev/null; then
	# Autosuggest with changes on accept and partial accept
	source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#        # Let python be homebrew managed python on macOS
#        alias python=~/.pyenv/shims/python3
#        alias pip=~/.pyenv/shims/pip3
else
	# prior to this, git clone into .zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
	source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

#        alias python=/usr/bin/python3
#        alias pip=/usr/bin/pip3
fi

ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
		end-of-line
		vi-end-of-line
		vi-add-eol
)

ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
		forward-word
		emacs-forward-word
		vi-forward-char
		vi-forward-word
		vi-forward-word-end
		vi-forward-blank-word
		vi-forward-blank-word-end
		vi-find-next-char
		vi-find-next-char-skip
	)


# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -v '^?' backward-delete-char

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.bin:$PATH
#export PYENV_VERSION=3.11.1

HIST_STAMPS="mm/dd/yyyy"

export TERM="xterm-256color"
export FZFZ_RECENT_DIRS_TOOL=autojump

#if [ -f /etc/zshrc ]; then
#. /etc/zshrc
#fi


[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f /usr/share/autojump/autojump.sh ] && . /usr/share/autojump/autojump.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.bin/v ] && export PATH=~/.bin:"$PATH"

function cd {
    builtin cd "$@" && ls -F
    }

tmux()
{
    local current_env=""
    if [ "$VIRTUAL_ENV" != "" ]; then
        current_env="$VIRTUAL_ENV"
        deactivate
    fi

    command tmux "$@"
    local ret=$?

    if [ "$current_env" != "" ]; then
        workon $(basename $current_env)
    fi

    return $ret
}


# Fuzzy find to automatically open in vim by hitting <C-f>
# bind '"\C-f":"vim $(fzf)\n"'
# Same, but my imporved version to not open empty vim on fzf exit :))
# Also doesn't save the crazy command into history (watch the leading space with HISTCONTROL)
# Also saves the executed filename in the history! I'm so proud
bindkey -s "\C-f" ' fzf_out=$(fzf --layout=reverse --bind K:preview-up,J:preview-down,H:preview-page-up,L:preview-page-down --preview  \"bat --style=numbers --color=always --line-range :500 {}\"); [[ -z $fzf_out ]] && : || vim $fzf_out\n print -S "vim $fzf_out"\n'
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
export FZF_DEFAULT_OPT='--layout=reverse --height=60% --bind up:preview-up,down:preview-down'



# Interactive search.
# Usage: ff or ff <folder>.
# Separate searchterms by | without space
ff() {
[[ -n $1 ]] && cd $1 || # go to provided folder or noop
RG_DEFAULT_COMMAND="rg  -i -l --hidden --no-ignore-vcs"
selected=$(
FZF_DEFAULT_COMMAND="rg  --files --hidden --follow" fzf \
  -m \
  -e \
  --ansi \
  --phony \
  --reverse \
  --bind "ctrl-a:select-all" \
  --bind "f12:execute-silent:(subl -b {})" \
  --bind "change:reload:$RG_DEFAULT_COMMAND {q} || true" \
  --preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2
)
[[ -n $selected ]] && vim $selected # open multiple files in editor
}
bindkey -s "\C-g" ' ff\n'

back_project() {
while [[ $(ls -a | grep -q ".git"; echo $?) -eq 1 ]]; do
cd ..
if [[ "$(pwd)" == "$HOME" ]]; then
	break
fi
done
}
bindkey -s "\C-n" ' back_project\n'

# Interactive search.
wikiprivate() {
[[ -n $1 ]] && builtin cd $1 || builtin cd ~/tools/private-wiki #provided or default
RG_DEFAULT_COMMAND="rg -i -l --no-ignore-vcs"
selected=$(
FZF_DEFAULT_COMMAND="rg --files" fzf \
  -m \
  -e \
  --ansi \
  --phony \
  --reverse \
  --bind "ctrl-a:select-all" \
  --bind "f12:execute-silent:(subl -b {})" \
  --bind "change:reload:$RG_DEFAULT_COMMAND {q} || true" \
  --preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2
)
[[ -n $selected ]] && vim $selected # open multiple files in editor
builtin cd -
}
bindkey -s "\C-e" ' wikiprivate\n'

dsi_kube() {
	cp ~/.kube/config_dsi ~/.kube/config
}

# Interactive search.
wikiff() {
[[ -n $1 ]] && builtin cd $1 || builtin cd ~/tools/extendwiki #provided or default
RG_DEFAULT_COMMAND="rg -i -l --no-ignore-vcs"
selected=$(
FZF_DEFAULT_COMMAND="rg --files" fzf \
  -m \
  -e \
  --ansi \
  --phony \
  --reverse \
  --bind "ctrl-a:select-all" \
  --bind "f12:execute-silent:(subl -b {})" \
  --bind "change:reload:$RG_DEFAULT_COMMAND {q} || true" \
  --preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2
)
[[ -n $selected ]] && vim $selected # open multiple files in editor
builtin cd -
}
bindkey -s "\C-w" ' wikiff\n'


# Interactive search.
#wikipp() {
#[[ -n $1 ]] && cd $1 || cd ~/my_site #provided or default
#RG_DEFAULT_COMMAND="rg -i -l --no-ignore-vcs"
#selected=$(
#FZF_DEFAULT_COMMAND="rg --files" fzf \
  #-m \
  #-e \
  #--ansi \
  #--phony \
  #--reverse \
  #--bind "ctrl-a:select-all" \
  #--bind "f12:execute-silent:(subl -b {})" \
  #--bind "change:reload:$RG_DEFAULT_COMMAND {q} || true" \
  #--preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2
#)
#[[ -n $selected ]] &&  grep "<cpy>" $selected | sed 's/<cpy>//g' | pbcopy # open multiple files in editor
#}
#bindkey -s "\C-q" 'wikipp\n'

export EDITOR=nvim
export VISUAL=nvim
export OPENER=open


### Change cursor shape for different vi modes.
##function zle-keymap-select {
#  #if [[ ${KEYMAP} == vicmd ]] ||
#     #[[ $1 = 'block' ]]; then
#    #echo -ne '\e[1 q'
#  #elif [[ ${KEYMAP} == main ]] ||
#       #[[ ${KEYMAP} == viins ]] ||
#       #[[ ${KEYMAP} = '' ]] ||
#       #[[ $1 = 'beam' ]]; then
#    #echo -ne '\e[5 q'
#  #fi
##}
##zle -N zle-keymap-select
##zle-line-init() {
#    #zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#    #echo -ne "\e[5 q"
##}
##zle -N zle-line-init
##echo -ne '\e[5 q' # Use beam shape cursor on startup.
##preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
#
# Use lf to switch directories and bind it to ctrl-o
#
#
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^p' ' lfcd\n'

bindkey -s "\C-t" ' cd $(fzfz)\n'

## In case I decide to go back to ranger - just don't, it's slow
#rangercd () {
#    tmp="$(mktemp)"
#    ranger --choosedir="$tmp" "$@"
#    if [ -f "$tmp" ]; then
#        dir="$(cat "$tmp")"
#        rm -f "$tmp"
#        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
#    fi
#}
#
##bindkey -s '^o' 'rangercd\n'

# Change prompt to include k8s namespace and kn command to omit writing -n in each command
#source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
#PS1='$(kube_ps1) '$PS1
#kn () {
#	if [ -z "$1" ]; then
#		kubectl get namespaces
#	else
#		kubectl config set-context --current --namespace=$1 > /dev/null
#	fi
#}


export NAYVY_PYPROJECT_ROOT_MARKERS='pyproject.toml,setup.py,.git'  # comma-separated format
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="~/.pyenv/versions/3.7.7/lib/python3.7/site-packages:$PATH"
alias ipython='python -m IPython --TerminalInteractiveShell.editing_mode=vi --no-autoindent' 
# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
