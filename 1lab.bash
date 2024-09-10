#!/bin/bash

head /etc/os-release -n 2 | tail -n 1
head /etc/os-release -n 4 | tail -n 1
uname -rm