#!/usr/bin/env bats

load teardown setup

@test "run with custom IPv4 DNS resolver" {
    echo 8.8.8.8 > intnetdns.txt
    run ../easy-wg-quick customdns
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run grep 'DNS =.*8\.8\.8\.8' wgclient_customdns.conf
    [[ "$status" -eq 0 ]]
}

@test "run with custom IPv6 DNS resolver" {
    touch forceipv6.txt
    echo 2001:4860:4860::8888 > intnet6dns.txt
    run ../easy-wg-quick customdns6
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run grep 'DNS =.*2001:4860:4860::8888' wgclient_customdns6.conf
    [[ "$status" -eq 0 ]]
}
