# Anleitung: PE-Beteiligungs-Agentensystem (Step by Step)

Diese Anleitung führt dich von der Installation bis zum vollständigen Durchlauf eines Deals über
alle Lebenszyklus-Phasen. Sie richtet sich an **Nutzer** (Deal-Team), nicht an die IT.

> **Grundprinzip:** Pro Prozessschritt streiten zwei Agenten – **Bull** (Pro-Case) und **Bear**
> (Contra-Case) – faktenbasiert, ein **Referee** moderiert bis zur Konvergenz und protokolliert
> die Entscheidung. Offene, nicht belegbare Punkte werden **eskaliert** (`needs-human`), nie
> maschinell „wegentschieden". Prognosen werden später gegen das Reporting abgeglichen
> (selbstlernender Loop).
>
> **Wichtig:** Entscheidungs-Unterstützung, **kein** Ersatz für qualifizierte Rechts-/Steuerberatung.

---

## 0. Die 5 Phasen auf einen Blick

| Schritt | Command | Zweck |
|--------|---------|-------|
| 1 | `/dd-debate <deal-id>` | Due Diligence (Financial, Tax, Legal, Commercial) |
| 2 | `/ic-debate <deal-id>` | Investment Committee (Go/No-Go, Bewertung, Auflagen) |
| 3 | `/signing-debate <deal-id>` | Signing/Closing (CP-Tracking, SPA-/Vertragsprüfung) |
| 4 | `/monitor <deal-id> [pdf]` | Monitoring (Reporting→KPI, Prognose-Abgleich, Maßnahmen) |
| 5 | `/exit-debate <deal-id>` | Exit (Timing, Kanal, Preis/Struktur, realisierter MOIC) |

Jede Phase baut auf der vorigen auf und schreibt einen **Entscheidungs-Record** in den Deal-Ordner.

---

## 1. Einmaliges Setup

1. Repository öffnen (Claude Code) mit dem Ordner `pe-lifecycle/`.
2. Agenten & Commands installieren:
   ```bash
   bash pe-lifecycle/install.sh
   ```
   Das kopiert die Agenten nach `~/.claude/agents/` und die Commands nach `~/.claude/commands/`.
3. **Hinweis (Cloud-Umgebung):** `~/.claude/` wird nach einem Neustart geleert. Führe `install.sh`
   dann einfach erneut aus. (IT arbeitet an einer automatischen Lösung – Ticket IT-2.)

Prüfen, ob es geklappt hat: Tippe `/` und es sollten `dd-debate`, `ic-debate`, `signing-debate`,
`monitor`, `exit-debate` erscheinen.

---

## 2. Neuen Deal anlegen (Schritt für Schritt)

**Schritt 2.1 – Deal-Ordner aus der Vorlage erstellen.** Wähle eine kurze, stabile `deal-id`
(Kleinbuchstaben, Bindestriche), z. B. `projekt-helvetia`:
```bash
cp -r pe-lifecycle/beteiligungen/_TEMPLATE pe-lifecycle/beteiligungen/projekt-helvetia
```

**Schritt 2.2 – Stammdaten erfassen.** Öffne `beteiligungen/projekt-helvetia/00_profile.json` und
fülle die Felder (Schema: `schemas/deal-profile.schema.json`). Minimalbeispiel:
```json
{
  "deal_id": "projekt-helvetia",
  "target_name": "Beispiel AG",
  "phase_stage": "series-a",
  "geography": {"hq_country": "CH", "hq_canton": "Zug", "subsidiaries": ["Beispiel DE GmbH"]},
  "round": {"currency": "CHF", "round_size": 6000000, "pre_money": 24000000, "our_ticket": 3000000, "our_stake_fd_pct": 10.0},
  "kpis": {"arr": 2400000, "arr_yoy_pct": 90, "gross_margin_pct": 78, "net_burn_monthly": 320000, "cash": 4100000},
  "flags": ["Top-3-Kunden = 46% ARR", "Kern-IP z.T. von DE-Angestellten"]
}
```

**Schritt 2.3 – Data Room befüllen.** Lege die Unterlagen unter `dataroom/` ab. Bewährte Struktur:
```
dataroom/
  financials/   (Finanzmodell, Kohorten, Bankauszüge)
  legal/        (Cap Table/Wasserfall, Statuten, ABV, SPA-Entwurf, IP)
  contracts/    (Schlüsselkundenverträge)
  market/       (TAM/Wettbewerb)
  reporting-inbox/ (spätere Reporting-PDFs fürs Monitoring)
```
Die Agenten lesen diese Dateien selbst. Je mehr belegte Fakten vorliegen, desto mehr Punkte
können `resolved` statt `needs-human` werden.

> **Vertraulichkeit:** Der gesamte Deal-Ordner ist per `.gitignore` von der Versionsverwaltung
> ausgeschlossen – echte Deal-Daten landen **nie** im Repo. Die Datei `pseudonyms.json` (Klarnamen-
> Zuordnung) bleibt strikt lokal.

---

## 3. Phase 1 – Due Diligence

**Aufruf:**
```
/dd-debate projekt-helvetia
```

**Was passiert:** Pseudonymisierung → für jeden Workstream (Financial, Tax, Legal, Commercial)
streiten Bull und Bear über mehrere Runden (max. 6), Fach-Agenten (`pe-legal-ch/de`,
`pe-tax-ch/de`) liefern die belegte Grundwahrheit, der Referee führt das Fakten-Ledger und schreibt
am Ende die Records.

**Ergebnisdateien** (im Deal-Ordner):
- `fact-ledger/<datum>_dd.json` – jede strittige Behauptung mit Status `resolved` / `needs-human`
- `decisions/<datum>_dd.json` – Empfehlung, Auflagen, Eskalationen, **Prognosen**
- `predictions/open.json` – die falsifizierbaren Prognosen (für den Lern-Loop)

**So liest du das Ergebnis:** Zuerst `recommendation` (proceed / proceed-with-conditions / hold /
decline), dann die `escalations` (`needs-human`) – das sind die Punkte, die **du** klären musst.

---

## 4. Phase 2 – Investment Committee

**Voraussetzung:** DD-Record vorhanden.
```
/ic-debate projekt-helvetia
```
Zusätzlich rechnet `pe-valuation` Entry-Bewertung und **MOIC/IRR in Downside/Base/Upside** inkl.
Liquidationspräferenz-Wasserfall. Wichtig: Offene DD-Deal-Breaker werden zu **Conditions Precedent**,
nicht „weggestimmt". Ergebnis: `decisions/<datum>_ic.json` (phase `investment-decision`).

---

## 5. Phase 3 – Signing / Closing

**Voraussetzung:** IC-Record + SPA-Entwurf/Disclosure Schedule im `dataroom/legal/`.
```
/signing-debate projekt-helvetia
```
Verfolgt jede IC-Auflage (Signing- vs. Closing-CP), die Legal-Agenten prüfen das Vertragswerk
(Reps & Warranties, Indemnity-Cap/Escrow, MAC). Ergebnis: `decisions/<datum>_signing.json` mit
Reife-Votum und verbleibenden CPs + konkreten SPA-Nachbesserungen.

---

## 6. Phase 4 – Monitoring / Value Creation (der Lern-Loop)

Sobald ein Reporting eintrifft, lege das PDF unter `dataroom/reporting-inbox/` und starte:
```
/monitor projekt-helvetia
```
(oder mit explizitem Pfad: `/monitor projekt-helvetia dataroom/reporting-inbox/q3.pdf`)

**Ablauf:**
1. `pe-report-extractor` liest das PDF → `reporting/<periode>.json` (4 KPI-Dimensionen;
   Unsicheres wird als `zu-prüfen` markiert, **nicht** geraten).
2. `pe-reconciler` gleicht die offenen Prognosen gegen das Ist ab → `reconciliation/<periode>.json`
   (hit/miss + Kalibrierung), schreibt **Lessons** und verschiebt abgeschlossene Prognosen nach
   `predictions/closed.json`.
3. Frühwarn-Gates (Runway, Kundenverlust, Plan-Abweichung) + Bull/Bear-Maßnahmen-Review →
   `decisions/<datum>_monitoring.json` mit Handlungsempfehlung und neuen, rollenden Prognosen.

> **Bild-PDFs:** Manche Reportings sind reine Bild-Folien. Dann muss das PDF zuerst zu Bildern
> gerendert werden (IT-Ticket IT-8). Bis dahin ggf. die relevanten KPI-Seiten als PNG bereitstellen.

---

## 7. Phase 5 – Exit

```
/exit-debate projekt-helvetia
```
`pe-valuation` liefert Exit-Szenarien (jetzt verkaufen vs. halten), Bull/Bear streiten über
Timing/Kanal (Trade Sale / Secondary / IPO / Write-off), Legal/Tax prüfen die Struktur
(Beteiligungsabzug/Haltedauer, § 8b/DBA). Ergebnis: `decisions/<datum>_exit.json`.
**Nach vollzogenem Exit:** einen finalen `pe-reconciler`-Lauf über den ganzen Haltezeitraum
anstoßen → konsolidierte, deal-agnostische Lessons.

---

## 8. Ergebnisse verstehen (Kurzreferenz)

- **`recommendation`**: `proceed` = grün · `proceed-with-conditions` = mit Auflagen · `hold` =
  vertagt/beobachten · `decline` = ablehnen/Abwicklung.
- **`conditions`**: die Auflagen/CPs, die erfüllt werden müssen.
- **`escalations` = `needs-human`**: die für dich wichtigsten offenen Punkte – bewusst nicht
  maschinell entschieden. **Hier setzt deine Arbeit an.**
- **`predictions`**: falsifizierbare Prognosen (metric, target, horizon, confidence) – der Treibstoff
  des Lern-Loops.
- **`fact-ledger`**: die vollständige Streitliste mit Belegen und Status – für Audit/Nachvollzug.
- **„prüfungsbedürftig / unsicher – prüfen lassen"**: CH-Rechts-/Steuerpunkte, die (noch) nicht gegen
  Primärquellen verifiziert werden konnten → externe Fachprüfung nötig.

---

## 9. Wichtige Regeln (Do / Don't)

- ✅ Data Room mit **belegten** Unterlagen füllen – Belege verwandeln `needs-human` in `resolved`.
- ✅ Nach jedem Lauf die `escalations` abarbeiten und Klärungen als neue Dokumente nachlegen; danach
  die Phase erneut laufen lassen.
- ✅ CH-Rechts-/Steuer-Rulings immer als **prüfungsbedürftig** behandeln, bis extern bestätigt.
- ⛔ Reale Deal-Daten / `pseudonyms.json` **nicht** committen (ist per `.gitignore` geschützt).
- ⛔ Rechts-/Steuer-Aussagen des Systems **nicht** als verbindliche Beratung verwenden.

---

## 10. Aktuelle Einschränkungen (Stand jetzt)

- **CH-Primärquellen (fedlex/estv/admin.ch)** sind über den Proxy noch blockiert (HTTP 403) →
  Schweizer Rulings kommen als „prüfen lassen". Freischaltung ist IT-Ticket **IT-1**.
- **Bild-basierte Reporting-PDFs** benötigen einen Render-Schritt (IT-Ticket **IT-8**).
- **Persistenz** von `~/.claude` in der Cloud – nach Neustart `install.sh` erneut (IT-Ticket **IT-2**).

Die vollständige IT-Liste steht in `ops/it-aufgaben.md`, Konzept und Beispiel-Durchläufe unter
`docs/`.

---

## 11. Cheat-Sheet

```
# Setup (einmalig / nach Neustart)
bash pe-lifecycle/install.sh

# Neuen Deal anlegen
cp -r pe-lifecycle/beteiligungen/_TEMPLATE pe-lifecycle/beteiligungen/<deal-id>
#   -> 00_profile.json ausfüllen, dataroom/ befüllen

# Lebenszyklus durchlaufen
/dd-debate <deal-id>
/ic-debate <deal-id>
/signing-debate <deal-id>      # SPA-Entwurf in dataroom/legal/
/monitor <deal-id>             # Reporting-PDF in dataroom/reporting-inbox/
/exit-debate <deal-id>

# Ergebnisse: beteiligungen/<deal-id>/decisions/ , fact-ledger/ , predictions/ , reconciliation/
```
