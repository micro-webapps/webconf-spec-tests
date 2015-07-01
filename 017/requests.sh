source ../functions.sh

handled_by_8080_ssl "localhost" "https://localhost:9443/owncloud"
handled_by_8080_ssl "localhost" "https://localhost:9443/owncloud/"
handled_by_8080_ssl "localhost" "https://localhost:9443/owncloud/another"

handled_by_8081_ssl "localhost2" "https://localhost2:9443/owncloud"
handled_by_8081_ssl "localhost2" "https://localhost2:9443/owncloud/"
handled_by_8081_ssl "localhost2" "https://localhost2:9443/owncloud/another"
