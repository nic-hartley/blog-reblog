# allocate

This blob of IaC does everything needed to spin up a b/rb instance on Linode:

- Creates the instance(s) that will run the k3s cluster
- Configures those instances to run k3s, and connects them into a cluster
- Points the domain name's `A` records to the cluster

Bear in mind that this only needs to be (re)run to create new Kubernetes clusters or update them.
To deploy the code, see `k8s/`.
The split is very deliberate: This just spins up a Kubernetes cluster in a specific cloud instance.
Once you have one, *no matter where it's hosted*, you can use that yourself.

## Usage

You have to manually [create the domain](https://cloud.linode.com/domains).
(It could've been automatic, but that would've made it way more complex.)
Get the ID by clicking on it in the web UI, then taking the number after `/domains/`.

Once you've got that, the easiest way is probably to use `brb-tf.sh`:

```sh
# To spin up the cluster at a subdomain (outputs useful things into `allocate/<subdomain>/`)
./brb-tf.sh '<subdomain>' up

# To tear the whole cluster down (including deleting `allocate/<subdomain>/`)
./brb-tf.sh '<subdomain>' down
```

It'll create a directory to store that subdomain's info, then prompt for some required information, then spit out the kubeconfig.
The subdomain has to be either `@` (for no subdomain) or the text (i.e. the `foo` in `foo.example.com`).

All it really does is manage shared information in a consistent way, though.
You can always run the Terraform manaully if you prefer.
