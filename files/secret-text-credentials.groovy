#!groovy
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.domains.*
import org.jenkinsci.plugins.plaincredentials.*
import org.jenkinsci.plugins.plaincredentials.impl.*
import hudson.util.Secret

domain = Domain.global()
store = Jenkins.instance.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()

secretText = new StringCredentialsImpl(
        CredentialsScope.GLOBAL, "{{ jenkins_credentials_id }}", "{{ jenkins_credentials_descrption }}", Secret.fromString("{{ jenkins_credentials_secret }}"))

store.addCredentials(domain, secretText)
