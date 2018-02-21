# auto-songbook
simple framework for utilization of LaTeX songs package

# Prerequisities
* Linux (may work on Windows as well, but need to rewrite corresponding shell scripts)
* LaTeX
* [songbook](https://ctan.org/pkg/songbook?lang=en) LaTeX package

# Usage
Write your songs with chords in +LaTeX songbook+ syntax, please see the examples in the songs directory. Then use one of the provided shell scripts:

```shell
make-from-dir.sh /path/to/your/song/dir
```
or
```shell
make-from-list.sh /path/to/your/playlist
```

where playlist file contains the paths to each song file. This latter method is particularly useful if you care about the order of the songs.
