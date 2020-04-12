#!/usr/bin/env bats

load teardown

setup() {
    echo iptables > fwtype.txt
}

@test "run with sysctl type set to linux" {
    echo linux > sysctltype.txt
    run ../easy-wg-quick
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    run grep 'net.ipv4.ip_forward=1' wghub.conf
    [ "$status" -eq 0 ]
    [ "$output" == "PostUp = sysctl -q -w net.ipv4.ip_forward=1" ]
}

@test "run with sysctl type set to none" {
    echo none > sysctltype.txt
    run ../easy-wg-quick
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    run grep 'sysctl' wghub.conf
    [ "$status" -eq 1 ]
    [ "${#lines[@]}" -eq 0 ]
}
