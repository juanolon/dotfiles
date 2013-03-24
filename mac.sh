# disable download warning
defaults write com.apple.LaunchServices LSQuarantine -bool NO
# fix bold fonts (default: 2)
defaults -currentHost write -globalDomain AppleFontSmoothing -int 0
# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false
