#!groovy
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.domains.*
import org.jenkinsci.plugins.plaincredentials.*
import org.jenkinsci.plugins.plaincredentials.impl.*
import hudson.util.Secret

domain = Domain.global()
store = Jenkins.instance.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()

{% for credential in jenkins_credentials %}
{{ credential.id }} = new StringCredentialsImpl(
    CredentialsScope.GLOBAL, "{{ credential.id }}", "{{ credential.description }}", Secret.fromString("{{ credential.secret }}"))
store.addCredentials(domain, {{ credential.id }})

{% endfor %}
