---
layout: post
title:  "Unit testing: a realistic guide on where to start"
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

So you decided to start unit testing the code in your project. 
You might be working alone or in a small team. 
It's possible that you are unsure how to approach it and where to start.
If you can relate to the feeling, then this article is for you!

----- 

So many great resources are out there to learn about testing. 
You can learn about so many topics: 
the different kinds of tests (unit tests, integration tests, end-to-end tests, UI tests), 
how and when to run them,
how to write tests with XCTest and about all other framewroks you can use,
different techniques such as TDD,
how to benefit from test plans, how to leverage generated test results, 
and so forth. 

On top of that, you might feel that your code is not exactly easily testable, 
you might wonder whether it's a good time to refactor your project into 
a more testable architecture. 
You might even feel the pressure of having to fully commit to testing all your code. 

No surprise that figuring out _where to actually start_ can be tricky, and even overwhelming. 

So let me help you get you started 🙌  

I'm not here to tell you how you _should_ test your apps. 
My goal is to offer _realistic_ advice, so you can get started and iterate forward more confidently, at your own pace. 

## Start from zero, iterate

Automating testing of a project is an iterative process. You start with no tests, then add some, bit by bit - either for existing code or along with code that is newly written. 
As the time goes, the amount of tested code grows.
Eventually, a significant portion of your code will be tested, although it usually takes a while to get there.

But what if I told you, that **even having zero tests brings value to your project**?

That's right. _Any_ amount (and kind) of tests is better than none.

When we run a test suite with no tests, we already verify that
a) the project compiles 
b) the app doesn't crash immediately on start (only applies when testing apps, not frameworks). 

For example, running tests before every commit makes you confident that the version in git can compile and run. 
You're saved from accidentally committing a version that doesn't even compile. 

It only gets better from there - every test you add verifies a tiny path in your code, not only for correctness of the produced result, 
but also that it doesn't crash or hang. 

## Setting up testing infrastructure

So to start benefitting from testing, all you need is to have the testing infrastructure in place. 
From there, you can continue learning all there is about testing, experimenting with different types of tests, and so on. 
Adding new tests it just a matter of adding a new test case class or a new function. 

Tests are not part of the application, but they are part of the app project. Tests live in a separate target. 

### Adding a test target to the project

When you create a new project, make sure to enable the **Include tests** checkbox.

If you have pre-existing codebase, a test target can be added with just a few clicks. 
[This free guide](https://openclassrooms.com/en/courses/4554386-enhance-an-existing-app-using-test-driven-development/5095691-create-your-first-test) illustrates how to add a new test target to a project. (I have no affiliation with the paid course).

### Managing a broken test target

If you already have a test target in the project, but it fails to compile or a lot of tests fail, there's still a way forward. 
If there's only a couple of errors, it makes sense to try to fix them. 

It could turn out that fixing the old test target is a larger task and you can't afford to spend the time. In this case, my recommendation is to create a new test target in the project. 

There can be as many test targets as you like in a project. Moving test case classes (files) between targets is easy, and you can consolidate all your tests in one target later. That shouldn't block you from starting to add new tests now!

### When and where to run tests

Tests can be run locally or on a remote machine. A remote machine is usually managed by a CI (continious integration) system, which pulls the code from the source control system, executes the tests and reports the results. Xcode Cloud will allow to execute tests on remote machines right from within Xcode.  

The _when_ also has multiple options: you can run manually on-demand (essentially whenever you remember to do it), 
before merging a feature branch, on each pull request (if you practice that), or even on or before every commit. 

In my opinion, the optimal setup even for solo developers is to create pull requests for each merge, and to execute tests on every pull request automatically via a CI system.

If learning how to configure a CI system is not on the top of your priorities (which is totally fine), 
I recommend running tests locally before pushing your changes to remote or at least before merging a branch. 

## Is it _testing_ or _unit testing_?

Testing in general describes the process of verifying correctness of software. 
Then we distinguish between automated testing and manual testing. 

_Unit tests_ are the kind of automated tests that verify correctness of implementation of individual units of code - classes, structs, functions. If we only have unit tests, we have to trust that the _units_ are put together correctly to make a functioning app. 
_Integration tests_ verify that units work together correctly. _End-to-end tests_ are even more high-level automated tests that verify the system as a whole, including server-side connection. _UI tests_ verify app's interface. This is what's called _The Testing Pyramid_. If you want to learn more, read [The Practical Test Pyramid by Martin Fowler](https://martinfowler.com/articles/practical-test-pyramid.html).

We write all of these test types with XCTest framework by creating `XCTestCase` subclasses. 
Writing UI tests requires us to use special `XCUIApplication` API, but the rest of the test types are very semantic.
Depending on which part of your code you are testing, you call it unit, integration, or end-to-end test. 

Unit tests are small and there are usually many of them, and they usually comprise the majority of the test suite. 
Because of that, the words _testing_ and _unit testing_ are sometimes used interchangeably.

## Picking what to test

Many articles will tell you which areas of the codebase you should test.
But do you _have to_ commit to unit testing everything that you _should_?  

Absolutely no. Having some tests is better than having none, as we discussed above.
You can absolutely limit the scope of your testing efforts, based on your preference, time, deadlines, etc.

Here are my 3 tips on how to find areas to focus on for the testing efforts:

- logic that is critical to your app

- less critical, but obscure logic where it's hard to notice if it breaks 

- areas where it's time-consuming or tricky to test all edge cases manually 

Some examples of such areas: deserializing (parsing) server responses, date arithmetics, custom sorting/filtering logic, saving and reading back user's local data.

## Testing the untestable 

You might get tempted to refactor your code, especially if unit testing wasn't originally on your mind.  
Most of the commonly used architectures are well suited for unit testing: MVVM, MVP, etc, and refactoring _will_ make writing tests easier.
But to _start_ with unit testing, you absolutely don't have to do any major refactoring.

Here's an approach that _always_ works regardless of how untestable you think your code is:

- Extract a piece of code into a completely separate helper function in a helper class. This way your code can be pure: pure code has no side effects and uses only passed in parameters (no singletones, global variables, etc).

- Then call this function with one line where needed. 

Even though the rest of the code would still not be covered by tests, you can test the extracted function. 
Sure, you can still call the function in a way that causes a bug, but you made it less likely.

Here's a simple example. Let's say we have a view controller class with a piece of logic we want to test:

{% splash %}
class MyViewController: UIViewController {
    // ...
    private func sortData() {
        self.data = self.data.sorted({.......}) // complex logic here
    }
    // ...
}
{% endsplash %}

You can extract this piece of logic into a separate, pure function, and test that function:

{% splash %}
class MyViewController: UIViewController {
    // ...
    private func sortData() {
        self.data = MyViewControllerHelper.sortData(self.data)
    }
    // ...
}

final class MyViewControllerHelper {
    static func sortData(_ data: [MyObject]) -> [MyObject] {
         return data.sorted({......}) // complex logic here
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
{% endsplash %}

How many bugs can sneak in when calling `self.data = MyViewControllerHelper.sortData(self.data)` ? Not a lot.  
At the same time, we can be sure that the sorting logic works as expected. 

Later on, you could turn the helper into a view model (shall you go with MVVM). 
If you're comfortable enough with MVVM already, go with it right away - that's a great way to improve testability _and_ your app's architecture at the same time. 
But if you're not ready to do major refactorings - you still have a way to start tesing your code. 

## Do we have to TDD?

TDD (Test Driven Development) is a methodology that is commonly associated with unit testing.
It suggests to write the tests before writing the implementation. Some people believe it's the _one true way_ to write tests. 

In reality though, everyone’s brains are wired differently. Coding is a very creative process, and different people prefer different ways of getting to the same result. Most developers who practice testing don't actually follow TDD, most of the time.

Let me offer a simple rule of thumb: if you want to have your code be covered by tests, commit to the _outcome_ of having code paired with tests. How you get to that point is personal preference.
If you work in a team, you could commit to having tests included in each PR along with the code. 

You can sketch a draft of the implementation in the playground. Or write/rewrite your code as many times as you like, and write tests when you feel done. 
Or write tests first against a skeleton of the implementation, and fill in the actual logic to make tests pass. Try different things and figure out what works best for you!

## Wrapping up

Stepping onto unknown territory can be overwhelming. There's enough to learn about automated testing as it is: from different assert APIs to improving app architecture to configuring CI systems. 

I hope my advice on where to start and the answers to common questions and misconceptions have set you on a path where you can feel more confident!


