#!/bin/sh

git clone https://github.com/p4nd4tz/zap.git "$HOME/.local/share/zap"

echo '[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh" >> $HOME/.config/zsh/.zshrc'
