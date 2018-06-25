#!/bin/bash
#
#  LICENSE: Copyright (C) 2018 Abhishek Tamrakar
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
SCRIPT=${0##*/}
RELEASE_FILE="/etc/os-release"
# functions here
info()
{
    printf '\n\e[34m%s\e[0m %s' "INFO" "$@"
}

error()
{
    printf '\n\e[31m%s\e[0m %s' "ERROR" "$@"
    exit 1
}

warn()
{
    printf '\n\e[33m%s\e[0m %s' "WARN" "$@"
}

check_os()
{
    # check OS ID
    [[ -e ${RELEASE_FILE} && -s ${RELEASE_FILE} ]] \
        && \
        . ${RELEASE_FILE} \
        || \
        ID_LIKE=debian
    
    case ${ID_LIKE,,} in
    [dD]ebian ) CMD=apt;;
    [Rr]edhat ) CMD=yum;;
    * ) CMD=apt;;
    esac
}

install_basic()
{
    local basic=(python python-pip ansible)
    for package in ${basic[@]}
    do
        if [[ x$(which ${!package}) = x ]]
        then
            info "Installing package ${!package}"
            $CMD install ${!package} -y
        fi
    done
}

invoke_playbook()
{
    ansible-playbook $@
}

usage()
{
    cat <<EOF

        -h|--help           print this usage and exit
        -d|--dir            playbook dir (default current directory)
        -p|--playbook-path  destination path for new playbook with name (default is $HOME/myplaybook)
        -r|--roles          additional role directories to create (comma separated)
        -c|--copy-default   copy default files (main.yml)

        examples: 
        $SCRIPT -h

        $SCRIPT -d /tmp/ansible-create -p /path/to/new-playbook -r 'database.,webservers,monitoring' -c

EOF
exit 0
}

# main here
if [[ $# -eq 0 ]]
then
   usage
fi

while [ $# -gt 0 ]
do
    case ${1} in
        -h|--help ) usage;;
        -d|--dir ) shift; play=$1;;
        -p|--playbook-path ) shift; playbook_path=$1;;
        -r|--roles ) shift; roles=$1;;
        -c|--copy-default ) iscopy=yes;;
        * ) error "invalid choice $1";;
    esac 
    shift
done

if [[ $(whoami) = "root" ]]
then
    check_os
    install_basic
else
    warn "Skipping package check! run as root, to install ansible, if not installed."
fi

invoke_playbook ${play:-.}/create.yml -e "playbook_path=${playbook_path:-$HOME/myplaybook}" -e "{\"extras\":[${roles:-common}]}" -e "copy_default=${iscopy:-no}"
