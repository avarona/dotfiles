#!/bin/bash

# Notes
# 1. This script assumes the monorepo is cloned to folder "~/Cube" on your machine
# 2. Make this script executable with "chmod u+x <path-to-script>"
# 3. You might want to create an alias in your bashrc/zshrc

# Requirements
# 1. Setup the Cube Addons & clone to "~/Cube": https://github.com/cube-planning/add-ins-monorepo/blob/master/readme.md
# 2. Install the AWS key rotation repo: https://github.com/stefansundin/aws-rotate-key

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

# Print usage when passing -h, --help parameters
showHelp() { 
  echo -e """
  Usage:
  
      ${YELLOW}./cube-docker [OPTS] <container_name(s)>${NC}

      -k , --keys         Rotate AWS keys
      -a , --auth         Setup the authentication package
      -i , --install      Install dependencies outside of docker
      -h , --help         Show usage of script
  """;
  exit 0;
}

# Handle optional parameters
while getopts "kaiph-:" OPT; do
  if [ "$OPT" = "-" ]; then
    OPT="${OPTARG%%=*}"
  fi

  case "$OPT" in
    k|keys) rotate_keys=true;;
    a|auth) auth_setup=true;;
    i|install) install_deps=true;;
    p|prune) prune_docker=true;;
    h|help) showHelp;;
    ??*) echo "Illegal option --$OPT"; exit 2;;
    ?) exit 2;;
  esac
done
shift $((OPTIND-1)) # Remove paramerter from $@

# Rotate AWS keys
if [ "$rotate_keys" == true ]; then
  echo -e "${YELLOW}Rotating aws keys...${NC}";
  cd ~;
  aws-rotate-key -y -d;
fi

# Setup Authentication js-package
if [ "$auth_setup" == true ]; then
  echo -e "${YELLOW}Running auth setup...${NC}";
  cd ~/Cube/js-packages;
  ./bin/setup-npm;
fi

# Cube monorepo
cd ~/Cube/add-ins-monorepo;

# Install dependencies
if [ "$install_deps" == true ]; then
  echo -e "${YELLOW}Installing dependencies...${NC}";
  npm install;
fi

# Prune Docker
if [ "$prune_docker" == true ]; then
  echo -e "${YELLOW}Pruning docker...${NC}";

  container_ids=$(docker ps -a -q)
  for id in $container_ids; do
      echo "$id - container"
      docker stop $id && docker rm -f $id;
  done

  image_ids=$(docker images -a -q)
  for id in $image_ids; do
      echo "$id - image"
      docker image rm -f $id;
  done
fi

# Build Docker image & container
echo -e "${YELLOW}Rebuilding docker...${NC} $@";
docker-compose build --build-arg NPM_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain cube --domain-owner 947364778009 --query authorizationToken --output text` $@;
docker-compose up -d $@;

echo -e "${YELLOW}Docker rebuilt${NC}";
