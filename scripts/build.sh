#!/bin/sh

git clone https://github.com/johnsundell/splash.git
cd splash
make install

jekyll build --drafts