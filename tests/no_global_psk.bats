#!/usr/bin/env bats

load teardown setup

@test "run to check for private psk" {
    run ../easy-wg-quick private_psk
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run test -f wgclient_private_psk.psk
    [[ "$status" -eq 0 ]]
    run test -f wgpsk.key
    [[ "$status" -eq 1 ]]
}
