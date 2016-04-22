FROM xrdp
MAINTAINER Sven Dowideit <SvenDowideit@home.org.au> @SvenDowideit

ENV USERNAME dockerx
ENV HOME /home/$USERNAME
#RUN groupadd -r $USERNAME -g 757 && \
#     useradd -u 757 --create-home --home-dir $HOME $USERNAME -g $USERNAME && \
#     chown -R $USERNAME:$USERNAME $HOME && \
#     echo "$USERNAME:$USERNAME" | chpasswd && adduser $USERNAME sudo # Give user ability to use sudo

# Setup for non-interactive install
ENV DEBIAN_FRONTEND noninteractive

# Update all the package references available for download
RUN apt-get update

# Install tools
RUN apt-get install -y \
    python-software-properties \
    software-properties-common \
    gcc-4.9 \
    git \
    make \
    wget

RUN ln -s /usr/bin/gcc-4.9 /usr/bin/gcc

# Switch to non-root user
USER $USERNAME
RUN mkdir $HOME/bin
ENV PATH $HOME/bin:$PATH

# Go-specific instructions.
# Reference link: https://golang.org/dl/
ENV GOLANG 1.6.2
RUN wget https://storage.googleapis.com/golang/go${GOLANG}.linux-amd64.tar.gz -O $HOME/go.tar.gz
RUN mkdir $HOME/go && tar -C $HOME -xzf $HOME/go.tar.gz && rm $HOME/go.tar.gz
RUN ln -s $HOME/go/bin/go $HOME/bin/go

# Set the gopath
RUN mkdir -p $HOME/project/src
ENV GOPATH $HOME/project
ENV GOROOT $HOME/go

# Install tools
RUN go get -u -v github.com/nsf/gocode github.com/rogpeppe/godef github.com/golang/lint/golint github.com/lukehoban/go-find-references sourcegraph.com/sqs/goreturns golang.org/x/tools/cmd/gorename

# Install the debugger
ENV GO15VENDOREXPERIMENT 1
RUN git clone https://github.com/derekparker/delve.git $GOPATH/src/github.com/derekparker/delve
#RUN cd $GOPATH/src/github.com/derekparker/delve && git checkout v0.11.0-alpha && make install
RUN cd $GOPATH/src/github.com/derekparker/delve && make install

# Preserve the PATH because when we run `su $USERNAME`, PATH would have been reset.
# Part of workaround discussed in entry.sh
RUN echo "export PATH=$PATH:$GOPATH/bin" >> $HOME/.bashrc

# Remove all files in the src folder to clean up
RUN rm -rf $GOPATH/src/*

# Set the workspace
WORKDIR $GOPATH
#USER root
# Add the entrypoint script
#ADD entry.sh $HOME/bin/entry.sh
#RUN chmod +x $HOME/bin/entry.sh
USER $USERNAME

#ENTRYPOINT "$HOME/bin/entry.sh"
#FROM base-gdec-gui
#MAINTAINER James C. Scott III <jcscott.iii@gmail.com>

# Change to root to install more dependencies
USER root
# Make sure to download newer version of node than what is the default in apt-get
# Install other dependencies
RUN apt-get install -y curl
#RUN curl -sL https://deb.nodesource.com/setup | sudo -E bash -
RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
RUN apt-get install -y \
    nodejs \
    zip


# Change back to non-root user
USER $USERNAME

# Switch npm prefix to prevent using sudo.
RUN mkdir $HOME/.npm-global
ENV NPM_CONFIG_PREFIX $HOME/.npm-global
ENV PATH $HOME/.npm-global/bin:$PATH

# Install VSCode
#RUN wget -O $HOME/VSCode.zip 'https://az764295.vo.msecnd.net/public/0.10.3/VSCode-linux64.zip'
# https://go.microsoft.com/fwlink/?LinkID=620884
RUN wget -O $HOME/VSCode.zip 'https://go.microsoft.com/fwlink/?LinkID=620884'
RUN unzip $HOME/VSCode.zip -d $HOME/vscode/
RUN ln -s $HOME/vscode/VSCode-linux-x64/Code $HOME/bin/code

USER root

# Install vsce, the Visual Studio Extension Manager
RUN npm install -g vsce
RUN npm --version \
	&& which vsce

USER $USERNAME

# Install the vscode-go extension
RUN git clone https://github.com/Microsoft/vscode-go $HOME/.vscode/extensions/lukehoban.Go
RUN cd $HOME/.vscode/extensions/lukehoban.Go \
	&& git checkout tags/0.6.30
RUN cd $HOME/.vscode/extensions/lukehoban.Go \
	&& npm install
#RUN cd $HOME/.vscode/extensions/lukehoban.Go \
#	&& chmod 755 ./node_modules/vscode/bin/compile \
#	&& vsce package

# Add settings.json file that contains settings for the go extension
RUN mkdir -p $HOME/.config/Code/User/
ADD settings.json $HOME/.config/Code/User/settings.json

# Move back to root for the su in entry.sh
USER root

# chown the settings.json file to the non-root user
RUN chown -R $USERNAME:$USERNAME $HOME/.config/Code/User/settings.json


ADD xsession $HOME/.xsession
ADD start.sh /
ENTRYPOINT ["/start.sh"]

# xrdp_sec_incoming: error reading /etc/xrdp/rsakeys.ini file
#RUN xrdp-keygen xrdp /etc/xrdp/rsakeys.ini

RUN apt-get install -y \
    libgtk2.0-0 \
    libgconf-2-4 \
    libasound2 \
    libxtst6 \
    libnss3

RUN apt-get clean

# OMG. https://github.com/Microsoft/vscode/issues/3451#issuecomment-199090068
RUN sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1
