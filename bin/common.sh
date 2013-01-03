set +x # Disabling verbose output in Jenkins

# Quick verification that we're running under Jenkins env
: ${JENKINS_HOME:?"This MUST be run inside Jenkins environment. JENKINS_HOME variable MUST have value"}

# Protection againt self-run
: ${BASH_SOURCE[0]:?"Hell, no! This is library is MUST be sourced in 1st line of Jenkins job!"}

# Including current dir to PATH
export PATH="$PATH:${BASH_SOURCE[0]}"

export HttpUser="root"
export HttpPassword=$(get_api_token.rb $HttpUser)
export curl="/usr/bin/curl -s --basic -u $HttpUser:$HttpPassword"

