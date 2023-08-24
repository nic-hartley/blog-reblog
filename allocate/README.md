# allocate

This blob of Rust does everything needed to spin up a b/rb instance on Linode:

- Creates the instance(s) that will run the k3s cluster
- Configures those instances to run k3s, and connects them into a cluster
- Points the domain name's `A` records to the cluster

Bear in mind that this only needs to be (re)run to create new Kubernetes clusters or update them.
To deploy the code, see `k8s/`.
The split is very deliberate: This just spins up a Kubernetes cluster in a specific cloud instance.
Once you have one, *no matter how or where it's hosted*, you can use that yourself.

## Usage

First, create a [Linode personal access token](https://cloud.linode.com/profile/tokens).
Then you can run `cargo run ./allocate --help`, to see the usage information.

You'll be prompted on stdin for your token, or you can pass it through the `LINODE_TOKEN` environment variable, e.g. for CI.
You'll probably *also* want to set the `BRB_ROOT` environment variable to your domain name -- unless you own `blog-reblog.net`.

The code works a bit like Terraform, with assets keyed off the domain -- so if you refer to `beta` several times, you're always referring to the same group of VMs, and if you want a *new* group, you give it a new subdomain, e.g. `beta2`.
For specific command line details, check the help output, but in broad strokes:

- `up`:
  Create an entirely fresh cluster, including nodes, DNS, etc.
  If there's already one there, it'll get entirely torn down and recreated.
  (This might use up a lot of bandwidth!)
- `down`:
  Tear down an existing cluster, or do nothing (with a warning) if there isn't one.
- `resize`:
  Add or remove nodes, or change their sizes.
  (Note that you can't actually *resize* a node in Linode -- this creates new nodes and deletes the old ones.)
  This will gracefully migrate things; you shouldn't have any downtime unless something goes wrong.
- `update`:
  Runs an OS and K3s update, ensuring all the software is up-to-date.
  This should only result in downtime if you only have one server node, the default.

Do note that `allocate` is deliberately *not* a published crate.
It might well be useful elsewhere, but ultimately it's just a handy tool for b/rb.
That said, if you *do* find it useful, please let me know.
That's very neat!
