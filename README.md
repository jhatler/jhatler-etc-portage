# The Gentoo Portage Configs of @jhatler

This repository contains my personal Portage configuration files. It is intended to be used with
[my Gentoo setup guide for a Dell Precision 7540](https://github.com/jhatler/gentoo-precision-7540).

The branch names in this repo are non-standard. They are named after the
system the branch is intended to be used on. For example, the main branch
is named `precision-7540` because it is intended to be used on my Dell
Precision 7540 laptop which is the system I use most often.

## Portage Repositories

This repo configures Portage to use the following repositories via Git:
- [Gentoo's official Portage tree](https://github.com/gentoo/gentoo)
- [My fork of the GentooLTO overlay project](https://github.com/jhatler/gentooLTO)
  - [The mv overlay](https://github.com/gentoo-mirror/mv) as a dependency
- [My personal Portage overlay](https://github.com/jhatler/jhatler-overlay)

## Testing

The ```test``` FEATURES flag is enabled in this configuration so all packages
have their tests run during the ebuild process. Much of the configuration in
this repo is related to supporting those tests and debugging the issues that
arise from them. When a package fails its tests, some of the actions I might
take are:

- Repeat the tests with various optimizations disabled. If this fixes a test
  failure, I will ratify the changes in my fork of the GentooLTO overlay.
- See if the test failure is known in the Gentoo or project bug tracker. If it
  is, any patches that address the issue will be applied by adding them here.
- Determine if the tests fail to something specific to my system. If so, I will
  add custom patches here or move the package to my personal overlay to modify
  the ebuild.
- Begrudingly disable the tests in the ebuild. This is a last resort and I
  try to avoid it as much as possible.

Time and attention span permitting, I will try to report issues uptream along with
any patches I produce.

## World Files

Normally, the set of packages installed on a system is tracked in the
`/var/lib/portage/world` file, and the installed sets are tracked in the
`/var/lib/portage/world_sets` file. However, I prefer to track these files in
`/etc/portage` so they can be checked into version control. You'll find both
in the `world` directory of this repo. I remove the files from `/var/lib/portage`
and symlink them to the files here. This has the added benefit of allowing me
to track the changes to my installed packages along with their portage configs.

## GentooLTO Overlay

Many of the files in this repo are symlinks to files in my fork of the GentooLTO overlay.
The overlay is designed that way so when ```emerge --sync``` is run, the files in this
repo are updated automatically without needed to ebuild anything. Use the link below if
you'd like to see what I've done with my fork. Most of my changes are related to testing
the historical workarounds maintained in the overlay, removing the ones that are no longer
needed, and adding new ones as I run package tests. You can find that work in the 
```workaroundCleanup``` branch of my fork.

[jhatler/GentooLTO](https://github.com/jhatler/GentooLTO)

## Patches and Configs of Note

* `make.conf` is optimized for an Intel Core i9-9980HK CPU with 64GB of RAM. ([1f545d8](https://github.com/jhatler/jhatler-etc-portage/commit/1f545d8))
* `dev-libs/libaio` tests fail intermittently when run on a BTRFS filesystem with checksums enabled. ([a5b12f4](https://github.com/jhatler/jhatler-etc-portage/commit/a5b12f4))
* I fixed a bug in `sys-libs/glibc` related to the detection of the Hardware Lock Elision (HLE) CPU feature. ([ac77f05](https://github.com/jhatler/jhatler-etc-portage/commit/ac77f05))
  * I need to submit this upstream still since it affects the latest versions as well.
* A `sys-fs/e2fsprogs` tests fails when run on a BTRFS filesystem. ([02138bc](https://github.com/jhatler/jhatler-etc-portage/commit/02138bc))
* Python 3.12 and Ruby 3.3 used exclusively (my personal overlay contains patches to support this).
