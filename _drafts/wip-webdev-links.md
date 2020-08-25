---
layout: post
title:  "Building A Static Website: Essentials"
date:   2017-10-10 21:00:16 +0200
# excerpt: All you need to know about testing throwing functions with XCTest and keeping test code clean & robust in the process.
---


Building a website in 2020 was a much more exciting experience than I expected. 
I first learned HTML and CSS in 2000-s. Since then, I worked with audiobooks a lot, but it's been forever since I made a website from scratch. 
Working off of previous knowledge, I discovered so many new things as web development has advanced by a lot since early 2000s.

While building this site, I’ve done a ton of research on multiple essential topics, and gathered a large collection of bookmarks. 
Many of those links I keep referring back to all the time. 

If you are building a simple website, I hope you can benefit from my collection regardless of what framework you use. 

> Disclaimer: All links are from my personal collection and I have no affiliation with any of the linked resources. 
All linked resources are free to use. 

* toc
{:toc}

# Page Layout

### Flexbox

Table-based layouts turned out to be are a thing of the past. 
I found that Flexbox is the most common way to layout web UIs these days. 
[This guide to Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/) ended up being one of the resources I get back to the most. 

### CSS Selectors

There's a lot of ways to apply styles to an element in CSS. 
I love [this simple CSS selector reference](https://www.w3schools.com/cssref/css_selectors.asp), it provides a short overview of each selector and lets me quickly choose the best option. 

### HTML & Accessibility

While browsing Twitter one day I stumbled upon an article recommendation from [@ReyTheDev](https://twitter.com/ReyTheDev/status/1294148221992935424) for [structuring HTML semantically](https://developer.mozilla.org/en-US/docs/Learn/Accessibility/HTML) to achieve low-effort accessibility and reader mode support. 

# Navigation

### Opening external links

It became a complete revelation to me that opening links in a new tab is unfriendly to accessibility and mobile usage. 
This is usually achieved with `target="_blank"` on links. 
I've never looked at it in a way that the user can opt-in to open something in a new tab, but they can never opt-out. 
[UX Collective wrote a comprehesive article on opening links](https://uxdesign.cc/linking-to-a-new-tab-vs-same-tab-f88b495d2187).

# SEO

To make a site be searchable through search engines, it is essential to get some meta properties right. 
Shout out to [@MarinaHuber](https://twitter.com/SerinnahHuber) for introducing me to this comprehensive [SEO check tool](https://www.seobility.net/en/seocheck/). It checks both technical side and content itself.

_Canonical URLs_ help avoid duplicate content on the web. they are useful even if you post only in one place. Check out [the ultimate guide to rel=canonical](https://yoast.com/rel-canonical/).

I was surptised to find out that [keywords tag is a thing of the past](https://webmasters.googleblog.com/2009/09/google-does-not-use-keywords-meta-tag.html).
One less meta field to maintain, so that's nice.

# Art 

When building even the simplest site it was hard to avoid needing graphic resources. 
There are many copyright-free resources out there, for example [Unsplash](https://unsplash.com), [Undraw](https://undraw.co/illustrations) and [Black Illustrations](https://www.blackillustrations.com). 

<!-- ### Favicons -->

A quick way to generate favicons is to use an online generator. 
[favicon.io](https://favicon.io) lets you make favicons from text, emojis and images. For example, I made my favicon from text "MG". Creative, right :P 
Files will be ready-to-go along with a code snippet. 

[Favicon checker](https://realfavicongenerator.net/favicon_checker) is super handy for verifying that all favicons and manifests are in place. 

<!-- ### Icons -->

[Simple Icons](http://simpleicons.org) has a comprehensive catalog of free SVG icons for popular brands. 

<!-- ### Colors -->

I tried several palette generators, and ended up staying with [Coolors](https://coolors.co). 
It's free and lets you pick from a huge catalog of palettes, modify them or create your own, even based off an uploaded image. 

# Social Sharing 

### Buttons

My goal was to avoid using cookies or any kind of local storage, so I wouldn't have to show the infamous cookie banner.
Twitter sharing widget and similar components from other social networks have tracking in them, so I opted out of using them.

So I ended up using a [sharing button generator](https://sharingbuttons.io). I had to tweak the CSS a bit, but otherwise they work perfectly. 

ALternatively there's a [page that lists simple code](https://www.ahmad-osman.com/en/blogs/social-media-share-without-javascript/) for most popular social apps and networks. 

### Preview cards

Most social networks use Open Graph metadata to generate preview cards. 
[Open Graph Protocol homepage](https://ogp.me) gives a nice overview of the generic webpage properties and directions to dig 
deeper for special content such as books, video, and more. 

Twitter has their own meta properties inspired by Open Graph. The main addition is that you can specify what kind of style you want your card to follow.
Here's the link to [Twitter's Documentation on Cards](https://developer.twitter.com/en/docs/tweets/optimize-with-cards/guides/getting-started).

I found that other large social networks such as [LinkedIn](https://www.linkedin.com/help/linkedin/answer/46687/making-your-website-shareable-on-linkedin?lang=en) and [Facebook](https://developers.facebook.com/docs/sharing/webmasters/) rely on Open Graph protocol and don't have their own properties sans rare exceptions. 

#### Testing preview cards

Testing preview cards is something that I did a lot of, making sure I like how my site looks when shared. 
I certainly did send myself messages on Twitter and via iMessage, nothing wrong with that :D 

Each of the major social networks has their own _card validator_, which lets you easily preview the card. It even tells you if any essential properties are missing. 
And a huge hidden perk of using card validators is that they also invalidate the respective caches. I only have [Twitter Card Validator](https://cards-dev.twitter.com/validator) bookmarked, but here's also [LinkedIn Post Inspector](https://www.linkedin.com/post-inspector/) and [Facebook Sharing Debugger](https://developers.facebook.com/tools/debug/).

It turned out that card metadata is cached on social network's side, so they don't have to hit your webpage every time someone is looking at a post with your link in it. 
Here's the article that goes in-depth on cards, caching and how to clear the caches: [How to Clear Facebook Cache, Twitter Cache, and LinkedIn Cache so Your Content Looks Right](https://www.socialmediaexaminer.com/how-to-clear-facebook-cache-twitter-cache-linkedin-cache/).

# Tracking

I deeply care about privacy, so having Google Analytics on the previous version of my site was really bugging me. I felt bad for having it. 

Once while browsing random repos on GitHub I stumbled upon [GoatCounter]() - privacy-friendly open source web analyctics.
[GoatCounter's rationale](https://github.com/zgoat/goatcounter/blob/master/docs/rationale.markdown) resonated with me, and now it is my go-to analytics service, which by the way is completely free for non-commercial use. 

# Inspiration

Wonderful aggregator of personal websites: [humans.fyi](https://humans.fyi). Gives endless inspiration for layouts and color schemes and a little bit of FOMO. 

