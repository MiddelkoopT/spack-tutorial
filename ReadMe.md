# Spack Tutorial
Copyright 2021 Timothy Middelkoop.  License CC by SA 3.0

Simple Spack Tutorial on a Raspberry Pi 4 on Ubuntu 20.10

## Reading and References
* https://spack.io/
* https://spack.readthedocs.io/en/latest/index.html
* https://spack-tutorial.readthedocs.io/en/sc17/tutorial_environments.html
* https://spack.readthedocs.io/en/latest/environments.html

## Setup account
```
echo "source ~/spack/share/spack/setup-env.sh" >> ~/.bashrc
echo "shopt -s globstar dotglob" >> ~/.bashrc
echo "export LESS=-icMR" >> ~/.bashrc
git config --global color.ui auto
```

## Setup build environment
```
sudo apt-get install -y git python3 ca-certificates procps wget curl unzip jq build-essential automake gfortran
```

## Setup Spack
```
git clone https://github.com/spack/spack.git ~/spack
source ~/spack/share/spack/setup-env.sh
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

## Setup VS Code
```
export EDITOR=code
echo '/.vscode/' >> .gitignore
git add .gitignore
```

Exclude `~/.spack-env` in `.vscode/settings.json` from watcher due to size:
```
{"files.watcherExclude": { "**/.spack-env/**": true }}
```

## Setup Spack project environment (spack/user wide) - don't do this
```
spack env create $(basename $PWD)
spack env activate -p $(basename $PWD)
spack env deactivate
spack env rm $(basename $PWD)
```

## Setup spack project locally (project)
```
spack env create -d .
spack env activate -p -d .
echo '/.spack-env/' >> .gitignore
git add .gitignore
```

## Setup an env
```
spack find
spack add python py-pip
git add spack.yaml spack.lock
spack install
spack find
spack config get
```

## Close out
```
spack env deactivate
```

## Docker

Build and Run
```
./package.sh
docker run --rm -it spack-tutorial
```

Cleanup Docker processes and images
```
docker rm  `docker ps --no-trunc -aq`
docker rmi `docker images --no-trunc -aq --filter "dangling=true"`
```
