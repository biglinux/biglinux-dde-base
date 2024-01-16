#!/usr/bin/env bash
#shellcheck disable=SC2155,SC2034,SC2094
#shellcheck source=/dev/null

#  ddelib.sh
#  Description: Control Center to help usage of BigLinux dde
#
#  Created: 2024/01/14
#  Altered: 2024/01/16
#
#  Copyright (c) 2024-2024, Vilmar Catafesta <vcatafesta@gmail.com>
#                2024-2024, Tales A. Mendonça <talesam@gmail.com>
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions
#  are met:
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
#  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
#  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
#  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
#  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
#  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
#  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
#  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[[ -n "$LIB_DDELIB_SH" ]] && return
LIB_DDELIB_SH=1

APP="${0##*/}"
_VERSION_="1.0.0-20240116"
LOGGER='/dev/tty8'

function unset_var_proxy() {
	# List of variables to check
	vars=("all_proxy" "auto_proxy" "ftp_proxy" "http_proxy" "https_proxy" "no_proxy")

	# Initialize a string to store the variables to be unset
	unset_vars=""

	# Loop to check each variable
	for var in "${vars[@]}"; do
		# Check if the variable is empty
		if [ -z "${!var}" ]; then
			# Add the variable to the list of variables to be unset
			unset_vars+=" $var"
		fi
	done

	# Check if there are any variables to be unset
	if [ -n "$unset_vars" ]; then
		# Execute the unset command for the empty variables
		unset $unset_vars
	fi
}
export -f unset_var_proxy

function xdebug {
    local script_name0="${0##*/}[${FUNCNAME[0]}]:${BASH_LINENO[0]}"
    local script_name1="${0##*/}[${FUNCNAME[1]}]:${BASH_LINENO[1]}"
    local script_name2="${0##*/}[${FUNCNAME[2]}]:${BASH_LINENO[2]}"

    #   kdialog --title "[xdebug (kdialog)]$0" \
    #       --yes-label="Não" \
    #       --no-label="Sim" \
    #       --warningyesno "\n${*}\n\nContinuar ?\n"
    #   result=$?
    #   [[ $result -eq 0 ]] && exit 1 # botões invertidos
    #   return $result
    #

    yad --title="[xdebug (yad)]$script_name1" \
        --text="${*}\n\nContinuar ?" \
        --center \
        --width=400 \
        --window-icon="$xicon" \
        --buttons-layout=center \
        --on-top \
        --close-on-unfocus \
        --selectable-labels \
        --button="Sim:0" \
        --button="Não:1"
    result=$?
    [[ $result -eq 1 ]] && exit 1
    return $result
}
export -f xdebug
