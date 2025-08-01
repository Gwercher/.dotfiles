#!/usr/bin/env zsh

#======================================================================#
#    _        _                _ _ _         _____ _                   #
#   /_\  _ __| |_  _ _ ___  __| (_) |_ ___  |_   _| |_  ___ _ __  ___  #
#  / _ \| '_ \ ' \| '_/ _ \/ _` | |  _/ -_)   | | | ' \/ -_) '  \/ -_) #
# /_/ \_\ .__/_||_|_| \___/\__,_|_|\__\___|   |_| |_||_\___|_|_|_\___| #
#       |_|                                                            #
#                                                                      #
#                       Aphrodite Terminal Theme                       #
#                 by Sergei Kolesnikov a.k.a. win0err                  #
#                         (customized version)
#                                                                      #
#                        https://kolesnikov.se                         #
#                                                                      #
#======================================================================#


export VIRTUAL_ENV_DISABLE_PROMPT=true
setopt PROMPT_SUBST

aphrodite_get_prompt() {
  echo
#	echo -n "%F{6}%n" # username
#	echo -n "%F{8}@"
#	echo -n "%F{12}%m" # machine name
#	echo -n "%F{8}:"
	echo -n "%F{7}%~"
	echo -n " "

	local git_branch=$(git --no-optional-locks rev-parse --abbrev-ref HEAD 2> /dev/null)
	if [[ -n "$git_branch" ]]; then
		local git_status=$(git --no-optional-locks status --porcelain 2> /dev/null | tail -n 1)
		[[ -n "$git_status" ]] && echo -n "%F{1}" || echo -n "%F{6}"
		echo -n "‹${git_branch}›%f "
	fi

	if [[ -v VIRTUAL_ENV ]]; then
		echo -n "%F{7}["$(basename "$VIRTUAL_ENV")"]%f "
	fi

	if [[ -v APHRODITE_THEME_SHOW_TIME ]]; then
		echo -n "%F{8} [%D{%H:%M:%S}]%f"
	fi

	echo  # new line

	echo -n "%(?.%f.%F{1})"  # if retcode == 0 ? reset : red
	echo -n "%(!.#.$)%f "  # if is_root_user ? # : $
}

export PROMPT='$(aphrodite_get_prompt)'
