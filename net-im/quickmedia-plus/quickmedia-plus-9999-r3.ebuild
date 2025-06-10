EAPI=8

HOMEPAGE="https://git.dec05eba.com/QuickMedia"
DESCRIPTION="QuickMedia with improved emojis and more"

SRC_URI="https://plan9.rocks/archive/twemoji.tar.gz -> twemoji-plus.tar.gz"
inherit git-r3
EGIT_REPO_URI="https://repo.dec05eba.com/QuickMedia"
EGIT_CLONE_TYPE="shallow"
EGIT_SUBMODULES=( '*' )
KEYWORDS="amd64 x86"

LICENSE="GPL-3"
SLOT="0"

PATCHES=(
	"${FILESDIR}/authenticated-media.patch"
	"${FILESDIR}/emoji.patch"
	"${FILESDIR}/length.patch"
	"${FILESDIR}/bot-command.patch"
	"${FILESDIR}/quickmedia-reply-encrypt.patch"
	"${FILESDIR}/config.patch"
	"${FILESDIR}/theme.patch"
)

BDEPEND="
	dev-util/sibs
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

src_compile() {
	sibs build --release video_player
	sibs build --release
}

src_install() {
	install -Dm755 "video_player/sibs-build/$(sibs platform)/release/quickmedia-video-player" "${D}/usr/bin/quickmedia-video-player"
	install -Dm755 "sibs-build/$(sibs platform)/release/quickmedia" "${D}/usr/bin/quickmedia"
	ln -sf "/usr/bin/quickmedia" "${D}/usr/bin/qm"
	install -Dm644 boards.json "${D}/usr/share/quickmedia/boards.json"
	install -Dm644 example-config.json "${D}/usr/share/quickmedia/example-config.json"
	install -Dm644 README.md "${D}/usr/share/quickmedia/README.md"
	install -Dm644 mpv/fonts/Material-Design-Iconic-Font.ttf "${D}/usr/share/quickmedia/mpv/fonts/Material-Design-Iconic-Font.ttf"
	install -Dm644 mpv/scripts/mordenx.lua "${D}/usr/share/quickmedia/mpv/scripts/mordenx.lua"
	install -Dm644 mpv/scripts/ytdl_hook.lua "${D}/usr/share/quickmedia/mpv/scripts/ytdl_hook.lua"
	install -Dm644 mpv/input.conf "${D}/usr/share/quickmedia/mpv/input.conf"
	install -Dm644 mpv/mpv.conf "${D}/usr/share/quickmedia/mpv/mpv.conf"
	install -Dm755 "${FILESDIR}/qmm" "${D}/usr/bin/qmm"
	install -Dm644 "${FILESDIR}/black.json" "${D}/usr/share/quickmedia/themes/black.json"

	for file in images/* icons/* shaders/* themes/* emoji/*; do
		install -Dm644 "$file" "${D}/usr/share/quickmedia/$file"
	done

	for file in launcher/*; do
		filename=$(basename "$file")
		install -Dm644 "$file" "${D}/usr/share/applications/$filename"
	done
}
