dump_error() {
    echo "$1"
    echo "Host: $host"
    echo "URL:  $url"
    echo 'Output of `curl --resolve $host:$port:127.0.0.1 -k -L -H "Host: $host" "$url"`:'
    curl --resolve $host:$port:127.0.0.1 -k -L -v "$url"
    echo "Output of server:"
    cat haproxy.output
}

check_redirect_location() {
    host=$1
    url=$2
    location=$3
    expected=$4
    port=`echo $url |cut -d: -f3|cut -d/ -f 1`

    l=`curl --resolve $host:$port:127.0.0.1 -H "TestLocation: $location" -k "$url" -v 2>&1| grep "< Location"| awk '{print $3}'|tr -d '\n'|tr -d '\r'`
    if [ "$l" != "$expected" ] && [ "$l" != "http://$host:$port$expected" ]; then
        dump_error "Returned location $l is not equal $expected or http://$host:$port$expected"
        exit 1
    fi
}

get_cookie() {
    host=$1
    url=$2
    port=`echo $url |cut -d: -f3|cut -d/ -f 1`

    curl --resolve $host:$port:127.0.0.1 -k "$url" -v 2>&1| grep "< Set-Cookie"| awk '{print $3}'|tr -d '\n'|tr -d '\r'
}

returns_bad_request() {
    echo -e "test" | nc 127.0.0.1 9090 | grep "badrequest" > /dev/null 2>&1
    if [ $? != 0 ]; then
        dump_error "badrequest is not returned, but it should be:"
        exit 1
    fi
}

handled_by_8080_or_8081_in_ratio() {
    host=$1
    url=$2
    ratio1=$3
    ratio2=$4
    reqs=$(( ratio1 + ratio2 ))
    port=`echo $url |cut -d: -f3|cut -d/ -f 1`
    ratio_8080=0
    ratio_8081=0

    echo "$reqs"
    for (( c=0; c<$reqs; c++ ))
    do
        curl --resolve $host:$port:127.0.0.1 -L "$url" 2>/dev/null > test.out
        cat test.out|grep 8080
        if [ $? == 0 ]; then
            ratio_8080=$((ratio_8080 + 1))
        fi

        cat test.out|grep 8081
        if [ $? == 0 ]; then
            ratio_8081=$((ratio_8081 + 1))
        fi
    done

    rm -f test.out
    if [ $ratio1 -ne $ratio_8080 ] || [ $ratio2 -ne $ratio_8081 ]; then
        dump_error "Ratio of backends used for requests is $ratio_8080:$ratio_8081, but it should be $ratio1:$ratio2"
        exit 1
    fi
}

handled_by_8080() {
    host=$1
    url=$2
    cookie=$3
    port=`echo $url |cut -d: -f3|cut -d/ -f 1`

    curl --resolve $host:$port:127.0.0.1 -L --cookie "$cookie" "$url" 2>/dev/null|grep "8080" >/dev/null
    if [ $? != 0 ]; then
        dump_error "URL is not handled by 8080 backend, but it should be:"
        exit 1
    fi
}

handled_by_8080_ssl() {
    host=$1
    url=$2
    port=`echo $url |cut -d: -f3|cut -d/ -f 1`

    curl --resolve $host:$port:127.0.0.1 -k -L "$url" -v 2>&1|grep "8080" -B100|grep "SSL connection using" >/dev/null
    if [ $? != 0 ]; then
        dump_error "URL is not handled by 8080 backend using SSL, but it should be:"
        exit 1
    fi
}

not_handled_by_8080() {
    host=$1
    url=$2
    port=`echo $url |cut -d: -f3|cut -d/ -f 1`

    curl --resolve $host:$port:127.0.0.1 -k -L "$url" 2>/dev/null|grep "8080" >/dev/null
    if [ $? == 0 ]; then
        dump_error "URL is handled by 8080 backend, but it should not be:"
        exit 1
    fi
}

handled_by_8081() {
    host=$1
    url=$2
    cookie=$3
    port=`echo $url |cut -d: -f3|cut -d/ -f 1`

    curl --resolve $host:$port:127.0.0.1 -k -L --cookie "$cookie" "$url" 2>/dev/null|grep "8081" >/dev/null
    if [ $? != 0 ]; then
        dump_error "URL is not handled by 8081 backend, but it should be:"
        exit 1
    fi
}

handled_by_8081_ssl() {
    host=$1
    url=$2
    port=`echo $url |cut -d: -f3|cut -d/ -f 1`

    curl --resolve $host:$port:127.0.0.1 -k -L "$url" -v 2>&1|grep "8081" -B100|grep "SSL connection using" >/dev/null
    if [ $? != 0 ]; then
        dump_error "URL is not handled by 8081 backend using SSL, but it should be:"
        exit 1
    fi
}

not_handled_by_8081() {
    host=$1
    url=$2
    port=`echo $url |cut -d: -f3|cut -d/ -f 1`

    curl --resolve $host:$port:127.0.0.1 -k -L "$url" 2>/dev/null|grep "8081" >/dev/null
    if [ $? == 0 ]; then
        dump_error "URL is handled by 8081 backend, but it should not be:"
        exit 1
    fi
}
