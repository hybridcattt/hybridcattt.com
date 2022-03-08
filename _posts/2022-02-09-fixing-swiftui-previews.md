---
layout: post
title:  "Fixing SwiftUI's Automatic Preview Updating Paused"
excerpt: Understand why SwiftUI previews keep getting paused and how to improve the situation

tags: 
  - SwiftUI
  - Xcode 

image: /assets/posts/fixing-swiftui-previews/header.png
twitter: 
  card: summary_large_image
---

If you work with SwiftUI, or have even just tried SwiftUI previews, then you've seen this annoying message: `Automatic preview updating paused`.
To some devs it happens all the time and is _extremely_ frustrating. 

In this article I'll explain why this happens and how it can be solved. 
Let's dig in!

![Screenshot of the error](/assets/posts/fixing-swiftui-previews/header.png)

## Why previews get paused

Let's follow the crumbs to understand what happens. 

When we get the message, the (i) symbol offers some more context:

`Automatic preview updating pauses when the preview file is edited in a way that causes the containing module to be rebuilt.`

![Screenshot of the popup](/assets/posts/fixing-swiftui-previews/popup.png)

It kind of makes sense.
Changing any code in a module (for example your app module) normally warrants a rebuild to get the new changes into the product. 
But why is it suddenly a problem? Isn't that what happens anyway?
Turns out, no. Let's have a look at how live editing works.

## Understanding live reloading

Turns out, when we're editing a preview live (when it works as it should), Xcode doesn't rebuild the module on every single change. 

When previews are activated, Xcode builds the current scheme _for testing_. When you make subsequent changes, there is no re-building happening to reflect changes on the canvas.

Swift has a special feature to support live changes of SwiftUI previews - called `dynamic function replacement`. The attribute for it is `@_dynamicReplacement(for:)`.
This feature did not go through the formal evolution process - it was [pitched](https://forums.swift.org/t/dynamic-method-replacement/16619) and [implemented](https://github.com/apple/swift/pull/20333) back in 2018, ahead of the initial reveal of SwiftUI. 

{% splash %}
struct MyStruct {
  dynamic func x() {
    print("x")
  }
}

extension MyStruct {
  @_dynamicReplacement(for: x())
  func y() {
    print("y - replaced dynamically")
  }
}
{% endsplash %}

Whenever `x()` is called, `y()`'s implementation will be used instead. This is Swift's reply to swizzling.

Because 'hot reloading' is implemented using dynamic replacement, it has limitations:
- It's applicable only when we change _implementation_ of a function, computed variable, initializer or subscript.
- For SwiftUI previews, dynamism is applied to all declarations in the current file.

So it's actually easier to list when previews _can_ be updated live. 

Any other changes are not supported by dynamic replacement. For example:

- changing function signature in any way (even just changing from `internal` to `private`)
- adding or removing functions or variables
- changing initial value of a non-computed property
- doing any edits in other files

And since these changes don't fall under dynamic replacement, the previews have to get paused until the next proper rebuild.

> If you want to learn more about the under-the-hood workings of SwiftUI previews, I like [Behind SwiftUI Previews](https://www.guardsquare.com/blog/behind-swiftui-previews) by Damian Malarczyk.

For me, understanding why things are happening already helps with the frustration. But let's see how to fix it 🙌

## Fixing it

So what can we do to improve the situation?

First, we can write our code in a way that allows for more dynamic replacement.

But there still would be a lot of situations when previews have to pause. 
Come to think of it, what are we most annoyed about? Having to resume them! So let's automate that.

### Improving code to reduce pausing 

The most common cause of previews pausing I've seen is variable declarations:

If you have a variable declaration with initial value, editing it will pause the previews:

{% splash %}
var color = Color.red // change to Color.green, previews are paused
{% endsplash %}

This applies to any variables in the current file - global or instance variables. 

To fix it, change the variable to be computed. That way, it can be dynamically replaced when edited:

{% splash %}
var color: Color { Color.red }
{% endsplash %}

Another possible reason is build scripts in Build Phases that cause changes to the project. It could be build number incrementing or code generation. 
I haven't run into it myself, but if you get unexplained pauses - it's a direction worth looking into.

### Automatically resume previews 

Imagine this - you're making changes to the code, and previews get paused. You try to resume previews - they fail. Possibly due to build errors, but errors are not always properly surfaced. 
Maybe you forgot to change test code - errors there also cause previews to fail (because previews are built for testing). 

To figure the best way to solve this, I took a step back. What do we do to verify our code changes normally? We build or run. Then we either get more compilation errors and continue fixing them, or all succeeds and we're happy. 

I figured, previews should auto-resume after a successful build. And it's been working pretty well for me so far.

I couldn't find any programmatic way to resume previews in Xcode, but we can trigger the keyboard shortcut. 

Here's just two simple steps to set it up:

First, place the script somewhere in your system, for example in `~/scripts`:

```bash
touch ~/scripts/cmd_opt_p.sh
chmod +x ~/scripts/cmd_opt_p.sh
open ~/scripts/cmd_opt_p.sh #edit with your favorite editor
```
Then paste this:
```bash
#!/bin/sh
osascript -e 'tell application "System Events" to keystroke "p" using {command down, option down}'
```

Second, configure Xcode to trigger this script whenever a build succeeds:

In `Preferences -> Behaviours -> Build Succeeds -> Run`, select the newly created script: 
![Preferences -> Behaviours -> Build Succeeds -> Run](/assets/posts/fixing-swiftui-previews/behaviours.png)

Voila! First time the script triggers, it'll ask to allow Xcode to use accessibility features to control the computer. 

Here's a couple of things to keep in mind: 

- If Xcode is not the active application by the time a build operation succeeds, the shortcut will be triggered in the currently focused application.
Cmd+Option+P is not a common shortcut, so most likely it won't do anything. 
If you'd like it to force-switch to Xcode, add this to the script: `osascript -e 'activate application "Xcode"'`.

- After a normal build succeeds and the shortcut is triggered, a second build is made - a special build for previews. 
I think that it's fine - since the first build succeeded, the second one will be very fast. Still faster than pressing Cmd+Option+P manually 😅

- There's no easy way to distinguish between builds for running and build for testing from Xcode Behaviours.
If tests fail to build, previews will fail to resume, even if build for running succeeded and triggered the automation. 
When this happens, instead of `Cmd+B` use `Cmd+Shift+B` to trigger a build for testing. Once it succeeds, the automation will be triggerred again.

Even though this method is not perfect, it works quite well for me, both in SwiftUI and UIKit projects.

Let me know how this works for you, especially if you experience any issues with this approach!
