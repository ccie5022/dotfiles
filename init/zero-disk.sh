#!/bin/bash
# Zero disk space
dd if=/dev/zero of=/zero.file bs=10M count=999999999
rm /zero.file

