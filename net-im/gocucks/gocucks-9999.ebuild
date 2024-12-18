EAPI=8

inherit go-module
inherit git-r3

DESCRIPTION="Matrix client for chuds"
HOMEPAGE="https://git.thisisjoes.site/loliglitch/${PN}"
RESTRICT="network-sandbox"
EGIT_REPO_URI="https://git.thisisjoes.site/loliglitch/${PN}"

LICENSE="AGPL-3"
SLOT="0"
IUSE="+encryption"
KEYWORDS="amd64 x86"

DEPEND="encryption? ( dev-libs/olm )"
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/go"

src_compile() {
	use encryption || export CGO_ENABLED=0
	ego build
}

src_install() {
	install -Dm 755 gomuks ${D}/usr/bin/gocucks
}
