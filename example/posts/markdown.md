---
title: Markdown demo
author: Mark Down <mark@dow.net>
tags:
- example
- markdown
publish: 2023-09-19
---

Hello there!

# This is a Markdown tutorial!

You'll notice that the header above is an `<h1>`, compared to the post title `<div class="title">` at the top of the page.
Headers are meant to be used within the post; that means they indicate levels of heading within the post, which is different than the page's title.

As usual for Markdown, you can do lots of things

- Unordered lists
- **Bold**, *italic*, ***bold+italic***, form**mat**ting wi*thin* words, etc.

4. Ordered lists that start at whatever number you want (but notice how that breaks the last list!)
0. And notice that after the first item, the number autoincrements.

```
You can do triple-tick code blocks.
They can have code formatting, e.g.:
```

```py
def foo(x):
  print(f"hello, {x}")
  return x + 2
```

## Extensions

There are some extensions to the basic Markdown syntax as well, e.g.:

- __Underlining__ with `__double underscores__`
- | Tables work | like you'd | expect |
  |:-----------:|:-----------|-------:|
  | including   | formatting | **wh** |
  | *eeeeeeeee* | ***eeeee** | *eeee* |
- Extra backticks for extra codeblockiness:

  `````
  This is a quintuple-ticked code block, containing an example of a 4-tick code block:
  ````
  This could be used to show the syntax used for 3-tick code blocks:
  ```py
  print("Hello, World!")
  ```
  And then the code block would end.
  ````
  And then the actual code block ends.
  `````

## Inserts

On top of the usual Markdown, there are also a variety of "inserts" to generate things automatically.
For example:

````
```index
limit: 10
include:
- title
```
````

Inserting this into most pages will leave you with a list of your 10 most recent post title.

There are a variety of kinds of insert.
Each takes parameters in YAML, and they can get quite complex.
For details you should look at the documentation, this is just an example of some of the formatting.
