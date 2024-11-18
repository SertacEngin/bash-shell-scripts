#!/bin/bash

#######################################
# About: This script lists users who have read access to a specified GitHub repository.
# Input: ./script.sh repo_owner repo_name
# Owner: Sertac Engin
#######################################
# Function to display usage instructions
function display_usage {
    echo "Usage: $0 <repo_owner> <repo_name>"
    echo "This script lists users with read access to a specified GitHub repository."
    echo
    echo "Arguments:"
    echo "  <repo_owner>  The owner of the repository."
    echo "  <repo_name>   The name of the repository."
    echo
    echo "Example: $0 myusername myrepository"
}

# Check if no arguments were provided
if [[ $# -ne 2 ]]; then
    echo "Error: Missing arguments."
    display_usage
    exit 1
fi

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# Main script
echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
