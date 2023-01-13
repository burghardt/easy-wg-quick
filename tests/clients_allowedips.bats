#!/usr/bin/env bats

load teardown setup

@test "run with default client's AllowedIPs" {
    run ../easy-wg-quick defaultallowedips
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run grep 'AllowedIPs = 0.0.0.0/0, ::/0' wgclient_defaultallowedips.conf
    [[ "$status" -eq 0 ]]
}

@test "run with custom client's AllowedIPs" {
    echo 192.168.1.0/24 > intnetallowedips.txt
    run ../easy-wg-quick customallowedips
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run grep 'AllowedIPs = 192\.168\.1\.0/24$' wgclient_customallowedips.conf
    [[ "$status" -eq 0 ]]
}
