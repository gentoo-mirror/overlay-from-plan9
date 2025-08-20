EAPI=8

inherit meson

DESCRIPTION="QuickMedia with improved emojis and more"
HOMEPAGE="https://git.dec05eba.com/QuickMedia"

SRC_URI="
	https://dec05eba.com/files/twemoji-plus.tar.gz
	https://cia.govt.hu/datamining/twemoji-plus.tar.gz
"
inherit git-r3
EGIT_REPO_URI="https://repo.dec05eba.com/QuickMedia"
EGIT_SUBMODULES=( '*' )

LICENSE="GPL-3"
SLOT="0"

PATCHES=(
	"${FILESDIR}/emoji.patch"
	"${FILESDIR}/config.patch"
	"${FILESDIR}/theme.patch"
)

BDEPEND="
	dev-build/meson
	dev-build/ninja
"
DEPEND="
	${COMMON_DEPENDS}
	!net-im/quickmedia
	media-libs/libglvnd
	x11-libs/libX11
	net-misc/curl
	media-video/mpv
	x11-libs/libXrandr
	media-fonts/noto
"
RDEPEND="
	${DEPEND}
	x11-misc/xdg-utils
	media-video/ffmpeg
	dev-util/source-highlight
	net-misc/yt-dlp
"

src_unpack() {
	git-r3_src_unpack
	mkdir -p "${S}/emoji"
	tar -xzf "${DISTDIR}/twemoji-plus.tar.gz" -C "${S}/emoji"
}

src_configure() {
	local emesonargs=(
		-Dinstall_symlink=true
		-Dinstall_emoji=false
		-Dstrip=true
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	insinto /usr/share/quickmedia
	doins -r emoji

	dobin "${FILESDIR}/qmm"
	fperms +x /usr/bin/qmm

	insinto /usr/share/quickmedia/themes
	doins "${FILESDIR}/black.json"
}
