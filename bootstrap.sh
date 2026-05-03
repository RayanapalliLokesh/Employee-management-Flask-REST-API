#!/usr/bin/env bash

set -e  # exit on error
set -u  # treat unset vars as errors
set -o pipefail # catch errors in pipelines

GREEN='\033[0;32m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[+] $1${NC}"
}

update_system() {
    log "Updating system packages..."
    sudo apt-get update -y
    sudo apt-get upgrade -y
}

install_basic_tools() {
    log "Installing basic tools (curl, wget, unzip, git, make, python3, pip, venv)..."
    sudo apt-get install -y \
        curl wget unzip git make \
        python3 python3-pip python3-venv \
        software-properties-common apt-transport-https ca-certificates gnupg lsb-release
    
    source venv/bin/activate
    sudo pip install -r requirements.txt
}


main() {
    update_system
    install_basic_tools
}

main "$@"