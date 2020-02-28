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
# ttyd
ADD https://github.com/tsl0922/ttyd/releases/download/1.6.0/ttyd_linux.x86_64 /usr/bin/ttyd
# permissions
RUN chmod 755 /usr/bin/diff-so-fancy /usr/bin/prettyping /usr/bin/tldr /usr/bin/ttyd

# bat, fd, lsd, ripgrep
WORKDIR /tmp
RUN curl -L -O https://github.com/sharkdp/bat/releases/download/v0.12.1/bat_0.12.1_amd64.deb && \
    curl -L -O https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb && \
    curl -L -O https://github.com/Peltoche/lsd/releases/download/0.16.0/lsd_0.16.0_amd64.deb && \
    curl -L -O https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb && \
    dpkg -i bat_0.12.1_amd64.deb && \
    dpkg -i fd_7.4.0_amd64.deb && \
    dpkg -i lsd_0.16.0_amd64.deb && \
    dpkg -i ripgrep_11.0.2_amd64.deb
RUN rm -rf *

# correctly display powerline fonts
RUN locale-gen C.UTF-8 && \
    update-locale LANG=C.UTF-8

ENV LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TERM=xterm-256color

RUN ln -f /usr/bin/zsh /bin/sh && \
    groupadd -r -g 1337 leet && \
    useradd -r -m -u 1337 -g 1337 -s /usr/bin/zsh leet && \
    chown leet:leet /mnt

USER leet
WORKDIR /home/leet

# oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# fzf
RUN git clone https://github.com/junegunn/fzf.git ~/.oh-my-zsh/custom/plugins/fzf && \
    git clone https://github.com/Treri/fzf-zsh.git ~/.oh-my-zsh/custom/plugins/fzf-zsh && \
    ~/.oh-my-zsh/custom/plugins/fzf/install --bin
# powerlevel10k
RUN git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
# vim-plug
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# copy configuration files
ADD --chown=leet:leet config/* /home/leet/

# use diff-so-fancy for git diffs
RUN git config --global core.pager "diff-so-fancy | less --tabs=2 -RFX"

# install vim plugins
RUN mkdir -p ~/.vim/plugged && \
    vim +PlugInstall +qall > /dev/null

# update tldr cache
RUN tldr --update

# clean up git files
RUN find . \( -name ".git" -o -name ".gitignore" -o -name ".gitmodules" -o -name ".gitattributes" \) -exec rm -rf -- {} +

CMD ["/usr/bin/ttyd", \
    "--uid", "1337", \
    "--gid", "1337", \
    "--client-option", "fontFamily=FuraCode Nerd Font Mono", \
    "--client-option", "theme={'background': '#292d3e', 'foreground': '#bfc7d5'}", \
    "/usr/bin/zsh"]
