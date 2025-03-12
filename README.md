# gk - Kubernetes Utility Script

`gk` is a powerful, Bash-based command-line utility designed to simplify common Kubernetes tasks. Built with the assistance of **Grok**, an AI developed by xAI, this tool streamlines interactions with Kubernetes clusters by wrapping `kubectl` commands into an intuitive, user-friendly interface. Whether you're listing resources, managing pods, or monitoring usage, `gk` reduces complexity and enhances productivity.

## Features

- **Resource Management**: List, view, and modify Kubernetes resources like pods, deployments, services, configmaps, secrets, namespaces, jobs, cronjobs, and nodes.
- **Pod Operations**: Connect to pods, view logs (with tailing), copy files, restart, or delete them.
- **Resource Monitoring**: Check real-time CPU and memory usage for nodes or pods, with sorting options.
- **Cluster Insights**: View events and edit resources directly.
- **Bash Completion**: Autocomplete commands, options, and resource names for faster workflows.
- **AI-Assisted Development**: Crafted with Grok's help to optimize usability and functionality.

## Installation

### Prerequisites
- `kubectl` installed and configured with cluster access.
- Bash shell (completion requires `/etc/bash_completion.d/` or equivalent).

### Steps
1. Clone the repository:
```   
   git clone https://github.com/gborbonus/gk.git
   cd gk
```
Run the installer:
  `sudo ./install.sh`
  
3. Reload your shell:
    `. ~/bashrc`


The installer places `gk` in `/usr/local/bin/` and the completion script in `/etc/bash_completion.d/`.

## Usage

### Commands
- **List Resources**: `gk list [-t <type>] [-ns <namespace>]`
  - Default: Lists pods.
  - Example: `gk list -t deployments`
- **Get Details**: `gk get <config|file|desc> -n <name> [-t <type>] [-ns <namespace>]`
  - Example: `gk get config -t services -n my-svc`
- **Modify Resources**: `gk mod <delete|restart|scale|edit> -n <name> [-t <type>] [options]`
  - Example: `gk mod restart -n my-pod --yes`
  - Example: `gk mod scale -n my-app --replicas 3`
- **Connect to Pods**: `gk conn -n <pod>`
- **View Logs**: `gk log -n <pod> [-f] [--tail <lines>]`
  - Example: `gk log -n my-pod --tail 1000`
- **Resource Usage**: `gk top [-n <pod>] [--sort <memory|memory-desc>]`
  - Example: `gk top --sort memory`
  - Setup Metrics Server: `gk top prep-top`
- **Events**: `gk events [-ns <namespace>]`
- **Help**: `gk help`

### Supported Resource Types
- pods, configmaps, secrets, services, namespaces, jobs, deployments, cronjobs, nodes

## Why Grok?
This utility was developed with the help of **Grok**, an AI from xAI, which provided insights into optimizing command structures, handling edge cases, and enhancing user experience. Grok’s ability to understand and refine complex scripting tasks made `gk` more robust and intuitive, saving time and reducing errors in Kubernetes management.

## Contributing
Feel free to fork this repository, submit issues, or send pull requests. Contributions to add new features, improve error handling, or extend resource support are welcome!

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details (create one if desired).

## Contact
Feel free to reach out to me with any issues/recommendations for additional functionality. This is an evolving project.
greg@ableadmins.com

## Groksprint
Please check out http://groksprint.com for the latest in apps developed with Grok.

---

Happy Kubernetes managing with `gk`!
