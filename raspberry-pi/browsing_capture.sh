#!/bin/sh
if [ -z "$1" ]; then
    echo "Uso: browsing_capture.sh <nome_app>"
    exit 1
fi

APP=$1
TS=$(date +%Y%m%d_%H%M%S)
PCAP="/tmp/cattura_browsing_${APP}_${TS}.pcap"
LOG="/tmp/log_browsing_${APP}_${TS}.txt"

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
echo ">>> Aprire l'App Store, cercare app, scorrere le pagina, guardare screenshot <<<"
echo ">>> NON scaricare/aggiornare nulla, solo navigare per circa 1 minuto <<<"
echo ">>> Premere INVIO qui per fermare la cattura <<<"
read _

echo "=== Registro l'evento di riconoscimento ==="
ubus call appfilter dev_list > "$LOG"
cat "$LOG"

kill $TCPDUMP_PID

echo ""
echo "=== Ciclo completato ==="
echo "Log riconoscimento: $LOG"
echo "Cattura traffico:   $PCAP"