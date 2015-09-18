source ../functions.sh

handled_by_8080_or_8081_in_ratio "localhost" "http://localhost:9090/blog/index.php" 1 4
handled_by_8080_or_8081_in_ratio "localhost" "http://localhost:9090/foo/index.php" 4 1
