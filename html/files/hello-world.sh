#!/usr/bin/env sh

sudo /usr/sbin/httpd -k start > /dev/null 2>&1
curl --silent localhost
