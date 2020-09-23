#!/bin/sh

if [ -d splash ]; then 
  echo Splash is already checked out
else
  git clone https://github.com/johnsundell/splash.git
fi

cd splash
swift build -c release
install .build/release/SplashHTMLGen ../SplashHTMLGen

cd ..
JEKYLL_ENV=production jekyll build
