EAPI=8

inherit desktop

DESCRIPTION="Private and secure open-source messenger - no user IDs (not even random numbers)"
HOMEPAGE="https://simplex.chat/"

UBUNTU_RELEASE="24.04"

SRC_URI="https://github.com/simplex-chat/simplex-chat/releases/download/v${PV}/${PN%-bin}-ubuntu-${UBUNTU_RELEASE//./_}-x86_64.deb"

S="${WORKDIR}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="-* amd64"

QA_PREBUILT="*"

src_unpack() {
	default
	tar xf data.tar.* || die
}

src_install() {
	insinto /usr/share/pixmaps
	newins opt/simplex/lib/simplex.png simplex-desktop.png

	rm -f opt/simplex/lib/simplex-simplex.desktop opt/simplex/lib/simplex.png

	domenu "${FILESDIR}/simplex-desktop.desktop"

	insinto /opt
	doins -r opt/simplex

	fperms +x /opt/simplex/bin/simplex
	dosym ../../opt/simplex/bin/simplex /usr/bin/simplex-desktop
}
