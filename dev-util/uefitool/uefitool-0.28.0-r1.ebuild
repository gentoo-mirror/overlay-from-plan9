# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit qmake-utils desktop xdg

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
	newbin UEFITool uefitool

	domenu "${FILESDIR}"/uefitool.desktop
	local x
	for x in 16 32 48 64 128 256; do
		newicon -s ${x} "${FILESDIR}"/${PN}_${x}x${x}.png uefitool.png
	done
}
