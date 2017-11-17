#!/bin/bash

acpi | grep -Po 'Battery 0: \K.*'
