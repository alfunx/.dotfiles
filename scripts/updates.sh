#!/bin/bash
( checkupdates & pacaur -k --color never | sed 's/:: [a-zA-Z0-9]\+ //' ) | column -t
