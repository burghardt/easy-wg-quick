#!/bin/sh -lxe

shfmt -d -i 4 -ci -sr -ln posix easy-wg-quick
shfmt -d -i 4 -ci -sr -ln bash easy-wg-quick
shfmt -d -i 4 -ci -sr -ln mksh easy-wg-quick

shfmt -d -i 4 -ci -sr -ln bats tests/*
