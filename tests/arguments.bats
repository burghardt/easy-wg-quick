#!/usr/bin/env bats

load teardown setup

@test "single run" {
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 3 ]]
    run cat wgclient_10.conf
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
}

@test "two runs" {
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 3 ]]
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 3 ]]
    run cat wgclient_10.conf
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run cat wgclient_11.conf
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
}

@test "run with name parameter" {
    run ../easy-wg-quick name
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 3 ]]
    run cat wgclient_name.conf
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
}

@test "run with -h parameter" {
    run ../easy-wg-quick -h
    [[ "$status" -eq 1 ]]
    [[ "${#lines[@]}" -ge 1 ]]
}

@test "run with --help parameter" {
    run ../easy-wg-quick --help
    [[ "$status" -eq 1 ]]
    [[ "${#lines[@]}" -ge 1 ]]
}

@test "run with too many parameters" {
    run ../easy-wg-quick foo bar
    [[ "$status" -eq 1 ]]
    [[ "${#lines[@]}" -ge 1 ]]
}

@test "multiple mixed runs" {
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 3 ]]
    run cat wgclient_10.conf
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]

    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 3 ]]
    run cat wgclient_11.conf
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]

    run ../easy-wg-quick client01
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 3 ]]
    run cat wgclient_client01.conf
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]

    run ../easy-wg-quick client02
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 3 ]]
    run cat wgclient_client02.conf
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]

    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 3 ]]
    run cat wgclient_14.conf
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
}
