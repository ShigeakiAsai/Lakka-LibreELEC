#!/bin/bash

# This script downloads a tarball of libretro package (packages/libretro) and extracts
# this tarball to sources/<package> folder.
# It is usefull in cases when the core repository was force-pushed and it is not possible
# to clone / checkout the the desired commit, which breaks the build.

# Where are the tarballs hosted
URL="https://nightly.builds.lakka.tv"
PKGPATHS="\
	packages/lakka/retroarch_base \
	packages/lakka/libretro_cores \
	"
PRG="\
	wget \
	"

# Check arguments and print usage
[ $# -ne 1 ] && {
	echo "Usage:"
	echo "$0 <package>"
	echo ""
	echo "Download tarball from ${URL} and store it in sources/<package> folder"
	exit 1
}

PKG=${1}
PKG_PATH=""

# Check if there is such package
for FINDPATH in ${PKGPATHS} ; do
	if [ -d ${FINDPATH}/${PKG} ] ; then
		PKG_PATH=${FINDPATH}/${PKG}
		break
	fi
done

[ -z "${PKG_PATH}" ] && {
	echo "There is no package '${PKG}' in"
	for FINDPATH in ${PKGPATHS} ; do
		echo "- ${FINDPATH}"
	done
	exit 2
}

# Check if we have package.mk
[ ! -f ${PKG_PATH}/package.mk ] && {
	echo "Missing package.mk in ${PKG_PATH}"
	exit 3
}

# Import package properties
source ${PKG_PATH}/package.mk 2>&1 >/dev/null

# Check for package version, URL and that URL is git repo
[ -z "${PKG_VERSION}" ] && {
	echo "No PKG_VERSION set in ${PKG_PATH}/package.mk"
	exit 4
}

[ -z "${PKG_URL}" ] && {
	echo "No PKG_URL set in ${PKG_PATH}/package.mk"
	exit 4
}

[ "${PKG_URL: -4}" = ".git" -o "${PKG_URL:0:6}" = "git://" ] || {
	echo "PKG_URL (${PKG_URL}) is not a git repository"
	exit 4
}

FILENAME=${PKG}-${PKG_VERSION}.tar.xz
FILEPATH=sources/${PKG}/${FILENAME}
STAMPFILE=${FILENAME}.gitstamp
STAMPPATH=sources/${PKG}/${STAMPFILE}
LINKFILE=${URL}/sources/${PKG}/${FILENAME}
LINKSTAMP=${URL}/sources/${PKG}/${STAMPFILE}

# Do not continue when a tarball is already present in the sources folder
# (also safety catch in case this script is started on the server, where the tarballs are hosted)
[ -f ${FILEPATH} ] && {
	echo "There is already ${FILEPATH} - remove it and try again"
	exit 5
}

[ -f ${STAMPPATH} ] && {
	echo "There is already ${STAMPPATH} - remove it and try again"
	exit 5
}

# Create folder in case it does not exist already
if [ ! -d sources/${PKG} ]
then
	if [ ! -f sources/${PKG} ]
	then
		mkdir -p sources/${PKG}
	else
		echo "Cannot create folder sources/${PKG} - file exists"
		exit 6
	fi
fi

# Check if we have programs
[ -z "$(which ${PRG} 2>/dev/null)" ] && {
	echo "Please install ${PRG}"
	exit 7
}

# Download the tarball
echo -e "Downloading archive\n\tfrom\n${LINKFILE}\n\tto\n${FILEPATH}"
wget --quiet -O ${FILEPATH} ${LINKFILE}

[ ${?} -gt 0 ] && {
	echo "Error downloading ${LINKFILE}"
	exit 8
}

# Download the stamp file
echo -e "\nDownload stamp file\n\tfrom\n${LINKSTAMP}\n\tto\n${STAMPPATH}"
wget --quiet -O ${STAMPPATH} ${LINKSTAMP}

[ ${?} -gt 0 ] && {
	echo "Error downloading ${LINKSTAMP}"
	exit 8
}

# And we are done
echo "Done"
