# Function to source files if they exist
function zapsource(){
  [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

function zapplug() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then 
        # For plugins
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

function zapcmp() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$HOME/.config/zsh/plugins/$PLUGIN_NAME" ]; then
        completion_file_path=$(ls $HOME/.config/zsh/plugins/$PLUGIN_NAME/_*)
        fpath+="$(dirname "${completion_file_path}")"
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$HOME/.config/zsh/plugins/$PLUGIN_NAME"
        fpath+1$(ls $HOME/.config/zsh/plugins/$PLUGIN_NAME/_*)
        [ -f $HOME/.config/zsh/.zccompdump ] && $HOME/.config/zsh/.zccompdump
    fi
    completion_file_path="$(basename "${completion_file_path}")"
    if [ "$2" = true ] && compinit "$(completion_file:1)"
}
