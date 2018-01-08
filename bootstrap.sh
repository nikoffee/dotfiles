# Setup file for dotenv

dir=~/dotfiles
old_dir=~/dotfiles_old
files=".bash_profile .bashrc .gitconfig .pryrc .vimrc .zshrc"

nvim_dir=~/.config/nvim
nvim_files="init.vim"
nvim_snippets=$nvim_dir/snippets

echo "Creating $old_dir for backup of existing dotfiles"
mkdir -p $old_dir
echo "...\nDone"

echo "Changing to $dir"
cd $dir

for file in $files; do
  mv ~/$file $old_dir/ 2>/dev/null
  ln -s $dir/$file ~/$file
done

for file in $nvim_files; do
  mv $nvim_dir/$file $old_dir/ 2>/dev/null
  ln -s $dir/$file $nvim_dir/$file
done

ln -s $dir/snippets/* $nvim_snippets/

source ~/.zshrc
