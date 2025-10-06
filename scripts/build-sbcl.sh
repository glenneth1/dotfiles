#!/bin/bash

# set -x

clear

# script should scale to accomodate systems with only one cpu, or systems with many.
system_type=$(uname)

case "${system_type}" in
    Linux) 
        num_jobs="$(grep -c 'core id' /proc/cpuinfo)";;
    Darwin)
        num_jobs=6;;
esac
        
source_location="$HOME"/SourceCode/x-lisp-implementations/sbcl

export crosslisp="$(which sbcl)"

echo "this is the thing: $crosslisp"

while getopts "p:s:t:x:" flag
do
    case ${flag} in
        p) num_jobs=${OPTARG};;
        s) source_location=${OPTARG};;
        t) source_tag=${OPTARG};;
        x) crosslisp=${OPTARG};;
    esac
done

crosslisp="$(which "$crosslisp")"

echo "this is the thing now: $crosslisp" 

echo "NUMBER OF PARALLEL JOBS: $num_jobs"
echo "IN SOURCE TREE: $source_location"

export XCLISP="$crosslisp"

echo "CROSSLISP:: $XCLISP"

export SBCL_MAKE_JOBS=-j$num_jobs
export SBCL_MAKE_PARALLEL=$num_jobs

# exit 0

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

if [ ! "$source_location" ]
then
    source_location=~/SourceCode/x-lisp-implementations/sbcl/
fi

if [[ -d "$source_location" ]]; 
then
    echo "Using existing source repository in $source_location"
    cd "$source_location" &&
        sh ./clean.sh &&
        git checkout master
else
    echo 'Cloning SBCL source repository from https://github.com/sbcl/sbcl.git into ' "$source_location..."
    mkdir -p "$(dirname "$source_location")" &&
        cd "$(dirname "$source_location")" &&
        git clone https://github.com/sbcl/sbcl.git &&
        cd "$source_location" || exit 1
fi

echo 

git fetch --all --tags
git pull --all

## we can only calculate the source tag once we have a source
## repository, which is soonest, here.
if [[ ! $source_tag ]]
then
    # this is a nice idiom to get the most recent tag in the
    # repository. Defaults to master.
    source_tag="$(git describe --tags "$(git rev-list --tags --max-count=1)")"
fi
echo "BUILDING TAG: $source_tag"
echo "With lisp: $crosslisp"

echo
echo -n "Checking out $source_tag .. "

git checkout "$source_tag"
echo '[Done]'
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
sleep 2

# call the sbcl build bootstrap with an ANSI implementation of lisp. Prefer SBCL.
if [[ $(basename "$XCLISP") = "sbcl" ]] && [[ $(command -v "$XCLISP") ]]; then 
    sh ./make.sh --fancy --with-sb-linkable-runtime --with-sb-dynamic-core \
       --without-gencgc --with-mark-region-gc
elif [[ $(basename "$XCLISP") = "ccl" ]] && [[ $(command -v ccl) ]]; then
    sh ./make.sh --fancy --xc-host="$XCLISP --batch --no-init"
elif [[ $(basename "$XCLISP") = "ccl64" ]] && [[ $(command -v ccl64) ]]; then
    sh ./make.sh --fancy --xc-host="$XCLISP --batch --no-init"
elif [[ $(basename "$XCLISP") = "clisp" ]] && [[ $(command -v clisp) ]]; then
    sh ./make.sh --fancy --xc-host="$XCLISP -batch -norc"
else
    exit 6
fi

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

# make sbcl documentation

echo "Making the Documentation... "
sleep 5
cd doc/manual && make &&

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

# run tests. 

echo "Running the tests... "

sleep 5

cd "$source_location"/tests && sh ./run-tests.sh
