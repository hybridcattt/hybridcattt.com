---
layout: post
title:  "Building a Well-Rounded Website: Essentials"
medium_link: https://medium.com/@hybridcattt/building-a-well-rounded-website-essentials-822a27a46cad
excerpt: A collection of essential links useful for building a well-rounded website, regardless of the stack. While building my personal website, I've gathered 20+ resources that I regularly get back to, and I'm hoping this list will help others who are following a similar path. 
image: /assets/posts/website-essentials/img_twitter.jpg
twitter: 
  card: summary_large_image
---

![Woman coding in an IDE](/assets/posts/website-essentials/img.jpg)
<i class="subtle-text">Photo by <a href="https://unsplash.com/@crew?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Crew</a> on <a href="https://unsplash.com/s/photos/website?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></i>
<br>
<br>

I first learned the basics of web development in the 2000s, and have since contributed to web applications code in my corporate jobs and worked with HTML&CSS in the context of ebooks. 
But the first real website I made and published from scratch was the first version of my personal site that I built two years ago. 
It was a single `index.html` with a static layout and very little content.
The blog that you are reading right now is built with a static site generator. 

During the last couple of years, I have accumulated a large collection of bookmarks that I find helpful when making websites. 
I regularly keep referring to many of them. 

All of these resources are relevant to most kinds of websites, regardless of what stack or framework you use.
If you are building a website on your own, I hope this collection will prove to be useful.

> All links are from my personal collection. I have no affiliation with any of the linked resources. 
All linked resources are free to use. 

<br>
<a href="#tldr">TL;DR: Just give me the links!</a>

## Page Layout

### Flexbox

Table-based layouts are a thing of the past, with Flexbox being the most common way to layout web UIs these days. 
[A Complete Guide to Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/) ended up being one of the resources I get back to the most. 

### CSS Selectors

There's a lot of ways to apply styles to an element in CSS. 
I love the [CSS selector reference from w3schools](https://www.w3schools.com/cssref/css_selectors.asp). It provides a short overview of each selector and lets me quickly choose the best option. 

### HTML & Accessibility

While browsing Twitter one day I stumbled upon an article recommendation from [@ReyTheDev](https://twitter.com/ReyTheDev/status/1294148221992935424) for [structuring HTML semantically](https://developer.mozilla.org/en-US/docs/Learn/Accessibility/HTML) to achieve low-effort accessibility and reader mode support. 
It's a gold-mine when it comes to the basics of modern HTML.

## Navigation

### Opening external links

It was a discovery that opening links in a new tab is unfriendly to accessibility and mobile usage. 
This is usually achieved with `target="_blank"` on links. 
I've never looked at it in such a way that the user can always opt-in to open something in a new tab, but they can never opt-out. 
[UX Collective wrote a comprehensive article on opening links](https://uxdesign.cc/linking-to-a-new-tab-vs-same-tab-f88b495d2187).

## SEO

To make a site searchable through search engines, it is essential to get several meta properties right. 
Shout out to [@MarinaHuber](https://twitter.com/SerinnahHuber) for introducing me to this comprehensive [SEO check tool](https://www.seobility.net/en/seocheck/). It checks not only the technical side, but also the content itself.

_Canonical URLs_ help avoid duplicate content on the web. They are useful even if you post only in one place. Check out [rel=canonical: the ultimate guide](https://yoast.com/rel-canonical/).

## Art 

It's hard to avoid needing graphic resources, even when building a simple website. 
There are many copyright-free collections out there, for example [Unsplash](https://unsplash.com), [Undraw](https://undraw.co/illustrations) and [Black Illustrations](https://www.blackillustrations.com). 

### Favicons

The quickest way to get favicons is to use an online generator. 
[favicon.io](https://favicon.io) lets you make favicons from text, emojis, and images. For example, I made my favicon from the text "MG" - creative, right! 
Files will be ready-to-go along with a code snippet. 

[Favicon checker](https://realfavicongenerator.net/favicon_checker) is super handy for verifying that all favicons and manifests are in place. 

### Icons

[Simple Icons](http://simpleicons.org) has a comprehensive catalog of free SVG icons for popular brands. 

### Colors

I've tried several color scheme generators before ending up with [Coolors](https://coolors.co). 
You can pick a palette from a large catalog, modify or create your own, even based on an uploaded image. 

## Social Sharing 

### Buttons

Twitter's sharing widget and similar components from other social networks have tracking embedded, so I opted out of using them. 
I am also avoiding using unnecessary cookies or any kind of local storage, so I wouldn't have to show the infamous cookie banner.

[Social Media share buttons without javascript](https://www.ahmad-osman.com/en/blogs/social-media-share-without-javascript/) documents sharing links for many popular social apps and networks. 

[Sharing button generator](https://sharingbuttons.io) is a great starting point for rolling your own buttons. 
I had to tweak the CSS, but it was still easier than starting from scratch. 

### Preview cards

Most social networks use Open Graph metadata to generate preview cards. 
[Open Graph Protocol homepage](https://ogp.me) gives a nice overview of the generic webpage properties and directions to dig deeper. 

Twitter has its own meta properties inspired by Open Graph. The main addition is that you can specify the style you want your cards to follow.
Here's the link to [Twitter's Documentation on Cards](https://developer.twitter.com/en/docs/tweets/optimize-with-cards/guides/getting-started). Other social networks such as [LinkedIn](https://www.linkedin.com/help/linkedin/answer/46687/making-your-website-shareable-on-linkedin?lang=en) and [Facebook](https://developers.facebook.com/docs/sharing/webmasters/) rely on Open Graph protocol and don't have their own properties sans rare exceptions. 

#### Testing preview cards

Testing preview cards is something that I did a lot of, making sure I like how my site looks when shared. 
I certainly did send messages to myself, nothing wrong with that :)

Each of the major social networks has its own _card validator_, which lets you easily preview the cards. I only have [Twitter Card Validator](https://cards-dev.twitter.com/validator) bookmarked, but here's also [LinkedIn Post Inspector](https://www.linkedin.com/post-inspector/) and [Facebook Sharing Debugger](https://developers.facebook.com/tools/debug/).

Card metadata is heavily cached on the social network's side, so they don't have to hit your webpage every time someone is looking at a post with your link. 
Card validators have a hidden perk: they also invalidate the respective caches.
This article goes in-depth on cards and caching: [How to Clear Facebook Cache, Twitter Cache, and LinkedIn Cache so Your Content Looks Right](https://www.socialmediaexaminer.com/how-to-clear-facebook-cache-twitter-cache-linkedin-cache/).

## Tracking

I care about privacy, so having Google Analytics on the previous version of my site was bugging me. 
Once I randomly stumbled upon [GoatCounter](https://www.goatcounter.com) - privacy-friendly open source web analytics.
[GoatCounter's rationale](https://github.com/zgoat/goatcounter/blob/master/docs/rationale.markdown) resonated with me, and now it is my go-to analytics service. By the way, it is completely free for non-commercial use. 

## Inspiration

[humans.fyi](https://humans.fyi) is a huge catalog of personal websites, where you can browse by platform, dominant color, and even occupation. Exploring other people's sites gives endless inspiration for layouts, color schemes, and fonts. And a little bit of FOMO.

<a name="tldr"></a> 
## TL;DR 

  - [A Complete Guide to Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)
  - [CSS selector reference from w3schools](https://www.w3schools.com/cssref/css_selectors.asp)
  - [Structuring HTML semantically](https://developer.mozilla.org/en-US/docs/Learn/Accessibility/HTML)
  - [Linking to a new tab vs. same tab](https://uxdesign.cc/linking-to-a-new-tab-vs-same-tab-f88b495d2187)
  - [SEO check tool](https://www.seobility.net/en/seocheck/)
  - [rel=canonical: the ultimate guide](https://yoast.com/rel-canonical/)
  - [Unsplash - freely usable images](https://unsplash.com) 
  - [Undraw - open-source illustrations](https://undraw.co/illustrations)
  - [Black Illustrations](https://www.blackillustrations.com)
  - [favicon.io - favicon generator](https://favicon.io)
  - [Favicon checker](https://realfavicongenerator.net/favicon_checker)
  - [Simple Icons - svgs for popular brands](http://simpleicons.org)
  - [Coolors - color scheme generator](https://coolors.co)
  - [Sharing button generator](https://sharingbuttons.io)
  - [Social Media share buttons without javascript](https://www.ahmad-osman.com/en/blogs/social-media-share-without-javascript/)
  - [Open Graph Protocol homepage](https://ogp.me)
  - [Twitter's Documentation on Cards](https://developer.twitter.com/en/docs/tweets/optimize-with-cards/guides/getting-started)
  - [Twitter Card Validator](https://cards-dev.twitter.com/validator), [LinkedIn Post Inspector](https://www.linkedin.com/post-inspector/), [Facebook Sharing Debugger](https://developers.facebook.com/tools/debug/)
  - [How to Clear Facebook Cache, Twitter Cache, and LinkedIn Cache so Your Content Looks Right](https://www.socialmediaexaminer.com/how-to-clear-facebook-cache-twitter-cache-linkedin-cache/)
  - [GoatCounter web analytics](https://www.goatcounter.com), [GoatCounter's rationale](https://github.com/zgoat/goatcounter/blob/master/docs/rationale.markdown)
  - [humans.fyi - catalog of personal websites](https://humans.fyi)
