---
description: Fuehrt den DD-Debattenlauf (Bull/Bear/Referee, max. 6 Runden bis Konvergenz) fuer einen Deal und schreibt Entscheidungs-Record + Prognosen.
argument-hint: <deal-id>
---

Du orchestrierst eine strukturierte Due-Diligence-Debatte für den Deal **$ARGUMENTS**.
Arbeite deterministisch und faktenbasiert. Erzwinge nie ein Ergebnis.

## Vorbereitung
1. Bestimme das heutige Datum (aus dem Kontext/`date`), du gibst es an alle Sub-Agenten weiter –
   diese generieren selbst keine Daten.
2. Lies `pe-lifecycle/beteiligungen/$ARGUMENTS/00_profile.json` und die Data-Room-Dokumente.
3. Lies `pe-lifecycle/playbook/phase-dd.md` (Prüfraster + Red-Flag-Gates), `base-rates.json`
   und relevante `lessons.jsonl`-Einträge – als Kontext für die Debatte.
4. **Pseudonymisierung:** Rufe `pe-anonymizer` auf, damit die Debatte nur mit maskierten
   Identitäten arbeitet. Klarnamen bleiben in `beteiligungen/$ARGUMENTS/pseudonyms.json` (lokal).

## Debattenschleife (je Workstream: financial, tax, legal, commercial)
Für jeden Workstream, Runde n = 1..6:
1. Rufe `pe-bull` mit Profil, pseudonymisiertem Kontext, aktuellem Ledger und Workstream auf.
2. Rufe `pe-bear` analog auf (inkl. der frischen Bull-Thesen).
3. Für aufkommende Rechts-/Steuerfragen rufe die passenden Fach-Agenten auf
   (`pe-legal-ch`/`pe-legal-de`/`pe-tax-ch`/`pe-tax-de`) – deren belegte Befunde sind die
   Grundwahrheit; ungeklärte Punkte bleiben `needs-human`.
4. Rufe `pe-referee` auf: er aktualisiert das Fakten-Ledger (resolved/contested/needs-human),
   wendet die Anti-Scheinkonsens-Regel und die Red-Flag-Gates an.
5. **Abbruch je Workstream**, wenn kein `contested`-Claim mehr offen ist (Konvergenz) oder n = 6
   erreicht ist (verbleibende `contested` → `needs-human`).

## Abschluss
1. Lass `pe-referee` das finale Fakten-Ledger nach `beteiligungen/$ARGUMENTS/fact-ledger/<datum>_dd.json`
   und den Entscheidungs-Record nach `beteiligungen/$ARGUMENTS/decisions/<datum>_dd.json` schreiben
   (Schema: `pe-lifecycle/schemas/decision-record.schema.json`), inkl. falsifizierbarer
   **predictions** über die vier KPI-Dimensionen; Prognosen zusätzlich nach
   `beteiligungen/$ARGUMENTS/predictions/open.json`.
2. Fasse dem Nutzer zusammen: Empfehlung, Auflagen, die wichtigsten `needs-human`-Eskalationen und
   die gesetzten Prognosen. Mach die offenen Rechts-/Steuerpunkte als prüfungsbedürftig kenntlich.

## Prinzipien
- Faktenbindung: jede Behauptung braucht eine Quelle, sonst nicht `resolved`.
- Human-in-the-loop: kritische offene Punkte werden eskaliert, nicht wegentschieden.
- Vertraulichkeit: nur pseudonymisierte Inhalte in der Debatte.
