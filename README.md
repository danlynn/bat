This image allows you to run the excellent `cat` command replacement `bat` within a container.  `bat` is a `cat` clone with wings! ...and Docker

See [https://github.com/sharkdp/bat/](https://github.com/sharkdp/bat/)

![stars](https://img.shields.io/docker/stars/danlynn/ember-cli.svg) ![pulls](https://img.shields.io/docker/pulls/danlynn/ember-cli.svg) ![automated](https://img.shields.io/docker/automated/danlynn/ember-cli.svg) ![automated](https://img.shields.io/docker/build/danlynn/ember-cli.svg)

### Supported tags and respective `Dockerfile` links

+ [`0.6.1`,`latest` (0.6.1/Dockerfile)](https://github.com/danlynn/bat/blob/0.6.1/Dockerfile)

![bat logo](https://raw.githubusercontent.com/sharkdp/bat/master/doc/logo-header.svg?sanitize=true)

### usage

Note that these examples all use the shell alias described in the installation section below.

#### Syntax Highlighting

bat supports syntax highlighting for a large number of programming and markup languages:

![Syntax Highlighting Example]()

#### Git Integration

bat integrates with git to show modifications with respect to the index (see left side bar):

![Git Integration Example]()

#### Theme Selection

A number of different syntax highlighting themes are built-into `bat`.  To get a list of the available themes try `bat --list-themes`:

![List themes]()

To use a theme other than the default, either pass the `--theme` option on the command line -or- set the BAT_THEME env var:

![Select theme]()

### installation

It is NOT recommended, but this docker container can be ran as an executable container like:

```bash
docker run -it --rm -e BAT_THEME -v "$(pwd):/myapp" danlynn/bat myFile.js
```

INSTEAD, you should really consider creating a shell alias so that the command will run as if it is installed directly to your system.

Modify your `~/.bashrc` file to include the following line:

```bash
alias bat='docker run -it --rm -e BAT_THEME -v "$(pwd):/myapp" danlynn/bat'
```

From this point forward, any terminal windows that you open will be able to use the `bat` command as if it is installed directly on your system.