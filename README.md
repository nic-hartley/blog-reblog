# blog/reblog

blog/reblog, aka b/rb, is a social blogging platform.
It's meant to offer content you care about, to inspire you to write.
With cherrypicked social features and a robust CMS, it tries to blend the best of both worlds, striking a unique balance.

## Features

blog/reblog's CMS half is extremely clean, with:

- A clean, markdown-based text input for composing posts
- Built-in and automatic RSS, Atom, OpenGraph, etc.
- Integration with Git and other VCS
- Archivability and portability, by being based on open, text-based standards
- Customizable styles, URL hierarchies, and page layouts

It also cherrypicks a few social features from similar platforms, like:

- An advanced RSS reader for all the blogs you follow, on or off the site
- User-submitted questions, aka asks, both directly to you and about specific posts
- Reblogging other posts, just to share or adding your own thoughts

Currently, it doesn't really exist.
Eventually you'll be able to use it at [blog-reblog.net](https://blog-reblog.net), but it'll have to be made first.
You'll also be able to run your own instance, and thanks to the use of RSS they seamlessly interoperate in ways that are easily cached.

## Repository

This repo contains the source code for the blog/reblog website, as well as some associated tooling.
All of it's written in Rust, and the website runs on Kubernetes.

The project is broken into several parts, each with its own README for details:

- `blogrb-core`:
  The primary b/rb library, which implements most of the common code for the rest of the crates.
  In particular, it contains all the site generation code, plus some common helpers.
- `blogrb`:
  A CLI tool to generate a site from a repo, a lot like b/rb's VCS integration.
  (The social features might work a bit differently -- check the docs for details.)
- `brbnet-api`:
  A client library for the REST API, for building your own clients or frontends.
- `brbnet-core`:
  The primary b/rb*.net* library, which implements the common code for the containers.
  Primarily it's concerned with shuffling `blogrb-core` datatypes around the database.
- `brbnet-*`:
  The various containers that get deployed into Kubernetes to run the actual site.
  Each of these also has a Dockerfile, to generate the container image of the same name.
- `k8s`:
  Everything needed to build the containers and deploy them to a given Kubernetes cluster.
  This also documents how the containers fit together.

Of these, everything but `brbnet-*` and `k8s` are meant to be used as Haskell libraries.
None are available on Hackage, but they could be if there was literally any demand for that.
That said, [the releases](https://github.com/nic-hartley/blog-reblog/releases) should have all the installable files.

## Versioning

As is tradition in Rust spaces, this project uses [Semver](https://semver.org/), but it ***does not*** make the same strength of guarantee about backwards compatibility.
We use the same three-part version number, `major.minor.patch`, with each segment incremented (and the smaller ones reset) under specific conditions:

- `major` is incremented when there's a very large break with backwards compatibility.
  Your code is very likely to break.
  For example, `2.0.0` might refactor the API in a way that `1.x.y` code is very likely to be broken by.
- `minor` increases when things are added or changed, in a way that almost definitely won't break source-compatibility.
  For example, adding new functions to structs or trait methods with default implementations.
  Long-deprecated or especially troublesome functionality might be removed.
  As such it's recommended that you pin a specific `patch` version, e.g. `blogrb-core = "x.y.z"`.
- `patch` increases when basically any small, internal change is made, e.g. bugfixes, documentation tweaks, performance boosts.
  These will never break source compatibility.

All of these promises apply to *documented* behavior of the external interface.
If I accidentally make a type accessible, it might disappear at any time when I realize what I've done.
Or I might entirely refactor and rename and restructure all of the code inside a binary without changing its CLI.
I also give myself more leeway for changes that affect security, even if they break compatibility.
