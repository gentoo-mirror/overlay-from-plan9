EAPI=8

inherit git-r3
EGIT_REPO_URI="https://github.com/BarkyTheDog/catclock"
EGIT_CLONE_TYPE="shallow"

DESCRIPTION="Kit-Cat xclock"

LICENSE="all-rights-reserved"
SLOT="0"

PATCHES=(
	"${FILESDIR}/Makefile.patch"
)

RDEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXrender
	x11-libs/libXft
	x11-libs/libxkbfile
	x11-libs/motif
	x11-libs/libXaw"
DEPEND="${RDEPEND}
	x11-base/xorg-proto"
