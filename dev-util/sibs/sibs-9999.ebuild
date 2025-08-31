# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit git-r3

DESCRIPTION="A simple build system for native languages"
HOMEPAGE="https://git.dec05eba.com/sibs"

EGIT_REPO_URI="https://repo.dec05eba.com/sibs"
EGIT_SUBMODULES=( '*' )

LICENSE="GPL-3"
SLOT="0"

BDEPEND="
	dev-build/ninja
	dev-build/cmake
	dev-util/ccache
"
DEPEND="
	${COMMON_DEPENDS}
	net-misc/curl
	app-arch/libarchive
"
RDEPEND="${DEPEND}"

src_compile(){
	mkdir cmake/release
	cd cmake/release
	cmake -G Ninja -DCMAKE_BUILD_TYPE=Release ../../
	ninja
}

src_install() {
	dobin cmake/release/sibs
}
