EAPI=8

DESCRIPTION="A custom GoldSrc engine implementation"
HOMEPAGE="https://xash.su"

inherit git-r3
EGIT_REPO_URI="https://github.com/FWGS/xash3d-fwgs"
EGIT_SUBMODULES=( '*' )

LICENSE="GPL-3"
SLOT="0"

BDEPEND="
	dev-build/make
	sys-devel/binutils
	dev-lang/python
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
	install -Dm755 "${FILESDIR}/xash3d" "${D}/usr/bin/xash3d"
	./waf install --strip --destdir="${D}/opt/xash3d/"
	install -Dm755 "3rdparty/vgui_support/vgui-dev/lib/vgui.so" "${D}/opt/xash3d/vgui.so"
}
