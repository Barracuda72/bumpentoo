# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="Reimplementation of portions of the pygame API using SDL2"
HOMEPAGE="https://github.com/renpy/pygame_sdl2"
SRC_URI="http://www.renpy.org/dl/${PV}/pygame_sdl2-2.1.0-for-renpy-${PV}.tar.gz"

LICENSE="LGPL-2.1 ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/numpy-python2[${PYTHON_USEDEP}]
	media-libs/libpng:0
	media-libs/libsdl2[video]
	media-libs/sdl2-image[png,jpeg]
	media-libs/sdl2-mixer
	media-libs/sdl2-ttf
	virtual/jpeg:62
"
DEPEND="${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]"

S=${WORKDIR}/pygame_sdl2-2.1.0-for-renpy-${PV}

# PyGame distribution for this version has some pregenerated files; we need to
# remove them
python_prepare_all()
{
	cd ${S}
	rm -r gen gen3

	distutils-r1_python_prepare_all
}

