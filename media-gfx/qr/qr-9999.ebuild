EAPI=8
inherit git-r3

DESCRIPTION="Generate QR Codes straight in your terminal!"
HOMEPAGE="https://github.com/Y2Z/qr"
EGIT_REPO_URI="https://github.com/Y2Z/qr"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS=""

BDEPEND="media-gfx/qrencode"

src_install() {
	install -Dm755 qr "${D}/usr/bin/qr"
}
