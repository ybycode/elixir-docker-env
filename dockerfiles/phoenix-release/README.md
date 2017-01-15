Dockerfile used by the script `make-release.sh`.

It's based on the image "alpine-base" which is just a bare alpine linux with
the package `ncurses-libs` installed.

No other package is added since all what's needed is brought by the distillery
release.
