#!/bin/sh
uci delete appfilter.rule.app_list 2>/dev/null
uci commit appfilter
/usr/bin/oaf_rule reload
echo "OAF: regole rimosse — download libero"