This docker image allows you to run the excellent `cat` command replacement `bat` within a container.  `bat` is a `cat` clone with wings! ...and Docker

See the __*excellent*__ `bat` project that this docker container wraps at [https://github.com/sharkdp/bat/](https://github.com/sharkdp/bat/)

![stars](https://img.shields.io/docker/stars/danlynn/bat.svg) ![pulls](https://img.shields.io/docker/pulls/danlynn/bat.svg) ![automated](https://img.shields.io/docker/automated/danlynn/bat.svg) ![automated](https://img.shields.io/docker/build/danlynn/bat.svg)

### Supported tags and respective `Dockerfile` links

+ [`0.9.0`,`latest` (0.9.0/Dockerfile)](https://github.com/danlynn/bat/blob/0.9.0/Dockerfile)
+ [`0.7.1` (0.7.1/Dockerfile)](https://github.com/danlynn/bat/blob/0.7.1/Dockerfile)
+ [`0.6.1` (0.6.1/Dockerfile)](https://github.com/danlynn/bat/blob/0.6.1/Dockerfile)

![bat logo](https://raw.githubusercontent.com/danlynn/bat/master/README_assets/bat_logo_header.svg?sanitize=true)

## Usage

Note that these examples all use the bash function described in the installation section below.

#### Syntax Highlighting

`bat` supports syntax highlighting for a large number of programming and markup languages:

![Syntax Highlighting Example](https://raw.githubusercontent.com/danlynn/bat/master/README_assets/syntax_highlighting.png)

#### Git Integration

`bat` integrates with git to show modifications with respect to the index.  Notice the `~`, `+`, `-` symbols in the left margin:

![Git Integration Example](https://raw.githubusercontent.com/danlynn/bat/master/README_assets/git_integration.png)

#### Theme Selection

A number of different syntax highlighting themes are built-into `bat`.  To get a list of the available themes try `bat --list-themes`:

![List themes](https://raw.githubusercontent.com/danlynn/bat/master/README_assets/list_themes.png)

Notice how `bat` gives a sample of each theme listed. Nice!

To use a theme other than the default, either pass the `--theme` option on the command line -or- set the `BAT_THEME` env var on your local machine:

![Select theme](https://raw.githubusercontent.com/danlynn/bat/master/README_assets/select_theme1.png)

![Select theme](https://raw.githubusercontent.com/danlynn/bat/master/README_assets/select_theme2.png)

Note that if you want to use a different theme as a default then you should probably just set the `BAT_THEME` env var in your ~/.bashrc file like:

```bash
export BAT_THEME=1337
```

Similarly, you can put the BAT_STYLE and BAT_TABS env vars in your ~/.bashrc to provide defaults for the --style and --tabs options (see: [https://github.com/sharkdp/bat#customization](https://github.com/sharkdp/bat#customization)).

Alternatively, you can more easily customize your bat usage using the new `~/.config/bat/config` file added in bat v0.8.0 like:

```bash
# Set the theme to "TwoDark"
--theme="TwoDark"

# Show line numbers, Git modifications and file header (but no grid)
--style="numbers,changes,header"

# Use italic text on the terminal (not supported on all terminals)
--italic-text=always

# Add mouse scrolling support in less (does not work with older
# versions of "less")
--pager="less -FR"

# Use C++ syntax (instead of C) for .h header files
--map-syntax h:cpp

# Use "gitignore" highlighting for ".ignore" files
--map-syntax .ignore:.gitignore
```


## Installation

Basically, you don't install __*anything*__.  Instead, all you have to do is copy the following bash function into your ~/.bashrc file:

```bash
function bat {
        if [[ $# -eq 1 && $1 =~ ^\.\. ]]; then
                # handle ../../path when single arg
                docker run -it --rm -e BAT_THEME -e BAT_STYLE -e BAT_TABS -v "$HOME/.config/bat/config:/root/.config/bat/config" -v "$(cd "$(dirname "$1")"; pwd):/myapp" danlynn/bat $(basename "$1")
        elif [[ $# -eq 1 && $1 =~ ^\/ ]]; then
                # handle ~/path -or- actual absolute paths when single arg
                docker run -it --rm -e BAT_THEME -e BAT_STYLE -e BAT_TABS -v "$HOME/.config/bat/config:/root/.config/bat/config" -v "$(dirname "$1"):/myapp" danlynn/bat $(basename "$1")
        else
                # handle most everything else
                docker run -it --rm -e BAT_THEME -e BAT_STYLE -e BAT_TABS -v "$HOME/.config/bat/config:/root/.config/bat/config" -v "$(pwd):/myapp" danlynn/bat $@
        fi
}
```

This new function will act like the regular `bat` command and will be available in any __*new*__ terminal tabs or windows that you open.

Upon your __*first*__ use of the `bat` command, docker will automatically download this image and then continue on to run your `bat` command.  Every subsequent `bat` command will simply run as expected since the docker container will have already been created.

It is __*NOT*__ recommended, but if you really don't want to setup a bash function then you can run the `bat` docker image as an executable container like:

```bash
docker run -it --rm -e BAT_THEME -e BAT_STYLE -e BAT_TABS -v "$HOME/.config/bat/config:/root/.config/bat/config" -v "$(pwd):/myapp" danlynn/bat myFile.js
```

### Docker-Specific Issues

Since all dependencies associated with running `bat` are included in the docker container, you don't need to install anything on your local machine - except maybe the bash function.

This means that even though you might not have command-line git installed locally, the git support required to show the diffs still works because git is included in the docker container.

If you get a message like:

```bash
[bat error]: No such file or directory (os error 2)
```

Then you have probably tried a complex `bat` command with multiple args and a file outside of the current directory tree (eg: `bat -A ../../file`).  The `bat` bash function is setup to handle all use cases when using bat with a single arg like:

```bash
$ bat ../../Documents/temp/CORE-SETUP/setup
$ bat ~/.ssh/config
$ bat CORE-SETUP/setup
```

If, however, you are using multiple args in combination with `..` or `~` or and absolute path (eg: `/usr/local/file`) then you may run into some issues due to the nature of sharing the view of your local file system into the docker container where the bat command is actually running.

On the other hand, if you are using bat on a file in your current directory's subtree then pretty much anything will work just fine:

```bash
$ bat -A --style="numbers" CORE-SETUP/setup
```

Similarly, if you are trying to `bat` a file which is a soft link or is in a sub directory that is soft linked then it __*may*__ fail if those soft links are pointed at files which are not in the directory tree of the current directory.

Taking these "gotcha's" into account, 99.9% of normal `bat` use cases will work just fine.  So, don't sweat it and enjoy `bat`!
