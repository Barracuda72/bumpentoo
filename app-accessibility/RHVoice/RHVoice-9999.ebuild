# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9,10,11} )

inherit multilib python-r1 scons-utils toolchain-funcs git-r3

DESCRIPTION="RHVoice is a free and open source speech synthesizer."
HOMEPAGE="https://github.com/Olga-Yakovleva/RHVoice"
SRC_URI=""
EGIT_REPO_URI="https://github.com/Olga-Yakovleva/${PN}"

LICENSE="LGPLv2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="|| (
	media-sound/pulseaudio
	media-libs/libao
	media-libs/portaudio
)"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	python_setup
	escons CC="$(tc-getCC)"
}

src_install() {
	escons LIBDIR=/usr/$(get_libdir) DESTDIR="${D}" install
}
