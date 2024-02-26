#!/bin/zsh -l

PYSCF_DIR=$HOME/Developer/pyscf
PYSCF_FORGE_DIR=$HOME/Developer/pyscf-forge

function upgrade() {
  pushd $1

  git fetch upstream
  current_branch=`git branch | grep \* | cut -d' ' -f2`
  git checkout master
  git pull
  if ! git merge upstream/master | grep "Already up to date."; then
    git push

    # Build new library
    pushd pyscf/lib/build
    if ! make -j 4; then
      echo "make failed, trying to build"
      cmake .. -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DCMAKE_BUILD_TYPE=Release
      make -j 4
    fi
    popd
  fi
  git checkout $current_branch
  popd
}

venv activate pyscf

echo "Updating PySCF: $PYSCF_DIR"
upgrade $PYSCF_DIR
echo "Updating PySCF-forge: $PYSCF_FORGE_DIR"
upgrade $PYSCF_FORGE_DIR

venv deactivate
