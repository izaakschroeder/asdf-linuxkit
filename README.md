<div align="center">

# asdf-linuxkit [![Build](https://github.com/izaakschroeder/asdf-linuxkit/actions/workflows/build.yml/badge.svg)](https://github.com/izaakschroeder/asdf-linuxkit/actions/workflows/build.yml) [![Lint](https://github.com/izaakschroeder/asdf-linuxkit/actions/workflows/lint.yml/badge.svg)](https://github.com/izaakschroeder/asdf-linuxkit/actions/workflows/lint.yml)

[linuxkit](https://github.com/linuxkit/linuxkit) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add linuxkit
# or
asdf plugin add linuxkit https://github.com/izaakschroeder/asdf-linuxkit.git
```

linuxkit:

```shell
# Show all installable versions
asdf list-all linuxkit

# Install specific version
asdf install linuxkit latest

# Set a version globally (on your ~/.tool-versions file)
asdf global linuxkit latest

# Now linuxkit commands are available
linuxkit --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/izaakschroeder/asdf-linuxkit/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Izaak Schroeder](https://github.com/izaakschroeder/)
