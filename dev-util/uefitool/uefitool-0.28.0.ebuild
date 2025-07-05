EAPI=8

inherit qmake-utils

DESCRIPTION="UEFI firmware image viewer and editor"
HOMEPAGE="https://github.com/LongSoft/UEFITool"
SRC_URI="https://github.com/LongSoft/UEFITool/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/UEFITool-${PV}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="
	${RDEPEND}
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"

src_configure() {
	eqmake5 .
}

src_install() {
	dobin UEFITool
}
