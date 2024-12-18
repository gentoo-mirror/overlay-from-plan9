# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Utilities from coreboot"
HOMEPAGE="https://www.coreboot.org/"
SRC_URI="https://coreboot.org/releases/coreboot-${PV}.tar.xz"

LICENSE="GPL-2+ GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="sys-apps/pciutils
	sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/coreboot-${PV}"
PATCHES=(
	"${FILESDIR}"/${PN}-${PV}-flags.patch
)

# selection from README.md that seem useful outside coreboot
coreboot_utils=(
	cbfstool
	cbmem
	chromeos
	ectool
	ifdtool
	intelmetool
#	inteltool broken for now
	me_cleaner
	nvramtool
	pmh7tool
	superiotool
	spkmodem_recv
)

src_prepare() {
	default
	# drop some CFLAGS that hurt compilation on modern toolchains or
	# force optimisation
	# can't do this in one sed, because it all happens back-to-back
	for e in '-O[01234567s]' '-g' '-Werror' '-ansi' '-pendantic' ; do
		sed -i -e 's/\( \|=\)'"${e}"'\( \|$\)/\1/g' util/*/Makefile{.inc,} \
			|| die
	done
}

src_compile() {
	tc-export CC
	export HOSTCFLAGS="${CFLAGS}"
	for tool in ${coreboot_utils[*]} ; do
		[[ -f util/${tool}/Makefile ]] || continue
		emake -C util/${tool} V=1
	done
}

src_install() {
	exeinto /usr/sbin
	for tool in ${coreboot_utils[*]} ; do
		[[ -e util/${tool}/${tool} ]]    && doexe util/${tool}/${tool}
		[[ -e util/${tool}/${tool}.py ]] && doexe util/${tool}/${tool}.py
		[[ -e util/${tool}/${tool}.8 ]]  && doman util/${tool}/${tool}.8
		[[ -d util/${tool}/man ]]        && doman util/${tool}/man/*.[12345678]
	done
}
