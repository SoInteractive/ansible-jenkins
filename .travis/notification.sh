sudo: required
language: python
services:
  - docker
install:
  - pip install ansible==2.3.2 molecule==1.25.0 docker
script:
  - if [ -f requirements.yml ]; then ansible-galaxy install -r requirements.yml -p .molecule/roles/. ; fi
  - molecule syntax
  - molecule create
  - molecule converge
  - molecule idempotence
  - molecule verify
  - molecule destroy
before_deploy:
  - git config --global user.email "soibot@sointeractive.pl"
  - git config --global user.name "soi-bot"
  - export GIT_TAG=$([[ "$TRAVIS_COMMIT_MESSAGE" =~ ("Merge pull request".*/feature.*) ]] && git describe --abbrev=0 --tags | awk -F '.' '{print $1"."($2+1)"."0}' || git describe --abbrev=0 --tags | awk -F '.' '{print $1"."$2"."($3+1)}')
  - git tag $GIT_TAG -a -m "Generated tag from TravisCI for build $TRAVIS_BUILD_NUMBER"
  - export GIT_URL=$(git config --get remote.origin.url)
  - export GIT_URL=${GIT_URL#*//}
deploy:
  provider: script
  skip_cleanup: true
  script: git push https://${GH_TOKEN}:@${GIT_URL} --tags
  on:
    branch: master
#do not start when tag is added
branches:
  only:
    - master
tags:
  except:
    - /^\d+\.\d+\.\d+$/
notifications:
    webhooks: https://galaxy.ansible.com/api/v1/notifications/
after_success:
  - ./.travis/notification.sh
after_failure:
  - ./.travis/notification.sh
