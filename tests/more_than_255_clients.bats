#!/usr/bin/env bats

load teardown setup

@test "create 222 clients" {
    echo 222 > seqno.txt
    echo /16 > intnetmask.txt
    echo 10.99.0. > intnetaddress.txt
    echo fd72:5676:4409:7609:: > intnet6address.txt
    touch forceipv6.txt
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 3 ]]
    run grep 'Address' wgclient_222.conf
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -eq 1 ]]
    [[ "${lines[0]}" == "Address = 10.99.0.222/16, fd72:5676:4409:7609::222/64" ]]
}

@test "create 333 clients" {
    echo 333 > seqno.txt
    echo /16 > intnetmask.txt
    echo 10.99.0. > intnetaddress.txt
    echo fd72:5676:4409:7609:: > intnet6address.txt
    touch forceipv6.txt
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 3 ]]
    run grep 'Address' wgclient_333.conf
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -eq 1 ]]
    [[ "${lines[0]}" == "Address = 10.99.1.77/16, fd72:5676:4409:7609::333/64" ]]
}

@test "create 4444 clients" {
    echo 4444 > seqno.txt
    echo /16 > intnetmask.txt
    echo 10.99.0. > intnetaddress.txt
    echo fd72:5676:4409:7609:: > intnet6address.txt
    touch forceipv6.txt
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 3 ]]
    run grep 'Address' wgclient_4444.conf
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -eq 1 ]]
    [[ "${lines[0]}" == "Address = 10.99.17.92/16, fd72:5676:4409:7609::4444/64" ]]
}
