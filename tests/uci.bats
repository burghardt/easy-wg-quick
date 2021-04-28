#!/usr/bin/env bats

load teardown setup

@test "run to check key usage in UCI" {
    echo none > fwtype.txt
    echo none > sysctltype.txt
    run ../easy-wg-quick test_keys
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    run cat wgclient_test_keys.uci.txt
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 15 ]
    [ "${lines[7]}" == "	option private_key 'aFj9NLLBci/8xWCErHBHQ+Lz3eNrJZ5VlfW1dDEpxH8='" ]
    [ "${lines[16]}" == "	option public_key 'a+4ANyG+HEgiUqYeQI4dsOvlg4FCK64IcLZgMmkjnyE='" ]
    [ "${lines[17]}" == "	option preshared_key 'qRF8FZ3bPrvfEy0F1+K4/J8ySS4yKFjV6WdSvKBs4Oo='" ]
}

@test "run to create basic stable client configuration in UCI" {
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
    run cat wgclient_basic_stable.uci.txt
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 15 ]
    [ "${lines[1]}" == "config interface 'wg0'" ]
    [ "${lines[2]}" == "	option proto 'wireguard'" ]
    [ "${lines[3]}" == "	list addresses '10.127.0.10/24'" ]
    [ "${lines[4]}" == "	list addresses 'fdfc:2965:0503:e2ae::10/64'" ]
    [ "${lines[5]}" == "	list dns '8.8.8.8'" ]
    [ "${lines[6]}" == "	list dns '2001:4860:4860::8888'" ]
    [ "${lines[8]}" == "	option mtu '1280'" ]
    [ "${lines[9]}" == "config wireguard_wg0" ]
    [ "${lines[10]}" == "	list allowed_ips '0.0.0.0/0'" ]
    [ "${lines[11]}" == "	list allowed_ips '::/0'" ]
    [ "${lines[12]}" == "	option route_allowed_ips '1'" ]
    [ "${lines[13]}" == "	option endpoint_host '192.168.1.1'" ]
    [ "${lines[14]}" == "	option endpoint_port '12345'" ]
    [ "${lines[15]}" == "	option persistent_keepalive '25'" ]
}
