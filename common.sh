#!/bin/bash

RUN_FROM=`dirname "$0"`
FB_ROOT_REL="${0%/*}"
FB_ROOT=`cd "${FB_ROOT_REL}"; pwd`
BUILDDIR=""
PROJDIR=""
USED_ARGS=0

function print_usage()
{
    echo "usage: $0 [<project dir> [<build dir>]] [<params ...>]"
}

function check_proj_dir()
{

    # allow the project dir to be a symlink
    if [[ !( -d $1 || -L $1 ) ]]; then
        echo "ERROR: Project directory $1 does not exist."
        print_usage
        exit 1
    fi
}

if [[ "$1" != "" && ! ( "$1" =~ ^- ) ]]; then 
# $1 not empty and doesn't start with '-'
    check_proj_dir "$1"
    PROJDIR="$1"
    USED_ARGS=1
    if [[ "$2" != "" && ! ( "$2" =~ ^- ) ]]; then
    # $2 not empty and doesn't start with '-'
        BUILDDIR="$2"
        USED_ARGS=2
    fi
fi

if [ "$PROJDIR" = "" ]; then
# PROJDIR not set
    PROJDIR="${RUN_FROM}/projects"
fi

if [ "$BUILDDIR" = "" ]; then
# BUILDIR not set
    if [ "$PROJDIR" = "examples" ]; then
        BUILDDIR="${RUN_FROM}/buildex"
    else
        BUILDDIR="${RUN_FROM}/build"
    fi
fi