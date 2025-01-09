EAPI=8

inherit git-r3
EGIT_REPO_URI="https://github.com/fries1234/ncsa-mosaic"
EGIT_CLONE_TYPE="shallow"

DESCRIPTION="NCSA Mosaic 2.7"

LICENSE="UoI-NCSA"
SLOT="0"

RDEPEND="x11-libs/libX11
	x11-libs/libXrender
	x11-libs/libXft
	x11-libs/libxkbfile
	x11-libs/motif
	media-libs/libjpeg-turbo
	media-libs/libpng
	x11-libs/libXmu
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
	dev-build/meson
	dev-build/ninja"

src_compile() {
	meson build
	ninja -C build
}

src_install() {
	install -Dm755 build/src/Mosaic ${D}/usr/bin/mosaic
}
