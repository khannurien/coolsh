# coolsh
🐚 A Docker container for shell power users

## Included

### Shell

  * [Oh-My-ZSH](https://ohmyz.sh)
  * [powerlevel10k](https://github.com/romkatv/powerlevel10k)

### Editor

  * vim
  * [Plug](https://github.com/junegunn/vim-plug)
  * [vim-airline](https://github.com/vim-airline/vim-airline)
  * [vim-signify](https://github.com/mhinz/vim-signify)
  * [palenight](https://github.com/drewtempelmeyer/palenight.vim)

## Tools

  * awk
  * [bat](https://github.com/sharkdp/bat)
  * curl
  * [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
  * [fd](https://github.com/sharkdp/fd/)
  * [lsd](https://github.com/Peltoche/lsd)
  * [ncdu](https://dev.yorhel.nl/ncdu)
  * [prettyping](https://github.com/denilsonsa/prettyping)
  * [ripgrep](https://github.com/BurntSushi/ripgrep)
  * ssh
  * [tldr](https://tldr.sh)

## Usage

```
git clone https://github.com/khannurien/coolsh
cd coolsh
docker build -t coolsh .
docker run -it --hostname coucou coolsh:latest
```
