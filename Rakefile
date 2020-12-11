require 'rake'
require 'fileutils'

ROOT = File.expand_path File.dirname(__FILE__)

desc "Place dotfiles into standard locations"
task :install do
  puts "=============================="
  puts "Installing your environment."
  puts "=============================="

  install_homebrew
  setup_neovim
  Rake::Task[:install_private_fonts].execute
  Rake::Task[:install_dein].execute
  Rake::Task[:link_dotfiles].execute
  Rake::Task[:install_omz].execute
  Rake::Task[:setup_powerline].execute
  install_fonts
  Rake::Task[:install_mac_apps].execute
  install_iterm_theme
  setup_bundle_config

  Rake::Task[:setup_work].execute

  exit_with_success
end

desc "Setup Work dev env"
task :setup_work do
  Rake::Task[:setup_ssh].execute
  Rake::Task[:setup_dev].execute
end

desc "Setup ssh for github"
task :setup_ssh do
  sh "mkdir -p ~/.ssh"
  generate_ssh(account: "nikoffee", email: "greg@thisisfine.coffee")
  generate_ssh(account: "sorryeh", email: "houle.greg@gmail.com")
  sh %{ ssh-add -l }

  github_ssh_next_steps
end

task :install_private_fonts do
  sh %{
    svn export --force --username=nikoffee https://github.com/nikoffee/paid_fonts/trunk/fonts/ #{File.join(ROOT, "fonts/")}
  }
end

desc "Link all the dotfiles"
task :link_dotfiles do
  install_files Dir.glob("nvim/*"), dir: '.config/nvim/'
  install_files Dir.glob("solargraph/*"), dir: '.config/solargraph'
  install_files Dir.glob("git/*")
  install_files Dir.glob("irb/*")
  install_files Dir.glob("ruby/*")
  install_files Dir.glob("vim/*")
  install_files Dir.glob("python/*")
  install_files Dir.glob("zsh/*")
end

task :install_omz do
  install_omz
end

desc "Install my MacOS applications via brew cask"
task :install_mac_apps do
  cask_install "alfred"
  cask_install "fantastical"
  cask_install "bartender"
  # cask_install "1password"
  # cask_install "evernote"
  # cask_install "slack"
  # cask_install "google-chrome"
  # cask_install "the-unarchiver"
  sh "mas install 540348655" # Monosnap
  sh "mas install 824183456" # affinity photo
  sh "mas install 638161122" # Yubikey
  sh "mas install 736189492" # Notability
  cask_install "omnigraffle"
  cask_install "kaleidoscope"
  cask_install "spectacle"
  #cask_install "iterm2"
  cask_install "sonarr"
  cask_install "ivpn"
  cask_install "transmission"
  cask_install "plex-media-player"
  cask_install "soda-player"

  cask_upgrade
end

desc "Doctor the install"
task :doctor do
  Rake::Task[:dein_migration].execute if needs_migration_to_dein?
  Rake::Task[:install].execute
end

desc "Performs migration from TODO to dein"
task :dein_migration do
  raise NotImplemented
end

desc "runs the dein installer"
task :install_dein do
  puts "Installing and updating dein."

  dein_path = File.expand_path(File.join("~", ".cache", "dein"))
  FileUtils.mkdir_p(dein_path) unless File.exist? dein_path

  unless File.exist?(File.join(dein_path, "installer.sh"))
    dein_installer_path = File.join(dein_path, "installer.sh")
    sh %{
      curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > #{dein_installer_path}
      sh #{dein_installer_path} #{dein_path}
    }
  end
end

desc "Setup Powerline for oh-my-zsh"
task :setup_powerline do
  sh %{
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
    echo "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" >> ~/.zshrc
  }
end

task :default => :install

private

def generate_ssh(account:, email:)
  raise ArgumentError("Missing `account` or `email`") unless account && email
  ssh_path = File.expand_path(File.join("~", ".ssh"))
  ssh_config_path = File.join(ssh_path, "config")
  account_path = File.join(ssh_path, "id_rsa_#{account}")

  ssh_config = if account == "sorryeh"
    <<~CONFIG
    Host github.com
      HostName github.com
      User git
      IdentityFile #{account_path}
    CONFIG
  else
    <<~CONFIG
    Host #{account}.github.com
      HostName github.com
      User git
      IdentityFile #{account_path}
    CONFIG
  end

  unless File.exist?(account_path)
    sh %{ ssh-keygen -t rsa -b 4096 -f "#{account_path}" -C "#{email}" }
    sh %{ eval "$(ssh-agent -s)" }
    sh %{ echo "#{ssh_config}" >> #{ssh_config_path} }
  end
end

def github_ssh_next_steps
  puts ""
  puts "==========================================="
  puts "|                                         |"
  puts "| Add the SSH key to your Github Accounts |"
  puts "|                                         |"
  puts "==========================================="
  puts ""
end

def exit_with_success
  puts ""
  puts "||==========================================||"
  puts "||                                          ||"
  puts "|| Succesfully installed, restart terminal. ||"
  puts "||                                          ||"
  puts "||==========================================||"
  puts ""
end

def needs_migration_to_dein?
  raise NotImplemented
end

def setup_bundle_config
  return unless system "which bundle"

  bundler_jobs = (sh "sysctl -n hw.ncpu").to_i - 1
  sh "bundle config --global jobs #{bundler_jobs}"
end

def install_homebrew
  unless sh "which brew"
    sh %{ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
  end

  sh "brew update"

  sh "brew install ruby-install zsh python3 ruby mas haskell-stack zsh-syntax-highlighting postgresql neovim idris sqlite git openssl node"
  install_rustup

  sh %{ ruby-install ruby }

  brewfile

  puts "Succesfully installed homebrew and some packages"
end

def brewfile
  brewfile = File.join(ROOT, "brew", "Brewfile")
  sh %{ brew bundle install --file=#{brewfile} }
end

def install_rustup
  sh "curl https://sh.rustup.rs -sSf | sh"
end

def install_fonts
  sh "cp -f #{File.join(ROOT, "fonts", "/*")} $HOME/Library/Fonts"
end

def install_iterm_theme
  iterm_plist_path = File.join(ROOT, "iterm", "com.googlecode.iterm2.plist")
  return unless File.exist?(iterm_plist_path)
  sh %{ cp -f "#{iterm_plist_path}" "#{File.expand_path('~/Library/Preferences/')}"}
  sh %{ defaults read com.googlecode.iterm2 }
end

def install_omz
  if File.exist?(File.expand_path("~/.oh-my-zsh"))
    sh "upgrade_oh_my_zsh"
  else
    sh %{
      curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    }
  end
  install_files Dir.glob("zsh/*")
end

def install_files(files, dir: '', method: :symlink)
  target_dir = File.join(Dir.home, dir)
  unless dir.empty? || Dir.exist?(target_dir)
    Dir.mkdir(target_dir)
  end

  files.each do |f|
    file = f.split('/').last
    file = '.' << file if dir.empty?
    source_file = File.join(ROOT, f)
    target_file = File.join(target_dir, file)

    if File.exist?(target_file) && (!File.symlink?(target_file) || (File.symlink?(target_file) && File.readlink(target_file) != source_file))
      puts "[Renaming #{target_file}] appending '.backup' to file"
      File.rename(target_file, target_file + '.backup')
    end

    if method == :symlink
      sh %{ ln -nfs "#{source_file}" "#{target_file}" }
    else
      sh %{ cp -f "#{source_file}" "#{target_file}" }
    end
  end
end

def setup_neovim
  sh "pip install neovim"
  sh "pip3 install --user neovim"
  sh "pip3 install neovim"
  sh "gem install --user-install neovim"
  sh "npm install -g neovim"

  FileUtils.mkdir_p(File.expand_path("~/.config/nvim/")) unless File.exist?(File.expand_path("~/.config/nvim"))
end

def cask_install(app)
  sh %{ brew cask install #{app} }
end

def cask_upgrade
  sh %{
    brew cask doctor
    brew cask upgrade
  }
end
