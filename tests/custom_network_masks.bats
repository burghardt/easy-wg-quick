#!/usr/bin/env bats

load teardown setup

@test "run to create networks with custom masks for hub configuration" {
    echo 172.16.0. > intnetaddress.txt
    echo /16 > intnetmask.txt
    echo fd9d:9648:0841:0c6e:3d28:94d9:: > intnet6address.txt
    echo /112 > intnet6mask.txt
    echo none > fwtype.txt
    echo none > sysctltype.txt
    touch forceipv6.txt
    run ../easy-wg-quick
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run cat wghub.conf
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    [[ "${lines[1]}" == "[Interface]" ]]
    [[ "${lines[2]}" == "Address = 172.16.0.1/16, fd9d:9648:0841:0c6e:3d28:94d9::1/112" ]]
    [[ "${lines[10]}" == "[Peer]" ]]
    [[ "${lines[13]}" == "AllowedIPs = 172.16.0.10/32, fd9d:9648:0841:0c6e:3d28:94d9::10/128" ]]
}

@test "run to create networks with custom masks for client configuration" {
    echo 172.16.0. > intnetaddress.txt
    echo /16 > intnetmask.txt
    echo fd9d:9648:0841:0c6e:3d28:94d9:: > intnet6address.txt
    echo /112 > intnet6mask.txt
    echo none > fwtype.txt
    echo none > sysctltype.txt
    touch forceipv6.txt
    run ../easy-wg-quick basic_stable
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    run cat wgclient_basic_stable.conf
    [[ "$status" -eq 0 ]]
    [[ "${#lines[@]}" -gt 10 ]]
    [[ "${lines[1]}" == "[Interface]" ]]
    [[ "${lines[2]}" == "Address = 172.16.0.10/16, fd9d:9648:0841:0c6e:3d28:94d9::10/112" ]]
}
