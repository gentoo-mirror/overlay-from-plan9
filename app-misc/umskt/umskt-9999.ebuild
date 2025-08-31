# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit git-r3 cmake

DESCRIPTION="Universal MS Key Toolkit"
HOMEPAGE="https://github.com/UMSKT/UMSKT"

EGIT_REPO_URI="https://github.com/UMSKT/UMSKT"
EGIT_SUBMODULES=( '*' )

LICENSE="AGPL-3"
SLOT="0"

BDEPEND="
	sys-devel/gcc
	dev-build/cmake
	dev-libs/openssl:=[static-libs(+)]
"
DEPEND="
	${BDEPEND}
"
RDEPEND="${DEPEND}"

BUILD_DIR="${S}/build"
CMAKE_USE_DIR="${S}"

src_configure() {
	cd "${BUILD_DIR}"
	cmake ..
}

src_install() {
	dobin build/umskt
}
