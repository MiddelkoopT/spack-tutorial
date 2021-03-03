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

## Developmental Notes

* Tell a story to give context and references so students can follow
the console better, similar to what was done in statistics class with
doing the theory and why first, then doing it by hand on the board,
then finally in the console with R.

## Outline
1. Chapter 1 - Motivation and Theory - slides
   1. This is about the why (do it), and the how (it works). The "what" (to type) is easy (read the docs).
2. Chapter 2 - The Plan - Go over the chapters and communicat our end goal (reproducable science).
3. Chapter 3 - Moving In - user space
   1. Bring up the cloud with terraform.
   1. ssh and move in (skel + update + build-dep)
   1. Install spack (git clone and source environment)
   1. Kick off install `spack install tcl`
   1. Kick off install of other software in another terminal - gives time to build. 
      1. spack install python py-pip
      1. parallel:
```
DATE=$(date) ; for I in $(spack spec --json python py-pip | jq -r '.spec[] | keys | .[]') ; do echo $I ; spack install $I & done ; wait ; echo "=== DONE: $DATE to $(date)"
```
   1. Kick off another terminal and explore varients - ~lapack 
      1. spack install py-numpy~lapack
   1. Return to original tcl shell - explore system space - `spack load` - echo $PATH 
2. Chapter 4 - Setup the Project - project space
   1. `install -dv projects/launch`
   1. `git init`
   1. get config user.name, user.email
   1. echo "# Launch" > ReadMe.md ; git add ; git commit  ; git branch -m main  
   1. setup spack env.
   1. spack install tcl
   1. echo 'puts "hello world"' > one.tcl
3. Chapter 5. Move in to the project
   1. Basic system python3 project - system only - be simple
   1. Python3 Hello world
   1. Install spack env python3 `spack add python ; spack install` - this is key
   1. Look at spack.yaml
   1. Look at spack.lock
   1. Python3 numpy.
   1. ReadMe.md
   1. . ./envrionment.sh
   1. ./setup.sh
   1. ./cleanup.sh
   1. ./run.sh
   1. ./test.sh
   1. Developing - VS Code?
4. Chapter 6. Exporting the project
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
