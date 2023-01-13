#!/bin/sh -lxe

shellcheck -a -C -s bash -S style -o all -e SC2250,SC2312 easy-wg-quick

shellcheck -a -C -s dash -S style -o all -e SC2250,SC2312 easy-wg-quick
shellcheck -a -C -s ksh -S style -o all -e SC2250,SC2312 easy-wg-quick
shellcheck -a -C -s sh -S style -o all -e SC2250,SC2312 easy-wg-quick
