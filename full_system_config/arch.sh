#!bin/bash
#
#  _    __           __                      ______            _____      
# | |  / /___  _____/ /_____  _________ _   / ____/___  ____  / __(_)___ _
# | | / / __ \/ ___/ __/ __ \/ ___/ __ `/  / /   / __ \/ __ \/ /_/ / __ `/
# | |/ / /_/ (__  ) /_/ /_/ / /  / /_/ /  / /___/ /_/ / / / / __/ / /_/ / 
# |___/\____/____/\__/\____/_/   \__, /   \____/\____/_/ /_/_/ /_/\__, /  
#                               /____/                           /____/   
#
# Vostorg here. This is my full post-installation script for
# Arch-based distros.

echo "mononokiNF font pack installing"
sudo cp -r usr/ / 

echo "neovim plugin manager installing"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "packages installing"
PKGS=(
	# terminal 
	'alacritty'

	# text editor
	'neovim'

	# browser
	'firefox'

	# file manager
	'ranger'

	#chatting etc...
	'telegram-desktop'

	# other
	'w3m' # allow to draw pictures in ranger
	'gdu'
	'bashtop'
	'cmatrix'
	'bat'
	'exa'
	'lolcat'
	'figlet'
	'neofetch'
	'zip'
	'unzip'
	'python'
	'bpython'
	'feh'
	'tmux'
	'git'
	'simplescreenrecorder'
	'vlc'
	'virtualbox-host-modules-arch'
	'virtualbox-guest-iso'
	'calibre'
	'ripgrep'
	'elisa'
	'yt-dlp'
	'pandoc'
	'thunderbird'
	'catdoc'
	'zoxide' # kinda folder jumper
	'python-pip'
	'lazygit'
	'ipython'
	'tree'
	'unrar'
)

for PKG in "${PKGS[@]}"; do
    echo "installing: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo "tmux plugin manager installing"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "ranger-zoxide plugin installing"
git clone git@github.com:jchook/ranger-zoxide.git ~/.config/ranger/plugins/zoxide

echo "fzf installation"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "AUR package manager installing"
cd /opt
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R $USER:$USER ./yay-git
cd yay-git
makepkg -si
cd ~/

echo "AUR soft installation"
yay -S zotero tty-clock kwin-bismuth starship

echo "config downloading & setting"
cd ~/
git clone https://github.com/vostorgmachine/rc/
mkdir ~/.config/alacritty && cp ~/rc/alacritty.yml ~/.config/alacritty/
cp -r ~/rc/nvim/ ~/.config/
cp ~/rc/.tmux.conf ~/rc/.tmux-colorscheme.conf ~/
cp ~/.bashrc ~/.bashrc_old_bak
cp ~/rc/.bashrc ~/.bashrc
cp -r ~/rc/powerline/ ~/.config/.
source ~/.bashrc

echo
echo "=============================="
echo "All steps are done!"
echo "=============================="
echo
