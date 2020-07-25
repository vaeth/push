#!/usr/bin/env cat
# (C) Martin V\"ath <martin@mvath.de>
# SPDX-License-Identifier: BSD-3-Clause

Push() {
	case $1 in
	-c)
		PushA_=
		shift;;
	*)
		eval PushA_=\$$1;;
	esac
	PushB_=$1
	shift
	for PushE_
	do	[ -z "${PushA_:++}" ] || PushA_="$PushA_ "
		unset PushF_
		case ${PushE_:-=} in
		[=~]*)
			PushF_=false;;
		esac
		PushC_=$PushE_
		while PushD_=${PushC_%%\'*}
		do	if ${PushF_-:} && case $PushD_ in
			*[!-+=~@%/:.,_0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]*)
				false;;
			esac
			then	PushA_=$PushA_$PushD_
			else	PushA_="$PushA_'$PushD_'"
				unset PushF_
			fi
			[ x"$PushD_" = x"$PushC_" ] && break || \
			PushA_=$PushA_\\\'
			PushC_=${PushC_#*\'}
		done
	done
	eval "$PushB_=\$PushA_
	unset PushA_ PushB_ PushC_ PushD_ PushE_
	[ -n \"\${$PushB_:++}\" ]" || return 1
}
