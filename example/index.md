---
title: Homepage
url: /posts
---

# Welcome!

This is the index of the `blogrb` example blog.
To see it as HTML:
- Clone the repo:
  `git clone https://github.com/nic-hartley/blog-reblog.git`
- Install the CLI tool:
  `cabal install ./blog-reblog/blogrb`
- Run the site generator, with a local file base URL:
  `blogrb generate ./blog-reblog/example -o site/ --base-url="file:///$PWD/site"`
- Open it in your favorite browser:
  `firefox ./site/index.html`

To host it with a webserver, the first two steps are the same, but then:
- Run the site generator with no extra configuration:
  `blogrb generate ./blog-reblog/example -o site/`
- Serve it with any typical HTTP fileserver, e.g.:
  `httpserv ./site`

## Wow!

I know, right?
Whoever wrote this tool is such a good dev, and probably also really cute and their fanfiction is canon-consistent.
You might want to [contact them](page:contact) or read [this old blog post](post:first-post).

If you're here for the other posts, though:

```index
paginate:
  per-page: 3
include:
- title: link
- date
- tags
- synopsis
```

Oh hey there's some text after it too!
That's cool.
