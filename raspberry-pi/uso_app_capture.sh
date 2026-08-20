#!/bin/sh

if [ -z "$1" ]; then
    echo "Uso: uso_app_capture.sh <nome_app>"
    exit 1
fi

APP=$1
TS=$(date +%Y%m%d_%H%M%S)
PCAP="/mnt/usb/cattura_uso_${APP}_${TS}.pcap"
LOG="/mnt/usb/log_uso_${APP}_${TS}.txt"

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
echo ">>> Usare l'app $APP seguendo la stessa sequenza <<<"
echo ">>> Premere INVIO qui per fermare la cattura <<<"
read _

ubus call appfilter dev_list > "$LOG" 2>/dev/null
cat "$LOG" 2>/dev/null

kill $TCPDUMP_PID

echo ""
echo "=== Ciclo completato ==="
echo "Cattura traffico: $PCAP"
echo "Log dispositivi:  $LOG"
echo ""
echo "Ricorda: ripeti 5-6 volte per $APP, poi analizza tutte le catture"
echo "insieme con analisi_domini_sni.ipynb (glob.glob(\"*${APP}*.pcap\"))"
