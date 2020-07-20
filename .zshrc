# Enable shared history across all
# terminal sessions and tmux panes
HISTFILE=~/.histfile_zsh
HISTSIZE=1000000
SAVEHIST=10000000
export HISTCONTROL=ignoredups:erasedups:ignorespaces
setopt APPEND_HISTORY
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export HISTTIMEFORMAT="%F %T "


export LANG=en_US.UTF-8

# If vim could not be complied with +clipboard
# uncomment this
# alias vim='vimx'

# Prompt setup
PROMPT='%F{178}%n@%m%f %F{43}%2~%f%F{173}:%f '

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}[%b]%f'
zstyle ':vcs_info:*' enable git

# Enamble colors and change prompt
autoload -U colors && colors


# Vim keybindings and remappings
bindkey -v
bindkey '^R' history-incremental-search-backward

bindkey kj vi-cmd-mode
bindkey jk vi-cmd-mode


# Autocomplete
autoload -U compinit -C
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -C
_comp_options+=(globdots)


# Autosuggest with changes on accept and partial accept
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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



# Fuzzy find to automatically open in vim by hitting <C-f>
# bind '"\C-f":"vim $(fzf)\n"'
# Same, but my imporved version to not open empty vim on fzf exit :))
# Also doesn't save the crazy command into history (watch the leading space with HISTCONTROL)
# Also saves the executed filename in the history! I'm so proud
bind '"\C-f":" fzf_out=$(fzf --preview \"bat --style=numbers --color=always --line-range :500 {}\"); [[ -z $fzf_out ]] && : || vim $fzf_out\nhistory -s vim $fzf_out\n"'

export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
export FZF_DEFAULT_OPT='--layout=reverse --height=60%'

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}


# In case I decide to go back to ranger
rangercd () {
    tmp="$(mktemp)"
    ranger --choosedir="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^o' 'rangercd\n'
