#!/usr/bin/env bats

load teardown setup

@test "two runs to check listening port randomness" {
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 3 ]]
    RANDOM_PORT_FIRST="$(grep ListenPort wghub.conf | awk '{ print $3 }')"
    teardown
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 3 ]]
    RANDOM_PORT_SECOND="$(grep ListenPort wghub.conf | awk '{ print $3 }')"
    [[ "${RANDOM_PORT_FIRST}" -ne "${RANDOM_PORT_SECOND}" ]]
}
