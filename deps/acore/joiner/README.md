# Joiner v0.8.4

Universal crossplatform and agnostic dependency manager written in bash for any kind of module. 

it is compatible with:

- Linux (natively)
- MacOS (natively)
- Windows (via mingw, wsl or other installable bash console)

This script is able to install and update modules and its dependencies via git clone, submodule or files directly.
To install dependencies you must configure your repository to support Joiner. Read instructions below.

## Projects that are using Joiner

- https://github.com/azerothcore/azerothcore-wotlk

- https://github.com/hw-core

## features

- install modules via git clone/submodule or files/zipped folders
- update modules downloaded via git
- remove modules and its dependencies
- define and install dependencies or suggested modules
- since it uses bash, you can run any kind of task/script during install/uninstall (compilation, configuration etc.)

## requirements

- bash
- git
- unzip
- curl

## Installation

This command will download the script then you can directly run it or include in your script to run commands programmatically   

```
git clone https://github.com/drassil/joiner.git drassil/joiner
```

if you want to include in your scripts you can use this code that will also automatically download the joiner if you don't have it yet and will keep it updated at each run (internally handled by joiner script):

```
J_PATH_MODULES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/modules"
[ ! -d $J_PATH_MODULES/drassil/joiner ] && git clone https://github.com/drassil/joiner $J_PATH_MODULES/drassil/joiner -b master
source "$J_PATH_MODULES/drassil/joiner/joiner.sh"
```

## Usage

You can run joiner executing it in a bash shell. It will prompt an interactive menu where you can run commands or just run them directly via command line (see below)

Alternatively you can use it programmatically running internal functions in your scripts (see below). It's also needed to create a module compatible with Joiner dependency manager.

## Sample

This command will install js-lib-class modules and its dependencies

    joiner add-repo https://github.com/HW-Core/js-lib-class

To install also development dependencies (test and documentation modules) you've to run:

    joiner add-repo --dev https://github.com/HW-Core/js-lib-class
    
## Options

-d|--dev: install development dependencies (see Joiner:with_dev)

-e|--extras: install extras dependencies (see Joiner:with_extras)

-z|--unzip: if adding a compressed file, this option will unzip it

## Command line

- **add-repo (a)**: download and install a module from git repository.
  
  Syntax: joiner.sh add-repo [-d] [-e] url name branch [basedir]
  
  If you set name/branch as empty string ("") the system will use default values

- **upd-repo (u)**: update a module.
  Syntax: joiner.sh upd-repo [-d] [-e] url name branch [basedir]
  
  If you set name/branch as empty string ("") the system will use default values

- **add-git-submodule (s)**: download and install module from git repository as git submodule.
  
  Syntax: joiner.sh add-git-submodule [-d] [-e] url name branch [basedir]

  If you set name/branch as empty string ("") the system will use default values


- **add-file (f)**: download and install a file or zipped folder.

  Syntax: joiner.sh add-file [-d] [-e] [-z] source [destination]

- **remove (r)**: uninstall and remove a module.

  Syntax: joiner.sh remove name [basedir]

- **self-update (j)**: Update joiner version to the latest stable (master branch)

  Syntax: joiner.sh self-update



## Programmatically usage

### commands methods
Download and install a module from git repository.

    Joiner:add_repo [-d] [-e] url name branch [basedir]

Update a module.

    Joiner:upd_repo [-d] [-e] url name branch [basedir]

Download and install module from git repository as git submodule.
    
    Joiner:add_git_submodule [-d] [-e] url name branch [basedir]

Download and install a file or zipped folder.

    Joiner:add_file [-d] [-e] [-z] source [destination]

Uninstall and remove a module.

    Joiner:remove name [basedir]

### conditional methods

Check if Joiner has been run with --dev|-d option

    Joiner:with_dev

    return: true|false

Check if Joiner has been run with --extras|-e option

    Joiner:with_extras

    return: true|false

Update joiner version to the latest stable (master branch)

    Joiner:self_update


## How to create a Joiner module

Creating a Joiner compatible module is extremely simple.
You just have to create following files in the root directory of your project:

### install.sh

```
#!/usr/bin/env bash

J_PATH_MODULES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/modules"
[ ! -d $J_PATH_MODULES/drassil/joiner ] && git clone https://github.com/drassil/joiner $J_PATH_MODULES/drassil/joiner -b master
source "$J_PATH_MODULES/drassil/joiner/joiner.sh"

## You can do any kind of pre-install task here

# ADD DEPENDENCIES

Joiner:add_repo "dependency-repo-url"

if Joiner:with_dev ; then
    Joiner:add_repo "dev-dependency-repo-url"
fi

## You can do any kind of post-install task here
```


### uninstall.sh


```
#!/usr/bin/env bash

J_PATH_MODULES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/modules"
[ ! -d $J_PATH_MODULES/drassil/joiner ] && git clone https://github.com/drassil/joiner $J_PATH_MODULES/drassil/joiner -b master
source "$J_PATH_MODULES/drassil/joiner/joiner.sh"

#
# REMOVE DEPENDENCIES
#

Joiner:remove "dependency-folder-name"

```

If other dependencies are Joiner modules then joiner will install dependencies recursively, otherwise will just download them.


## Contribute

Please use github platform to report an issue or ask anything you like:

https://github.com/Drassil/joiner







