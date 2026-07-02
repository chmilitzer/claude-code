---
description: Monitoring-Lauf je Reporting-Periode: extrahiert KPIs aus dem Reporting-PDF, gleicht offene Prognosen ab (Lern-Loop), erkennt Fruehwarnungen und leitet Handlungsbedarf ab. Schreibt einen monitoring-Record.
argument-hint: <deal-id> [reporting-pdf-pfad]
---

Du steuerst einen **Monitoring-Lauf**. Argumente in **$ARGUMENTS**: erstes Token = `<deal-id>`,
optionales zweites Token = Pfad zum Reporting-PDF. Fehlt der Pfad, verwende die neueste Datei unter
`pe-lifecycle/beteiligungen/<deal-id>/dataroom/reporting-inbox/`.

## Vorbereitung
1. Heutiges Datum aus dem Kontext bestimmen; unveraendert an alle Sub-Agenten weitergeben. Bestimme
   die Reporting-Periode (aus dem PDF, z. B. 2026-Q3).
2. Lies den letzten Entscheidungs-Record (`decisions/*`), `predictions/open.json`, `00_profile.json`
   und `playbook/phase-monitoring.md`. Pseudonymisierung sicherstellen.

## Ablauf
1. **Extraktion:** Rufe `pe-report-extractor` mit dem Reporting-PDF auf → schreibt
   `beteiligungen/<deal-id>/reporting/<periode>.json` (4 KPI-Dimensionen; Unsicheres = `zu-pruefen`).
2. **Reconciliation (Lern-Loop):** Rufe `pe-reconciler` auf → gleicht `predictions/open.json` gegen
   das Ist ab, schreibt `reconciliation/<periode>.json`, ergaenzt `playbook/lessons.jsonl`, verschiebt
   abgeschlossene Prognosen nach `predictions/closed.json`, aktualisiert `base-rates.json` (erst ab ≥10).
3. **Fruehwarn-Gates** (playbook): pruefe Runway, Top-Kunden-Churn, ARR-Plan-Abweichung, Covenant-/
   Meilenstein-Bruch, Impairment-Indikator. Treffer ⇒ `needs-human`.
4. **Action-Review:** `pe-bull` (Case „auf Kurs / unterstuetzen") vs. `pe-bear` (Case „eingreifen /
   Watchlist / Wertberichtigung"), faktenbasiert auf Ist + Reconciliation. Bei Rechts-/Steuerfragen
   (z. B. Follow-on-Struktur, 10%-Schwelle) die Fach-Agenten konsultieren. `pe-referee` fuehrt das
   Ledger und entscheidet.

## Abschluss
1. `pe-referee` schreibt (unter `pe-lifecycle/beteiligungen/<deal-id>/`):
   - `fact-ledger/<datum>_monitoring.json`
   - `decisions/<datum>_monitoring.json` (Schema `decision-record`, **phase: "monitoring"**) mit
     recommendation (proceed = auf Kurs | proceed-with-conditions = unterstuetzen mit Massnahmen |
     hold = Watchlist | decline = Wertberichtigung/Exit-Vorbereitung), conditions/Massnahmen,
     resolved, escalations (Fruehwarn-Gates), **predictions** (rollend fuer die naechste Periode,
     inkl. Fair-Value-Mark), bull_summary, bear_summary, rounds_used, anonymization, sources.
   - Neue rollende Prognosen nach `predictions/open.json` (append).
2. Fasse dem Nutzer zusammen: Reconciliation-Bilanz (hit/miss je Prognose + Brier), ausgeloeste
   Fruehwarn-Gates, empfohlene Handlung/Massnahmen, aktualisierten Fair-Value, neue Prognosen und die
   wichtigsten neuen Lessons. CH-Rechts-/Steuerpunkte als pruefungsbeduerftig kennzeichnen.

## Prinzipien
- Faktenbindung; Human-in-the-loop fuer Eingriffe; nur pseudonymisierte Inhalte.
- Der Reconciliation-Schritt ist obligatorisch — er ist der Kern des selbstlernenden Systems.
