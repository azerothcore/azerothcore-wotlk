# Release tools used for curl 8.12.1

The following tools and their Debian package version numbers were used to
produce this release tarball.

- autoconf: 2.71-3
- automake: 1:1.16.5-1.3
- libtool: 2.4.7-7~deb12u1
- make: 4.3-4.1
- perl: 5.36.0-7+deb12u1
- git: 1:2.39.5-0+deb12u2

# Reproduce the tarball

- Clone the repo and checkout the tag/commit: curl-8_12_1
- Install the same set of tools + versions as listed above

## Do a standard build

- autoreconf -fi
- ./configure [...]
- make

## Generate the tarball with the same timestamp

- export SOURCE_DATE_EPOCH=1739430900
- ./scripts/maketgz [version]

