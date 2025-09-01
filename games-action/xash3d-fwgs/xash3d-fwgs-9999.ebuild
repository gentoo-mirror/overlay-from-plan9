# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )

inherit python-any-r1

DESCRIPTION="A custom GoldSrc engine implementation"
HOMEPAGE="https://xash.su"

inherit git-r3
EGIT_REPO_URI="https://github.com/FWGS/xash3d-fwgs"
EGIT_SUBMODULES=( '*' )

LICENSE="GPL-3"
SLOT="0"

BDEPEND="
	${PYTHON_DEPS}
	dev-build/make
	sys-devel/binutils
	sys-devel/gcc:=[multilib(+),graphite(+)]
"
DEPEND="
	${COMMON_DEPENDS}
	media-libs/freetype:=[abi_x86_32(+)]
	media-libs/fontconfig:=[abi_x86_32(+)]
	media-libs/libpulse:=[abi_x86_32(+)]
	media-libs/libsdl2:=[abi_x86_32(+),opengl(+)]
"
RDEPEND="${DEPEND}"

src_configure(){
	./waf configure -T release --enable-lto --enable-poly-opt
}

src_compile(){
	./waf build
}

src_install() {
	newbin "${FILESDIR}/xash3d" xash3d
	fperms +x /usr/bin/xash3d

	./waf install --strip --destdir="${ED}/opt/xash3d/"

	insinto /opt/xash3d
	doins 3rdparty/vgui_support/vgui-dev/lib/vgui.so
}
