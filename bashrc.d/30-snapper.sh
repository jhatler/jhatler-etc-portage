#!/bin/bash

Snapper_preinst() {
	if [ -z "${REPLACING_VERSIONS}" ]; then
		SNAPPER_DESC="Installing ${CATEGORY}/${PF}"
	else
		SNAPPER_DESC="Upgrading to ${CATEGORY}/${PF} replacing version(s) ${REPLACING_VERSIONS}"
	fi

	SNAPPER_NUMBER=`snapper -c gentoo create -t pre -p -d "${SNAPPER_DESC}" -c number`
}

Snapper_postinst() {
	snapper -c gentoo create -t post --pre-number "${SNAPPER_NUMBER}" -d "${SNAPPER_DESC}" -c number
}

BashrcdPhase preinst Snapper_preinst
BashrcdPhase postinst Snapper_postinst
