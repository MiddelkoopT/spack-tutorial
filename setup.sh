#!/bin/bash

spack env create -d .
spack env activate -p -d .
spack install
spack find
