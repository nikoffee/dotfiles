# Setup file for dotenv

cur_dir=$(pwd)
dir=~/dotfiles
old_dir=~/dotfiles_old
brew_dump=$dir/startup/brew
files=".bash_profile .bashrc .gitconfig .pryrc .vimrc .zshrc"

printf "Initial Brew setup"
if command -v brew 2>/dev/null; then
  printf "Already have brew <3\n"
else
  printf "Missing brew\nInstalling now...\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew install zsh python3 ruby haskell-stack zsh-syntax-highlighting postgresql mysql neovim lua idris node sqlite git openssl
cd $brew_dump
brew bundle
cd $cur_dir
pip install neovim
pip3 install --user neovim
pip3 install neovim
gem install --user-install neovim
npm install -g neovim
printf "...\nDone\n"

printf "Initial oh-my-zsh setup"
if [ -d ~/.oh-my-zsh ]; then
  printf "Already have oh-my-zsh"
  printf "upgrading oh-my-zsh"
  upgrade_oh_my_zsh
else
  printf "Missing oh-my-zsh\nInstalling now...\n"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
printf "...\nDone\n"

nvim_dir=~/.config/nvim
nvim_files="init.vim"
nvim_snippets=$nvim_dir/snippets

printf "Creating $old_dir for backup of existing dotfiles"
mkdir -p $old_dir
printf "...\nDone"

printf "Changing to $dir"
cd $dir

printf "Make necessary dirs"
mkdir -p $nvim_dir
mkdir -p $nvim_snippets

printf "Move old dotfiles and link new ones..."
for file in $files; do
  mv ~/$file $old_dir/ 2>/dev/null
  ln -sfn $dir/$file ~/$file
done
printf "...\nDone"

printf "Move old nvim files and link new ones"
for file in $nvim_files; do
  mv $nvim_dir/$file $old_dir/ 2>/dev/null
  ln -sfn $dir/$file $nvim_dir/$file
done

ln -sfn $dir/snippets/* $nvim_snippets/
printf "...\nDone"

cd $cur_dir
