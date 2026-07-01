# Deal-Ordner – Vorlage

Kopiere diesen Ordner nach `beteiligungen/<deal-id>/` und befülle ihn.

```
<deal-id>/
  00_profile.json          # Stammdaten (Schema: schemas/deal-profile.schema.json)
  pseudonyms.json          # lokale Klarname->Platzhalter-Map (NIE committen/extern teilen)
  dataroom/                # Data-Room-Dokumente (financials/, legal/, contracts/, market/ ...)
  fact-ledger/             # vom pe-referee je Debatte geschrieben
  decisions/               # Entscheidungs-Records je Phase
  predictions/
    open.json              # offene, noch nicht abgeglichene Prognosen
    closed.json            # abgeschlossene Prognosen
  reporting/               # extrahierte Ist-KPIs aus Reporting-PDFs
  reconciliation/          # Prognose-vs-Ist-Abgleiche + Brier-Scores
```

> **Vertraulichkeit:** `pseudonyms.json` und der komplette `dataroom/` enthalten sensible
> Deal-Daten. In `.gitignore` halten bzw. bewusst entscheiden, was versioniert wird.
