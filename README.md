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

This repo contains the source code for the blog/reblog software.
It's written in Rust and deployed with Helm to a Kubernetes cluster.
Because each of the crates are tightly tied together, they're all pinned to the same versions, and you'll need to make sure versions line up.
This repo is broken into several crates, each with its own README for details:

- `blogrb-core`:
  The primary b/rb library, which implements most of the common code for the rest of the crates.
  In particular, database code generally lives here, as do the various types that get shuttled between the components.
- `blogrb-c-*`:
  Various containers that get deployed into Kubernetes to run the actual site.
  Each of these also has a Dockerfile, to generate the container image of the same name.
- `blogrb`:
  A CLI tool to generate a site from a repo, a lot like b/rb's VCS integration.
  (The social features might work a bit differently -- check the docs for details.)

It also has the relevant Kubernetes files to deploy the site to a Kubernetes cluster in `k8s`.
The IaC for caching is in `cache`.
Both also have READMEs explaining how to deploy them.
