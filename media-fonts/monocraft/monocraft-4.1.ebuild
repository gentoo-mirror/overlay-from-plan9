# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit font

DESCRIPTION="A monospaced programming font inspired by the Minecraft typeface"
HOMEPAGE="https://github.com/IdreesInc/Monocraft"
SRC_URI="fetch+https://github.com/IdreesInc/Monocraft/releases/download/v${PV}/Monocraft.ttc
	ttf? ( fetch+https://github.com/IdreesInc/Monocraft/releases/download/v${PV}/Monocraft-ttf-otf.zip )"

S="${WORKDIR}"
LICENSE="OFL-1.1"

SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ~riscv x86"
IUSE="ttf"
FONT_SUFFIX="ttc"

BDEPEND="app-arch/unzip"

src_unpack() {
	use ttf && unzip -j "${DISTDIR}/Monocraft-ttf-otf.zip"
	cp "${DISTDIR}/Monocraft.ttc" "${S}" || die "Failed to copy Monocraft.ttc"
}

src_install() {
	use ttf && FONT_SUFFIX="ttc ttf"
	font_src_install
}
