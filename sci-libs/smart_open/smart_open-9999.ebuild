# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_6 python3_8 python3_9 python3_10 )

inherit distutils-r1 git-r3

DESCRIPTION="smart_open is a Python 2 & Python 3 library for efficient streaming of very large files from/to S3, HDFS, WebHDFS, HTTP, or local (compressed) files."
HOMEPAGE="https://github.com/RaRe-Technologies/smart_open"
SRC_URI=""
EGIT_REPO_URI="https://github.com/RaRe-Technologies/smart_open"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="
	"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
