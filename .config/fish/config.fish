if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -Ux EDITOR vim

set -x DOTNET_ROOT $HOME/dotnet
set -x DOTNET_TOOL $HOME/.dotnet/tools
set -x PATH $PATH $DOTNET_ROOT
set -x PATH $PATH $DOTNET_TOOL
set -x PATH $PATH $HOME/.cargo/bin
set -x MESSAGE_HOST_ENVIRONMENT Dev
set -x ASPNETCORE_ENVIRONMENT Dev
set -x MAVEN_HOME "$HOME/Application/java/maven/apache-maven-3.9.6"
set -x PATH $PATH $MAVEN_HOME/bin

set -x DOTNET_ROOT $HOME/dotnet
set -x PATH $PATH:$HOME/dotnet
set -x PATH $PATH:$HOME/.local/bin
set -x JAVA_HOME $HOME/Application/java/jdk-23.0.1
set -x KOTLIN_HOME $HOME/Application/java/kotlinc
set -x PATH $PATH $JAVA_HOME/bin $KOTLIN_HOME/bin
set -x PATH $PATH /usr/local/mysql/bin

source $HOME/.config/environment


source ~/Application/shells/fish/tod.sh
source ~/Application/shells/fish/tom.sh
source ~/.config/environment
source ~/Application/shells/fish/y.sh
