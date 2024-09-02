#!/usr/bin/env bats

load teardown setup

@test "run to create random IPv4 network address" {
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run cat intnetaddress.txt
    saved_first_output="$output"
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -eq 1 ]]

    rm -f intnetaddress.txt
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run cat intnetaddress.txt
    saved_second_output="$output"
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -eq 1 ]]

    [[ "$saved_first_output" != "$saved_second_output" ]]
}

@test "run to create random IPv6 network address" {
    touch forceipv6.txt
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run cat intnet6address.txt
    saved_first_output="$output"
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -eq 1 ]]

    rm -f intnet6address.txt
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run cat intnet6address.txt
    saved_second_output="$output"
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -eq 1 ]]

    [[ "$saved_first_output" != "$saved_second_output" ]]
}
