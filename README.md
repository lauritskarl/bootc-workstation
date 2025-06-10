# bootc-workstation
Personal workstation image

## Build disk image

- Set --type to whatever you need (e.g., raw, anaconda-iso, qcow2, etc)
- Set --target-arch if building for a different architecture (e.g., x86_64 or aarch64)

```bash
mkdir -p $(pwd)/output
run0 podman pull ghcr.io/lauritskarl/bootc-workstation:latest
run0 podman run \
    --rm \
    -it \
    --privileged \
    --pull=newer \
    --security-opt label=type:unconfined_t \
    -v /var/lib/containers/storage:/var/lib/containers/storage \
    -v $(pwd)/config.toml:/config.toml \
    -v $(pwd)/output:/output \
    quay.io/centos-bootc/bootc-image-builder:latest \
    --type anaconda-iso \
    --rootfs btrfs \
    --use-librepo=True \
    ghcr.io/lauritskarl/bootc-workstation:latest
```
