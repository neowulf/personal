#!/bin/sh

# http://wiki.macromates.com/Main/SubversionCheckout

pushd /Library/Application\ Support/TextMate/Bundles
export LC_CTYPE=en_US.UTF-8
svn update
echo "--Textmate bundles updated..."
echo

cd groovy.tmbundle
git pull origin master
echo "--Textmate groovy bundle updated..."

# hg clone https://bitbucket.org/croach/json.tmbundle
cd ../json.tmbundle
hg pull
echo "--Textmate json bundle updated..."

# git clone git://github.com/alkemist/Confluence.tmbundle.git
cd ../Confluence.tmbundle
git pull origin master
echo "--Textmate Confluence bundle updated..."

popd
osascript -e 'tell app "TextMate" to reload bundles'
