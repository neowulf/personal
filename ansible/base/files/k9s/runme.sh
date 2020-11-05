#!/bin/bash

set -ex

# overwrite config.yml with config-base.yml for keys that exist
yq m -ix config.yml config-base.yml

rm plugin.yml
yq m *.yml ~/.work/configs/k9s-plugins-work.yml > plugin.yml
