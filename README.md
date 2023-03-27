# dotfiles

Script to install config files ~~and often-used packages~~ onto a fresh OS
without the need to clone the repository.

This is mainly serving as a proof-of-concept, but should also make things
somewhat more convenient.

## Install

Note that this script will **replace all current dotfiles** with the dotfiles
in this repo.

```sh
bash -c "$(curl -#fL raw.github.com/mcfrazier/dotfiles/main/install.sh)"
```

## TODO
 - add package auto installation
 - implement compatibility across OS, particularly with vimrc over unix, win,
   and gvim 
 - update script


## Acknowledgements
Much of this code was adapted from [here](https://github.com/gjunkie/dotfiles)
