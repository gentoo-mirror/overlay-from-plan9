# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit git-r3

DESCRIPTION="Automatic key repeat rate/delay configuration for hotplugged keyboards."
HOMEPAGE="https://github.com/SFTtech/xautocfg"
EGIT_REPO_URI="https://github.com/SFTtech/xautocfg"

LICENSE="GPL-3"
SLOT="0"

PATCHES=(
	"${FILESDIR}/use-etc-config.patch"
)

DEPEND="
	x11-libs/libX11
	x11-libs/libXi
	sys-devel/gcc
"
RDEPEND="${DEPEND}"

src_install() {
	insinto /etc
	doins etc/xautocfg.cfg
	dobin xautocfg
}
