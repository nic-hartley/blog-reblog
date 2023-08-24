# blog/reblog

blog/reblog, aka b/rb, is a social blogging platform.
It's meant to offer content you care about, to inspire you to write.
With cherrypicked social features and a robust CMS, it tries to blend the best of both worlds, striking a unique balance.

## Features

blog/reblog's CMS half is robust, with:

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
Eventually it'll be hosted online, but it'll have to be made first.

## Repository

This repo contains the source code for the blog/reblog website, as well as some associated tooling.
All of it's written in Rust, and the website runs on Kubernetes, deployed with Helm.

The project is broken into several parts, each with its own README for details:

- `blogrb-core`:
  The primary b/rb library, which implements most of the common code for the rest of the crates.
  In particular, database code generally lives here, as do the various types that get shuttled between the components.
- `blogrb`:
  A CLI tool to generate a site from a repo, a lot like b/rb's VCS integration.
  (The social features might work a bit differently -- check the docs for details.)
- `blogrb-api`:
  An async client library for the REST API, for building your own clients or frontends.
- `containers/*`:
  The various containers that get deployed into Kubernetes to run the actual site.
  Each of these also has a Dockerfile, to generate the container image of the same name.
- `allocate`:
  A tool to start up and manage the Kubernetes cluster, handle DNS mappings, etc. on b/rb's cloud.
  This is only directly useful if you're also using the same cloud providers in the same way b/rb does, but it might be instructive for other reasons.
- `k8s`:
  Everything needed to build the containers and deploy them to a given Kubernetes cluster.

Of these, only a handful are published to `crates.io`; notably, the ones designed to be used as standalone tools, rather than just one piece of the website.

## Versioning

Versioning can get complex.
For specific details, check each crate's README.

Security fixes will usually mean a new patch version, *even if it breaks your code*, to make you deliberately choose to remain on a specific older version, instead of letting it happen accidentally.
They'll usually only be released for the latest version, but 

The containers in a running cluster almost always have to be the exact same version.
They're unpublished for a reason; they're not really independent crates, just distinct binaries forming components of a whole system.
See `k8s/README.md` for how to update.

Whatever version the containers are is the *site version*.
The versions of the other tools usually match major/minor versions with the site, and are [semantically versioned](https://semver.org/) in the usual way.
For example, upgrading your website from 1.1.0 to 1.2.0 shouldn't break your custom client using `blogrb-api` 1.1.5, and upgrading your client from 1.1.5 to 1.2.0 shouldn't break its functionality against 1.1.0 sites -- unless you're using something introduced in 1.2.0, of course.

There's some added complexity in that the site might briefly present multiple API versions, under different paths.
*Usually*, there'll be just one, but:
- Leading up to a new major version, there might be *unstable* next-major-version APIs.
  For example, 1.9.8 might come with `/v2` APIs.
  Breaking changes to these prerelease APIs is *not* going to bump the major version.
- Once it's released, the new APIs stabilize, and you get the usual semver guarantees.
  On the other hand, in this example, the old APIs will stick around, until at least 2.1.0.
  Deleting an old API is a minor version bump.
