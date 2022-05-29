all: build

build: build-vmware build-libvirt

build-vmware:
	packer build --only=vmware-iso nixos-unstable.json

build-libvirt:
	packer build --only=qemu nixos-unstable.json

.PHONY: all build-vmware build-libvirt
