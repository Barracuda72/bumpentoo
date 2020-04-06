# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1 git-r3

EGIT_HAS_SUBMODULES=1
EGIT_REPO_URI="https://github.com/kaitai-io/kaitai_struct_python_runtime"

DESCRIPTION="Kaitai Struct runtime for Python"
HOMEPAGE="https://kaitai.io/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="<=dev-python/setuptools-46.0.0[${PYTHON_USEDEP}]"
