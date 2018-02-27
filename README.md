# My personal git

## Setup 

`vagrant up` to test the installation

## What gets installed 

1. bash files
1. anaconda
 root - jupyter, aws, awless, mitmproxy, matplotlib, tmuxp
1. ~/.matplotlib/matplotlibrc contains "backend : TkAgg"
 pip install --user tmuxp
1. exercism
1. jupyter configurations
1. important packages

1. Alternate sbt script - https://github.com/sbt/sbt-launcher-package
1. Install curl https://raw.githubusercontent.com/wallix/awless/master/getawless.sh | bash


bin/
    multi-purpose utility scripts
configs/
    config files which are hidden in the home directory
mac_os_x/
    mac os x specific configs
misc/
    optional scripts, extensions, etc.

To pull git submodules, perform:

	git submodule init
	git submodule update
	conda create -n personal python=3.6
	source activate personal
	pip install ansible
	ansible playbook.yml
