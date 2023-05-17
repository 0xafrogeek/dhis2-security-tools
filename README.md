# DHIS2 SECURITY TOOLS

## Purpose of the Tool

DHIS2 Security Tools is a tool built to ease Security/Compliance Assessments/Audits of DHIS2 Instances through automation.

## Technologies Used

- Ansible - For its flexibility
- GO ([Goss](https://github.com/goss-org/goss/) Binary) - Leverage [Goss](https://github.com/goss-org/goss/), a lighting fast [serverspec](http://serverspec.org/) alternative for testing/validating server configuration.

## Dependencies

- Ansible
- Python3
- jq

## How to use DHIS2 Security Tools

1. Clone this repository on your DHIS2 Server: git clone https://github.com/babouceesay/dhis2-security-tools.git
2. Change directory into dhis2-security-tools: cd dhis2-security-tools
3. Execute assess.sh with sudo privileges. It will install dependenciess, run Security Assessement and generate report: sudo ./assess.sh

## License

BSD

## Author Information

- Baboucarr Ceesay
