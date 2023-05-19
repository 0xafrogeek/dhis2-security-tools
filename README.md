# DHIS2 SECURITY TOOLS

## Purpose of the Tool

DHIS2 Security Tools is a tool built to ease and Automate Security/Compliance AUDIT of DHIS2 Instances based on the DHIS2 Security Assessment Checklist developed by the DHIS2 Security Team.

- The tool will also enable Auditors to apply PATCHES to security holes or misconfigurations detected during audit in an automated and hassle-free fashion.
- Incident Response for compromised DHIS2 instances will also be supported in the near future.

## TODO (Features)

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
- curl

## Pre-requisites

- Your DHIS2 instance should be running on one of the recommended DHIS2 Ubuntu Server releases: 20.X or 22.X
- Your DHIS2 deployment should be one of the recommended secure DHIS2 deployments using [Bob Tools](https://github.com/bobjolliffe/dhis2-tools-ng) or [DHIS2 Server Tools](https://github.com/dhis2/dhis2-server-tools)

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

## DHIS2 Security Assessment Checklist - as of 2021

![Alt Text](https://github.com/babouceesay/dhis2-security-tools/blob/main/images/DHIS2-SA-2021.png)

## License

BSD

## Author Information

- Baboucarr Ceesay
