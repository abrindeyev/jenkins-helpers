# Quick verification that we're running under Jenkins env
: ${JENKINS_HOME:?"This MUST be run inside Jenkins environment. JENKINS_HOME variable MUST have value"}

# Including current dir to PATH
export PATH="$PATH:${BASH_SOURCE[0]}"

