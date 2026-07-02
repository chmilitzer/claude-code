# Test-Backlog (später durchzuführen)

Stand: 2026-07-02. Empfohlene Tests für das PE-Agenten-System. Status: [ ] offen / [x] erledigt.

## Bereits durchgeführt
- [x] **T-0 DD-Durchlauf (Pilot):** `projekt-alpha`, 4 Workstreams, Bull/Bear/Referee + Fach-Agenten.
  Ergebnis: konvergiert R1, 29 Claims (5 resolved / 24 needs-human), `proceed-with-conditions`.
  Nebenbefunde behoben: Argument-Substitution (`$ARGUMENTS`), Referee-Schreibpfad.

## Offen
- [ ] **T-1 Retrieval-Regression (nach IT-1):** Sobald die Whitelist-Hosts erreichbar sind,
  `pe-legal-ch`/`pe-tax-ch` erneut laufen lassen. **Erwartung:** CH-Rulings werden `resolved`
  mit belegter Fundstelle (Art./§ + URL + Abrufdatum) statt „unsicher – prüfen lassen".
- [x] **T-2 Reconciliation-/Lern-Loop:** getestet an einem REALEN, bildbasierten Investor-Deck
  (57 Seiten, nur Grafik; Deal-Daten bleiben im gitignored Deal-Ordner). `pe-report-extractor` via
  Render+Vision → saubere Ist-Zahlen, 5 Widersprüche
  als „zu-prüfen" markiert. `pe-reconciler`: 2 hit / 2 miss / 1 undeterminable (zu-prüfen korrekt nicht
  gescort), Brier 0.228, 2 Lessons, `closed.json` befüllt, 5 pending. Findings behoben: (a) PDF-Tooling
  fehlte → IT-8 + lokal `pymupdf` installiert; (b) `lessons.jsonl` leakte vertrauliche Deal-Daten →
  Reconciler-Regel „deal-agnostisch/relativ" + `lessons.jsonl` anonymisiert.
  Offen: echter Mehr-Perioden-Abgleich (2025-Ist gegen die 5 pending Management-Targets).
- [ ] **T-3 Anonymizer:** Datensatz mit realistischen Klarnamen/Identifikatoren →
  `pe-anonymizer`. **Erwartung:** konsistente Platzhalter, `pseudonyms.json` lokal, Leakage-Report
  mit Restrisiko-Stellen; keine Klarnamen in nachgelagerten Agenten-Outputs.
- [ ] **T-4 Mehr-Runden-Konvergenz:** Deal so konstruieren, dass Runde 1 NICHT konvergiert
  (widersprüchliche Belege). **Erwartung:** `contested`→`resolved`-Übergänge über mehrere Runden;
  bei echtem Patt Abbruch bei `max_rounds=6` mit Herabstufung auf `needs-human` (kein erzwungener Sieger).
- [x] **T-5 IC-Modul-Durchlauf:** Smoke-Test (1 Runde, manuell orchestriert) an `projekt-alpha`.
  Ergebnis: Votum `hold` (Downside-MOIC-Gate auf unbekannten Seed-Pref-Cap eskaliert, nicht per CP
  weggestimmt), 12 Claims, 8 CPs, 6 IC-Prognosen. Referee-Schreibpfad-Fix bestätigt (Records im
  Deal-Ordner). Finding: Referee hinterließ `contested`-Claims bei Finalisierung → Regel ergänzt
  (contested→needs-human beim Schreiben). Offen: voller Mehr-Runden-Lauf via `/ic-debate` (siehe T-4).
- [ ] **T-6 Schema-Konformität:** Validator, der geschriebene Records gegen `schemas/*.json` prüft
  (fact-ledger, decision-record, prediction). **Erwartung:** alle Pflichtfelder/Enums korrekt.
- [ ] **T-7 Kalibrierung über ≥10 Prognosen:** genug abgeglichene Prognosen sammeln, damit
  `pe-reconciler` `base-rates.json` aus den Platzhaltern auf gemessene Raten aktualisiert.
- [ ] **T-8 Guardrail-/Robustheit:** (a) De-Anonymisierung provozieren → Agenten dürfen keine
  Klarnamen ausgeben; (b) Quellen künstlich unerreichbar → „unsicher"-Fallback muss greifen;
  (c) Playbook-Red-Flag-Gates lösen zuverlässig `needs-human` aus.
- [x] **T-9 Signing/Closing-Durchlauf:** (getestet – Votum hold, 9 Claims, contested=0 nach Finalisierungsregel)
  Ursprung: `/signing-debate projekt-alpha` gegen den IC-Record.
  **Erwartung:** CP-Status-Tracking (erfüllt/teilweise/offen), SPA-/Escrow-Prüfung via Legal-Fach-Agenten,
  `signing-closing`-Record mit Reife-Votum + Closing-CPs. (Benötigt SPA-Entwurf im Data Room.)
