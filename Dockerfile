FROM zshusers/zsh:5.7.1

# ncdu, vim
RUN install_packages \
    ca-certificates \
    curl \
    gawk \
    git \
    iputils-ping \
    locales \
    ncdu \
    ncurses-bin \
    openssh-client \
    vim

# diff-so-fancy
ADD https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy /usr/bin/
# pretty ping
ADD https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping /usr/bin/
# tldr
ADD https://raw.githubusercontent.com/raylee/tldr/master/tldr /usr/bin/
# permissions
RUN chmod 755 /usr/bin/diff-so-fancy /usr/bin/prettyping /usr/bin/tldr

# bat, fd, lsd, ripgrep
WORKDIR /tmp
RUN curl -L -O https://github.com/sharkdp/bat/releases/download/v0.11.0/bat_0.11.0_amd64.deb && \
    curl -L -O https://github.com/sharkdp/fd/releases/download/v7.3.0/fd_7.3.0_amd64.deb && \
    curl -L -O https://github.com/Peltoche/lsd/releases/download/0.15.1/lsd_0.15.1_amd64.deb && \
    curl -L -O https://github.com/BurntSushi/ripgrep/releases/download/11.0.1/ripgrep_11.0.1_amd64.deb && \
    dpkg -i bat_0.11.0_amd64.deb && \
    dpkg -i fd_7.3.0_amd64.deb && \
    dpkg -i lsd_0.15.1_amd64.deb && \
    dpkg -i ripgrep_11.0.1_amd64.deb
RUN rm -rf *

# correctly display powerline fonts
RUN locale-gen C.UTF-8 && update-locale LANG=C.UTF-8
ENV LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8
ENV TERM=xterm-256color

RUN ln -f /usr/bin/zsh /bin/sh
RUN groupadd -r -g 1337 leet && \
    useradd -r -m -u 1337 -g 1337 -s /usr/bin/zsh leet
RUN chown leet:leet /mnt

USER leet
WORKDIR /home/leet

# oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# powerlevel10k
RUN git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
# vim-plug
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ADD --chown=leet:leet config/.zshrc /home/leet/
ADD --chown=leet:leet config/.vimrc /home/leet/

RUN git config --global core.pager "diff-so-fancy | less --tabs=2 -RFX"

# install vim plugins
RUN mkdir -p ~/.vim/plugged && \
    vim +PlugInstall +qall > /dev/null

# clean up git files
RUN find . \( -name ".git" -o -name ".gitignore" -o -name ".gitmodules" -o -name ".gitattributes" \) -exec rm -rf -- {} +

CMD ["/usr/bin/zsh"]
