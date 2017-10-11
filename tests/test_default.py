from testinfra.utils.ansible_runner import AnsibleRunner

testinfra_hosts = AnsibleRunner('.molecule/ansible_inventory').get_hosts('all')


def test_directories(File):
    present = [
        "/var/lib/jenkins",
        "/var/lib/jenkins/init.groovy.d"
    ]
    for directory in present:
        d = File(directory)
        assert d.is_directory
        assert d.exists


def test_files(File, SystemInfo):
    if SystemInfo.distribution == 'centos':
        CONF = '/etc/sysconfig/jenkins'
    else:
        CONF = '/etc/default/jenkins'
    present = [
        CONF,
        "/opt/jenkins-cli.jar"
    ]
    absent = [
        "/var/lib/jenkins/init.groovy.d/basic-security.groovy",
        "/var/lib/jenkins/init.groovy.d/secret-text-credentials.groovy"
    ]

    for file in present:
        f = File(file)
        assert f.exists
        assert f.is_file

    for file in absent:
        f = File(file)
        assert not f.exists


def test_service(Service):
    present = [
        "jenkins"
    ]
    for service in present:
        s = Service(service)
        assert s.is_enabled
        assert s.is_running


def test_packages(Package):
    present = [
        "jenkins"
    ]
    for package in present:
        p = Package(package)
        assert p.is_installed
