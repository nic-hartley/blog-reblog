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
All of it's written in Haskel, and the website runs on Kubernetes.

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

As is tradition in Haskell spaces, this project uses [PVP](https://pvp.haskell.org/).
Specifically, it uses a four-part version number, `gen.break.add.fix`, with guarantees about the **source code** compatibility:

- `gen` indicates the "generation" of the package.
  When large, sweeping, structural changes are made that affect what it's like to use the package, this version updates and all others reset.
  Notably, the gen of all the packages will be in sync in any particular commit.
- `break` is incremented when there's a breaking change, but it's not a large one.
  For example, `2.0.0.0` might introduce a brand-new API, but leave the old one available under `V1` to allow incremental porting.
  `2.1.0.0` might delete `V1`.
- `add` increases when things are added or changed, in a way that won't break **source**-compatibility.
  For example, adding a field to a record type whose constructor isn't accessible would fit here.
- `fix` increases when basically any small, internal change is made, e.g. bugfixes, documentation tweaks, performance boosts.
  Notably, when something entirely under-the-hood is replaced, this is probably what increases, even if it's a major internal change.

All of these promises apply to *documented* behavior of the code's external API.
If I accidentally make a type accessible, it might disappear at any time when I realize what I've done.
Or I might entirely refactor and rename and restructure all of the code inside a binary without changing its CLI.
I also give myself more leeway for changes that affect security; even if they break source compatibility they might be done in a sub-major version to encourage upgrades.
