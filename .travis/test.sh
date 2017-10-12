#!/bin/bash
set -e

if [ -f requirements.yml ]
then
  ansible-galaxy install -r requirements.yml -p .molecule/roles/.
fi

molecule syntax
molecule create
molecule converge
molecule idempotence
molecule verify
molecule destroy