# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit git-r3

DESCRIPTION="Read the Bible, God's Word, from your terminal"
HOMEPAGE="https://github.com/bontibon/kjv"
SRC_URI="
	apocrypha?   ( fetch+https://github.com/catfromplan9/kjv/raw/master/kjv.tsv )
"
EGIT_REPO_URI="https://github.com/bontibon/kjv"

LICENSE="Unlicense"
SLOT="0"
IUSE="+search-context apocrypha"

DEPEND="
		sys-libs/readline
		sys-apps/less
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	if use search-context; then
		eapply "${FILESDIR}/search-context.patch"
	fi
}

src_unpack() {
	git-r3_src_unpack
	if use apocrypha; then
		cp "${DISTDIR}/kjv.tsv" "${S}/data/kjv.tsv" || die
	fi
}
