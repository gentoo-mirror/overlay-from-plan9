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
	install -Dm 755 "build/umskt" "${D}/usr/bin/umskt"
}
