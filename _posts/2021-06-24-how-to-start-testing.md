---
layout: post
title:  "Unit testing: how to start"
tags: 
- Unit testing 
#medium_link: https://medium.com/@hybridcattt/building-a-well-rounded-website-essentials-822a27a46cad?source=friends_link&sk=e11724a15e3bfa5a61a728397d1dbe0d
excerpt: How to start practicing unit tests when you're unsure where to start
#image: /assets/posts/website-essentials/img_twitter.jpg
#twitter: 
#card: summary_large_image
toc_config:
  only_anchors: false
  max_toc_level: 2
---


So you decided that you want to start unit testing the code in your project. 
It's possible that you're not sure how to approach it and where to start.
If you can relate, then you will find this article useful.

## Any test is better than none

First of all, I strongly believe in one simple statement: 
_any kind and amount of tests is better than no tests at all._ And _any_ includes zero!

When you run a test suite that has zero tests, you already verify that the project compiles. 
That is so, so much better than nothing. 

## Why starting testing is so owerwhelming

There's a bunch of reasons why you might feel that 'just adding new tests' hard:

- the project is not configured for 'just adding new tests'
- you feel that if you start adding unit tests, you have to commit to it and it will suck your time/resources
- you feel that your code is not easily testable. you might fear having to refactor everything.
- TDD. I heard this is a thing. Do I have to follow it?

Let's adress these one by one to get you started 🙌 


## Setting up the testing infrastructure

Iterative improvement is generally easier than getting started.  
That's why it's so important to get your project configured and ready for tests.
Then you could start with one, or even zero tests, and add more as you go. 
Once you have testing infrastructure in place, adding new tests it just a matter of adding a new test class or a new function. 


< a sentence about test target in general >

Two main reasons the project is not ready to ‘just add tests’:
- Project is not set up for unit tests at all (there is no test target)
- Unit test target is there but outdated / not compiling

### New project

When you create a new project, make sure the 'Include test target' checkbox is checked. 

### Adding a test target to your Xcode project

### Managing a broken test target

You might already have a test target in the project, but it fails to compile, or a lot of tests fail. 
If there's only a couple of errors, you might be able to fix it within reasonable time and use the existing target. 

If you're anxious to start though, my recommendation is to create a new test target in the project. 
There can be as many test targets as you like in the project. Moving test case classes (files) between targets is easy. 
So you can always consolidate your old and new tests in the future. That shouldn't block you from starting to add new tests.

// The easiest way to not have a broken test target is to


## Do I have to commit to unit testing everything?  

Absolutely no. You don't have to go all in on testing everything. Any tests is better than none. Do what you can.

You can absolutely limit the scope of your testing efforts, based on your preference, time, deadlines, etc.
Here are 3 tips on how to find areas to focus on for the testing efforts:

- logic that is critical to your app

- less critical, but obscure logic where it's hard to notice if it breaks 

- areas where it's time-consuming or tricky to test all edge cases manually 

Some examples of such areas: deserializing (parsing) server responses, date arithmetics, custom sorting/filtering logic, saving and reading back user's local data.

## I think my code is not testable. Do I have to refactor everything?
 Remember, having any tests is better than having none.

Even when you think all is lost, here's an approach that _always_ works regardless of how untestable you think your code is:

You can extract pieces of code into a separate helper function, where your code can be pure (have no side effects, only use passed in parameters). 
Then call this function with one line where needed. 
Even though the rest of the code is still not covered by tests, you can test the extracted function. 
Sure, you could still call the function in a way that causes a bug, but that's the nature of _unit tests_ - 
we tests units of code, and trust they are put together correctly.  

Here's a simple example. Let's say we have a view controller class with a piece of logic we want to test:

```swift
class MyViewController: UIViewController {
    // ...
    private func sortData() {
        self.data = self.data.sorted() // complex logic here
    }
    // ...
}
```

You can extract this piece of logic into a separate, pure function, and test that function:

```swift
class MyViewController: UIViewController {
    // ...
    private func sortData() {
        self.data = MyViewControllerHelper.sortData(self.data)
    }
    // ...
}

final class MyViewControllerHelper {
    static func sortData(_ data: [MyObject]) -> [MyObject] {
         return data.sorted() // complex logic here
    }
}

/// In tests:
class MyViewControllerHelperTests() {
    func test_sortData() {
        XCTAssertEqual(MyViewControllerHelper.sortData([]), [])
        XCTAssertEqual(MyViewControllerHelper.sortData([1, 3, 2]), [1, 2, 3])
    }
    // ...
}
```

How many bugs can sneak in when calling `self.data = self.data.sorted()` ? Not a lot.  
At the same time, we can be sure that our sorting logic works as expected. 

You can choose to start refactoring your class to f.ex. MVVM, creating a view model and testing it, instead of moving out independent pieces of code. 
That's a great approach to improve test coverage _and_ your app's architecture. 
But if you're not ready to do major refactorings - you still have a way to start tesing your code.



## I heard TDD is a thing. Do I have to follow it?

TDD (Test Driven Development) is a methodology that is commonly associated with unit testing. Some people believe it's the _one true way_ to write unit tests  - write tests first, and then fill in the implementation to make the tests pass. 

In reality though, everyone’s brains are wired differently. Coding is a very creative process, and different people prefer different ways of getting to the same result. 

Let me offer a simple rule of thumb: if you want to have your code be covered by tests, commit to the _outcome_ of having code paired with tests.
If you work in a team, you could commit to having tests included in the PR along with the logic code. 

How you get there is personal preference. You should try different things and see what works best for you. 
You can sketch a draft of the implementation in the playground. Or write/rewrite your code as many times as you like, and write tests when you feel done. 
Or write tests first against a skeleton of the implementation, and fill in the actual logic to make tests pass. 

How and when you write tests is up to you. Try different approaches until you find what works for your style. 
Don’t listen to anyone who says there is one true way to write code!
