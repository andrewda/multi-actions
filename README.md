# multi-actions

Install and configure multiple
[self-hosted GitHub Actions runners](https://docs.github.com/en/actions/hosting-your-own-runners)
on the same host.

Basic usage:

```bash
$ ./install.sh \
    --url <org url> \ # (required) URL of the GitHub organization
    --token <token> \ # (required) GitHub Actions token
    --count <number of runners> \ # Number of runners to install (defaults to number of cores)
    --version <runner version> \ # Runner version to install (defaults to 2.291.1)
    --checksum <runner checksum> \ # Checksum of the Runner (defaults to checksum for 2.291.1)
    --dir <installation directory> # Installation directory (defaults to /home/ubuntu/github)
```

To uninstall the runners:

```bash
$ ./uninstall.sh --token <token> --dir <installation directory>
```
