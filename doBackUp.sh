#!/bin/sh

rm -rf .config
rm -rf .oh-my-zsh
rm -rf .themes
mkdir .config
mkdir -p .oh-my-zsh/themes/
mkdir .themes

cp    ~/.config/compton.conf .config/
cp -r ~/.config/dunst        .config/
cp -r ~/.config/i3           .config/
cp -r ~/.config/polybar      .config/
cp -r ~/.config/rofi         .config/
cp -r ~/.config/nano         .config/
cp    ~/.nanorc              .
cp    ~/.oh-my-zsh/themes/aleNix.zsh-theme .oh-my-zsh/themes/
cp    ~/.Xresources          .
cp    ~/.zshrc               .
cp -r ~/.themes/materia-nord .themes/            
