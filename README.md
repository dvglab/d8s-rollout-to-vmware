# A set of utils to prepare rollout deckhouse cluster on VMWare vSphere

The packer-for-vsphere dir contains configs and build script to make vmware template from official linux ubuntu distro iso /tested for Ubuntu 22.04 only/
[Based on packer-examples-for-vsphere](https://github.com/vmware-samples/packer-examples-for-vsphere)

In the vsphere-vm-enrollment you can find terraform configs to rollout 10 vm from the template:
| Node role | Count |
| --------- | ----- |
| master    |   3   |
| ingress   |   2   |
| monitoring|   2   |
| work      |   3   |

After all ansible playbooks to expand disks, update packages, add lvm volumes and etc.

