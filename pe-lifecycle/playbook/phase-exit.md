# Playbook – Exit (Prüfraster)

Die Realisierungsphase: Wann, über welchen Kanal und zu welchem Preis wird die Beteiligung
veräußert? Eingang sind der jüngste Entscheidungs-/Monitoring-Record, das aktuelle Reporting und
die offenen/abgeschlossenen Prognosen (realisierte vs. erwartete Entwicklung).

## Eingang (zwingend laden)
- Jüngster `decisions/*` (IC/Monitoring), letztes `reporting/<periode>.json`, `reconciliation/*`.
- `predictions/open.json` + `closed.json` (Kalibrierung/tatsächliche Entwicklung).
- Cap Table / Wasserfall (`dataroom/legal/waterfall.md`), Fondslaufzeit/Reserve-Status.

## Exit-Kanäle
- Trade Sale (strategischer Käufer), Secondary (Verkauf an Finanzinvestor), IPO, Recap/Dividende,
  Write-off/Liquidation.

## Exit-Red-Flag-Gates (Treffer ⇒ `needs-human`, ggf. hold/weiter halten)
- Realisierter/erwarteter Exit-MOIC unter Zielrendite (inkl. Präferenz-Wasserfall)
- Präferenz-Erosion: participating Seniorpräferenzen drücken unseren Anteil im aktuellen Exit-Band
- Steuer-Leakage am Exit nicht geklärt (CH Beteiligungsabzug / DE § 8b / DBA-Quellensteuer)
- Kein belastbarer Käuferkreis / kein IPO-Fenster; Timing vs. Fondslaufzeit im Konflikt
- 10 %-Schwelle vor Exit unterschritten (steuerliche Qualifikation gefährdet)

## Prüfdimensionen
### Bewertung & Returns (pe-valuation)
- Aktuelle Exit-EV-Bandbreite vs. Entry; MOIC/IRR realisiert nach Wasserfall; Sensitivität auf
  Präferenzen und 10 %-Schwelle; Vergleich Verkaufen-jetzt vs. Halten-und-später.

### Timing & Kanal
- Marktfenster, Käuferlandschaft, Wettbewerb um das Asset; Fondslaufzeit/Liquiditätsbedarf; DPI/TVPI.

### Struktur & Steuer (Legal-/Tax-Fach-Agenten)
- Share- vs. Asset-Deal; Reps & Warranties/W&I; Earn-out; CH-Beteiligungsabzug (Haltedauer/Quote),
  DE § 8b/DBA, Emissionsabgabe n/a; Verrechnungspreis-/Substanzlage.

## Votum (recommendation)
- `proceed` = Exit einleiten (Kanal benennen); `proceed-with-conditions` = Exit vorbereiten,
  Bedingungen/Optimierungen zuerst (z. B. Steuer-Haltedauer, Präferenz-Klärung); `hold` = weiter
  halten (Timing/Value-Creation), Re-Check-Datum setzen; `decline` = Write-off/geordnete Abwicklung.

## Prognosen (Realisierung)
- valuation: realisierter Exit-EV / MOIC; milestone: Signing/Closing des Exits bis Zieldatum.
- Nach Exit: finaler Prognose-Ist-Abgleich (`pe-reconciler`) über den gesamten Haltezeitraum →
  konsolidierte Lessons (deal-agnostisch) für den Lern-Loop.
