# Research Lifecycles Lecture Notes

## Teaching Perspective

This is a class on Spack and where to work in terms of project space,
user space, OS etc.  Focus on both the “project environment”,
repeatability and providence (spack.lock) aspects and the use of
containers - you can easily build a container to house spack and all
the environment.  Working independently from your service provider,
whatever that may be.

This is not a cooking show, we will be hanging out in the kitchen.
Don’t worry I have some frozen lasagna in the freezer.

Please type questions into the chat.


## Outline
1. Slides
1. Bring up terraform.
1. Ssh and move in (skel+ update)
1. Install spack (git clone)
1. Kick off install `spack install tcl`
1. Kick off install of other software in another window `spack install python py-pip ; spack install py-numpy~lapack`
`install -dv projects/launch`
1. git init 
1. setup spack env.
1. Basic system python3 project - system only - be simple
1. Install spack env python3 `spack add python ; spack install` - this is key
1. Look at spack.yaml
1. Python3 Hello world
1. Python3 numpy.
1. . ./envrionment.sh
1. ./setup.sh
1. ./cleanup.sh
1. ./run.sh
1. ./test.sh
1. Docker?

## Scientific Workflows

### Use Simple Solutions
Use simple solutions until they are not.

Python example.
1. System (package) interpreter and built in packages/modules.
2. Use venv
3. conda, anaconda, etc - skip this step
4. spack

Always stay in the project context (don't use user-space `pip install`)
