#!/usr/bin/env bash
# Copyright 2016 Christoph Reiter
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# Taken from Quod Libet and modified for Parlatype by Gabor Karsay.

DIR="$( cd "$( dirname "$0" )" && pwd )"
source "$DIR"/_base.sh

function main {
    local GIT_TAG=${1:-"main"}

    [[ -d "${BUILD_ROOT}" ]] && (echo "${BUILD_ROOT} already exists"; exit 1)

    # started from the wrong env -> switch
    if [ $(echo "$MSYSTEM" | tr '[A-Z]' '[a-z]') != "$MINGW" ]; then
        "/${MINGW}.exe" "$0" "$1"
        exit $?
    fi

    install_pre_deps
    create_root
    install_deps
    cleanup_before
    install_parlatype "$GIT_TAG"
    cleanup_after
    build_installer
}

main "$@";
