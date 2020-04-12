#!/usr/bin/env bats

load teardown setup

@test "run with sysctl type set to linux" {
    echo iptables > fwtype.txt
    echo linux > sysctltype.txt
    run ../easy-wg-quick
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    run grep 'net.ipv4.ip_forward=1' wghub.conf
    [ "$status" -eq 0 ]
    [ "$output" == "PostUp = sysctl -q -w net.ipv4.ip_forward=1" ]
}

@test "run with sysctl type set to freebsd" {
    echo pf > fwtype.txt
    echo freebsd > sysctltype.txt
    run ../easy-wg-quick
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    run grep 'net.inet.ip.forwarding=1' wghub.conf
    [ "$status" -eq 0 ]
    [ "$output" == "PostUp = sysctl net.inet.ip.forwarding=1" ]
}

@test "run with sysctl type set to none" {
    echo iptables > fwtype.txt
    echo none > sysctltype.txt
    run ../easy-wg-quick
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    run grep 'sysctl' wghub.conf
    [ "$status" -eq 1 ]
    [ "${#lines[@]}" -eq 0 ]
}
