# Setup file for dotenv

cur_dir=$(pwd)
dir=~/dotfiles
old_dir=~/dotfiles_old
brew_dump=$dir/startup/brew
files=".bash_profile .bashrc .gitconfig .pryrc .vimrc .zshrc"

echo -e "Initial Brew setup"
if command -v brew 2>/dev/null; then
  echo -e "Already have brew <3\n"
else
  echo -e "Missing brew\nInstalling now...\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew install zsh python3 ruby haskell-stack zsh-syntax-highlighting postgresql mysql neovim lua idris node sqlite git openssl
cd $brew_dump
brew bundle
cd $cur_dir
echo -e "...\nDone\n"

echo -e "Initial oh-my-zsh setup"
if [ -d "~/.oh-my-zsh" ]; then
  echo -e "Already have oh-my-zsh"
  echo -e "upgrading oh-my-zsh"
  upgrade_oh_my_zsh
else
  echo -e "Missing oh-my-zsh\nInstalling now...\n"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
echo -e "...\nDone\n"

nvim_dir=~/.config/nvim
nvim_files="init.vim"
nvim_snippets=$nvim_dir/snippets

echo -e "Creating $old_dir for backup of existing dotfiles"
mkdir -p $old_dir
echo -e "...\nDone"

echo -e "Changing to $dir"
cd $dir

echo -e "Move old dotfiles and link new ones..."
for file in $files; do
  mv ~/$file $old_dir/ 2>/dev/null
  ln -sfn $dir/$file ~/$file
done
echo -e "...\nDone"

echo -e "Move old nvim files and link new ones"
for file in $nvim_files; do
  mv $nvim_dir/$file $old_dir/ 2>/dev/null
  ln -sfn $dir/$file $nvim_dir/$file
done

ln -sfn $dir/snippets/* $nvim_snippets/
echo -e "...\nDone"

cd $cur_dir
