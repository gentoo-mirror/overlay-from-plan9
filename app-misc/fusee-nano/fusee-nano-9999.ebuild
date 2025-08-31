# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

DESCRIPTION="A minimalist re-implementation of the Fusée Gelée exploit. (Zero dependencies)"
HOMEPAGE="https://github.com/DavidBuchanan314/fusee-nano"

if [[ "${PV}" != 9999 ]] ; then
	SRC_URI="https://github.com/DavidBuchanan314/fusee-nano/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}"
	KEYWORDS="amd64 x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/DavidBuchanan314/fusee-nano"
fi

LICENSE="MIT"
SLOT="0"

src_install() {
	dobin ${PN}
}
