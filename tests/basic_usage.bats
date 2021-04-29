#!/usr/bin/env bats

load teardown setup

@test "run to check key usage" {
    echo none > fwtype.txt
    echo none > sysctltype.txt
    run ../easy-wg-quick test_keys
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    run cat wgclient_test_keys.conf
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    [ "${lines[4]}" == "PrivateKey = aFj9NLLBci/8xWCErHBHQ+Lz3eNrJZ5VlfW1dDEpxH8=" ]
    [ "${lines[7]}" == "PublicKey = a+4ANyG+HEgiUqYeQI4dsOvlg4FCK64IcLZgMmkjnyE=" ]
    [ "${lines[8]}" == "PresharedKey = qRF8FZ3bPrvfEy0F1+K4/J8ySS4yKFjV6WdSvKBs4Oo=" ]
}

@test "run to create basic stable hub configuration" {
    echo enp5s0 > extnetif.txt
    echo 192.168.1.1 > extnetip.txt
    echo 12345 > portno.txt
    echo 10.127.0. > intnetaddress.txt
    echo fdfc:2965:0503:e2ae:: > intnet6address.txt
    echo 8.8.8.8 > intnetdns.txt
    echo 2001:4860:4860::8888 > intnet6dns.txt
    echo none > fwtype.txt
    echo none > sysctltype.txt
    touch forceipv6.txt
    run ../easy-wg-quick
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    run cat wghub.conf
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    [ "${lines[1]}" == "[Interface]" ]
    [ "${lines[2]}" == "Address = 10.127.0.1/24, fdfc:2965:0503:e2ae::1/64" ]
    [ "${lines[3]}" == "ListenPort = 12345" ]
    [ "${lines[4]}" == "PrivateKey = aFj9NLLBci/8xWCErHBHQ+Lz3eNrJZ5VlfW1dDEpxH8=" ]
    [ "${lines[5]}" == "SaveConfig = false" ]
    [ "${lines[6]}" == "MTU = 1280" ]
    [ "${lines[10]}" == "[Peer]" ]
    [ "${lines[11]}" == "PublicKey = a+4ANyG+HEgiUqYeQI4dsOvlg4FCK64IcLZgMmkjnyE=" ]
    [ "${lines[12]}" == "PresharedKey = qRF8FZ3bPrvfEy0F1+K4/J8ySS4yKFjV6WdSvKBs4Oo=" ]
    [ "${lines[13]}" == "AllowedIPs = 10.127.0.10/32, fdfc:2965:0503:e2ae::10/128" ]
}

@test "run to create basic stable client configuration" {
    echo enp5s0 > extnetif.txt
    echo 192.168.1.1 > extnetip.txt
    echo 12345 > portno.txt
    echo 10.127.0. > intnetaddress.txt
    echo fdfc:2965:0503:e2ae:: > intnet6address.txt
    echo 8.8.8.8 > intnetdns.txt
    echo 2001:4860:4860::8888 > intnet6dns.txt
    echo none > fwtype.txt
    echo none > sysctltype.txt
    touch forceipv6.txt
    run ../easy-wg-quick basic_stable
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    run cat wgclient_basic_stable.conf
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    [ "${lines[1]}" == "[Interface]" ]
    [ "${lines[2]}" == "Address = 10.127.0.10/24, fdfc:2965:0503:e2ae::10/64" ]
    [ "${lines[3]}" == "DNS = 8.8.8.8, 2001:4860:4860::8888" ]
    [ "${lines[5]}" == "MTU = 1280" ]
    [ "${lines[6]}" == "[Peer]" ]
    [ "${lines[9]}" == "AllowedIPs = 0.0.0.0/0, ::/0" ]
    [ "${lines[10]}" == "Endpoint = 192.168.1.1:12345" ]
    [ "${lines[11]}" == "PersistentKeepalive = 25" ]
}
