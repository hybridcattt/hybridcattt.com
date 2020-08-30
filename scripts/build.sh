#!/bin/sh

git clone https://github.com/johnsundell/splash.git
cd splash

swift build -c release
install .build/release/SplashHTMLGen ../SplashHTMLGen

cd ..
jekyll build