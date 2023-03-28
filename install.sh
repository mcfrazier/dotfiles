#!/usr/bin/env bash
# /install.sh


GITHUB_USER="mcfrazier"
GITHUB_REPO="dotfiles"
DIR="${HOME}/.${GITHUB_REPO}"

LOG="${DIR}/dotfiles.log"
touch "${LOG}"


##message helper fns
_warning() {
  echo "$(date) WARNING:  $@" >> $LOG
  printf "$(tput setaf 3) WARNING:$(tput sgr0) %s\n" "$@"
}

_error() {
  echo "$(date) ERROR:  $@" >> $LOG
  printf "$(tput setaf 3) ERROR:$(tput sgr0) %s. Aborting...\n" "$@"
  exit 1
}
_process() {
  echo "$(date) PROCESSING:  $@" >> $LOG
  printf "$(tput setaf 6)→ %s...$(tput sgr0)\n" "$@"
}

_success() {
  local message=$1
  printf "%s✓ SUCCESS:%s\n" "$(tput setaf 2)" "$(tput sgr0) $message"
}

_question() {
  printf "$(tput setaf 4) %s $(tput sgr0)" "$@"
}
##end msg help fns


##installation helper fns
install_git() {
  _process "Installing git"

  sudo apt install git -y
  #ln -s "${DIR}/configs/.gitconfig" "${HOME}/.gitconfig"
  #ln -s "${DIR}/configs/.gitignore" "${HOME}/.gitignore"

  [[ $? ]] && _success "Installed git"
}

setup_git() {
  _process "Setting up git author"

  #check if git author already set
  GIT_AUTHOR_NAME=eval "git config user.name"
  if [[ ! -z "$GIT_AUTHOR_NAME" ]]; then
    _question "Enter your name:"
    read USER_GIT_AUTHOR_NAME
    if [[ ! -z "$USER_GIT_AUTHOR_NAME" ]]; then
      GIT_AUTHOR_NAME="${USER_GIT_AUTHOR_NAME}"
      $(git config --global user.name "$GIT_AUTHOR_NAME")
    else
      _warning "No git user name has been set. Please update manually"
    fi


    _question "Enter your email:"
    read USER_GIT_AUTHOR_EMAIL
    if [[ ! -z "$USER_GIT_AUTHOR_EMAIL" ]]; then
      GIT_AUTHOR_EMAIL="${USER_GIT_AUTHOR_EMAIL}"
      $(git config --global user.email "$GIT_AUTHOR_EMAIL")
    else
      _warning "No git user email has been set. Please update manually"
    fi
  else
    _process "git author already set"

  fi
}

#TODO 
init_git_repo() {
  _process "Initializing git repository"
  git init

  git remote add origin "https://github.com/${GITHUB_USER}/${GITHUB_REPO}.git"

  git fetch origin main

  git reset --hard FETCH_HEAD

  git clean -fd

  git pull origin main

  [[ $? ]] && _success "${GITHUB_REPO} repository has been initialized"
}
##end install helper fns


download_dotfiles() {
  _process "Creating directory at ${DIR} and setting permissions"
  mkdir -p "${DIR}"

  _process "Downloading repository to /tmp directory"
  curl -#fLo /tmp/${GITHUB_REPO}.tar.gz "https://github.com/${GITHUB_USER}/${GITHUB_REPO}/tarball/main"
  #curl -#fLo /tmp/${GITHUB_REPO}.tar.gz -u token:${PAT} "https://github.com/${GITHUB_USER}/${GITHUB_REPO}/tarball/main"

  _process "Extracting files to ${DIR}"
  tar -zxf /tmp/${GITHUB_REPO}.tar.gz --strip-components 1 -C "${DIR}"

  _process "Removing tarball from /tmp directory"
  rm -rf /tmp/${GITHUB_REPO}.tar.gz

  [[ $? ]] && _success "${DIR} created, repository downloaded and extracted"

  #change into dir
  cd "${DIR}"

}


link_dotfiles() {
  #symlink files to the HOME directory
  # CHANGING TO USER_HOME, ow running w sudo causes write to root dir
  if [[ -f "${DIR}/opt/files" ]]; then
    _process "Symlinking dotfiles in /configs"

    #set variable for list of files
    files="${DIR}/opt/files"

    #store IFS separator within a temp var
    OIFS=$IFS
    #set the separator to a carriage return and newline
    #read in passed-in file, store as arr
    IFS=$'\r\n'
    links=($(cat "${files}"))

    #loop through arr of files
    for index in ${!links[*]}
    do  
      for link in ${links[$index]}
      do
        _process "Linking ${links[$index]}"
        #set IFS back to space to split string
        IFS=$' '
        #create an arr of line items
        file=(${links[$index]})
        #create symlink
        #ln -fs "${DIR}/${file[0]}" "${USER_HOME}/${file[1]}"
        ln -fs "${DIR}/${file[0]}" "${HOME}/${file[1]}"
      done
      #set IFS back to \r and \n
      IFS=$'\r\n'
    done

    #reset IFS
    IFS=$OIFS

    [[ $? ]] && _success "All files have been copied"
  fi
}


main() {
  _process "Updating current packages"
  sudo apt update
  sudo apt upgrade -y
  [[ $? ]] && _success "Current packages have been updated"

  #check if git is installed
  if ! type -P 'git' &> /dev/null; then
    install_git
  fi

  setup_git

  #init_git_repo

  download_dotfiles
  link_dotfiles

  #TODO install packages


  . "${HOME}/.bashrc"
}


main
