#!groovy

node {

    currentBuild.result = "SUCCESS"

    try {
        ws('workspace/jenkins') {

            stage('Checkout code') {
                checkout scm
            }

            stage('Installing Molecule') {
                sh 'sudo pip install molecule'
            }

            stage('Creating Containers') {
                sh 'molecule create'
            }

            stage('Installing the Role') {
                sh 'molecule converge'
            }

            stage('Idempotence check') {
                sh 'molecule idempotence'
            }

            stage('Verify the application') {
                sh 'molecule verify'
            }
            stage('Destroy the containers') {
                sh 'molecule destroy'
            }

            stage('Merge accept') {
                    addGitLabMRComment comment: 'Accepted by Jenkins job'
                    /* acceptGitLabMR() */
                    mattermostSend channel: 'repositories', color: 'good', endpoint: 'https://chat.sointeractive.pl/hooks/kt9i54xiq7bqzf471sjcsaiknr', message: "Job ${JOB_NAME} ${BUILD_NUMBER} zakończony powodzeniem (<${BUILD_URL}|Open>)"
                }
        }
    }
    catch (err) {
        mattermostSend channel: 'repositories', color: 'bad', endpoint: 'https://chat.sointeractive.pl/hooks/kt9i54xiq7bqzf471sjcsaiknr', message: "Job ${JOB_NAME} ${BUILD_NUMBER} zakończony niepowodzeniem (<${BUILD_URL}|Open>)"
        currentBuild.result = "FAILURE"
        throw err
    }
}