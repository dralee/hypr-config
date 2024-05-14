if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x DOTNET_ROOT $HOME/dotnet
set -x DOTNET_TOOL $HOME/.dotnet/tools
set -x PATH $PATH $DOTNET_ROOT
set -x PATH $PATH $DOTNET_TOOL
set -x PATH $PATH $HOME/.cargo/bin
set -x MESSAGE_HOST_ENVIRONMENT Dev
set -x ASPNETCORE_ENVIRONMENT Dev
set -x MAVEN_HOME "/home/dralee/Application/java/maven/apache-maven-3.9.6"
set -x PATH $PATH $MAVEN_HOME/bin


