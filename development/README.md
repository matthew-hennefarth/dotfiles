# Developer Information

## Python Packages

I will try to reduce the amount of python packages that I install globally and instead prefer virtual environments. Though, of course, there are certain packages that I would like everywhere and so it doesn't make sense to NOT install them. Hence, they will live in this relatively small `requirements.txt` file. To install on a fresh system, just do

`pip -r requirements.txt`

## Virtualenvs

Homebrew should have installed `virtualenv`. I like to create my virtual environments in `Developer/.venvs`. Then I can quickly activate them like

```
source activate pyscf
```

and can deactivate with 

```
deactivate
```

I like to additionally append any python paths that are necessary in the `activate` files to get the program to run. For example, in pyscf, I need to do

```
if ! [ -z "${_OLD_VIRTUAL_PYTHONPATH+_}" ]; then
  PYTHONPATH="${_OLD_VIRTUAL_PYTHONPATH}"
  export PYTHONPATH
  unset _OLD_VIRTUAL_PYTHONPATH
fi
```

in the `deactivate` function and add a

```
# deal with PYTHONPATH
VIRTUAL_PYTHONPATH="$HOME/Developer/pyscf"
_OLD_VIRTUAL_PYTHONPATH="$PYTHONPATH"
PYTHONPATH="$VIRTUAL_PYTHONPATH:$PYTHONPATH"
export PYTHONPATH
```

At some later point, I might add some dependence on `modules` to these files, but I am unsure if I necessarily want to do that quite yet. It doesn't seem that it is particularly important to do so anyways.
