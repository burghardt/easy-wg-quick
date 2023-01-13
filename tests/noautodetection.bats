#!/usr/bin/env bats

load teardown setup

@test "run without external interface autodetection" {
    echo iptables > fwtype.txt
    echo vtnet0 > extnetif.txt
    echo 10.20.15.25 > extnetip.txt
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run grep 'iptables -t nat -A POSTROUTING' wghub.conf
    [[ "$status" -eq 0 ]]
    [[ "$output" == "PostUp = iptables -t nat -A POSTROUTING -o vtnet0 -j MASQUERADE" ]]
}

@test "run without random port assignment" {
    echo 65535 > portno.txt
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run grep 'ListenPort = ' wghub.conf
    [[ "$status" -eq 0 ]]
    [[ "$output" == "ListenPort = 65535" ]]
}

@test "run without external IP address autodetection" {
    echo 192.168.193.169 > extnetip.txt
    echo 1 > portno.txt
    run ../easy-wg-quick customip
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run grep 'Endpoint = ' wgclient_customip.conf
    [[ "$status" -eq 0 ]]
    [[ "$output" == "Endpoint = 192.168.193.169:1" ]]
}
