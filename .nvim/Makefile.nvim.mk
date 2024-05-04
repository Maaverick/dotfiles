

clean::
	@echo "Delete .vimrc"
	rm -f ~/.vimrc
	@echo "Delete init.vim"
	rm -f ~/.config/nvim/init.vim

install::
	$(shell bash ./.nvim/install.sh)

