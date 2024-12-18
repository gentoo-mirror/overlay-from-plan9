EAPI=8

inherit font

DESCRIPTION="A monospaced programming font inspired by the Minecraft typeface"
HOMEPAGE="https://github.com/IdreesInc/Monocraft"
SRC_URI="https://github.com/IdreesInc/Monocraft/releases/download/v${PV}/Monocraft.ttc
	ttf? ( https://github.com/IdreesInc/Monocraft/releases/download/v${PV}/Monocraft-ttf-otf.zip )"

SLOT="0"
LICENSE="OFL-1.1"
KEYWORDS="amd64 ~arm ~arm64 ~loong ~riscv x86"
IUSE="ttf"

S="${WORKDIR}"
FONT_SUFFIX="ttc"

src_unpack() {
	use ttf && unzip -j "${DISTDIR}/Monocraft-ttf-otf.zip"
	cp "${DISTDIR}/Monocraft.ttc" "${S}" || die "Failed to copy Monocraft.ttc"
}

src_install() {
	use ttf && FONT_SUFFIX="ttc ttf"
	font_src_install
}
