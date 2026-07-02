---
description: Fuehrt die Investment-Committee-Debatte (Go/No-Go) fuer einen Deal auf Basis des DD-Records; Bull/Bear/Referee + Bewertung, max. 6 Runden bis Konvergenz. Schreibt einen investment-decision-Record.
argument-hint: <deal-id>
---

Du orchestrierst die **Investment-Committee-Entscheidung** für den Deal **$ARGUMENTS**.
Aufbauend auf der abgeschlossenen Due Diligence. Faktenbasiert, kein erzwungenes Ergebnis.

## Vorbereitung
1. Heutiges Datum aus dem Kontext bestimmen; unverändert an alle Sub-Agenten weitergeben.
2. Lade den **DD-Entscheidungs-Record** (neueste `pe-lifecycle/beteiligungen/$ARGUMENTS/decisions/*_dd.json`),
   `predictions/open.json`, `00_profile.json` und die Data-Room-Dokumente. Behandle die DD-`escalations`
   (needs-human) als offene Punkte, die im IC entweder als Closing-Condition adressiert oder zum
   `decline`/`hold` führen.
3. Lies `pe-lifecycle/playbook/phase-ic.md` (Prüfraster + IC-Gates) sowie `playbook/base-rates.json`
   und relevante `lessons.jsonl`.
4. **Pseudonymisierung** sicherstellen (Klarnamen bleiben in `pseudonyms.json`, lokal).
5. Rufe **`pe-valuation`** auf → Entry-Bewertung, Ownership, MOIC/IRR in Downside/Base/Upside inkl.
   Präferenz-Wasserfall und Verwässerungs-Sensitivität.

## Debattenschleife (Runde n = 1..6)
1. `pe-bull`: Pro-Investment-Case über die **konsolidierte** Sicht (DD-Resolveds + Bewertung +
   adressierbare Bedingungen), mit Belegen.
2. `pe-bear`: Contra-Case (offene DD-Deal-Breaker, Bewertungsrisiko, Downside-MOIC, Reservebedarf).
3. Für Rest-Rechts-/Steuerfragen zur Struktur/CP-Machbarkeit die Fach-Agenten
   (`pe-legal-ch/de`, `pe-tax-ch/de`) konsultieren.
4. `pe-referee`: Fakten-Ledger aktualisieren (resolved/contested/needs-human), Anti-Scheinkonsens-
   und IC-Gates anwenden.
5. Abbruch bei Konvergenz (kein `contested`) oder n = 6 (Rest → `needs-human`).

## Abschluss
1. `pe-referee` schreibt (unter `pe-lifecycle/beteiligungen/$ARGUMENTS/`):
   - `fact-ledger/<datum>_ic.json`
   - `decisions/<datum>_ic.json` (Schema `decision-record`, **phase: "investment-decision"**) mit
     recommendation (proceed | proceed-with-conditions | hold | decline), conditions (inkl.
     übernommener DD-Escalations als CPs), resolved, escalations, **predictions** (an Returns
     geknüpft: valuation/growth/profitability/milestone), bull_summary, bear_summary, rounds_used,
     anonymization, sources.
   - Prognosen zusätzlich nach `predictions/open.json` (append).
2. Fasse dem Nutzer zusammen: Votum, Entry-Bewertung & MOIC-Bandbreite, die Conditions Precedent,
   die wichtigsten offenen `needs-human`-Punkte und die neuen Prognosen. CH-Rechts-/Steuerpunkte
   ohne verifizierte Primärquelle als prüfungsbedürftig kennzeichnen.

## Prinzipien
- Faktenbindung; Human-in-the-loop für kritische offene Punkte; nur pseudonymisierte Inhalte.
- Die IC-Entscheidung darf DD-Deal-Breaker nicht „wegstimmen" – sie werden zu CPs oder führen zu hold/decline.
