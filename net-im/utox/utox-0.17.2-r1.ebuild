# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

MY_P="uTox-${PV}"
inherit cmake-utils

MININI_COMMIT="b40dff4924461272f669814da7d0c9fdc8be6d94"
QRCODEGEN_VERSION="1.6.0"

DESCRIPTION="Lightweight Tox client"
HOMEPAGE="https://github.com/uTox/uTox"
SRC_URI="https://github.com/uTox/uTox/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz
https://github.com/nayuki/QR-Code-generator/archive/v${QRCODEGEN_VERSION}.tar.gz -> QR-Code-generator-${QRCODEGEN_VERSION}.tar.gz
https://github.com/compuphase/minIni/archive/${MININI_COMMIT}.tar.gz -> minIni-${MININI_COMMIT}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="+dbus filteraudio test clang asan"
KEYWORDS="~amd64"

RDEPEND="net-libs/tox:0/0.2[av]
	media-libs/freetype
	filteraudio? ( media-libs/libfilteraudio )
	media-libs/libv4l
	media-libs/libvpx
	media-libs/openal
	media-libs/opus
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	dev-libs/libsodium
	dev-libs/stb
	test? ( dev-libs/check )
	clang? ( sys-devel/clang )
	dbus? ( sys-apps/dbus )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${MY_P}-use-system-stb.patch
	"${FILESDIR}"/${MY_P}-workaround-group-chat-crash.patch
)

S="${WORKDIR}/${MY_P}"

src_prepare() {
	#Prevent
	#CMake Error at cmake_install.cmake:36 (file):
	#  file INSTALL cannot find
	#  "/var/tmp/portage/net-im/uTox-0.11.1/work/uTox-0.11.1/utox".
	sed -i "s/^\s*utox$/\$\{CMAKE_CURRENT_BINARY_DIR\}\/utox/g" ${S}/CMakeLists.txt
	mv -v ../QR-Code-generator-${QRCODEGEN_VERSION}/c third-party/qrcodegen/
	mv -v ../minIni-${MININI_COMMIT}/dev/ third-party/minini/

	#epatch_user
	cmake-utils_src_prepare
}

src_configure() {
	if use filteraudio && [ "${PROFILE_IS_HARDENED}" = 1 ]; then
		ewarn "Building µTox with support for filter_audio using hardened profile results in"
		ewarn "crash upon start. For details, see https://github.com/notsecure/uTox/issues/844"
	fi

	ewarn "uTox is known to currently crash with ASAN enabled."
	if use asan ; then
		ewarn "You've enabled ASAN, so be ready for crashes."
	else
		ewarn "Disabling ASAN doesn't fix the issue, just masks it. Beware."
	fi

	local mycmakeargs=( \
		-DENABLE_DBUS=$(usex dbus "ON" "OFF") \
		-DENABLE_FILTERAUDIO=$(usex filteraudio "ON" "OFF")\
		-DENABLE_TESTS=$(usex test "ON" "OFF")\
		-DENABLE_ASAN=$(usex asan "ON" "OFF")\
		-DCMAKE_C_COMPILER=$(usex clang "clang" "gcc")
	)
	cmake-utils_src_configure
}
