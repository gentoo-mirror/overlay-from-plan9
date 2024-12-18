EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake

HOMEPAGE="https://github.com/UMSKT/UMSKT"
DESCRIPTION="Universal MS Key Toolkit"

inherit git-r3
EGIT_REPO_URI="https://github.com/UMSKT/UMSKT"
EGIT_CLONE_TYPE="shallow"
EGIT_SUBMODULES=( '*' )
KEYWORDS="amd64 x86"


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

# Can;t figure it out, let's just hardcode it...
src_configure() {
	cd "${BUILD_DIR}"
	cmake ..
}

src_install() {
	install -Dm 755 "build/umskt" "${D}/usr/bin/umskt"
}
