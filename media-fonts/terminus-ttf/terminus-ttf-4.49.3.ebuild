# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit font

DESCRIPTION="TTF version of media-fonts/terminus-font"
HOMEPAGE="https://files.ax86.net/terminus-ttf/ https://files.ax86.net/terminus-ttf/files/"
SRC_URI="fetch+https://files.ax86.net/${PN}/files/$PV/${P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 x86"

BDEPEND="app-arch/unzip"

FONT_SUFFIX="ttf"
