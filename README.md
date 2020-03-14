# bumpentoo
Direct and simple version bumps for packages of my interest

# Summary
This repo contains the following:

- Bumped version of packages from main repo or another overlays that matters to me
- Ebuilds of packages tuned to satisfy my needs (e.g. package supports Python 3.8 but ebuild in main tree still declare support only for 3.7)
- Some stale ebuilds from the Web that I use
- Some hand-written ebuilds for packages not present in main repo nor any overlays

Overall, the only rule is "I use it, so I publish it here".

# How to add this overlay

- Insert `https://github.com/Barracuda72/bumpentoo/raw/master/repositories.xml` into `overlay` section in `/etc/layman/layman.cfg`
- Run `layman -S` and then `layman -a bumpentoo`

# Reporting bugs

The ebuilds might not work for you; but they at least work for me (Gentoo GNU/Linux ~amd64 17.1).

However, if you want to improve my quick & dirty hacks, use GitHub Issues for bug reporting or (even better) create a pull request.
