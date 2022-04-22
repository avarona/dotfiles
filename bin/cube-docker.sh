#!/bin/bash

# Notes
# This script assumes the monorepo is cloned to folder "~/Cube" on your machine

# Requirements
# Cube Addons is setup per the documentation: https://github.com/cube-planning/add-ins-monorepo/blob/master/readme.md
# AWS key rotation: https://github.com/stefansundin/aws-rotate-key

# Manual
# k | keys -> rotate aws keys
# a | auth -> setup auth setup
# i | install -> install dependencies (outside of docker)
# h | help -> list of optional parameters
# 
# no args = rebuild all docker images
# arg array = rebuild select docker images

# Colors
YELLOW='\033[0;33m'
NC='\033[0m'

# Optional parameters
rotate_keys=false
auth_setup=false
install_deps=false
prune_docker=false

while getopts "kaiph-:" OPT; do
  if [ "$OPT" = "-" ]; then
    OPT="${OPTARG%%=*}"
  fi

  case "$OPT" in
    k|keys) rotate_keys=true;;
    a|auth) auth_setup=true;;
    i|install) install_deps=true;;
    p|prune) prune_docker=true;;
    h|help)
        echo """
          [--keys | -k] Rotate AWS keys
          [--auth | -a] Setup the authentication package
          [--install | -i] Install dependencies outside of docker
        """
      ;;
    ??*) echo "Illegal option --$OPT"; exit 2;;
    ?) exit 2;;
  esac
done

# AWS keys
if [ "$rotate_keys" == true ]; then
  echo -e "${YELLOW}Rotating aws keys...${NC}";
  cd ~;
  aws-rotate-key -y -d;
fi

# Authentication js-package
if [ "$auth_setup" == true ]; then
  echo -e "${YELLOW}Running auth setup...${NC}";
  cd ~/Cube/js-packages;
  ./bin/setup-npm;
fi

# Cube monorepo
cd ~/Cube/add-ins-monorepo;

if [ "$install_deps" == true ]; then
  echo -e "${YELLOW}Installing dependencies...${NC}";
  npm install;
fi

if [ "$prune_docker" == true ]; then
  echo -e "${YELLOW}Pruning docker...${NC}";
  docker kill $(docker ps -q); # Stop containers
  docker rm $(docker ps -a -q); # Remove containers
  docker image prune -a -f; # Remove images
fi

echo -e "${YELLOW}Rebuilding docker...${NC}";
docker-compose build --build-arg NPM_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain cube --domain-owner 947364778009 --query authorizationToken --output text` $@;
docker-compose up -d $@;

echo -e "${YELLOW}Docker rebuilt${NC}";
