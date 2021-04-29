#!/usr/bin/env bats

load teardown setup

@test "run with custom MTU set" {
    echo 1410 > intnetmtu.txt
    run ../easy-wg-quick custommtu
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -gt 10 ]
    run grep 'MTU = 1410' wghub.conf
    [ "$status" -eq 0 ]
    run grep 'MTU = 1410' wgclient_custommtu.conf
    [ "$status" -eq 0 ]
}

@test "run with too smal MTU set" {
    echo 1200 > intnetmtu.txt
    run ../easy-wg-quick toosmalmtu
    [ "$status" -eq 1 ]
}

@test "run with too big MTU set" {
    echo 1500 > intnetmtu.txt
    run ../easy-wg-quick toobigmtu
    [ "$status" -eq 1 ]
}
