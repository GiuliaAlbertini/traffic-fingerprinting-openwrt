# Analisi di traffico cifrato per il riconoscimento e il controllo di applicazioni mobili


## Panoramica

Quando un telefono si collega a Internet, il traffico che genera è quasi sempre cifrato: non è possibile leggere direttamente cosa sta facendo un'app. Questo progetto studia se sia comunque possibile capire *quale* app sta comunicando e *cosa* sta facendo, osservando solo le caratteristiche esterne del traffico (quantità di dati, ritmo, direzione), senza mai accedere al suo contenuto.

Un'applicazione concreta di questa idea è il **parental control**: poter riconoscere e limitare l'uso di specifiche app su una rete domestica, senza dover installare nulla sul dispositivo controllato e senza bisogno di violare la cifratura delle comunicazioni.

L'obiettivo del lavoro è duplice: da un lato riconoscere le applicazioni a partire da questi segnali indiretti, dall'altro capire come questa informazione possa essere usata per controllare l'accesso alla rete in modo mirato.

## Risultati principali

| Esperimento | Accuratezza |
|---|---|
| Riconoscimento dell'applicazione scaricata | **83.3%** |
| Riconoscimento del tipo di attività (navigazione, download, aggiornamento) | **82.2%** |

## Struttura della repository

- `Diario_tesi.docx` — diario di lavoro completo, con la cronologia dell'intero progetto
- `Studio Preliminare e Obiettivi di Ricerca.docx` — introduzione e formulazione degli obiettivi di ricerca
- `raspberry-pi/` — script utilizzati per la raccolta dati sul campo
- `notebook/` — analisi, dati estratti e grafici

## Nota sui dati

Le catture di traffico originali non sono incluse per limiti di dimensione; l'analisi si basa sulle caratteristiche già estratte, disponibili nei file di dati. 

## Stato del lavoro

Il riconoscimento delle applicazioni e delle tipologie di attività è completato. È in corso lo sviluppo di un meccanismo che integri il riconoscimento con un'azione di controllo a livello di rete.
