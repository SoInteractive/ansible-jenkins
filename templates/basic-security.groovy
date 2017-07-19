#!groovy
import hudson.security.*
import jenkins.model.*

def instance = Jenkins.getInstance()

println "--> creating (or modifying) local user 'admin'"

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount('{{ jenkins_admin_username }}', '{{ jenkins_admin_password }}')
instance.setSecurityRealm(hudsonRealm)

println "--> setting up authorization model"

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)
instance.save()
