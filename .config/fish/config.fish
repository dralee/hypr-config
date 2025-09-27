alias del "mv -t ~/.local/share/Trash/files/ --backup"

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
set -x JAVA_HOME /usr/lib/jvm/java-21-openjdk
set -x PATH $PATH $JAVA_HOME/bin
set -x MAVEN_HOME "/home/dralee/Application/java/maven/apache-maven-3.9.6"
set -x PATH $PATH $MAVEN_HOME/bin
set -x CPAPI_HOST_ENVIRONMENT Development
set -x ASPNETCORE_ENVIRONMENT Dev
set -x DINGTALKOPENAPI_HOST_ENVIRONMENT Development
set -x USERCENTER_HOST_ENVIRONMENT Dev
set -x CA_HOST_ENVIRONMENT Development
set -x PATH $PATH $HOME/.local/bin
set -x KOTLIN_NATIVE_HOME $HOME/Application/java/kotlin-native
set -x KOTLIN_HOME $HOME/Application/java/kotlinc
set -x PATH $PATH $KOTLIN_NATIVE_HOME/bin $KOTLIN_HOME/bin 
#set -x PATH $PATH $KOTLIN_HOME/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# mysql
set -x PATH $PATH /usr/local/mysql/bin


source ~/Application/shells/fish/tod.sh
source ~/Application/shells/fish/tom.sh
source ~/.config/environment


