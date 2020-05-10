# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )
PYTHON_REQ_USE="sqlite"

inherit eutils python-single-r1 xdg

DESCRIPTION="A spaced-repetition memory training program (flash cards)"
HOMEPAGE="https://apps.ankiweb.net"
SRC_URI="https://github.com/ankitects/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="latex +recording +sound test"
RESTRICT="!test? ( test )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		|| (
			(
				>=dev-python/PyQt5-5.12[gui,svg,widgets,${PYTHON_MULTI_USEDEP}]
				dev-python/PyQtWebEngine[${PYTHON_MULTI_USEDEP}]
			)
			<dev-python/PyQt5-5.12[gui,svg,webengine,widgets,${PYTHON_MULTI_USEDEP}]
		)
		>=dev-python/httplib2-0.7.4[${PYTHON_MULTI_USEDEP}]
		dev-python/beautifulsoup:4[${PYTHON_MULTI_USEDEP}]
		dev-python/decorator[${PYTHON_MULTI_USEDEP}]
		dev-python/markdown[${PYTHON_MULTI_USEDEP}]
		dev-python/requests[${PYTHON_MULTI_USEDEP}]
		dev-python/send2trash[${PYTHON_MULTI_USEDEP}]
	')
	recording? ( media-sound/lame )
	sound? ( media-video/mpv )
	latex? (
		app-text/texlive
		app-text/dvipng
	)
"
DEPEND="${RDEPEND}
	test? (
		$(python_gen_cond_dep '
			dev-python/nose[${PYTHON_MULTI_USEDEP}]
		')
	)
"

PATCHES=( "${FILESDIR}"/${PN}-2.1.26-web-folder.patch )

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	default
	sed -i -e "s/updates=True/updates=False/" \
		qt/aqt/profiles.py || die
}

src_compile() {
	make build
}

src_test() {
	sed -e "s:nose=nosetests$:nose=\"${EPYTHON} ${EROOT}usr/bin/nosetests\":" \
		-i tools/tests.sh || die
	sed -e "s:nose=nosetests3$:nose=\"${EPYTHON} ${EROOT}usr/bin/nosetests3\":" \
		-i tools/tests.sh || die
	sed -e "s:which nosetests3:which ${EROOT}usr/bin/nosetests3:" \
		-i tools/tests.sh || die
	./tools/tests.sh || die
}

src_install() {
	doicon qt/${PN}.png
	domenu qt/${PN}.desktop
	doman qt/${PN}.1

	dodoc README.md README.development
	python_domodule qt/aqt pylib/anki
	python_newscript qt/runanki anki

	# Localization files go into the anki directory:
	#python_moduleinto anki
	#python_domodule locale

	# not sure if this is correct, but
	# site-packages/aqt/mediasrv.py wants the directory
	insinto /usr/share/anki
	doins -r qt/aqt_data/web
}
