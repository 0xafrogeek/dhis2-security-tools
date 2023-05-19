#! /bin/bash    

# Copy assessment content to /var/tmp
cp -R ./* /var/tmp

# help output
Help()
{
   # Goss Help flags
   echo "Script to run the goss audit"
   echo
   echo "Syntax: $0 [-f|-g|-o|-v|-w|-h]"
   echo "options:"
   echo "-f     optional - change the format output (default value = json) other working options documentation, rspecish"
   echo "-g     optional - Add a group that the server should be grouped with (default value = ungrouped)"
   echo "-o     optional - file to output audit data"
   echo "-v     optional - relative path to thevars file to load"
   echo "-w     optional - Sets the system_type to workstation (Default - Server)"
   echo "-h     Print this Help."
   echo
}


## option statement
while getopts f:g:o:v::h option; do
   case "${option}" in
        f ) FORMAT=${OPTARG} ;;
        g ) GROUP=${OPTARG} ;;
        o ) OUTFILE=${OPTARG} ;;
        v ) VARS_PATH=${OPTARG} ;;
        h ) # display Help
            Help
            exit;;
        ? ) # Invalid option
         echo "Invalid option: -${OPTARG}."
         Help
         exit;;
  esac
done


#### Pre-Checks

# check whether script is run with sudo privileges
if [ "$(/usr/bin/id -u)" -ne 0 ]; then
  echo "Script need to run with sudo privileges"
  exit 1
fi


# Command options
export DEBIAN_FRONTEND=noninteractive
APT_OPTS='-qq -y'

# Ansible install func
install_ansible() {
    sudo apt-get update "$APT_OPTS"
    sudo apt-get upgrade "$APT_OPTS"
    sudo apt-get install "$APT_OPTS" software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt-get install "$APT_OPTS" ansible
    sudo apt-get install "$APT_OPTS" python3-netaddr
    sudo apt-get autoclean "$APT_OPTS"
    ansible-galaxy collection install community.general
}

# Check and install ansible if not installed
if ! command -v ansible &> /dev/null; then
    install_ansible
fi

# Check and install jq
if ! command -v jq &> /dev/null; then
    sudo apt-get install "$APT_OPTS" jq
fi

# Check and install curl
if ! command -v curl &> /dev/null; then
    sudo apt-get install "$APT_OPTS" curl
fi

# Check and install goss if not installed
if ! command -v goss &> /dev/null; then
    GOSS_VERSION="0.3.22"
    echo
    echo ## Download and configure Goss
    curl -L "https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/goss-linux-amd64" -o /usr/local/bin/goss
    curl -L "https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/goss-linux-amd64.sha256" -o /tmp/sha256sum.txt

    # Verify checksum
    EXPECTED_SUM=$(grep "goss-linux-amd64" /tmp/sha256sum.txt | awk '{print $1}')
    ACTUAL_SUM=$(sha256sum /usr/local/bin/goss | awk '{print $1}')

    if [ "$EXPECTED_SUM" != "$ACTUAL_SUM" ]; then
        echo
        echo "ERROR: goss binary checksum verification failed" 
        echo
        exit 1
    else
        echo
        echo "OK: goss binary checksum verified successfully!"
        echo
        sudo chmod 0700 /usr/local/bin/goss
    fi
fi


# Set variables
assessment_content_dir=/var/tmp
GOSS_FILE=goss.yml
GOSS_BINARY=/usr/local/bin/goss
format=json
assessment_out=$assessment_content_dir/dhis2_security_assessment_$(hostname)_$(date +"%s").$format
assessment_vars=$assessment_content_dir/vars/SECURITY.yml

# Check for required Goss and config files
echo "## Pre-assessment checks Started"
echo

export FAILURE=0
if [ ! -x "$GOSS_BINARY" ]; then
   echo "ERROR: The GOSS binary was not found at $GOSS_BINARY "; export FAILURE=1
else
   echo "OK: GOSS binary found at $GOSS_BINARY."
fi

if [ ! -f "$assessment_content_dir/$GOSS_FILE" ]; then
   echo "ERROR:  Goss file was not found at $assessment_content_dir/$GOSS_FILE"; export FAILURE=2
else
   echo "OK: Goss file found at $assessment_content_dir/$GOSS_FILE."
fi


if [ $(echo $FAILURE) != 0 ]; then
   echo "## Pre-assessment checks failed, please see output."
   exit 1
else
   echo
   echo "## Pre-assessment checks Successful"
   echo
fi


format_output="-f $format"

if [ $format = json ]; then
   format_output="-f json -o pretty"
fi

    ## Security Assessment starts
    echo "###########################"
    echo "SECURITY ASSESSMENT Started"
    echo "###########################"
    echo
    echo

# Run Security assessment
$GOSS_BINARY -g $assessment_content_dir/$GOSS_FILE --vars $assessment_vars v $format_output > $assessment_out


# Get key attr from Goss summary
duration=$(jq -r '.summary."total-duration"' $assessment_out)
test_count=$(jq -r '.summary."test-count"' $assessment_out)
failed_count=$(jq -r '.summary."failed-count"' $assessment_out)

# Check if all tests passed
if [ "$failed_count" = "0" ]; then
    echo "###########################################"
    echo "SECURITY ASSESSMENT Successfully Completed"
    echo "###########################################"
    echo
    echo "##################"
    echo "All Tests PASSED"
    echo "##################"
    echo
    echo "Security Assessment Report Summary:"
    echo "----------------------------------"
    echo "## Report Format: $format"
    echo "## Tests Run: $test_count"
    echo "## Tests Passed: $((test_count - failed_count))"
    echo "## Tests Failed: $failed_count"
    echo "## Runtime Duration: $(echo "$duration / 1000000" | bc) seconds"
    echo "## Detailed Security Assessment Report can be found in: $assessment_out"
    echo
else
    echo "## WARNING!!! - Some important Security Configurations are missing on your System. $failed_count out of $test_count tests failed. Please check report in: $assessment_out"
    echo
    echo "Security Assessment Failed Tests Summary:"
    echo "----------------------------------------"
    jq -r '.results | map(select(.result != 0)) | .[] | "Test Title: " + .title, "Successful: " + (.successful | tostring)' $assessment_out
    echo
    echo "## Total Tests Run: $test_count"
    echo "## Total Tests Failed: $failed_count"
    echo "## Runtime Duration: $(echo "$duration / 1000000" | bc) seconds"
    echo "## Detailed Report can be found in: $assessment_out"
    echo
fi