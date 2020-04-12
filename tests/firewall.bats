#!/usr/bin/env bats

load teardown setup

@test "run with firewall type set to Linux netfilter" {
    echo iptables > fwtype.txt
    run ../easy-wg-quick
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    run grep 'iptables -A FORWARD' wghub.conf
    [ "$status" -eq 0 ]
    [ "$output" == "PostUp = iptables -A FORWARD -i %i -j ACCEPT" ]
}

@test "run with firewall type set to OpenBSD PF" {
    echo pf > fwtype.txt
    run ../easy-wg-quick
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    run grep 'pfctl -e' wghub.conf
    [ "$status" -eq 0 ]
    [ "$output" == "PostUp = pfctl -e" ]
}

@test "run with firewall type set to custom" {
    echo custom > fwtype.txt
    echo "PostUp = custom_fw reload" > commands.txt
    run ../easy-wg-quick
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    run grep 'custom_fw reload' wghub.conf
    [ "$status" -eq 0 ]
    [ "$output" == "PostUp = custom_fw reload" ]
}

@test "run with firewall type set to none" {
    echo none > fwtype.txt
    run ../easy-wg-quick
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    run grep 'iptables' wghub.conf
    [ "$status" -eq 1 ]
    [ "${#lines[@]}" -eq 0 ]
    run grep 'pfctl' wghub.conf
    [ "$status" -eq 1 ]
    [ "${#lines[@]}" -eq 0 ]
    run grep 'custom_fw reload' wghub.conf
    [ "$status" -eq 1 ]
    [ "${#lines[@]}" -eq 0 ]
}
