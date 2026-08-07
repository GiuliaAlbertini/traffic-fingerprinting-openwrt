#!/bin/sh
if [ -z "$1" ]; then
    echo "Uso: update_capture.sh <nome_app>"
    exit 1
fi

APP=$1
TS=$(date +%Y%m%d_%H%M%S)
PCAP="/tmp/cattura_update_${APP}_${TS}.pcap"
LOG="/tmp/log_update_${APP}_${TS}.txt"

echo "=== Assicurarsi che il blocco OAF sia disattivato ==="
uci delete appfilter.rule.app_list 2>/dev/null
uci commit appfilter
/usr/bin/oaf_rule reload

echo ""
echo ">>> Avvio la cattura tcpdump in background <<<"
tcpdump -i br-lan -w "$PCAP" &
TCPDUMP_PID=$!
sleep 1
echo "Cattura avviata (PID $TCPDUMP_PID) -> $PCAP"

echo ""
echo ">>> Avviare l'AGGIORNAMENTO dell'app (non una nuova installazione) <<<"
echo ">>> Quando l'aggiornamento è COMPLETATO, premere INVIO per fermare la cattura <<<"
read _

echo "=== Registro l'evento di riconoscimento ==="
ubus call appfilter dev_list > "$LOG"
cat "$LOG"

kill $TCPDUMP_PID

echo ""
echo "=== Ciclo completato ==="
echo "Log riconoscimento: $LOG"
echo "Cattura traffico:   $PCAP"