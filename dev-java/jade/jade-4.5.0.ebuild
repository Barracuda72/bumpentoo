# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 #java-pkg-simple

EANT_BUILD_TARGET="lib"
EANT_DOC_TARGET="doc"

DESCRIPTION="JADE is FIPA-compliant Java Agent Development Environment"
HOMEPAGE="http://jade.cselt.it/"
SRC_URI="http://jade.tilab.com/dl.php?file=JADE-src-${PV}.zip -> ${P}.zip"
#SRC_URI="mirror://gentoo/JADE-src-${PV}.zip -> ${P}.zip"

LICENSE="LGPL-2"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE=""

RDEPEND="
	>=virtual/jre-1.6"

DEPEND="
	>=virtual/jdk-1.6
	source? ( app-arch/zip )"

S="${WORKDIR}/${PN}"

JAVA_ENCODING="ISO-8859-1"
JAVA_SRC_DIR="src"

src_install() {
        java-pkg_newjar lib/${PN}.jar ${PN}.jar

        use doc && java-pkg_dojavadoc dist/api
#        use source && java-pkg_dosrc src/java/org
#        use examples && java-pkg_doexamples src/java/examples
}
