#!/bin/bash
set -e
echo "=== test.sh $(date)"

echo "=== Test spack envrionment"
( . ./environment.sh ;
  which python3 | grep .spack-env/view/bin/python3$
  spack --version
  python3 --version
)

echo "=== Run test code"
## Filter out lines that start with '---'
./run.sh | grep -v '^---' | tee run.out

echo "=== Verify results"
if [ ! -f run.md5 ] ; then
    echo "+++ no run.md5 found - generating"
    md5sum run.out > run.md5
else
    md5sum -c run.md5
    echo "=== All tests passwd"
fi

