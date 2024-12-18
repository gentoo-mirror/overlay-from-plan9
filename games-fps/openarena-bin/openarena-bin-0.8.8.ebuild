EAPI=8

HOMEPAGE="http://openarena.ws/"
DESCRIPTION="A violent, sexy, multiplayer first person shooter based on the ioquake3 engine"

SRC_URI="https://psychz.dl.sourceforge.net/project/oarena/openarena-${PV}.zip?viasf=1 -> openarena-${PV}.zip"
KEYWORDS="amd64 x86"


LICENSE="GPL-3"
SLOT="0"

DEPEND="
	${COMMON_DEPENDS}
	media-libs/libvorbis
	net-misc/curl
	media-libs/openal
	media-libs/libxmp
	media-libs/libsdl
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/openarena-${PV}"

src_configure(){
	rm *.dll *.exe
	rm -rf __MACOSX *.app
}

src_install() {
	install -dm 755 "${D}/opt" "${D}/usr/share/pixmaps/" "${D}/usr/share/applications/" "${D}/usr/bin"
	mv "${S}" "${D}/opt/openarena"
	find "${D}/opt/openarena" -type f -exec chmod 644 {} \;
	find "${D}/opt/openarena" -type d -exec chmod 755 {} \;
	chmod 755 "${D}/opt/openarena/openarena.x86_64" "${D}/opt/openarena/openarena.i386"

	install -Dm 644 "${FILESDIR}/openarena.png" "${D}/usr/share/pixmaps/"
	install -Dm 644 "${FILESDIR}/openarena-server.png" "${D}/usr/share/pixmaps/"
	install -Dm 644 "${FILESDIR}/openarena.desktop" "${D}/usr/share/applications/"
	install -Dm 644 "${FILESDIR}/openarena-server.desktop" "${D}/usr/share/applications/"

	install -Dm 755 "${FILESDIR}/openarena-runner.sh" "${D}/opt/openarena/openarena-runner.sh"
	ln -s /opt/openarena/openarena-runner.sh "${D}/usr/bin/openarena"
	ln -s /opt/openarena/openarena-runner.sh "${D}/usr/bin/openarena-server"
}
