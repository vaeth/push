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
	do	[ -z "${PushA_:+-}" ] || PushA_="${PushA_} "
		PushF_=:
		case ${PushE_:-=} in
		[=~]*)	PushF_=false;;
		esac
		PushC_=${PushE_}
		while PushD_=${PushC_%%\'*}
		do	if ${PushF_} && case ${PushD_} in
			*[!-+=~/:.0-9_a-zA-Z]*)	false;;
			esac
			then	PushA_=${PushA_}${PushD_}
			else	PushA_="${PushA_}'${PushD_}'"
				PushF_=:
			fi
			[ "${PushD_}" = "${PushC_}" ] && break
			PushA_="${PushA_}\\'"
			PushC_=${PushC_#*\'}
		done
	done
	eval ${PushB_}=\${PushA_}
	[ -n "${PushA_:+-}" ]
}
