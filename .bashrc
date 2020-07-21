# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


export HISTSIZE=100000
export HISTCONTROL=ignoredups:erasedup:ignorespace
shopt -s histappend
#setopt APPEND_HISTORY
export PROMPT_COMMAND="history -a; history -r; $PROMPT_COMMAND"

# Testing for working with tmux on macOS
#export PROMPT_COMMAND="update_terminal_cwd; shell_session_history_check; $PROMPT_COMMAND"

export HISTTIMEFORMAT="%F %T "


# Fuzzy find to automatically open in vim by hitting <C-f>
# bind '"\C-f":"vim $(fzf)\n"'
# Same, but my imporved version to not open empty vim on fzf exit :))
# Also doesn't save the crazy command into history (watch the leading space with HISTCONTROL)
# Also saves the executed filename in the history! I'm so proud
bind '"\C-f":" fzf_out=$(fzf --preview \"bat --style=numbers --color=always --line-range :500 {}\"); [[ -z $fzf_out ]] && : || vim $fzf_out\nhistory -s vim $fzf_out\n"'


export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
export FZF_DEFAULT_OPT='--layout=reverse --height=60%'

alias ll='ls -lA'

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

export TERM="xterm-256color"

alias r='ranger'

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

