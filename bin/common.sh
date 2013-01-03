set +x # Disabling verbose output in Jenkins

# Quick verification that we're running under Jenkins env
: ${JENKINS_HOME:?"This MUST be run inside Jenkins environment. JENKINS_HOME variable MUST have value"}

# Protection againt self-run
: ${BASH_SOURCE[0]:?"Hell, no! This is library is MUST be sourced in 1st line of Jenkins job!"}

# Including current dir to PATH
export PATH="$PATH:$(dirname ${BASH_SOURCE[0]})"

export HttpUser="root"
export HttpPassword=$(get_api_token.rb $HttpUser)
export PoolAPI="http://webapp-un.c4d.griddynamics.net"

export curl="/usr/bin/curl -s"
export jcurl="$curl --basic -u $HttpUser:$HttpPassword"
export pcurl="$curl $PoolAPI"

# http://stackoverflow.com/questions/296536/urlencode-from-a-bash-script
urlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER) 
}
