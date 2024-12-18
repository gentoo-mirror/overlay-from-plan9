EAPI=8

inherit font

DESCRIPTION="A bitmap programming font optimized for coziness"
HOMEPAGE="https://github.com/slavfox/Cozette"
SRC_URI="https://github.com/slavfox/Cozette/releases/download/v.${PV}/CozetteFonts-v-${PV//./-}.zip"

SLOT="0"
LICENSE="MIT"
KEYWORDS="amd64 x86"

BDEPEND="app-arch/unzip"
S="${WORKDIR}/CozetteFonts"

FONT_SUFFIX="otb"
