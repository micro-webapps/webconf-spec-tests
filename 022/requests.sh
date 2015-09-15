source ../functions.sh

COOKIE=`get_cookie "localhost" "http://localhost:9090/blog/test.txt"`

if [ "$COOKIE" == "ROUTEID=.node0;" ]; then
    handled_by_8080 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8080 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8080 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8080 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8080 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8080 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8080 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8080 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8080 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8080 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
else
    handled_by_8081 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8081 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8081 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8081 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8081 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8081 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8081 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8081 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8081 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
    handled_by_8081 "localhost" "http://localhost:9090/blog/test.txt" "$COOKIE"
fi
