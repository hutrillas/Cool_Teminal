#!/bin/bash
#For arch based distros
if [ "$(whoami)" == "root" ]; then
    exit 1
fi

ruta=$(pwd)

# Actualizando el sistema

sudo pacman -Syu

# Instalamos paquetes adionales

sudo pacman -S zsh xclip bat locate neofetch kitty

# Creando carpeta de Reposistorios

mkdir ~/github

# Instalando p10k

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Instalando p10k root

sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k

# Instando lsd

sudo pacman -S lsd

# Instalamos las HackNerdFonts

sudo cp -v $ruta/fonts/* /usr/local/share/fonts/

# Copiando Archivos de Configuración

cp -rv $ruta/Config/* ~/.config/
sudo cp -rv $ruta/kitty /opt/

# Kitty Root

sudo cp -rv $ruta/Config/kitty /root/.config/

# Copia de configuracion de .p10k.zsh y .zshrc

rm -rf ~/.zshrc
cp -v $ruta/.zshrc ~/.zshrc

cp -v $ruta/.p10k.zsh ~/.p10k.zsh
sudo cp -v $ruta/.p10k.zsh-root /root/.p10k.zsh

# Plugins ZSH

sudo pacman -S zsh-syntax-highlighting zsh-autosuggestions
sudo mkdir /usr/share/zsh-sudo
cd /usr/share/zsh-sudo
sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh

# Cambiando de SHELL a zsh

chsh -s /usr/bin/zsh
sudo usermod --shell /usr/bin/zsh root
sudo usermod --shell /usr/bin/zsh $(whoami)
sudo ln -s -fv ~/.zshrc /root/.zshrc

# Quitamos el Repositorio

rm -rf ~/github
rm -rf $ruta

# Mensaje de Instalado

notify-send "Terminal Instalada"
