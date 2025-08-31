# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit go-module bash-completion-r1

DESCRIPTION="Go minifier for web formats"
HOMEPAGE="https://github.com/tdewolff/minify"

if [[ "${PV}" != 9999 ]] ; then
	SRC_URI="
		https://github.com/tdewolff/minify/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/tdewolff/minify/releases/download/v${PV}/${PN}-deps.tar.xz
	"
	S="${WORKDIR}/${P}"
	KEYWORDS="amd64 x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tdewolff/${PN}"
	EGIT_BRANCH="master"
fi

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-lang/go"

src_unpack() {
	if [[ "${PV}" != 9999 ]] ; then
		default
	else
		git-r3_src_unpack
		go-module_live_vendor
	fi
}

src_compile() {
	ego build -trimpath -buildmode=pie -mod=readonly -modcacherw -ldflags \
		"-linkmode external -extldflags \"${LDFLAGS}\" -X 'main.Version=v${PV}'" \
		-o minify_bin ./cmd/minify
}

src_install() {
	newbin minify_bin minify
	newbashcomp cmd/minify/bash_completion minify
}
