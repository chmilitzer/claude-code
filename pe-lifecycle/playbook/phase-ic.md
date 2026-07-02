# Playbook – Investment Committee / Investment Decision (Prüfraster)

Die IC-Phase **konsolidiert** die DD und beantwortet die Go/No-Go-Frage: investieren – zu welchem
Preis, mit welcher Struktur und welchen Bedingungen? Eingang ist der DD-Entscheidungs-Record.

## Eingang (zwingend laden)
- Letzter DD-Record `decisions/<datum>_dd.json` inkl. `recommendation`, `conditions`, `escalations`.
- Offene Prognosen `predictions/open.json`.
- `pe-valuation`-Output (Returns-Szenarien).

## IC-Red-Flag-Gates (Treffer ⇒ zwingend `needs-human`, ggf. decline/defer)
- Ungelöster DD-Deal-Breaker (z. B. IP-Titel, Ankerkunde) ohne belastbare Closing-Condition
- Entry-Bewertung außerhalb plausibler Marktbandbreite ohne Begründung
- Downside-MOIC < 1.0x im realistischen Szenario inkl. Präferenz-Wasserfall
- Kapitalreserve für Folgerunden nicht eingeplant (Verwässerungs-/Nachschussrisiko)
- Portfolio-Klumpen (Sektor/Stage/Einzelposition) über Zielallokation

## Prüfdimensionen
### Bewertung & Returns
- Entry-Multiple (z. B. ARR-Multiple) vs. Vergleichsbandbreite
- MOIC/IRR in Downside/Base/Upside – **inkl.** Liquidationspräferenz-Wasserfall und
  Verwässerung (Sensitivität auf die CH-10 %-Schwelle)
- Kapitalbedarf bis Break-even + Reserve-Allokation für Pro-rata

### Struktur & Bedingungen
- Übernahme der DD-`escalations` als Conditions Precedent / Covenants / Indemnities
- Governance (Board-/Informationsrechte), Pro-rata, Anti-Dilution
- Signing→Closing-Mechanik

### Portfolio-Fit
- Strategie-Fit, Diversifikation, Reserve, Konzentrationsgrenzen

## Votum (recommendation)
- `proceed` (invest), `proceed-with-conditions` (invest vorbehaltlich CPs),
  `hold` (defer – mehr Info nötig), `decline`.
- Offene deal-relevante `needs-human`/Deal-Breaker ⇒ höchstens `proceed-with-conditions`.

## Prognosen (an Returns geknüpft)
- valuation: Exit-Bewertung / Fair-Value-Entwicklung
- growth/profitability: die tragenden DD-Annahmen fortschreiben
- milestone: CP-Erfüllung bis Signing/Closing
