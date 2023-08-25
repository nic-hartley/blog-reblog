use clap::{Args, Parser, Subcommand};

/// Various knobs to tweak when building a cluster
#[derive(Debug, Args)]
struct ClusterSpec {
    /// How many servers, i.e. controllers, to create past the bootstrap node.
    #[arg(long, short, default_value = "0")]
    servers: usize,
    /// How many agents, i.e. workers, to create.
    #[arg(long, short, default_value = "0")]
    agents: usize,
    /// Linode instance type to use.
    #[arg(long, short, default_value = "g6-nanode-1")]
    instance_type: String,
}

#[derive(Debug, Subcommand)]
enum Action {
    /// Create a new cluster from scratch
    /// 
    /// This creates everything, including instances, DNS entries, etc., and installs and configures them all to
    /// create a k3s.
    /// 
    /// If there's already a cluster under that domain, it'll be entirely destroyed, resulting in some amount of
    /// downtime. If you just want to adjust the cluster, use `resize' instead.
    Up {
        /// The specification for the cluster
        #[command(flatten)]
        spec: ClusterSpec,
    },
    /// Delete an entire cluste.
    /// 
    /// Everything will go away, and unless you've already backed it up, it'll all be lost forever.
    Down,
    /// Edit an existing cluster
    /// 
    /// It'll stay under the same domain name, but the number of instances
    #[command(alias = "resize")]
    Edit {
        /// New cluster spec
        #[command(flatten)]
        spec: ClusterSpec,
    },
}

#[derive(Debug, Parser)]
#[command(version, author)]
struct Cli {
    #[command(subcommand)]
    action: Action,
    /// Subdomain of the cluster
    subdomain: String,
    /// Root domain of the entire website
    #[arg(default_value = "blog-reblog.net", env)]
    domain: String,
}

fn main() {
    println!("{:?}", Cli::parse());
}
