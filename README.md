# auto-songbook
This is a simple framework for utilization of LaTeX songs package.

# Prerequisities
* Linux (may work on Windows as well, but need to rewrite corresponding shell scripts)
* LaTeX
* [songbook](https://ctan.org/pkg/songbook?lang=en) LaTeX package

# Usage

Write your songs with chords in *LaTeX songbook* syntax, please see the examples in the songs directory.

## Local Setup (ubuntu)

On ubuntu, install particular `texlive-*` packages:

```bash
apt install texlive-xetex texlive-music
```

Then use one of the provided shell scripts to produce the pdf output:

```shell
make-from-dir.sh /path/to/your/song/dir
```
or
```shell
make-from-list.sh /path/to/your/playlist
```

where playlist file contains the paths to each song file. The latter method is particularly useful if you care about the order of the songs in the songbook.

## Using Docker (recommended)

Use some docker image with preinstalled `xelatex` environment, e.g. [vipintm/xelatex](https://hub.docker.com/r/vipintm/xelatex).

```bash
docker pull vipintm/xelatex:latest
docker run -v my_local_path/auto-songbook:/asb -it vipintm/xelatex:latest
```

... and inside docker container:

```bash
cd /asb && ./make-from-dir.sh /path/to/your/song/dir
```

## Using GitHub Actions

Automatic build is also running as a part of this repository. You may download the produced output as an GitHub Actions artifact.
