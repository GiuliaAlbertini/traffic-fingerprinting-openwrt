#!/bin/sh
if [ -z "$1" ]; then
    echo "Uso: oaf_block_ids.sh <id1> [id2] ..."
    exit 1
fi

uci delete appfilter.rule.app_list 2>/dev/null
for id in "$@"; do
    uci add_list appfilter.rule.app_list="$id"
done
uci commit appfilter
/usr/bin/oaf_rule reload

echo "OAF: regole ATTIVE (ID: $*) — blocco applicato"
