EAPI=7

inherit go-module
DESCRIPTION="A terminal based Matrix client written in Go"
HOMEPAGE="https://maunium.net/go/gomuks/"

if [[ "${PV}" != 9999 ]] ; then
	SRC_URI="
		https://github.com/tulir/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://codeberg.org/catfromplan9/overlay-files/releases/download/${P}/${P}-vendor.tar.xz
	"
	S="${WORKDIR}/${P}"
	KEYWORDS="amd64 x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tulir/${PN}"
	EGIT_BRANCH="master"
fi

LICENSE="AGPL-3"
SLOT="0"
IUSE="+encryption"

DEPEND="encryption? ( dev-libs/olm )"
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/go"

src_unpack() {
	if [[ "${PV}" != 9999 ]] ; then
		default
	else
		git-r3_src_unpack
		go-module_live_vendor
	fi
}

src_compile() {
	use encryption || export CGO_ENABLED=0
	ego build
}

src_install() {
	dobin ${PN}
}
