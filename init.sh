#!/bin/bash
function install_omzgit(){
		if ! command -v zsh ;then
				if command -v yum ;then
						yum -y install zsh git
				elif command -v apt ;then
						sudo apt -y install zsh git
				else
						echo "zsh not found"
				fi
		fi
		if [ -z $ZSH ] ;then
				sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
		fi
		if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions" ]; then
		git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
		fi
		if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting" ]; then
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
		fi
		curl -fLo ~/.zshrc https://raw.githubusercontent.com/Someone-Zh/AppConfigFile/master/shell/.zshrc
}
function install_vim(){
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
				https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		vim -c PlugInstall 
		curl -fLo ~/.vimrc https://raw.githubusercontent.com/Someone-Zh/AppConfigFile/master/vim/.vimrc
}
function install_docker(){
	 sh -c "$(curl -fsSL get.docker.com)" --mirror Aliyun
}
function main(){
	install_omzgit
	install_vim
}

main $@
