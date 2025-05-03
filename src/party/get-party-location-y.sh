#!/bin/bash

hex_byte=$(xxd -p -s 1 -l 1 data/party-data.bin)
byte_value=$((16#$hex_byte))
exit $byte_value