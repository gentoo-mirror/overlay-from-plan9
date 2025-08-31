# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8
inherit git-r3

DESCRIPTION="NCSA Mosaic 2.7"
HOMEPAGE="https://github.com/catfromplan9/ncsa-mosaic"
EGIT_REPO_URI="https://github.com/catfromplan9/ncsa-mosaic"

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
	x11-libs/libXpm
	media-gfx/sxiv"

DEPEND="${RDEPEND}
	x11-base/xorg-proto
	dev-build/meson
	dev-build/ninja"

src_compile() {
	meson build
	ninja -C build
}

src_install() {
	newbin build/src/Mosaic mosaic
}
