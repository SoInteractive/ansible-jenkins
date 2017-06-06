<p><img src="https://avatars2.githubusercontent.com/u/18436491?v=3&s=200" alt="sointeractive logo" title="sointeractive" align="right" height="60" /></p>

Ansible Role: jenkins
===================

[![Build Status](https://ci.devops.sosoftware.pl/buildStatus/icon?job=SoInteractive/jenkins/master)](https://ci.devops.sosoftware.pl/blue/organizations/jenkins/SoInteractive%2Fjenkins/activity) [![License](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)](https://opensource.org/licenses/MIT) [![Ansible Role](https://img.shields.io/ansible/role/0.svg)](https://galaxy.ansible.com/SoInteractive/jenkins/) [![Twitter URL](https://img.shields.io/twitter/follow/sointeractive.svg?style=social&label=Follow%20%40SoInteractive)](https://twitter.com/sointeractive)

Role to install Jenkins with basic configuration

Example usage
-------------

Use it in a playbook as follows:
```yaml
- hosts: all
  become: true
  roles:
    - SoInteractive.jenkins
```

Have a look at the [defaults/main.yml](defaults/main.yml) for role variables
that can be overridden.

# TODO

  - Java for CentOS support - currently manual java installation is required to use this role.