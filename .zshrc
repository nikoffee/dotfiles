export DEFAULT_USER="greghoule"
ZSH_THEME="agnoster"
COMPLETION_WAITING_DOTS="true"

export SHOPIFY_HOME=$HOME/src/github.com/Shopify
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
export PYTHON_PATH="/usr/local/lib/python3.6/site-packages:/usr/local/lib/python2.7/site-packages:$PYTHON_PATH"

plugins=(gem git brew colorize cp powerline sublime history sudo web-search pip zsh-syntax-highlighting forklift osx python rsync screen tmux vundle gnu-utils colored-man-pages mosh ruby rails)

if [[ -f /opt/dev/dev.sh ]] && [[ $- == *i* ]]; then
  source /opt/dev/dev.sh
fi

ssh-add -A

export GREP_OPTIONS='--color=auto'
export PATH="$PATH:$HOME/.custom-git"
export EDITOR="nvim"

if [ -f "$HOME/.bashrc" ]; then
  source "$HOME/.bashrc"
fi

if [ -f "$HOME/.profile" ]; then
  source "$HOME/.profile"
fi

# ------ Functions -------
brewit() {
  echo -e "\e[93mNow Updating brew..\e[0m"
  brew update
  echo -e "\e[93mNow Upgrading brew..\e[0m"
  brew upgrade
  brew update
  echo -e "\e[92mSuccess!\e[0m"
  echo -e "\e[93mNow a visit from the Doctor!\e[0m"
  brew doctor
  echo -e "\e[93mCleaning up brew\e[0m"
  brew cleanup
  echo -e "\e[92mSuccess!\e[0m"
  echo -e "\e[93mNow Upgrading oh-my-zsh!\e[0m"
  upgrade_oh_my_zsh
  echo -e "\e[92mSuccess!\e[0m"
  echo -e "\e[93mNow Upgrading pip & pip3 packages\e[0m"
  if [ hash pip3 2>/dev/null ]
  then
    pip3 list --outdated | cut -d' ' -f1 | xargs pip3 install --upgrade
  fi

  if [ hash pip2 2>/dev/null ]
  then
    pip2 list --outdated | cut -d' ' -f1 | xargs pip2 install --upgrade
  fi
  echo -e "\e[92mSuccess!\e[0m"
}

git_clean_merged_branches() {
  echo -e "\e[93mNow cleaning all local git branches that have been merged into master on the remote.. \e[0m"
  git branch --merged master --no-color | grep -v '^* master$' | xargs -n1 git branch -d
}

# Aliases
if type bundle > /dev/null 2>&1; then
  alias be="bundle exec"
fi

alias ll="ls -AahloPS"

# Networking Proxy Commands
burp_proxy_on() {
  networksetup -setwebproxystate 'Wi-Fi' on
  networksetup -setsecurewebproxystate 'Wi-Fi' on
}

burp_proxy_off() {
  networksetup -setwebproxystate 'Wi-Fi' off
  networksetup -setsecurewebproxystate 'Wi-Fi' off
}

dns_clear() {
  networksetup -setdnsservers 'Wi-Fi'
}

dns_google() {
  networksetup -setdnsservers 'Wi-Fi' 8.8.8.8 8.8.4.4
}

if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

export PATH="$HOME/.local/bin:$PATH"

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
eval "$(stack --bash-completion-script stack)"

export PATH="$PATH:/usr/local/opt/gettext/bin"
export PATH="$PATH:/usr/local/opt/libxml2/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
