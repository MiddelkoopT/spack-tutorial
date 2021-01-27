# Spack Tutorial
Copyright 2021 Timothy Middelkoop.  License CC by SA 3.0

Simple Spack Tutorial on a Raspberry Pi 4 on Ubuntu 20.10

## Setup account
```
echo "source ~/spack/share/spack/setup-env.sh" >> ~/.bashrc
echo "shopt -s globstar dotglob" >> ~/.bashrc
echo "export LESS=-icMR" >> ~/.bashrc
git config --global color.ui auto
```

## Setup build environment
```
sudo apt-get install -y git python3 ca-certificates procps wget curl unzip jq build-essential automake
```

## Setup Spack
```
git clone https://github.com/spack/spack.git ~/spack
source ~/spack/share/spack/setup-env.sh
spack install python py-pip
```

## Setup development environment
```
sudo apt-get install -y --no-install-recommends emacs-nox
sudo apt-get install -y aspell-en bash-completion rsync
git config --global core.editor 'emacs -nw' # overidden by GIT_EDITOR
```

## Setup project
```
install -dv ~/projects/spack-tutorial
cd ~/projects/spack-tutorial && git init
git config user.name ""
git config user.email ""
```

## Setup Spack project environment (spack/user wide)
```
spack env create $(basename $PWD)
spack env activate -p $(basename $PWD)
spack env deactivate
```

## Setup spack project locally (project)
