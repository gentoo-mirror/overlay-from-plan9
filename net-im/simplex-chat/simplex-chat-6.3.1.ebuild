EAPI=8

DESCRIPTION="Private and secure open-source messenger - no user IDs (not even random numbers)"
HOMEPAGE="https://simplex.chat/"

SRC_URI="https://github.com/simplex-chat/simplex-chat/archive/refs/tags/v${PV}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64"

GHC_VERSION="8.10.7"
RESTRICT="network-sandbox"

src_prepare() {
	default

	export GHCUP_INSTALL_BASE_PREFIX="${S}/_ghcup"
	export CABAL_DIR="${S}/.cabal"

	export PATH="${GHCUP_INSTALL_BASE_PREFIX}/.ghcup/bin:${CABAL_DIR}/bin:${PATH}"

	einfo "Installing ghcup locally into ${GHCUP_INSTALL_BASE_PREFIX}..."
	curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org \
		| BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
			BOOTSTRAP_HASKELL_NO_ENV_EXPORT=1 \
			BOOTSTRAP_HASKELL_INSTALL_STACK=0 \
			sh || die "Failed to install ghcup"

	command -v ghcup >/dev/null || die "ghcup not found"

	einfo "Installing GHC ${GHC_VERSION} via ghcup..."
	ghcup install ghc "${GHC_VERSION}" || die "Failed to install GHC ${GHC_VERSION}"
	ghcup set ghc "${GHC_VERSION}" || die "Failed to set GHC ${GHC_VERSION}"

	einfo "Updating the cabal package index..."
	cabal update || die "cabal update failed"
}

src_compile() {
	cabal build || die "cabal build failed"
}

src_install() {
	install -Dm755 $(find dist-newstyle -type f -name 'simplex-chat' -print -quit) "${D}/usr/bin/simplex-chat" || die "Installation of simplex-chat failed"
	# install -Dm644 "${FILESDIR}/SimpleX.desktop" "${D}/usr/share/applications/SimpleX.desktop"
	# install -Dm644 media-logos/simplex-symbol-light.png "${D}/usr/share/pixmaps/simplex.png"
}
