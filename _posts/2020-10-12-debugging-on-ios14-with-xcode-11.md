---
layout: post
title: "Debugging on iOS 14 with Xcode 11"
tag_list: "iOS development, Xcode, iOS 14"
tags: 
  - Xcode
  - Debugging
excerpt: Every year we get a new major iOS version to test our apps on. Some apps can't be upgraded to Xcode 12 right away, but they are still expected to work well on iOS 14. With some tricks, we can not only run on iOS 14 but also debug with breakpoints and much more.
medium_link: https://medium.com/@hybridcattt/d332f12f49dd?source=friends_link&sk=89454bc213ad54dd3fb773f5f19e3057
image: /assets/posts/debugging-ios14-xcode11/failed_to_start_error.png
twitter: 
  card: summary_large_image
toc_config:
  max_toc_level: 2
---

Every year we get a new major iOS version to test our apps on. 
The lucky ones can immediately upgrade to the newest Xcode 12, building against the latest iOS 14 SDK. 
Some other, larger projects can take a while to get upgraded. 
Those projects have to be built with Xcode 11 in the meantime. 
But even though those apps can’t be upgraded yet, they are still expected to work well on the newest iOS. And solving problems and bugs requires debugging.

I recently faced a rare camera bug that only reproduced on iPhone 11 Pro with iOS 14. 
The app hasn't been upgraded yet and was built with Xcode 11.
The bug was mission-critical and we couldn't afford to wait until we upgrade to Xcode 12.

Out of the box, older Xcode versions can’t work with iOS 14 at all. However, with some tricks, I could not only run on iOS 14 but also debug with breakpoints and much more.

## Overview

A usual run action in Xcode consists of a few independent steps:
- Building for the device.
- Installing the app on the device.
- Launching the app.
- Attaching a debugger.

These steps rely on Xcode being able to communicate with the physical device, and the communication interface can change between iOS versions.
So debugging an app built with an older version of Xcode requires a few tricks. 

## Building and installing a debug build to iOS 14

Being able to run against the newest iOS version is a problem that we have to fix every year. Thankfully, the same solution works every time.
An Xcode application bundle contains support files for each iOS version it knows how to work with.
Adding support for iOS 14 to Xcode 11 is a matter of copying device support files for iOS 14 into Xcode 11. 
Commonly, these device support files can be copied from Xcode 12 installed side by side, copied from a coworker's machine, 
or downloaded from a popular shared repo.  
It's been already widely discussed, so here's an article I like on the topic: [How to Fix Xcode: “Could Not Locate Device Support Files” Error](https://faizmokhtar.com/posts/how-to-fix-xcode-could-not-locate-device-support-files-error-without-updating-your-xcode/).

## Launching the app

With the default setup, a debug app build will automatically try to launch on the selected device after installation. 
Unfortunately, Xcode 11 doesn't know how to launch apps on iOS 14, so we get this annoying error alert every time: 
"Failed to start remote service on device. Please check your connection to your device."

![Error: Failed to start remote service on device. Please check your connection to your device.](/assets/posts/debugging-ios14-xcode11/failed_to_start_error.png)

We can still manually launch the app, though. 
And we can avoid the error alert popping up every time by disabling auto-launching.
This behavior can be changed in scheme settings by disabling the "Debug executable" checkbox:

![Disabling debug executable in scheme settings](/assets/posts/debugging-ios14-xcode11/scheme_settings_disable_debug.png)

This will prevent the app from auto-launching and trying to attach a debugger.

Installing the app will kill the app if it's already running. That's one way to know that it's been re-installed successfully. 
From there, it's just a matter of tapping that icon to launch by hand.

## Logging 

After the app has been built with Xcode 11, installed and manually launched on the device like mentioned above, the app can be tested.

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

---

So far we could build, launch, and test the app on iOS 14, and examine the logs using the system Console app, all while using Xcode 11 exclusively.

But sometimes just logs are not enough - debugging with breakpoints is often necessary for bug investigation. 

---

## Breakpoints

Unfortunately, Xcode 11 doesn't know how to debug apps on iOS 14. But Xcode 12 does! 
To get breakpoints to work, we have to use Xcode 12 for this step. 

There are two options to get the debugger running for an app already compiled with Xcode 11. 
We can either attach a debugger to an already running app, or let Xcode 12 also launch the app and attach the debugger for us.

### Launching from Xcode 12

After building the target with Xcode 11 (cmd+B), switch to Xcode 12, and do `Run Without Building`
by going to menu option `Product > Perform Action > Run Without Building` or using cmd+control+R.
This will install and launch the app, and attach the debugger. 

Using this method, we don't need to disable auto-launching or debugging in scheme settings, 
because we're using Xcode 12 for this step and it knows how to talk with iOS 14 devices. 
There's a downside however, that we would then need to use Xcode 12 for running the app. 
_I would recommend going this way only if you always need breakpoints and the hassle of switching between Xcode versions all the time is worth it for you._

Big thanks to [Geoff Hackworth](https://twitter.com/geoffhackworth) for suggesting this trick!

### Attaching debugger to a running app

If for some reason you don't want to use Xcode 12 for running, 
it's possible to attach a debugger to an already launched app (a running process) manually.

At any point of testing the app, we can open the project in Xcode 12 and attach the debugger 
by going to menu option `Debug > Attach to Process` and picking the app's process.
The app name should appear under "Likely targets". It might take a couple of attempts, but it works!

![App name shows under Likely Targets debug menu](/assets/posts/debugging-ios14-xcode11/debugger_likely_targets.png)

### Limitations of debugging on Xcode 12

With the debugger attached (either by running from Xcode 12 or manually attaching), breakpoints can be navigated as usual. 
We can pause anywhere, step over, step in, etc. We can also see stack traces normally.
We can debug view hierarchy, explore the memory graph, and even override environment settings such as text size or dark mode, 
all while running a debug build created with Xcode 11 on an iOS 14 device.

There is one limitation - when paused on a breakpoint, access to variables is quite limited. 
Most Swift variables can't be looked into, and debugger commands such as `po` don't work. 
That's because of this error: `Cannot load Swift type information; AST validation error in <...>: The module file format is too old to be used by this version of the debugger`.
However, `po` seems to work while in UI debugger, and we can write any Objective-C code there. It's not ideal, but it's something we can work with. 

For cases when debugger is failing to access Swift variables, good old logging can help, as described above. 

Even though debugging functionality is somewhat limited, often just being able to pause, step through code paths, and see stack frames is more than enough to find the cause of a bug.

### How to prevent accidental rebuilding with Xcode 12

Since we're building with Xcode 11, but running and debugging on Xcode 12, we might accidentally rebuild on Xcode 12 and end up testing a very different build of the app than originally intended. 
To avoid accidentally building with Xcode 12 while it's used for debugging, we can add a conditional compilation error for that case: 

{% splash %}
#if compiler(>=5.3)
#error("This project should not be built on Xcode 12")
#endif
{% endsplash %}

This piece of code can be placed anywhere in the source. The `#error` directive is skipped when the source code is compiled with the Swift compiler of any version lower than 5.3, which corresponds to Xcode 11 or older.
This way, it's not even technically possible to accidentally build on Xcode 12.  

## Wrapping up

Even those of us who are not so lucky to be able to upgrade to Xcode 12 right away can run and debug apps on devices running iOS 14. 
It's possible to fully stick to Xcode 11, occasionally resorting to Xcode 12 for breakpoints and extra things such as UI debugger. 
I was able to track down my critical bug and fix it, and I hope these tricks can help someone else one day too :)
