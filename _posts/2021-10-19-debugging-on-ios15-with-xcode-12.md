---
layout: post
title: "Debugging on iOS 15 with Xcode 12"
tags: 
  - Xcode
  - Debugging
excerpt: If your app can't be upgraded to Xcode 13 right away, but still has to run on iOS 15, you're limited in debuging options with Xcode 12. #With some tricks, we can not only run on iOS 15 but also debug with breakpoints and much more.
medium_link: https://medium.com/@hybridcattt/d332f12f49dd?source=friends_link&sk=89454bc213ad54dd3fb773f5f19e3057
image: /assets/posts/debugging-ios14-xcode11/failed_to_start_error.png
twitter: 
  card: summary_large_image
toc_config:
  max_toc_level: 2
---

Every year we get a new major iOS version to test our apps on. 
The lucky ones can immediately upgrade to the newest Xcode 13, building against the latest iOS 15 SDK. 
Some other, larger projects can take a while to get upgraded. 
Those projects have to be built with Xcode 12 in the meantime. 
But even though those apps can’t be upgraded yet, they are still expected to work well on the newest iOS. And solving problems and bugs requires debugging.

Out of the box, older Xcode versions can’t work with newer iOS versions. However, with some tricks, I could not only run on iOS 15 but also debug with breakpoints and much more.

## With Xcode 13 installed

If you can have both Xcode 13 and Xcode 12 installed on your machine, then you're in luck.
Due to changes in Xcode 13, Xcode 12 can now pick up device support files for newer iOS versions. 
Chances are you will need Xcode 13 anyway - for other projects or just for playing around with - so this is a great option.

There is no need to copy device support files or anything like that anymore. 

To install Xcode 13 in parallel with Xcode 12, I can think of a few options:

- use [xcode-install](https://github.com/xcpretty/xcode-install) command-line tool
- download Xcode 13 from [Downloads](https://developer.apple.com/download/all/)
- if you install your Xcode from App Store, upgrade it and download Xcode 12 again from [Downloads](https://developer.apple.com/download/all/)
- if you install your Xcode from App Store, zip or move Xcode.app before upgrading the App Store version (just renaming won't help), and unzip/move back to `/Applications` again after App Store update is complete.

Once you have Xcode 13, launch it, install command line tools when prompted, and run any project on your iOS 15 device at least once. Voila, you can now use your device in Xcode 12.5 as well for running, debuging, etc as normal 🙌

### How to prevent accidental rebuilding with Xcode 13

Since you're building with Xcode 12, but also have Xcode 13 installed, you might accidentally rebuild on Xcode 13 and end up pushing a very different build of the app than originally intended. 
To avoid accidentally building with Xcode 13, you can add a conditional compilation error for that case: 

{% splash %}
#if compiler(>=5.5)
#error("This project should not be built on Xcode 13")
#endif
{% endsplash %}

This piece of code can be placed anywhere in the source. The `#error` directive is skipped when the source code is compiled with the Swift compiler of any version lower than 5.5, which corresponds to Xcode 12.5 or older.
This way, it's not even technically possible to accidentally build on Xcode 13.  

## Without Xcode 13 installed

If you can't have Xcode 13 installed on your machine for some reason, there are still ways to run and debug on devices with iOS 15, although limited.

A usual run action in Xcode consists of a few independent steps:
- Building for the device.
- Installing the app on the device.
- Launching the app.
- Attaching a debugger.

These steps rely on Xcode being able to communicate with the physical device, and the communication interface can change between iOS versions.
So debugging an app built with an older version of Xcode requires a few tricks. 

### Building and installing a debug build to iOS 15 with Xcode 12

Being able to run against the newest iOS version is a problem that we had to previously fix every year. Thankfully, the same solution works every time.
An Xcode application bundle contains support files for each iOS version it knows how to work with.
Adding support for iOS 15 to Xcode 12.5 is a matter of copying device support files for iOS 15 into Xcode 12. 
Commonly, these device support files can be copied from Xcode 13 (copied from a coworker's machine or downloaded from a popular shared repo).  
It's been already widely discussed, so here's an article I like on the topic: [How to Fix Xcode: “Could Not Locate Device Support Files” Error](https://faizmokhtar.com/posts/how-to-fix-xcode-could-not-locate-device-support-files-error-without-updating-your-xcode/).

### Launching the app

With the default setup, a debug app build will automatically try to launch on the selected device after installation. 
Unfortunately, Xcode 12.5 doesn't know how to launch apps on iOS 15, so we get this annoying error alert every time: 
"Failed to start remote service on device. Please check your connection to your device." or "Unsupported device".

![Error: Failed to start remote service on device. Please check your connection to your device.](/assets/posts/debugging-ios14-xcode11/failed_to_start_error.png)

We can still manually launch the app, though. 
And we can avoid the error alert popping up every time by disabling auto-launching.
This behavior can be changed in scheme settings by disabling the "Debug executable" checkbox:

![Disabling debug executable in scheme settings](/assets/posts/debugging-ios14-xcode11/scheme_settings_disable_debug.png)

This will prevent the app from auto-launching and trying to attach a debugger.

Installing the app will kill the app if it's already running. That's one way to know that it's been re-installed successfully. 
From there, it's just a matter of tapping that icon to launch by hand.

### Logging 

After the app has been built with Xcode 12, installed and manually launched on the device like mentioned above, the app can be tested.

If we also want to look at logs, we can look at them in the Console app. 
To have app's logs show up there, we need to log them using the relatively new system `os` framework:

{% splash %}
import os
...
func logError(_ msg: StaticString, _ params: Any...) {
    os_log(msg, log: OSLog.default, type: .error, params)
}
...
logError("Value: %{public}@", property)
{% endsplash %}

Using `%{public}@` instead of just `%@` allows us to see the variables even with no debugger attached. 
Variables are private by default to prevent leaking sensitive data via logs.
[Read more about unified logging on SwiftLee](https://www.avanderlee.com/workflow/oslog-unified-logging/).

Device logs can be examined with the possibility to filter by many parameters such as app name, log level, and many more:

![Console app with various log filters](/assets/posts/debugging-ios14-xcode11/console_filters2.png)

I logged my app's messages with log level `.error` because they have a distinct yellow dot next to each message, making it easier to filter out the majority of system messages.

It's worth mentioning that messages logged with `NSLog` will also show up in Console app. 
I don't recommend using `NSLog` in Swift code, as `os_log` is the preferred way of logging on Apple platforms these days.



### Breakpoints

Unfortunately, Xcode 12 doesn't know how to debug apps on iOS 15. 

Previously, we could use the latest released Xcode for the debugging step. With Xcode 13 it's not needed - if Xcode 13 is installed on your machine, Xcode 12 automagically gains ability to debug apps on iOS 15. See above: [with Xcode 13 installed](#with-xcode-13-installed).  

## Wrapping up

Even those of us who are not so lucky to be able to upgrade to Xcode 13 right away can run and debug apps on devices running iOS 15. 

We can build, launch, and test the app on iOS 15, and examine the logs using the system Console app, all while having only Xcode 12.5. 
By installing Xcode 13 on the side, we give Xcode 12.5 full debugging capabilities on iOS 15.

This helps I hope these tricks can help someone else one day too :)
