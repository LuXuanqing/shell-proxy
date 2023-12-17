# !/bin/bash
# windows host ip, reference: https://blog.csdn.net/Yiang0/article/details/127780263
HOST=$(grep nameserver /etc/resolv.conf | awk '{print $2}' | head -1)
PORT=10809
WSL_IP=$(hostname -I | awk '{print $1}')



# proxy settings
# refer1: https://www.cnblogs.com/devilmaycry812839668/p/16807509.html
# refer2: https://blog.csdn.net/m0_46680603/article/details/128769706
function enable_proxy() {
    echo setting proxy at $HOST:$PORT
    export http_proxy=http://$HOST:$PORT
    export HTTP_PROXY=http://$HOST:$PORT
    export https_proxy=https://$HOST:$PORT
    export HTTPS_PROXY=https://$HOST:$PORT
    export all_proxy=http://$HOST:$PORT
    export ALL_PROXY=http://$HOST:$PORT
    echo "proxy is enabled"
}

function disable_proxy() {
    unset http_proxy
    unset HTTP_PROXY
    unset https_proxy
    unset HTTPS_PROXY
    unset all_proxy
    unset ALL_PROXY
    echo "proxy is disabled"
}

function proxy_status() {
    echo http_proxy: $http_proxy
    echo HTTP_PROXY: $HTTP_PROXY
    echo https_proxy: $https_proxy
    echo HTTPS_PROXY: $HTTPS_PROXY
    echo all_proxy: $all_proxy
    echo ALL_PROXY: $ALL_PROXY
}

function test_proxy() {
    echo "try to connect to google..."
    resp=$(curl -I -s --connect-timeout 5 -m 5 -w "%{http_code}" -o /dev/null www.google.com)
    if [ ${resp} = 200 ]; then
        echo "success"
    else
        echo "failed"
    fi
}

echo "1. enable proxy
2. disable proxy
3. show proxy status
4. test proxy by curl www.google.com
--------------------------"

read -p 'please input: ' SELECTION

if [ $SELECTION -eq 1 ]
then
    enable_proxy
elif [ $SELECTION -eq 2 ]
then
    disable_proxy
elif [ $SELECTION -eq 3 ]
then
    proxy_status
elif [ $SELECTION -eq 4 ]
then
    test_proxy
else
    echo invalid input
fi