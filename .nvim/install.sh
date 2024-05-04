#!/bin/bash

set -eu

# config
VIMRC="$HOME/.vimrc"
NVIMCONFIG="$HOME/.config/nvim/init.vim"


# dotfiles
DOTNVIM="./.nvim/nvim.config"
PLUGIN="./.nvim/plugins"

####### INIT VIMRC

if ! [ -f "$VIMRC" ]; then
	echo "Create .vimrc file" >&2
	touch "$VIMRC"
fi

####### INIT CONFIG

if ! [ -f "$NVIMCONFIG" ]; then
	echo "Create vim config file at $NVIMCONFIG" >&2
	touch "$NVIMCONFIG"
fi

######## CONFIG

if [ -f "$NVIMCONFIG" ]; then
	content_nvim_config=$(cat $DOTNVIM)

	if ! grep -q "$content_nvim_config" "$DOTNVIM"; then
		echo "Add nvim config to .vimrc" >&2
		cat $NVIMCONFIG >> $DOTNVIM
	fi
fi

######## PLUGINS

START_MANAGER_LINE="call plug#begin('~/.vim/plugged')"
END_MANAGER_LINE="call plug#end()"

#Lazy plugin manager
echo "Download vim-plug manager..." >&2
curl -SsfLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


if [ -f "$PLUGIN" ]; then
	plugin_content=$(cat $PLUGIN)

	if ! grep -q "$plugin_content" "$VIMRC"; then
		echo $START_MANAGER_LINE >> $VIMRC
		echo "Add plugins to .vimrc" >&2
		cat $PLUGIN >> $VIMRC
		echo $END_MANAGER_LINE >> $VIMRC
	fi
fi


