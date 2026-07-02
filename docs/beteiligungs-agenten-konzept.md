# Konzept: Agenten-System für den PE-/Startup-Beteiligungslebenszyklus

**Status:** Erster Vorschlag zur Vorgehensweise
**Geltungsbereich:** Private Equity & Startup-Beteiligungen, Recht & Steuerrecht CH + DE
**Charakter:** Entscheidungs-Unterstützung, kein Ersatz für qualifizierte Rechts-/Steuerberatung

---

## 1. Zielbild

Ein modulares Agenten-System, das jede Phase einer Beteiligung – von der ersten Due
Diligence bis zum Exit – begleitet. Pro Prozessschritt lassen zwei gegnerische Agenten
(**Bull** vs. **Bear**) ihre Thesen aufeinanderprallen. Ein **Referee** treibt die Debatte
faktenbasiert zur Konvergenz, protokolliert die Entscheidung lokal und speist einen
Lern-Loop, der Prognosen später mit dem realen Beteiligungs-Reporting abgleicht.

Kernprinzipien:
- **Faktenbindung:** Jede Behauptung im Streit muss auf eine Quelle zeigen (Data-Room-Dokument,
  Finanzmodell, Gesetzestext, Kommentar). Ungeerdete Aussagen werden vom Referee verworfen.
- **Konvergenz statt Endlosschleife:** Debatte endet, wenn keine bestrittene Behauptung mehr
  offen ist – oder ein Punkt als „ohne externe Info nicht entscheidbar" an den Menschen eskaliert.
- **Nachvollziehbarkeit:** Jede Entscheidung wird als strukturierter, versionierter Record gespeichert.
- **Lernen durch Abgleich:** Prognosen zum Entscheidungszeitpunkt werden später gegen Ist-Zahlen
  geprüft; Abweichungen werden attribuiert und als „Lessons" ins Playbook zurückgespielt.

---

## 2. Lebenszyklus-Phasen (je ein Modul)

| # | Phase | Fokus | Beispiel-Entscheidungen |
|---|-------|-------|-------------------------|
| 1 | Sourcing / Screening | Erst-Filter, Fit zur Strategie | Weiterverfolgen ja/nein |
| 2 | Due Diligence | Commercial, Financial, Legal, Tax, Tech, ESG | Red Flags, Deal-Breaker |
| 3 | Bewertung & Strukturierung | Valuation, Term Sheet, Deal-/Steuerstruktur CH/DE | Preis, Struktur, Instrumente |
| 4 | Investment Decision / IC | Gesamtabwägung, Votum | Investieren ja/nein, Auflagen |
| 5 | Signing / Closing | SPA, Vollzug, CPs | Vertragsrisiken, Garantien |
| 6 | Holding / Monitoring / Value Creation | KPIs, Board, Reporting-Abgleich | Nachschuss, Maßnahmen, Impairment |
| 7 | Exit | Timing, Kanal (Trade Sale/Secondary/IPO/Write-off) | Verkaufen ja/nein, Struktur |

Jedes Modul folgt demselben Muster (Abschnitt 4), damit das System skaliert und wartbar bleibt.

---

## 3. Agenten-Rollen

### 3.1 Prozess-Agenten (pro Phase)
- **`bull-<phase>`** – vertritt den Investment-/Pro-Case, sucht Upside, Chancen, Gegenargumente zu Bedenken.
- **`bear-<phase>`** – vertritt den Skeptiker-/Contra-Case, sucht Risiken, Red Flags, Downside.
- **`referee-<phase>`** – neutral: extrahiert strittige Behauptungen, prüft Faktenbindung, erklärt
  Punkte für gelöst/offen/eskalationsbedürftig, schreibt den Entscheidungs-Record.

> Umsetzungsempfehlung: **Bull/Bear generisch** (ein `bull.md`, ein `bear.md`) und die
> phasenspezifische Checkliste/Kontext beim Aufruf injizieren. Das reduziert Wartung von
> 21 auf ~3 Kernagenten + Phasen-Playbooks.

### 3.2 Fach-Referenz-Agenten (querschnittlich, liefern die „Fakten-Grundwahrheit")
- **`legal-ch`**, **`legal-de`** – Gesellschafts-/Vertragsrecht, SPA, Beteiligungsstrukturen.
- **`tax-ch`**, **`tax-de`** – Steuerstruktur, Transaktionssteuern, Wegzug/Zuzug, Beteiligungsabzug etc.

Diese Agenten werden von Bull/Bear angerufen, um Rechts-/Steuerfragen faktenbasiert zu klären.
**Wichtig:** Sie müssen gegen echte Quellen erden (siehe 7). Ohne belastbare Quelle geben sie
„unsicher – juristisch prüfen lassen" zurück, statt zu raten.

### 3.3 Orchestrierung & Gedächtnis
- **`orchestrator`** – steuert pro Phase den Debattenlauf bis zur Konvergenz.
- **`reconciler`** – gleicht periodisch Prognosen mit Reporting-Ist ab, erzeugt Lessons.
- **`historian`** – schreibt/liest die lokale Historie und stellt relevanten Kontext (RAG) bereit.

---

## 4. Der Challenge-Mechanismus (Debatte bis Konvergenz)

Rundenbasiert, mit gemeinsamem **Fakten-Ledger**:

1. **Setup:** Orchestrator lädt Phasen-Playbook + relevante frühere Lessons + Deal-Unterlagen.
2. **Runde n:**
   - `bull` formuliert Thesen mit Quellenverweis.
   - `bear` widerlegt / bringt Gegenbelege mit Quellenverweis.
   - `referee` aktualisiert das Ledger: jede Behauptung → Status
     `resolved-by-fact` | `still-contested` | `needs-human`.
3. **Abbruchkriterium:** keine `still-contested`-Einträge mehr → Konvergenz.
   - Sicherung gegen Endlosschleifen: `max_rounds` (z. B. 6). Danach bleiben offene Punkte
     `needs-human` und werden eskaliert – das System entscheidet nichts „erzwungen".
4. **Ergebnis:** `referee` schreibt den Entscheidungs-Record inkl. finaler Empfehlung,
   Rest-Unsicherheiten und **falsifizierbaren Prognosen** (Grundlage des Lern-Loops).

Regel gegen Scheinkonsens: Eine Behauptung gilt nur als `resolved`, wenn sie durch eine Quelle
belegt **oder** von der Gegenseite explizit konzediert ist – nicht durch bloße Wiederholung.

---

## 5. Lokale Historie & Datenmodell

Verzeichnisstruktur (lokal, versioniert):

```
beteiligungen/
  <deal-id>/
    00_profile.json           # Stammdaten der Beteiligung
    decisions/
      2026-07-01_dd.json      # Entscheidungs-Record je Phase
      2026-08-15_ic.json
    fact-ledger/
      2026-07-01_dd.json      # strittige Behauptungen + Status + Quellen
    predictions/
      open.json               # offene, noch nicht geprüfte Prognosen
    reporting/
      2026-Q3.json            # eingespieltes Beteiligungs-Reporting (Ist)
    reconciliation/
      2026-Q3.json            # Prognose vs. Ist + Attribution
playbook/
  phase-dd.md                 # Checklisten/Kriterien je Phase (wird gelernt/verbessert)
  lessons.jsonl               # kumulierte Lessons (append-only)
  base-rates.json             # gelernte Basisraten/Kalibrierung
```

Entscheidungs-Record (Schema, verkürzt):

```json
{
  "deal_id": "projekt-helvetia",
  "phase": "due-diligence",
  "date": "2026-07-01",
  "recommendation": "proceed-with-conditions",
  "conditions": ["Steuerruling CH einholen", "Cap Table bereinigen"],
  "key_assumptions": ["ARR-Wachstum >= 30% p.a.", "kein Change-of-Control-Blocker"],
  "predictions": [
    {"id": "p1", "claim": "ARR 24M >= 4.0 Mio.", "confidence": 0.6, "horizon": "2028-07"},
    {"id": "p2", "claim": "kein Legal-Blocker DE", "confidence": 0.8, "horizon": "closing"}
  ],
  "open_risks": ["IP-Zuordnung Gründer unklar"],
  "escalations": ["Steuerliche Behandlung Earn-out DE – Berater prüfen"],
  "bull_summary": "...",
  "bear_summary": "...",
  "sources": ["dataroom/…", "OR Art. …", "…"]
}
```

---

## 6. Der Lern-Loop (Reconciliation)

Ehrlich eingeordnet: kein Gewichts-Training, sondern **strukturierte Reflexion + Retrieval**.

1. **Prognosen festhalten:** Jede Phase erzeugt falsifizierbare Prognosen (mit Confidence & Horizont).
2. **Ist einspielen:** Reporting-Daten je Periode landen in `reporting/`.
3. **Abgleich (`reconciler`):** vergleicht Prognose vs. Ist, berechnet Trefferquote und
   Kalibrierung (z. B. Brier-Score), attribuiert Misses (welcher Agent/welches Argument lag daneben).
4. **Lesson schreiben:** z. B. „Bull überschätzt TAM bei SaaS-Pre-Seed systematisch → Haircut 20 %".
5. **Rückspielung:** Lessons + aktualisierte Basisraten werden in `playbook/` gepflegt und von
   Bull/Bear/Referee bei künftigen Debatten als Kontext geladen → Kalibrierung verbessert sich.

So entsteht ein System, das über Zyklen hinweg messbar besser kalibriert – transparent und auditierbar.

---

## 7. Realitäts-Hinweise (kritisch)

- **Grounding ist Pflicht.** Ohne Anbindung an echte Quellen (Data Room, Gesetzestexte, Kommentare)
  halluzinieren Rechts-/Steueragenten. Empfehlung: Data Room + relevante Normtexte lokal/als MCP
  bereitstellen; die Fach-Agenten zitieren nur, was belegt ist, sonst „prüfen lassen".
- **Kein Beratungsersatz.** Das System bereitet auf, priorisiert und dokumentiert – die
  verbindliche Rechts-/Steuerprüfung bleibt bei qualifizierten Beratern.
- **Vertraulichkeit.** Deal-Daten sind hochsensibel: lokale Speicherung, klare Zugriffsgrenzen,
  bewusste Entscheidung, welche Inhalte an externe Dienste gehen.
- **Human-in-the-loop.** Eskalierte/`needs-human`-Punkte werden nie automatisch entschieden.

---

## 8. Vorgeschlagenes Vorgehen in Etappen

**Etappe 0 – Fundament**
- Ordnerstruktur + JSON-Schemata + Debatten-Protokoll (als Skill/Command) anlegen.
- Generische `bull`, `bear`, `referee` + ein Phasen-Playbook.

**Etappe 1 – Pilot: DD-Modul (end-to-end an einem Beispiel-Deal)**
- Bull/Bear/Referee für Due Diligence, `legal-ch/de` + `tax-ch/de` angebunden.
- Erzeugt ersten Entscheidungs-Record + Prognosen.

**Etappe 2 – Restliche Phasen** nach demselben Muster ausrollen.

**Etappe 3 – Monitoring & Reconciliation** (Lern-Loop scharf schalten).

**Etappe 4 – Automatisierung** (Orchestrierungs-Workflows, geplanter Reconciliation-Lauf via Hook/Cron).

**Empfehlung:** Mit Etappe 0 + 1 (DD-Pilot) starten. Ein durchgespieltes Modul zeigt Nutzen und
Schwachstellen, bevor wir auf 7 Phasen skalieren.

---

## 9. Offene Entscheidungen vor dem Bau
1. Start-Pilot bestätigen: Due Diligence als erstes Modul?
2. Grounding-Quellen: Welche Rechts-/Steuertexte und Data-Room-Zugänge stehen bereit?
3. Ablageort: projektspezifisch (`.claude/agents/`, teambar via Git) oder persönlich?
4. Reporting-Format: Wie kommen die Ist-Zahlen der Beteiligungen herein (Datei, M365/SharePoint)?

---

## 10. Präzisierte Entscheidungen (Stand: Diskussion)

Fixiert im gemeinsamen Design-Dialog:

| Thema | Entscheidung | Konsequenz für den Bau |
|-------|--------------|------------------------|
| Grounding-Methode | **Web-Retrieval**, nur **Primärquellen** | Whitelist: Fedlex/admin.ch, gesetze-im-internet.de, ESTV, BMF. Fach-Agenten zitieren nur daraus. |
| Konvergenz | **max_rounds = 6**, Patt → `needs-human` | Kein erzwungener Sieger; offene Punkte eskalieren. |
| Ablageort | **Persönlich** (`~/.claude/agents/`) | Nicht im Repo; nicht teamweit versioniert. |
| Reporting-Input | **PDF**, **variiert je Beteiligung** | Toleranter Extraktionsschritt (PDF → KPIs); an Beispiel-PDF kalibrieren. |
| Vertraulichkeit | Öffentlich frei; Deal-Spezifisches **nur Identitäten maskiert** | Pseudonymisierungs-Schicht: Firmen-/Personennamen → Platzhalter, Zahlen/Fakten bleiben echt. |
| CH-Steuer | **Bundesebene Standard**, Kanton **nur wo relevant** | `tax-ch` erkennt entscheidungsrelevante Kantonsfragen und fragt gezielt nach. |
| DD-Pilot-Workstreams | **Financial, Tax, Legal, Commercial** | ESG/Tech vorerst außen vor. |
| Abgleich-KPIs | Wachstum (Umsatz/ARR), Profitabilität/Runway, Bewertung/Fair-Value, Meilensteine (qualitativ) | Prognose-Schema deckt diese vier Dimensionen ab. |

### Daraus resultierende neue Komponenten
- **`anonymizer` (Pseudonymisierung):** ersetzt vor externen Aufrufen Namen/Identifikatoren durch stabile Platzhalter (Deal-lokale Mapping-Tabelle, bleibt lokal). Hinweis: keine 100 %-Garantie – Kontext kann Identität teils implizit verraten; bei Bedarf manuelle Freigabe.
- **`report-extractor` (PDF → KPIs):** liest heterogene Reporting-PDFs, extrahiert die vier KPI-Dimensionen in ein einheitliches Ist-Schema; bei Unsicherheit markiert er Felder als „zu prüfen" statt zu raten.
- **Quellen-Whitelist:** zentrale Liste erlaubter Primärdomänen, auf die Legal/Tax-Retrieval beschränkt ist.

### Prognose-Schema (an KPIs ausgerichtet)
```json
{
  "id": "p1",
  "dimension": "growth|profitability|valuation|milestone",
  "claim": "ARR in 24 Monaten >= 4.0 Mio.",
  "metric": "arr",
  "target": 4000000,
  "horizon": "2028-07",
  "confidence": 0.6
}
```

### Nächster Schritt
Exemplarischer DD-Durchlauf (Bull/Bear/Referee) an einem anonymisierten Beispiel-Deal, um
Debattenführung, Fakten-Ledger und Entscheidungs-Record greifbar zu machen – danach Bau des Piloten.
