# coolsh
🐚 A Docker container for shell power users

## Requirements
You will need Docker and [Fura Code Mono](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode) from [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts).

## TODO

  * [navi](https://github.com/denisidoro/navi)

## Included

### Shell

  * [Oh-My-ZSH](https://ohmyz.sh)
  * [powerlevel10k](https://github.com/romkatv/powerlevel10k)

### Editor

  * vim
  * [Plug](https://github.com/junegunn/vim-plug)
  * [vim-airline](https://github.com/vim-airline/vim-airline)
  * [vim-signify](https://github.com/mhinz/vim-signify)
  * [vim-gitgutter](https://github.com/airblade/vim-gitgutter)
  * [vim-bufferline](https://github.com/bling/vim-bufferline)
  * [vim-devicons](https://github.com/ryanoasis/vim-devicons)
  * [nerdtree](https://github.com/scrooloose/nerdtree)
  * [nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin)
  * [nerdtree-syntax-highlight](https://github.com/tiagofumo/vim-nerdtree-syntax-highlight)
  * [palenight](https://github.com/drewtempelmeyer/palenight.vim)

### Tools

  * awk
  * [bat](https://github.com/sharkdp/bat)
  * curl
  * [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
  * [fd](https://github.com/sharkdp/fd/)
  * git
  * [lsd](https://github.com/Peltoche/lsd)
  * [ncdu](https://dev.yorhel.nl/ncdu)
  * [prettyping](https://github.com/denilsonsa/prettyping)
  * [ripgrep](https://github.com/BurntSushi/ripgrep)
  * ssh
  * [tldr](https://tldr.sh)

## Usage

```
git clone https://github.com/khannurien/coolsh
cd coolsh
docker build -t coolsh .
docker run -it --hostname coucou -p 1337:7681 coolsh:latest
```

Your terminal will be available in a browser at `http://localhost:1337`.

You can also mount a directory from your host OS in order to work on it from the container:

```
docker run -it --hostname coucou -p 1337:7681 -v /path/to/directory:/mnt coolsh:latest
```

The directory will then be available at `/mnt` in the container.
