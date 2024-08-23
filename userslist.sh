#!/bin/bash

#Github API URL
API_URL="https://api.github.com"

#Github Username and personel Access Token
USERNAME=$username
TOKEN=$token

#Github respository Information
REPO_OWNER=$1
REPO_NAME=$2

#Function to make Get a request to GITHUB API
function github_api_get {
    local endpoint="$1"
    local url= "${API_URL}/${endpoint}"
#Make a Get Request to Github API with authentication
    curl -u -s "${USERNAME}:${TOKEN}" "$url"
}
#Function to list of users with READ access to the respository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"
    
#Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(permissions.pulls == true) | .login')"

    # Display the list of collaborators with read access
    if  [[ -z "$collaborators"]]; then
        echo "No user with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

#Main Script
echo "Lsiting users with read access to ${REPO_OWNER}/${REPO_NAME}.."
list_users_with_read-access
  
    

