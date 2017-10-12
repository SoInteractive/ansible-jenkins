git config --global user.email "soibot@sointeractive.pl"
git config --global user.name "soi-bot"
export GIT_TAG=$([[ "$TRAVIS_COMMIT_MESSAGE" =~ ("Merge pull request".*/feature.*) ]] && git semver --next-minor || git semver --next-patch )
git tag $GIT_TAG -a -m "Generated tag from TravisCI for build $TRAVIS_BUILD_NUMBER"
export GIT_URL=$(git config --get remote.origin.url)
export GIT_URL=${GIT_URL#*//}