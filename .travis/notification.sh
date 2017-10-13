#!/bin/bash

function success {
  GIT_TAG=$([[ "$TRAVIS_COMMIT_MESSAGE" =~ ("Merge pull request".*/feature.*) ]] && git semver --next-minor || git semver --next-patch )

  if [ "$TRAVIS_PULL_REQUEST" != "false" ]
  then
    export MESSAGE="123"
    #export MESSAGE="Travis [build no. ${TRAVIS_BUILD_NUMBER}](travis-ci.org/${TRAVIS_REPO_SLUG}/builds/${TRAVIS_BUILD_ID}) has finished successfully. Pull request no. ${TRAVIS_PULL_REQUEST} opened by ${GIT_COMMITER} can be found [here](https://github.com/${TRAVIS_REPO_SLUG}/pull/${TRAVIS_PULL_REQUEST})."
  else
    export MESSAGE="456"
    #export MESSAGE="Travis [build no. ${TRAVIS_BUILD_NUMBER}](travis-ci.org/${TRAVIS_REPO_SLUG}/builds/${TRAVIS_BUILD_ID}) has finished successfully. Tag [${GIT_TAG}](https://github.com/${TRAVIS_REPO_SLUG}/releases/tag/${GIT_TAG}) was pushed to master by ${GIT_COMMITER}."
  fi
}

function failure {
  if [ "$TRAVIS_PULL_REQUEST" != "false" ]
  then
    export MESSAGE="Travis [build no. ${TRAVIS_BUILD_NUMBER}](travis-ci.org/${TRAVIS_REPO_SLUG}/builds/${TRAVIS_BUILD_ID}) has failed. Pull request no. ${TRAVIS_PULL_REQUEST} opened by ${GIT_COMMITER} can be found [here](https://github.com/${TRAVIS_REPO_SLUG}/pull/${TRAVIS_PULL_REQUEST})."
  else
    export MESSAGE="Travis [build no. ${TRAVIS_BUILD_NUMBER}](travis-ci.org/${TRAVIS_REPO_SLUG}/builds/${TRAVIS_BUILD_ID}) has failed. Please check for problems on branch [master](https://github.com/${TRAVIS_REPO_SLUG}/tree/master) which was pushed by ${GIT_COMMITER} on repo [${TRAVIS_REPO_SLUG}](https://github.com/${TRAVIS_REPO_SLUG})."
  fi
}


GIT_COMMITER=$(git show -s --pretty=%an)
if [ "$TRAVIS_TEST_RESULT" == "0" ]
then
  success
  export COLOR="#00FF00"
else
  failure
  export COLOR="#FF0000"
fi

curl -X POST --data-urlencode "payload={\"username\": \"soi\", \"attachments\": [{ \"color\": \"$COLOR\", \"text\": \"$MESSAGE\" }], \"icon_url\": \"https://maxcdn.icons8.com/office/PNG/512/Programming/bot_80-512.png\"}" "${MM_WEBHOOK}"
