#!/usr/bin/env bats

load teardown

@test "single run" {
    run ../easy-wg-quick
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 3 ]
    run cat wgclient_10.conf
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
}

@test "two runs" {
    run ../easy-wg-quick
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 3 ]
    run ../easy-wg-quick
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 3 ]
    run cat wgclient_10.conf
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    run cat wgclient_11.conf
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
}

@test "run with name parameter" {
    run ../easy-wg-quick name
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 3 ]
    run cat wgclient_name.conf
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
}
