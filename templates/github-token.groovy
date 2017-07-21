import jenkins.model.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.plugins.credentials.impl.*

domain = Domain.global()
store = Jenkins.instance.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()


{% for credential in jenkins_tokens %}
secret{{ loop.index }}= new UsernamePasswordCredentialsImpl(
        CredentialsScope.GLOBAL, "{{ credential.id }}", "{{ credential.description }}", "{{ credential.username }}", "{{ credential.token }}")
store.addCredentials(domain, secret{{ loop.index }})

{% endfor %}
