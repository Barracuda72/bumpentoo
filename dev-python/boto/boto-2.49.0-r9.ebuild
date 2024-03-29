# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8,9,10,11} )

inherit distutils-r1

DESCRIPTION="Amazon Web Services API"
HOMEPAGE="https://github.com/boto/boto https://pypi.org/project/boto/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

# requires Amazon Web Services keys to pass some tests
RESTRICT="test"

python_test() {
	"${PYTHON}" tests/test.py -v || die "Tests fail with ${EPYTHON}"
}
