#! /bin/sh
# (C) Martin V\"ath <martin@mvath.de>
# This script is meant to be sourced; the first line is only for editors

Push() {
	case ${1} in
	-c)	shift
		eval ${1}=;;
	esac
	PushB_=${1}
	eval PushA_=\${${1}}
	shift
	for PushE_
	do	PushA_="${PushA_}${PushA_:+ }'"
		PushC_=${PushE_}
		while {
			PushD_=${PushC_%%\'*}
			[ "${PushD_}" != "${PushC_}" ]
		}
		do	PushA_="${PushA_}${PushD_}'\\''"
			PushC_=${PushC_#*\'}
		done
		PushA_="${PushA_}${PushC_}'"
	done
	eval ${PushB_}=\${PushA_}
	[ -n "${PushA_}" ]
}
