EAPI=8

inherit go-module
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
	install -Dm755 minify_bin "${D}/usr/bin/${PN}"
	install -Dm644 "LICENSE" "${D}/usr/share/licenses/${PN}/LICENSE"
	install -Dm644 "cmd/minify/bash_completion" \
		"${D}/usr/share/bash-completion/completions/${PN}"
}
