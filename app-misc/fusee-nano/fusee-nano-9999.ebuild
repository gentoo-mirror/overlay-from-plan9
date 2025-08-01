EAPI=8
inherit git-r3

DESCRIPTION="A minimalist re-implementation of the Fusée Gelée exploit. (Zero dependencies)"
HOMEPAGE="https://github.com/DavidBuchanan314/fusee-nano"
EGIT_REPO_URI="https://github.com/DavidBuchanan314/fusee-nano"

LICENSE="MIT"
SLOT="0"

src_install() {
	install -Dm755 fusee-nano "${D}/usr/bin/fusee-nano"
}
