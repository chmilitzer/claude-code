# Playbook – Monitoring / Value Creation (Prüfraster)

Die laufende Beteiligungssteuerung. Diese Phase **schließt den Lern-Loop**: Reporting-Ist einlesen,
gegen die offenen Prognosen abgleichen, Frühwarnungen erkennen, Handlungsbedarf ableiten.

## Ablauf je Reporting-Periode
1. **Extraktion:** `pe-report-extractor` liest das Reporting-PDF → `reporting/<periode>.json`
   (Dimensionen growth / profitability / valuation / milestone; Unsicheres = `zu-pruefen`).
2. **Reconciliation:** `pe-reconciler` gleicht `predictions/open.json` gegen das Ist ab →
   `reconciliation/<periode>.json` (hit/miss/pending, Brier-Beitrag, Attribution) + `lessons.jsonl`;
   `base-rates.json` erst ab ≥10 abgeglichenen Prognosen aktualisieren.
3. **Frühwarn-Gates** (Treffer ⇒ `needs-human`, ggf. Eingriff):
   - Runway < 9 Monate oder Anschlussfinanzierung ungesichert
   - Verlust/Abwanderung eines Top-Kunden (insb. Ankerkunde)
   - ARR/Umsatz > 20 % unter Plan; Bruttomarge fällt materiell
   - Covenant-/Meilenstein-Bruch; Governance-/Informationsrechts-Verletzung
   - Down-Round-/Impairment-Indikator (Fair-Value-Mark unter Einstand)
4. **Action-Review** (Bull/Bear/Referee): Welche Handlung ist faktenbasiert geboten?

## Handlungsoptionen (mündet in recommendation)
- `proceed` = auf Kurs, halten/monitoren
- `proceed-with-conditions` = unterstützen mit Maßnahmen (Follow-on/Pro-rata, operative Hilfe,
  Board-Maßnahme, Nachverhandlung)
- `hold` = verschärft beobachten (Watchlist), Entscheidung vertagt bis nächster Datenpunkt
- `decline` = Wertberichtigung / Exit-Vorbereitung einleiten

## Bewertung / Reporting-Abgleich
- Fair-Value-Mark fortschreiben; Abweichung Prognose↔Ist dokumentieren (füttert den Lern-Loop).
- Reserve-Status (Pro-rata) prüfen und aktualisieren.

## Prognosen (rollend)
- Für die nächste Periode neue falsifizierbare Prognosen setzen (growth/profitability/valuation/
  milestone), damit der Lern-Loop kontinuierlich weiterläuft.
