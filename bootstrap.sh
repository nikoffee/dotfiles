# Setup file for dotenv

cur_dir=$(pwd)
dir=~/dotfiles
old_dir=~/dotfiles_old
brew_dump=$dir/startup/brew
files=".bash_profile .bashrc .gitconfig .pryrc .vimrc .zshrc"

echo "Initial Brew setup"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
cd $brew_dump
brew bundle
cd $cur_dir
echo "...\nDone\n"

nvim_dir=~/.config/nvim
nvim_files="init.vim"
nvim_snippets=$nvim_dir/snippets

echo "Creating $old_dir for backup of existing dotfiles"
mkdir -p $old_dir
echo "...\nDone"

echo "Changing to $dir"
cd $dir

echo "Move old dotfiles and link new ones..."
for file in $files; do
  mv ~/$file $old_dir/ 2>/dev/null
  ln -sfn $dir/$file ~/$file
done
echo "...\nDone"

echo "Move old nvim files and link new ones"
for file in $nvim_files; do
  mv $nvim_dir/$file $old_dir/ 2>/dev/null
  ln -sfn $dir/$file $nvim_dir/$file
done

ln -sfn $dir/snippets/* $nvim_snippets/
echo "...\nDone"

cd $cur_dir
