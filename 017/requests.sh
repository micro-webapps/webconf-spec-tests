source ../functions.sh

handled_by_8080 "localhost" "https://localhost:9443/owncloud"
handled_by_8080 "localhost" "https://localhost:9443/owncloud/"
handled_by_8080 "localhost" "https://localhost:9443/owncloud/another"

handled_by_8081 "localhost2" "https://localhost:9443/owncloud"
handled_by_8081 "localhost2" "https://localhost:9443/owncloud/"
handled_by_8081 "localhost2" "https://localhost:9443/owncloud/another"
