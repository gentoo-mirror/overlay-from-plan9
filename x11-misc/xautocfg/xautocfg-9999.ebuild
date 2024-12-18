EAPI=8
inherit git-r3
DESCRIPTION="Automatic key repeat rate/delay configuration for hotplugged keyboards."
HOMEPAGE="https://github.com/SFTtech/xautocfg"
EGIT_REPO_URI="https://github.com/SFTtech/xautocfg"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

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
	install -Dm644 etc/xautocfg.cfg "${D}"/etc/xautocfg.cfg
	install -Dm755 xautocfg "${D}"/usr/bin/xautocfg
}
