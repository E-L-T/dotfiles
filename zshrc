# Path to your oh-my-zsh installation.
export ZSH="/home/eric.leroy-terquem/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

#Git aliases
alias s='git status'
alias d='git diff'
alias a='git add -p'
alias a.='git add .'
alias g="git commit -m"
alias am='git commit --amend'
alias c='git checkout'
alias cb='git checkout -b'
alias cm='git checkout master'
alias cs='git checkout staging'
alias gp='git push'
alias gpf='git push -f'
alias p='git pull'
alias r='git rebase'
alias rim='git rebase -i master'
alias rbm='git rebase master'
alias rba='git rebase --abort'
alias rbc='git rebase --continue'
alias gm='git merge'
alias gmm='git merge master'
alias cp='git cherry-pick'
alias cpa='git cherry-pick --abort'
alias cpc='git cherry-pick --continue'
alias st='git stash --include-untracked'
alias stp='git stash pop'
alias lg='git log'
alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbl='git blame'
alias rstbr='git reset --hard origin/`git rev-parse --abbrev-ref HEAD`'
alias force_pull='git reset --hard origin/`git rev-parse --abbrev-ref HEAD`'
alias deploy_staging='git push -f recette staging:master'

# Rails aliases
alias 80='rails s --port 8080'
alias tp='rails db:test:prepare'
alias rr='rails routes'
alias rc='rails c'
alias dbm="rails db:migrate"
alias dbr="rails db:rollback"
alias dbc="rails db:create"
alias dbd="rails db:drop"
alias read_secrets="bin/rails runner 'puts Rails::Secrets.read'"
alias edit_secrets="bin/rails secrets:edit"

# Webpack aliases
alias wp="DISABLE_SPRING=true ./bin/webpack-dev-server"
alias twp="RAILS_ENV=test ./bin/webpack"

# Tests aliases
alias rs="bundle exec spring rspec"
alias check="bundle exec rubocop && bundle exec slim-lint app/views && RAILS_ENV=test ./bin/webpack && bundle exec spring rspec"

# Other aliases
alias rubymine='j bin; ./rubymine.sh'
alias open_gem='EDITOR=code bundle open'
alias zshrc_vi='vi ~/.zshrc'
alias zshrc_code='code ~/.zshrc'
alias rake='noglob rake'
alias sudo="sudo "

# Automatically expand all aliases:
# - don't forget the actual commands
# - don't confuse your pairing partner

preexec_functions=()

function expand_aliases {
  input_command=$1
  expanded_command=$2
  if [ $input_command != $expanded_command ]; then
    print -nP $PROMPT
    echo $expanded_command
  fi
}

preexec_functions+=expand_aliases
export PATH="$HOME/.rbenv/bin:$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
eval "$(rbenv init -)"

#Remind you to use aliases
function check-alias-and-accept {
  if [ $BUFFER ]; then

    ESCAPED_BUFFER=$(printf %s "$BUFFER" | sed 's/[][()\.^$?*+]/\\&/g')
    ALIAS=`alias -L | grep -e "=[\'\"]\?${ESCAPED_BUFFER}[\'\"]\?$"`

    if [ $ALIAS ]; then
      echo
      echo "You have this alias:"
      echo
      echo $ALIAS
      echo
      echo "Use it!"

      zle kill-whole-line
      zle reset-prompt
    else
      zle accept-line
    fi
  else
    zle accept-line
  fi
}

zle -N check-alias-and-accept
bindkey '^J' check-alias-and-accept
bindkey '^M' check-alias-and-accept

# Autocomplétion
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+='check-alias-and-accept'

source /home/eric.leroy-terquem/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#Autojump
. /usr/share/autojump/autojump.sh
