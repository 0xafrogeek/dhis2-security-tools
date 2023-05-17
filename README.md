# DHIS2 SECURITY TOOLS

## Purpose of the Tool

DHIS2 Security Tools is a tool built to ease and Automate Security/Compliance AUDIT of DHIS2 Instances based on the DHIS2 Security Assessment Checklist developed by the DHIS2 Security Team.

- The tool will also enable Auditors to apply PATCHES to security holes or misconfigurations detected during audit in an automated and hassle-free fashion.
- Incident Response for compromised DHIS2 instances will also be supported in the near future.

## TODO

- [x] Security Audit Role
- [ ] Security Patch Role
- [ ] Incident Response Role

## Tools/Technologies Used

- Ansible - For its flexibility
- GO ([Goss](https://github.com/goss-org/goss/) Binary) - Leveraging [Goss](https://github.com/goss-org/goss/), a lighting fast [serverspec](http://serverspec.org/) alternative for testing/validating server configuration. Goss's highly extensible yaml based syntax similar to Ansible, allows us to customize it to perform various kinds of tests/validations, ranging from Server to Application Security.

## Dependencies

- Ansible
- Goss Binary
- Python3
- jq

## How to use DHIS2 Security Tools

1. Clone this repository on your DHIS2 Server:

```sh
git clone https://github.com/babouceesay/dhis2-security-tools.git
```

2. Change directory into dhis2-security-tools:

```sh
cd dhis2-security-tools
```

3. Execute assess.sh with sudo privileges. It will install dependencies, run Security Assessement and generate report:

```sh
sudo ./assess.sh
```

## DHIS2 Security Assessment Checklist

**SA-ID** **CIS ID** **Name** **Automated** **Yes/No** **LVL** **Category** **Guidance**
DB-01 11.2 Regular automated database backup performed X 1 Database
DB-02 11.5 Regular database backup restore tested 1 Database
DB-03 11.4 Offsite backup X 1 Database
DT-01 13.1 DHIS2 exposed by web proxy (and not directly via tomcat) X 1 Deployment
DT-02 3.1 SSL setup (min A from ssllabs) X 1 Deployment
OS-01 5.4 SSH root access disabled X 1 Operating System
OS-02 SSH access with pub/priv keys X 1 Operating System
OS-03 SSH password login disabled X 1 Operating System
OS-04 5.3.1, 5.3.2, 5.3.3 SSH correct permissions (unix mode 660) on critical configuration files (e.g. sshd_config, keys) X 1 Operating System
OS-05 7.3 Unattended upgrades of OS level security patches X 1 Operating System
OS-06 DHIS2 correct permissions (unix mode 660) on critical files (e.g. conf, logs) X 1 Operating System
DT-03 Measures to test DHIS2 deployments on test instance 1 Deployment
AP-01 DHIS2 "admin" user disabled or default credentials changed X 1 Application
OS-07 Monitoring and alerting system (CPU, mem, postgres, web proxy, disk, etc) X 1 Operating System
OS-08 3.11 Encryption at rest for OS X 1 Operating System
OS-09 5.4 OS users with limited privileges X 1 Operating System
AP-02 Limited amount of DHIS admin users (around 1% of total DHIS2 user) 1 Application
AP-03 Strong DHIS2 user authentication method (complex password/passhprase or 2FA) 2 Application
OS-10 4.4 Expose to the internet only limited/necessary services (host/network firewall) X 1 Operating System
DB-04 5.4 Database users with limited privileges X 1 Database
DB-05 Database files correct permissions (unix mode 660) X 1 Database
DB-06 Database backup files correct permissions (unix mode 660) X 1 Database
DB-07 3.11 Encryption at rest for database 2 Database
OS-11 13.1, 13.2 Security monitoring and alerting system (host based) X 2 Operating System
DB-08 3.11 Encryption at rest for database backup X 2 Database
OS-12 13.3 Security monitoring and alerting system (network based) X 3 Operating System
DV-01 9.1 Devices to access DHIS2 are up to date with OS patches 3 Device
DV-02 9.1 Browsers to access DHIS2 are up to date 3 Device
DV-03 9.4 Minimum browser plugins are enabled when accessing DHIS2 3 Device
PS-01 Security manager appointed 1 Process
PS-02 Developed a security program 1 Process
PS-03 1.1 Asset inventory performed 1 Process
PS-04 17.1 - 17.9 Incident response plan developed 1 Process
PS-05 There is a data sharing agreement/NDA in place between data source and data receiver 1 Process
PS-06 5.1, 5.3 Procedure to remove user accounts belonging to leavers from DHIS2 1 Process
PS-07 5.1, 5.3 Procedure to remove user accounts belonging to leavers from OS 1 Process
PS-08 Risk assessment performed 2 Process
PS-09 Regular internal audit of system(s) 2 Process
PS-10 Regular external audit of system(s) 2 Process
PS-11 17.1 - 17.9 Incident response plan tested at least annually 2 Process
PS-12 7.1 Develop and maintain a vulnerability management process 2 Process
PS-13 Setup and report Key Performance Indicators (KPIs) to management at least quarterly 3 Process

## License

BSD

## Author Information

- Baboucarr Ceesay
