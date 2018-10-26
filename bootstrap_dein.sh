target_dir=$HOME/dotfiles
current_dir=$(pwd)
target_install_dir=$HOME/.cache/dein

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $target_dir/installer.sh
cd $target_dir
sh $target_dir/installer.sh $target_install_dir
