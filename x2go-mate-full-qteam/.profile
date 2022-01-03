# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

. ./.env
export SOFTWARE_BASE_PATH="~/${PROJECT}/install"

export ECLIPSE_HOME="$SOFTWARE_BASE_PATH/eclipse"
export ECLIPSE_WORKSPACE="$SOFTWARE_BASE_PATH/eclipse-workspace"
export M2_HOME="$SOFTWARE_BASE_PATH/apache-maven"
export M2_REPO="$SOFTWARE_BASE_PATH/.m2/repository"
export PATH=$ECLIPSE_HOME:$M2_HOME/bin:$SOFTWARE_BASE_PATH/bin:$PATH
export MAVEN_OPTS="-Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true"
export NPM_TOKEN_PASSWORD=YlAzWVZMdGM6UndIakVJT0NQN2Mtb3VZRnBvOXFUOGJ0U2dSWDNIZ3Nnekd5c1RxbW9sWHA=