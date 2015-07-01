source ../functions.sh

handled_by_8080 "localhost" "http://localhost:9090/owncloud"
handled_by_8080 "localhost" "http://localhost:9090/owncloud/"
handled_by_8080 "localhost" "http://localhost:9090/owncloud/another"

handled_by_8081 "localhost" "http://localhost:9090/owncloud2"
handled_by_8081 "localhost" "http://localhost:9090/owncloud2/"
handled_by_8081 "localhost" "http://localhost:9090/owncloud2/another"

not_handled_by_8080 "localhost" "http://localhost:9090/owncloud3"
not_handled_by_8080 "localhost" "http://localhost:9090/owncloud3/"
#not_handled_by_8080 "localhost2" "http://localhost:9090/owncloud/"

not_handled_by_8081 "localhost" "http://localhost:9090/owncloud3"
not_handled_by_8081 "localhost" "http://localhost:9090/owncloud3/"
#not_handled_by_8081 "localhost2" "http://localhost:9090/owncloud2/"
