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
  install_fonts
  Rake::Task[:install_mac_apps].execute
  install_iterm_theme
  setup_bundle_config

  exit_with_success
end

task :install_private_fonts do
  run %{
    svn export --force --username=nikoffee https://github.com/nikoffee/paid_fonts/trunk/fonts/ #{File.join(ROOT, "fonts/")}
  }
end

desc "Link all the dotfiles"
task :link_dotfiles do
  install_files Dir.glob("nvim/*"), dir: '.config/nvim/'
  install_files Dir.glob("git/*")
  install_files Dir.glob("irb/*")
  install_files Dir.glob("ruby/*")
  install_files Dir.glob("vim/*")
  install_files Dir.glob("python/*")
  install_files Dir.glob("sh/*")
end

task :install_omz do
  install_omz
end

desc "Install my MacOS applications via brew cask"
task :install_mac_apps do
  cask_install "alfred"
  cask_install "fantastical"
  cask_install "bartender"
  cask_install "1password"
  cask_install "evernote"
  cask_install "slack"
  cask_install "google-chrome"
  cask_install "the-unarchiver"
  run "mas install 540348655" # Monosnap
  run "mas install 824183456" # affinity photo
  run "mas install 638161122" # Yubikey
  run "mas install 495945638" # Wake up time
  run "mas install 736189492" # Notability
  run "mas install 414030210" # Limechat
  cask_install "omnigraffle"
  cask_install "kaleidoscope"
  cask_install "spectacle"
  cask_install "iterm2"
  cask_install "sonarr"
  cask_install "ivpn"
  cask_install "transmission"
  cask_install "plex-media-player"
  cask_install "soda-player"
  cask_install "tidal"

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

desc "Runs the dein installer"
task :install_dein do
  puts "Installing and updating dein."

  dein_path = File.expand_path(File.join("~", ".cache", "dein"))
  FileUtils.mkdir_p(dein_path) unless File.exists? dein_path

  unless File.exists?(File.join(dein_path, "installer.sh"))
    dein_installer_path = File.join(dein_path, "installer.sh")
    run %{
      curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > #{dein_installer_path}
      sh #{dein_installer_path} #{dein_path}
    }
  end
end

desc "Setup a dark theme for slack"
task :setup_dark_slack do
end

task :default => :install

private

def run(cmd)
  puts "[Execute] #{cmd}"
  system "#{cmd}" unless ENV['DEBUG']
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

  bundler_jobs = (run "sysctl -n hw.ncpu").to_i - 1
  run "bundle config --global jobs #{bundler_jobs}"
end

def install_homebrew
  unless run "which brew"
    run %{ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
  end

  run "brew update"

  run "brew install zsh python3 ruby mas haskell-stack zsh-syntax-highlighting postgresql neovim idris sqlite git openssl node"
  install_rustup

  brewfile

  puts "Succesfully installed homebrew and some packages"
end

def brewfile
  brewfile = File.join(ROOT, "brew", "Brewfile")
  run %{ brew bundle install --file=#{brewfile} }
end

def install_rustup
  run "curl https://sh.rustup.rs -sSf | sh"
end

def install_fonts
  run "cp -f #{File.join(ROOT, "fonts", "/*")} $HOME/Library/Fonts"
end

def install_iterm_theme
  iterm_plist_path = File.join(ROOT, "iterm", "com.googlecode.iterm2.plist")
  return unless File.exists?(iterm_plist_path)
  run %{ cp -f "#{iterm_plist_path}" "#{File.expand_path("~/Library/Preferences/")}"}
end

def install_omz
  if File.exists?(File.expand_path("~/.oh-my-zsh"))
    upgrade_oh_my_zsh
  else
    run %{
      curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    }
  end
end

def install_files(files, dir: '.', method: :symlink)
  files.each do |f|
    file = f.split('/').last
    source = "#{File.join(ROOT, f)}"
    target = "#{File.expand_path(File.join("~", dir, file))}"

    if File.exists?(target) && (!File.symlink?(target) || (File.symlink?(target) && File.readlink(target) != source))
      puts "[Overwriting] #{target}...leaving original at #{target}.backup..."
      run %{
        mv "#{File.expand_path(File.join("~", dir, file))}" "#{File.expand_path(File.join("~", dir, "#{file}.backup"))}
      }
    end

    if method == :symlink
      run %{ ln -nfs "#{source}" "#{target}" }
    else
      run %{ cp -f "#{source}" "#{target}" }
    end
  end
end

def setup_neovim
  run "pip install neovim"
  run "pip3 install --user neovim"
  run "pip3 install neovim"
  run "gem install --user-install neovim"
  run "npm install -g neovim"

  FileUtils.mkdir_p(File.expand_path("~/.config/nvim/")) unless File.exists?(File.expand_path("~/.config/nvim"))
end

def cask_install(app)
  run %{ brew cask install #{app} }
end

def cask_upgrade
  run %{
    brew cask doctor
    brew cask upgrade
  }
end
