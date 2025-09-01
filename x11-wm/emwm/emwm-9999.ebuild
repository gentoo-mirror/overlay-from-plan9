# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit toolchain-funcs

DESCRIPTION="EMWM is a fork of the Motif Window Manager with fixes and enhancements."
HOMEPAGE="https://fastestcode.org/emwm.html"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/alx210/${PN}.git"
else
	SRC_URI="https://fastestcode.org/dl/${PN}-src-${PV}.tar.xz"
	KEYWORDS="amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv x86"
	S="${WORKDIR}/${PN}-src-${PV}"
fi

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXt
	x11-libs/libXrandr
	x11-libs/libXinerama
	x11-libs/motif[xft]
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
"

src_prepare() {
	default

	sed -i \
		-e 's|^PREFIX = /usr$|PREFIX = \${DESTDIR}\${EPREFIX}/usr|' \
		-e 's|^RCDIR = /etc/X11$|RCDIR = \${DESTDIR}\${EPREFIX}/etc/X11|' \
		-e 's|^APPLRESDIR = /etc/X11/app-defaults$|APPLRESDIR = \${RCDIR}/app-defaults|' \
		-e 's|^INCDIRS =.*|INCDIRS =|' \
		-e 's|^LIBDIRS =.*|LIBDIRS =|' \
		-e 's|^CFLAGS =|CFLAGS +=|' \
		-e 's| -O2 | |g' \
		mf/Makefile.Linux || die

	sed -i 's/install -m/install -Dm/g' src/common.mf || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${ED}" install

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/emwm.desktop

	dodoc README
}
