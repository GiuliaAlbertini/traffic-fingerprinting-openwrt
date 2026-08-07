#!/bin/sh
APP=$1
TS=$(date +%Y%m%d_%H%M%S)
PCAP="/mnt/usb/cattura_${APP}_${TS}.pcap"
LOG="/mnt/usb/log_${APP}_${TS}.txt"

# FASE A: attivo il blocco
uci set appfilter.rule.app_list='7002'
uci add_list appfilter.rule.app_list='9001'
uci commit appfilter
/usr/bin/oaf_rule reload
# [attesa interattiva: ricerca app sul dispositivo]
ubus call appfilter dev_list > "$LOG"

# FASE B: rimuovo il blocco, avvio la cattura
uci delete appfilter.rule.app_list
uci commit appfilter
/usr/bin/oaf_rule reload
tcpdump -i br-lan -w "$PCAP" &
# [attesa interattiva: download sul dispositivo]
kill $TCPDUMP_PID
