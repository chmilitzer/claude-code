# DD-Modul – Exemplarischer Durchlauf (Beispiel-Deal)

> **Zweck:** Das Bull/Bear/Referee-Prinzip, das Fakten-Ledger und den Entscheidungs-Record
> greifbar machen – bevor gebaut wird.
> **Hinweis:** Alle Namen sind pseudonymisiert (wie es die Anonymisierungs-Schicht täte).
> Rechts-/Steuer-Aussagen sind **illustrativ** und stünden im echten System unter Primärquellen-
> Beleg **und** Vorbehalt qualifizierter Prüfung. Dies ist keine Rechts-/Steuerberatung.

---

## 0. Anonymisierter Deal-Steckbrief (Input)

| Feld | Wert (pseudonymisiert) |
|------|------------------------|
| Deal-ID | `projekt-alpha` |
| Target | `TargetCo` – vertikale B2B-SaaS, Sitz CH (Kanton Zug), Tochter `TargetCo DE GmbH` (München) |
| Runde | Series A, CHF 6.0 Mio.; Pre-Money CHF 24.0 Mio. |
| Unser Ticket | CHF 3.0 Mio. → ~10 % (voll verwässert) |
| Kennzahlen | ARR CHF 2.4 Mio., YoY +90 %; Bruttomarge 78 %; Netto-Burn CHF 320k/Monat; Cash CHF 4.1 Mio. |
| Team | 2 Gründer (CH-ansässig), 34 FTE (davon 20 in DE-Tochter) |
| Besonderheiten | Top-3-Kunden = 46 % ARR; ESOP 8 %; IP z. T. von DE-Angestellten entwickelt |

**Pseudonym-Mapping** (bleibt lokal, geht nie extern):
`TargetCo → [reale Firma]`, `Gründer A/B → [Namen]`, Beträge real.

---

## 1. Debattenlauf je Workstream

Notation je Behauptung (Claim):
**B+** = Bull-These · **B−** = Bear-Einwand · **⚖︎** = Referee-Ruling · **Status** ∈ {resolved, needs-human}

### 1.1 Financial

**C-F1 – „Die +90 % Wachstum sind nachhaltig."**
- **B+**: ARR-Kurve +90 % YoY, Bruttomarge 78 %, Net Revenue Retention 118 % (Data Room, `financials/cohorts.xlsx`).
- **B−**: 46 % ARR aus Top-3-Kunden; einer davon (34 % Anteil) läuft in 14 Monaten aus, keine Verlängerung unterschrieben (`contracts/keyaccounts.pdf`).
- **⚖︎ Runde 2**: NRR-Zahl belegt; Klumpenrisiko ebenfalls belegt. These „nachhaltig" wird zerlegt: Wachstum belegt **bis** zum Auslauf des Ankerkunden; danach unbelegt.
- **Status → needs-human**: Verlängerungswahrscheinlichkeit Ankerkunde ist Tatsachenfrage → Management-Q&A nötig. **Prognose p1 erzeugt** (s. u.).

**C-F2 – „Runway reicht bis Cash-Flow-Break-even."**
- **B+**: Cash 4.1 Mio. + neue 6.0 Mio. = 10.1 Mio.; Burn 320k → ~31 Monate.
- **B−**: Plan unterstellt Burn-Reduktion, obwohl 12 Neueinstellungen geplant → Burn steigt eher auf ~410k → ~24 Monate.
- **⚖︎**: Beide Szenarien aus demselben Modell ableitbar; Differenz = Annahme über Hiring-Tempo.
- **Status → resolved (konditional)**: Runway 24–31 Monate, abhängig von Hiring. In Record als Bandbreite. **Prognose p2.**

### 1.2 Commercial

**C-C1 – „Verteidigbarer Markt / Moat."**
- **B+**: Vertikale Spezialisierung, Wechselkosten hoch (tiefe Workflow-Integration).
- **B−**: Zwei finanzstarke Wettbewerber mit Quer-Subventionierung; TAM in DACH begrenzt (`market/tam.pdf` zeigt SAM ~CHF 300 Mio.).
- **⚖︎**: Wechselkosten plausibel, aber nicht quantifiziert; TAM-Zahl belegt. „Moat" bleibt Meinung, nicht Faktum.
- **Status → needs-human**: Kundenreferenzen/Churn-Gründe erhören. **Prognose p3 (Meilenstein).**

### 1.3 Legal (CH/DE)

**C-L1 – „IP liegt sauber bei TargetCo."**
- **B+**: IP-Assignment-Klauseln in CH-Arbeitsverträgen vorhanden.
- **B−**: Kern-IP wurde von Angestellten der **DE-Tochter** entwickelt. In DE greift das **Arbeitnehmererfindungsgesetz (ArbnErfG)** – Rechte gehen nicht automatisch über, es braucht **Inanspruchnahme**; Vergütungsansprüche möglich (illustrativ, Primärquelle: gesetze-im-internet.de/arbnerfg).
- **⚖︎**: CH-seitig belegt sauber; DE-seitig ist die ordnungsgemäße Inanspruchnahme **nicht** im Data Room dokumentiert → offener Rechtsmangel.
- **Status → needs-human (Deal-relevant)**: Nachweis der Inanspruchnahme anfordern; sonst Closing-Bedingung. **Prognose p4.**

**C-L2 – „Gesellschafterrechte marktüblich absicherbar."**
- **B+**: Term Sheet sieht Tag-along, Drag-along, Vorkaufsrecht, 1× non-participating Liquidation Preference vor.
- **B−**: Bestehende Altinvestoren haben 1× **participating** Preference → im Downside-Exit verwässert uns überproportional.
- **⚖︎**: Cap-Table-Wasserfall (`legal/waterfall.xlsx`) bestätigt Bear: bei Exit < CHF 40 Mio. reduziert sich unser Rückfluss messbar.
- **Status → resolved**: Faktum belegt → als Verhandlungspunkt (Angleichung der Präferenzen) in den Record.

### 1.4 Tax (CH/DE)

**C-T1 – „Exit-Gewinn ist auf unserer Ebene steuerlich effizient."**
- **B+**: Halten über CH-AG → **Beteiligungsabzug** auf Dividenden/Kapitalgewinnen bei ≥10 % / ≥CHF 1 Mio. (illustrativ, ESTV/DBG).
- **B−**: Unser Ticket ergibt ~10 % voll verwässert – bei weiterer Verwässerung droht Unterschreiten der 10 %-Schwelle; zudem Haltedauer-Anforderung (1 Jahr) beachten.
- **⚖︎**: Schwellen-/Haltedauer-Logik korrekt; aktuelle Quote grenzwertig → struktursensitiv.
- **Status → resolved (mit Auflage)**: Beteiligung so strukturieren, dass Schwelle robust gehalten wird (z. B. Anti-Dilution / Aufstockungsoption). **Kanton Zug**: hier **nicht** entscheidungsrelevant über Bundesebene hinaus → keine Kantons-Vertiefung.

**C-T2 – „ESOP der DE-Tochter ist unproblematisch."**
- **B+**: 8 % ESOP als Standard-Anreiz.
- **B−**: In DE **Dry-Income-Problematik** bei Anteilsgewährung; § 19a EStG mildert, aber mit Bedingungen (illustrativ, gesetze-im-internet.de/estg). Fehlgestaltung = Steuerlast bei Mitarbeitern ohne Zufluss → Retention-Risiko.
- **⚖︎**: Problem real; Ausgestaltung im Data Room nicht belegt.
- **Status → needs-human**: ESOP-Dokumentation + steuerliche Behandlung anfordern.

---

## 2. Fakten-Ledger (Snapshot nach Konvergenz, Runde 3 von max. 6)

| Claim | Thema | Beleg-Quelle | Status |
|-------|-------|--------------|--------|
| C-F1 | Wachstum nachhaltig | cohorts.xlsx / keyaccounts.pdf | needs-human |
| C-F2 | Runway | Finanzmodell | resolved (24–31 Mte.) |
| C-C1 | Moat/TAM | tam.pdf | needs-human |
| C-L1 | IP-Zuordnung DE | ArbnErfG / Verträge | needs-human (deal-relevant) |
| C-L2 | Präferenzen | waterfall.xlsx | resolved |
| C-T1 | Beteiligungsabzug | DBG/ESTV | resolved (mit Auflage) |
| C-T2 | ESOP DE | EStG §19a | needs-human |

**Konvergenz erreicht:** keine `contested`-Einträge mehr offen. 4 `needs-human`-Eskalationen,
3 `resolved`. Debatte endet vor Runde 6 → keine erzwungene Entscheidung.

---

## 3. Entscheidungs-Record (Output)

```json
{
  "deal_id": "projekt-alpha",
  "phase": "due-diligence",
  "date": "2026-07-01",
  "recommendation": "proceed-with-conditions",
  "conditions": [
    "Ankerkunden-Verlängerung (34% ARR) klären – Deal-Breaker falls ungesichert",
    "Nachweis ArbnErfG-Inanspruchnahme DE-IP vor Closing",
    "Angleichung Liquidationspräferenzen (participating -> non-participating)",
    "Beteiligung >=10% robust strukturieren (Anti-Dilution)",
    "ESOP-DE steuerkonform dokumentieren (§19a EStG)"
  ],
  "resolved": ["runway-24-31m", "waterfall-disadvantage", "participation-exemption-conditional"],
  "escalations": ["anchor-customer-renewal", "moat-evidence", "de-ip-assignment", "esop-de-tax"],
  "predictions": [
    {"id":"p1","dimension":"growth","claim":"ARR in 24M >= CHF 4.0 Mio.","metric":"arr","target":4000000,"horizon":"2028-07","confidence":0.55},
    {"id":"p2","dimension":"profitability","claim":"Runway >= 24 Monate ohne Zwischenrunde","metric":"runway_months","target":24,"horizon":"2028-07","confidence":0.6},
    {"id":"p3","dimension":"milestone","claim":"Kein Verlust eines Top-3-Kunden in 18M","metric":"top3_churn","target":0,"horizon":"2028-01","confidence":0.5},
    {"id":"p4","dimension":"milestone","claim":"DE-IP-Mangel vor Closing geheilt","metric":"ip_cleared","target":1,"horizon":"closing","confidence":0.7}
  ],
  "bull_summary": "Starkes Wachstum, hohe Marge, hohe NRR, verteidigbare vertikale Nische.",
  "bear_summary": "Kundenklumpen + auslaufender Ankerkunde, DE-IP-Mangel, ungünstige Altpräferenzen.",
  "anonymization": {"mapping_ref": "local://projekt-alpha/pseudonyms.json", "external_leakage": "identities-only-masked"},
  "sources": ["dataroom/financials/cohorts.xlsx", "dataroom/legal/waterfall.xlsx", "arbnerfg", "estg-19a", "dbg-participation"]
}
```

---

## 4. Anbindung an den Lern-Loop

Die vier Prognosen `p1–p4` wandern nach `predictions/open.json`. Sobald Reporting-PDFs
eintreffen, extrahiert `report-extractor` die Ist-Werte (ARR, Runway, Kunden-Status, IP-Status);
`reconciler` vergleicht:

- **p1 (ARR ≥ 4.0 Mio.)** – bei Ist 3.6 Mio. → Miss; Attribution: Bull-Wachstumsannahme zu optimistisch
  → Lesson „SaaS-Series-A-ARR-Prognosen mit −15 % Haircut kalibrieren".
- **p3 (kein Top-3-Churn)** – bei Ist „Ankerkunde verloren" → Miss; bestätigt Bear-Frühwarnung
  → Lesson „Kundenkonzentration >40 % als Red-Flag-Gate vor IC".

Diese Lessons landen in `playbook/lessons.jsonl` und werden bei künftigen DD-Debatten als
Kontext geladen → das System kalibriert sich über Zyklen messbar besser.

---

## 5. Was dieser Durchlauf zeigt (Design-Erkenntnisse)

1. **Faktenbindung wirkt:** „Moat" und „Wachstum nachhaltig" wurden korrekt von `resolved`
   getrennt und zu `needs-human` degradiert, weil Belege fehlten – kein Scheinkonsens.
2. **needs-human ist ein Feature, kein Bug:** Die wertvollsten Punkte (Ankerkunde, DE-IP)
   landen bewusst beim Menschen statt in einer erzwungenen Maschinen-Entscheidung.
3. **Prognosen sind falsifizierbar** und damit der Treibstoff des Lern-Loops.
4. **Offene Baustelle:** Qualität der Rechts-/Steuer-Rulings steht und fällt mit dem
   Primärquellen-Retrieval – der nächste kritische Baustein.
