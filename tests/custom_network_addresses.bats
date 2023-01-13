#!/usr/bin/env bats

load teardown setup

@test "run to create custom networks hub configuration" {
    echo enp5s0 > extnetif.txt
    echo 192.168.1.1 > extnetip.txt
    echo 12345 > portno.txt
    echo 172.16.1. > intnetaddress.txt
    echo fd51:c743:e2fa:dc6f:: > intnet6address.txt
    echo 8.8.8.8 > intnetdns.txt
    echo 2001:4860:4860::8888 > intnet6dns.txt
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
    [[ "${lines[2]}" == "Address = 172.16.1.1/24, fd51:c743:e2fa:dc6f::1/64" ]]
    [[ "${lines[3]}" == "ListenPort = 12345" ]]
    [[ "${lines[5]}" == "SaveConfig = false" ]]
    [[ "${lines[10]}" == "[Peer]" ]]
    [[ "${lines[13]}" == "AllowedIPs = 172.16.1.10/32, fd51:c743:e2fa:dc6f::10/128" ]]
}

@test "run to create custom networks client configuration" {
    echo enp5s0 > extnetif.txt
    echo 192.168.1.1 > extnetip.txt
    echo 12345 > portno.txt
    echo 172.16.1. > intnetaddress.txt
    echo fd51:c743:e2fa:dc6f:: > intnet6address.txt
    echo 8.8.8.8 > intnetdns.txt
    echo 2001:4860:4860::8888 > intnet6dns.txt
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
    [[ "${lines[2]}" == "Address = 172.16.1.10/24, fd51:c743:e2fa:dc6f::10/64" ]]
    [[ "${lines[3]}" == "DNS = 8.8.8.8, 2001:4860:4860::8888" ]]
    [[ "${lines[6]}" == "[Peer]" ]]
    [[ "${lines[9]}" == "AllowedIPs = 0.0.0.0/0, ::/0" ]]
    [[ "${lines[10]}" == "Endpoint = 192.168.1.1:12345" ]]
    [[ "${lines[11]}" == "PersistentKeepalive = 25" ]]
}
