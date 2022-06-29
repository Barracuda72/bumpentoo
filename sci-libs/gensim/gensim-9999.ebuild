# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9,10} )

inherit distutils-r1 git-r3

DESCRIPTION="Gensim is a Python library for topic modelling, document indexing and similarity retrieval with large corpora. Target audience is the natural language processing (NLP) and information retrieval (IR) community."
HOMEPAGE="https://radimrehurek.com/gensim/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/RaRe-Technologies/gensim"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="
	>=dev-python/numpy-1.3
	>=dev-python/scipy-0.7
	sci-libs/smart_open
	dev-python/boto
	dev-python/boto3
	"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
