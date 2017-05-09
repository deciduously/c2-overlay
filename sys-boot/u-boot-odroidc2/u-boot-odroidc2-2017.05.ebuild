# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="git://git.denx.de/u-boot.git"

if [[ ${PV} = 9999 ]]; then
        GIT_ECLASS="git-r3"
        EXPERIMENTAL="true"
fi

inherit ${GIT_ECLASS}


DESCRIPTION="Mainline U-Boot for ODROID-C2"
HOMEPAGE="https://www.denx.de/wiki/U-Boot"
#SRC_URI="ftp://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~arm64"
IUSE=""

DEPEND="
	sys-boot/meson-tools
	sys-apps/dtc
	dev-lang/python:2.7
"

RDEPEND="${DEPEND}"


if [[ ${PV} == 9999 ]] ; then
	SRC_URI=""
else
	SRC_URI="ftp://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2"
	S=${WORKDIR}/u-boot-${PV}
	KEYWORDS="~arm ~arm64"
fi


src_compile() {
	emake odroid-c2_defconfig
	emake
}

src_install() {
	dodir /usr/share/u-boot-odroidc2
	insinto /usr/share/u-boot-odroidc2
	
	if [[ ${PV} == 9999 ]] ; then
		newins u-boot.bin u-boot-git.bin
	else
		newins u-boot.bin u-boot-${PV}.bin
	fi
}
