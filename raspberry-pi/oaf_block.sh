#!/bin/sh
uci set appfilter.rule.app_list='7002'
uci add_list appfilter.rule.app_list='9001'
uci commit appfilter
/usr/bin/oaf_rule reload
echo "OAF: regole ATTIVE (7002 AppStore, 9001 GooglePlay) — download bloccato"