---
description: Fuehrt die Exit-Debatte fuer einen Deal: Timing, Kanal (Trade Sale/Secondary/IPO/Write-off), Preis und Struktur. Bull/Bear/Referee + Bewertung + Legal/Tax, max. 6 Runden. Schreibt einen exit-Record.
argument-hint: <deal-id>
---

Du orchestrierst die **Exit-Entscheidung** für den Deal **$ARGUMENTS**. Faktenbasiert, kein
erzwungenes Ergebnis.

## Vorbereitung
1. Heutiges Datum aus dem Kontext bestimmen; unveraendert an alle Sub-Agenten weitergeben.
2. Lade unter `pe-lifecycle/beteiligungen/$ARGUMENTS/`: den juengsten `decisions/*` (IC/Monitoring),
   das letzte `reporting/*`, `reconciliation/*`, `predictions/open.json` + `closed.json`,
   `00_profile.json` und `dataroom/legal/waterfall.md`. Lies `playbook/phase-exit.md` (Gates) sowie
   `base-rates.json` und relevante `lessons.jsonl`. Pseudonymisierung sicherstellen.
3. Rufe **`pe-valuation`** auf → aktuelle Exit-EV-Bandbreite, MOIC/IRR realisiert nach Wasserfall,
   Sensitivitaet auf Praeferenzen und 10 %-Schwelle, Vergleich „jetzt verkaufen vs. halten".

## Debattenschleife (Runde n = 1..6)
1. `pe-bull`: Case fuer den Exit jetzt (bester Kanal, Preis, warum das Fenster guenstig ist).
2. `pe-bear`: Gegen-Case (Timing/Bewertungsrisiko, besser halten/Value-Creation, Praeferenz-/
   Steuerrisiko, kein belastbarer Kaeuferkreis).
3. Fuer Struktur-/Steuerfragen des Exits die Fach-Agenten (`pe-legal-ch/de`, `pe-tax-ch/de`)
   konsultieren (Share- vs. Asset-Deal, Beteiligungsabzug/Haltedauer, § 8b/DBA); nicht verifizierbare
   CH-Punkte bleiben `needs-human`.
4. `pe-referee`: Fakten-Ledger aktualisieren, Anti-Scheinkonsens + Exit-Gates anwenden.
5. Abbruch bei Konvergenz oder n = 6 (Rest → `needs-human`).

## Abschluss
1. `pe-referee` schreibt (unter `pe-lifecycle/beteiligungen/$ARGUMENTS/`):
   - `fact-ledger/<datum>_exit.json`
   - `decisions/<datum>_exit.json` (Schema `decision-record`, **phase: "exit"**) mit
     recommendation (proceed = Exit einleiten + Kanal | proceed-with-conditions = Exit vorbereiten |
     hold = weiter halten + Re-Check-Datum | decline = Write-off/Abwicklung), conditions, resolved,
     escalations, **predictions** (valuation: realisierter Exit-EV/MOIC; milestone: Exit-Closing bis
     Zieldatum), bull_summary, bear_summary, rounds_used, anonymization, sources.
   - Prognosen zusätzlich nach `predictions/open.json` (append).
2. **Nach vollzogenem Exit:** empfehle einen finalen `pe-reconciler`-Lauf ueber den gesamten
   Haltezeitraum (alle Prognosen) → konsolidierte, **deal-agnostische** Lessons in `lessons.jsonl`.
3. Fasse dem Nutzer zusammen: Votum + empfohlener Kanal, Exit-EV/MOIC-Bandbreite, steuerliche
   Kernpunkte (CH prüfungsbedürftig markieren), Bedingungen und neue Prognosen.

## Prinzipien
- Faktenbindung; Human-in-the-loop; nur pseudonymisierte Inhalte.
- Der Wasserfall (participating Seniorpräferenzen) und die Steuer-Haltedauer/10 %-Schwelle sind im
  Exit die zentralen Werthebel – explizit prüfen, nicht annehmen.
