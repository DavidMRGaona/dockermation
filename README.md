# dockermation

## SSH keys

This repository no longer ships with default SSH keys. If you enable
`INSTALL_WORKSPACE_SSH` when building the workspace image, provide your own
`id_rsa` and `id_rsa.pub` files or generate a new key pair during the build.

Generate a key pair with:

```bash
ssh-keygen -t rsa -b 4096 -N '' -f id_rsa
```

Then copy `id_rsa` and `id_rsa.pub` into the build context (for example as
`docker/workspace/id_rsa` and `docker/workspace/id_rsa.pub`) or mount them at
runtime.
