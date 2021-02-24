# Level two Python

import numpy

def main():
    rg=numpy.random.default_rng(1)
    a=rg.random((3,2))
    b=rg.random((2,3))
    print(a)
    print(b)
    print(b @ a)

if __name__=='__main__':
    print("two.py>")
    exit(main())
