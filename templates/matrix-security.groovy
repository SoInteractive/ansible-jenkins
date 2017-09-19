#!groovy

import jenkins.*
import hudson.*
import jenkins.model.*
import hudson.model.*
import jenkins.security.*
import hudson.security.*

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount('{{ jenkins_admin_username }}', '{{ jenkins_admin_password }}')
hudsonRealm.createAccount('{{ jenkins_viewer_username }}', '{{ jenkins_viewer_password }}')

def instance = Jenkins.getInstance()
instance.setSecurityRealm(hudsonRealm)
instance.save()


def strategy = new hudson.security.GlobalMatrixAuthorizationStrategy()

// Admin permission - for admin user only!!!
strategy.add(Jenkins.ADMINISTER, '{{ jenkins_admin_username }}')

// Overall read permissions for viewer
strategy.add(hudson.model.Hudson.READ, '{{ jenkins_viewer_username }}')

// Job read permissions for viewer
strategy.add(hudson.model.Item.READ, '{{ jenkins_viewer_username }}')

// View read permissions for viewer
strategy.add(hudson.model.View.CONFIGURE, '{{ jenkins_viewer_username }}')
strategy.add(hudson.model.View.CREATE, '{{ jenkins_viewer_username }}')
strategy.add(hudson.model.View.DELETE, '{{ jenkins_viewer_username }}')
strategy.add(hudson.model.View.READ, '{{ jenkins_viewer_username }}')

instance.setAuthorizationStrategy(strategy)
instance.save()