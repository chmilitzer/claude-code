---
description: Fuehrt die Signing/Closing-Debatte fuer einen Deal auf Basis des IC-Records; prueft CP-Erfuellung und Vertragswerk (SPA). Bull/Bear/Referee + Legal-Fach-Agenten, max. 6 Runden. Schreibt einen signing-closing-Record.
argument-hint: <deal-id>
---

Du orchestrierst die **Signing-/Closing-Reifepruefung** für den Deal **$ARGUMENTS**.
Aufbauend auf der IC-Entscheidung. Faktenbasiert, kein erzwungenes Ergebnis.

## Vorbereitung
1. Heutiges Datum aus dem Kontext bestimmen; unveraendert an alle Sub-Agenten weitergeben.
2. Lade den **IC-Record** (neueste `pe-lifecycle/beteiligungen/$ARGUMENTS/decisions/*_ic.json`) mit
   seinen `conditions` (CPs) und `escalations`, den DD-Record, `predictions/open.json`,
   `00_profile.json` sowie SPA-/Vertragsentwuerfe und Disclosure Schedule aus `dataroom/legal/`
   (sofern vorhanden — fehlen sie, ist das selbst ein Signing-Gate).
3. Lies `pe-lifecycle/playbook/phase-signing.md` (Prüfraster + Gates) sowie `playbook/base-rates.json`
   und relevante `lessons.jsonl`.
4. **Pseudonymisierung** sicherstellen (Klarnamen bleiben in `pseudonyms.json`, lokal).

## Debattenschleife (Runde n = 1..6)
1. `pe-bull`: Case „signing-/closing-reif" — welche CPs sind erfüllt (mit Beleg), warum ist das
   Vertragswerk akzeptabel, welche Punkte sind als Closing-CP heilbar.
2. `pe-bear`: Gegen-Case — offene/gate-kritische CPs, Luecken in Reps & Warranties/Indemnity/Escrow,
   MAC-/Disclosure-Risiken, fehlende Governance-Deliverables.
3. Für Vertrags-/CP-Rechtsfragen die **Legal-Fach-Agenten** (`pe-legal-ch`/`pe-legal-de`) und bei
   steuerlichen CPs `pe-tax-ch`/`pe-tax-de` konsultieren — belegte Befunde sind Grundwahrheit;
   nicht verifizierbare CH-Punkte bleiben `needs-human`.
4. `pe-referee`: Fakten-Ledger je CP/Vertragspunkt aktualisieren (resolved/contested/needs-human),
   Anti-Scheinkonsens und Signing-Gates anwenden.
5. Abbruch bei Konvergenz oder n = 6 (Rest → `needs-human`).

## Abschluss
1. `pe-referee` schreibt (unter `pe-lifecycle/beteiligungen/$ARGUMENTS/`):
   - `fact-ledger/<datum>_signing.json`
   - `decisions/<datum>_signing.json` (Schema `decision-record`, **phase: "signing-closing"**) mit
     recommendation (proceed | proceed-with-conditions | hold | decline), conditions (verbleibende
     Signing-/Closing-CPs mit Status), resolved, escalations, **predictions** (v. a. milestone:
     Closing-CP-Erfüllung bis Vollzug), bull_summary, bear_summary, rounds_used, anonymization, sources.
   - Prognosen zusätzlich nach `predictions/open.json` (append).
2. Fasse dem Nutzer zusammen: Reife-Votum, CP-Status (erfüllt/teilweise/offen), die kritischen
   Vertrags-/Escrow-Punkte, verbleibende Closing-CPs und neue Prognosen. CH-Punkte ohne verifizierte
   Primärquelle als prüfungsbedürftig kennzeichnen.

## Prinzipien
- Faktenbindung; Human-in-the-loop; nur pseudonymisierte Inhalte.
- Gate-kritische offene CP werden nicht „weggestimmt" — sie bleiben Signing-Blocker oder Closing-CP.
