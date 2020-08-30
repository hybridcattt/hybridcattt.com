#!/bin/sh

git clone https://github.com/johnsundell/splash.git
cd Splash
make install

jekyll build --drafts