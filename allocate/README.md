# allocate

This blob of IaC does everything needed to spin up a b/rb instance on Linode:

- Creates the instance(s) that will run the k3s cluster
- Configures those instances to run k3s, and connects them into a cluster
- Points the domain name's `A` records to the cluster

Bear in mind that this only needs to be (re)run to create new Kubernetes clusters or update them.
To deploy the code, see `k8s/`.

## Usage

TODO: Write the code, then figure out how to run it.
