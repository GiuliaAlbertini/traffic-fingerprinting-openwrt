# Analisi di traffico cifrato per il riconoscimento e il controllo di applicazioni mobili
## Panoramica
Quando un telefono si collega a Internet, il traffico generato è quasi sempre cifrato. Questo progetto studia come identificare le applicazioni e limitarne l'uso su una rete domestica osservando esclusivamente le caratteristiche esterne del traffico (quantità di dati, ritmo, direzione), senza mai accedere al contenuto cifrato.

Un'applicazione concreta di questa idea è il **parental control**: poter riconoscere e limitare l'uso di specifiche app su una rete domestica, senza dover installare nulla sul dispositivo controllato e senza bisogno di violare la cifratura delle comunicazioni.

Il progetto integra due componenti principali:
* **Classificazione:** Un modello di Machine Learning basato su feature estratte dal traffico di download, in grado di identificare l'applicazione con un'accuratezza dell'83.3%.
* **Enforcement:** Una pipeline automatizzata che, previa analisi dei domini SNI (Server Name Indication), applica regole di blocco mirate, individuate tramite l'analisi dei domini SNI.
## Nota Metodologica sull'Enforcement
Il sistema di enforcement non opera in modo automatico su qualsiasi applicazione, ma segue un protocollo sperimentale basato su due fasi distinte di cattura:
1. **Fase di Classificazione:** Effettuata su catture di download, dove il traffico è dominato dagli store applicativi.
2. **Fase di Analisi dei Domini (Usage):** Necessaria per estrarre le firme, richiede una cattura effettuata durante l'uso attivo dell'app.
L'applicazione del blocco mirato (per-app) è fattibile solo se il traffico verso il dominio radice dell'azienda supera una soglia di dominanza empirica (fissata attorno al 20-25%). Sotto questa soglia, il traffico risulta troppo disperso tra SDK di terze parti (analytics, CDN, pubblicità) e il sistema ricorre a una strategia di ripiego (fallback) a livello di store.
## Risultati Principali e Casi Studio
| Esperimento / Analisi | Esito / Metrica |
|---|---|
| Riconoscimento dell'applicazione (Random Forest) | **83.3%** di accuratezza |
| Riconoscimento del tipo di attività | **82.2%** di accuratezza |
| IKEA (Analisi domini SNI) | **27.3%** sul dominio proprietario → **Buona candidata** (Test di blocco per-app verificato) |
| Unieuro (Analisi domini SNI) | **16.5%** sul dominio proprietario → **Candidata debole** (Traffico disperso) |
## Struttura della Repository
- `Diario_tesi.docx` — Diario di lavoro completo.
- `notebook/classificazione_app.ipynb` — Addestramento e validazione del modello di classificazione dell'applicazione.
- `notebook/classificazione_attivita.ipynb` — Addestramento e validazione del modello di classificazione del tipo di attività.
- `notebook/analisi_domini.ipynb` — Analisi dei domini SNI per la definizione delle policy di blocco.
- `notebook/enforcement.ipynb` — Pipeline integrata di classificazione ed esecuzione dei comandi di blocco (SSH/OAF).
- `raspberry-pi/` — Script utilizzati per la raccolta dati sul campo.
## Nota sui Dati
Le catture di traffico (`.pcap`) originali non sono incluse per limiti di dimensione. L'analisi si basa sulle feature estratte e sui dataset di statistiche inclusi nella cartella `dati/`.
## Stato del Lavoro
Il sistema è operativo in modalità semi-automatica (dalla cattura già trasferita fino al blocco). Il modulo di classificazione è integrato con una pipeline di enforcement remoto che permette il blocco selettivo delle applicazioni identificate (verificato sul caso studio IKEA), con relativo logging delle operazioni in formato CSV.
