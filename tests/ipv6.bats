#!/usr/bin/env bats

load teardown setup

@test "run to create networks with masquerade for hub configuration" {
    touch forceipv6.txt
    echo masquerade > ipv6mode.txt
    echo fd9d:9648:0841:0c6e:3d28:94d9:: > intnet6address.txt
    echo /112 > intnet6mask.txt
    echo iptables > fwtype.txt
    echo linux > sysctltype.txt
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run grep 'ip6tables -t nat -A POSTROUTING' wghub.conf
    [[ "$status" -eq 0 ]]
    run grep 'sysctl -q -w net.ipv6.conf.all.proxy_ndp=1' wghub.conf
    [[ "$status" -eq 1 ]]
    run grep 'ip -6 neigh add proxy' wghub.conf
    [[ "$status" -eq 1 ]]
}

@test "run to create networks with ndp proxy for hub configuration" {
    touch forceipv6.txt
    echo proxy_ndp > ipv6mode.txt
    echo fd9d:9648:0841:0c6e:3d28:94d9:: > intnet6address.txt
    echo /112 > intnet6mask.txt
    echo iptables > fwtype.txt
    echo linux > sysctltype.txt
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run grep 'sysctl -q -w net.ipv6.conf.all.proxy_ndp=1' wghub.conf
    [[ "$status" -eq 0 ]]
    run grep 'ip -6 neigh add proxy' wghub.conf
    [[ "$status" -eq 0 ]]
    run grep 'ip6tables -t nat -A POSTROUTING' wghub.conf
    [[ "$status" -eq 1 ]]
}

@test "run to create networks with masquerade and ufw" {
    touch forceipv6.txt
    echo masquerade > ipv6mode.txt
    echo fd9d:9648:0841:0c6e:3d28:94d9:: > intnet6address.txt
    echo /112 > intnet6mask.txt
    echo ufw > fwtype.txt
    echo linux > sysctltype.txt
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run grep 'ufw route allow in on %i out on' wghub.conf
    [[ "$status" -eq 0 ]]
    run grep 'ip6tables -t nat -A POSTROUTING' wghub.conf
    [[ "$status" -eq 0 ]]
    run grep 'sysctl -q -w net.ipv6.conf.all.proxy_ndp=1' wghub.conf
    [[ "$status" -eq 1 ]]
    run grep 'ip -6 neigh add proxy' wghub.conf
    [[ "$status" -eq 1 ]]
}

@test "run to create networks with ndp proxy and ufw" {
    touch forceipv6.txt
    echo proxy_ndp > ipv6mode.txt
    echo fd9d:9648:0841:0c6e:3d28:94d9:: > intnet6address.txt
    echo /112 > intnet6mask.txt
    echo ufw > fwtype.txt
    echo linux > sysctltype.txt
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run grep 'ufw route allow in on %i out on' wghub.conf
    [[ "$status" -eq 0 ]]
    run grep 'sysctl -q -w net.ipv6.conf.all.proxy_ndp=1' wghub.conf
    [[ "$status" -eq 0 ]]
    run grep 'ip -6 neigh add proxy' wghub.conf
    [[ "$status" -eq 0 ]]
    run grep 'ip6tables -t nat -A POSTROUTING' wghub.conf
    [[ "$status" -eq 1 ]]
}

