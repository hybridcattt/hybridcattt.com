---
layout: post
title:  "Debugging on iOS 14 device with Xcode 11"
tag_list: "iOS development, Xcode, iOS 14"
tags: 
  - iOS development 
  - Xcode 
  - iOS 14
excerpt: Every year we get a new major iOS version to test our apps on. Some apps can't be upgraded to Xcode 12 right away, but they are still expected to work well on iOS 14. With some tricks, I could not only run on iOS 14 but also debug with breakpoints and much more.
# medium_link: https://medium.com/@hybridcattt/building-a-well-rounded-website-essentials-822a27a46cad?source=friends_link&sk=e11724a15e3bfa5a61a728397d1dbe0d
# image: /assets/posts/website-essentials/img_twitter.jpg
---

Every year we get a new major iOS version to test our apps on. 
The lucky ones can immediately upgrade to the newest Xcode 12, building against the latest iOS 14 SDK. 
Some other, larger projects can take a while to get upgraded. 
Those projects have to be built with Xcode 11 in the meantime. 
But even though those apps can’t yet be upgraded, they are still expected to work well on the newest iOS. And solving problems and bugs require debugging.

I recently faced a rare camera bug that only reproduced on iPhone 11 Pro with iOS 14. 
The app hasn't been upgraded yet and was built with Xcode 11.
The bug was mission-critical and we couldn't afford to wait until we upgrade to Xcode 12.

Out of the box, older Xcode versions can’t work with iOS 14 at all. However, with some tricks, I could not only run on iOS 14 but also debug with breakpoints and much more.

### Overview

A usual run action in Xcode consists of a few independent steps:
- building for device
- installing the app to device
- launching the app
- attaching a debugger

These steps rely on Xcode being able to communicate with the physical device, and the communication interface can change between iOS versions.
So debugging an app built with older an Xcode requires a few tricks. 

### Building and installing a debug build to iOS 14

Being able to run against the newest iOS version is a problem that we have to fix every year. Gladly the same solution works every time. 
An Xcode application bundle contains support files for each iOS version it knows how to work with.
Adding support for iOS 14 to Xcode 11 is a matter of copying device support files for iOS 14 into Xcode 11. 
Commonly, these device support files can be copied from Xcode 12 installed side-by-side, copied from a coworker's machine, 
or downloaded from a popular shared repo.  
It's been already widely discussed, so here's a link to the article I like: [How to Fix Xcode: “Could Not Locate Device Support Files” Error](https://faizmokhtar.com/posts/how-to-fix-xcode-could-not-locate-device-support-files-error-without-updating-your-xcode/).

### Launching the app

With the default setup, a debug app build will automatically try to launch on the selected device after installation. 
Unfortunately, Xcode 11 doesn't know how to launch apps on iOS 14, so every time we get this annoying error alert: 
`Failed to start remote service on device. Please check your connection to your device.`
![Failed to start remote service on device. Please check your connection to your device.](/assets/posts/debugging-ios14-xcode11/failed_to_start_error.png)

We can still manually launch the app, though. 
And we can avoid the error alert popping up every time by disabling auto-launching.
This behavior can be changed in scheme settings by disabling the "Debug executable" checkbox. 

![](/assets/posts/debugging-ios14-xcode11/scheme_settings_disable_debug.png)

This will prevent the app from auto-launching and trying to attach a debugger.

Installing the app will kill the app if it's already running. That's one way to know that it's been re-installed successfully. 
From there it's just a matter of tapping that icon to launch by hand.

### Breakpoints

After the app has been built with Xcode 11, installed and manually launched on the device like mentioned above, the app can be tested.

Debugging with breakpoints is often needed for bug investigation. 
Unfortunately, Xcode 11 doesn't know how to debug apps on iOS 14. But Xcode 12 does!
Attaching a debugger to a launched app (a running process) is an independent operation that we can do manually on Xcode 12.

Close Xcode 11, open Xcode 12, and attach the debugger 
by going to menu option Debug > Attach to process and picking your app's process.
Your app name should appear under "Lucky targets". It might take a couple of attempts, but it works!

![](/assets/posts/debugging-ios14-xcode11/debugger_likely_targets.png)

With the debugger attached, breakpoints can be navigated as usual. You can pause anywhere, step over, step in, etc. You can also see stack traces normally.
You can debug view hierarchy, see the memory graph, and even override environment settings such as text size or dark mode, 
all while running a debug build created with Xcode 11 on an iOS 14 device.

There is one limitation - when paused on a breakpoint, access to variables is quite limited. Most Swift variables can't be looked into, and debugger commands such as `po` don't work. 
That's because of this error: `Cannot load Swift type information; AST validation error in <...>: The module file format is too old to be used by this version of the debugger`.
However, `po` seems to work while in UI debugger, and you can write Objective-C there. It's not ideal, but it's something we can work with. 

Even though debugging functionality is somewhat limited, often just being able to pause, step through code paths, and see stack frames is more than enough to find the cause of a bug.

### Logging

If we also want to look at variables, then good old logging can help. Logs can be examined at any time, for example, after pausing on a breakpoint or while using the UI. 

When the debugger is attached to the app process in Xcode 12, print statements are not being output to the usual console.
Instead, we can look at app logs in the Console app. 
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

![](/assets/posts/debugging-ios14-xcode11/console_filters2.png)

## Summary

Even those of us who are not so lucky to be able to start using Xcode 12 right away can run and debug apps on devices running iOS 14. 
I was able to track down my bug and fix it. Hope you now can too :) 

