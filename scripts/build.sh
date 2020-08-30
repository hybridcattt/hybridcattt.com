#!/bin/sh

git clone https://github.com/johnsundell/splash.git
cd splash

swift build -c release
install .build/release/SplashHTMLGen /usr/local/bin/SplashHTMLGen

cd ..
jekyll build