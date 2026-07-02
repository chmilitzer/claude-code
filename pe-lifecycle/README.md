# PE-/Startup-Beteiligungs-Agenten – DD-Pilot

Adversariales Agenten-System (Bull vs. Bear, moderiert von einem Referee) für den
Beteiligungslebenszyklus. Dieser Stand implementiert den **Due-Diligence-Piloten**
für die Workstreams **Financial, Tax, Legal, Commercial** mit Recht/Steuer CH + DE.

> **Charakter:** Entscheidungs-Unterstützung, **kein** Ersatz für qualifizierte
> Rechts-/Steuerberatung. Rechts-/Steuer-Aussagen werden gegen **Primärquellen** geerdet
> und bleiben prüfungsbedürftig.

## Verzeichnisstruktur

```
pe-lifecycle/
  README.md                 # dieses Dokument
  install.sh                # kopiert Agenten + Command nach ~/.claude/
  agents/                   # die Subagenten (Quelle der Wahrheit, versioniert)
  commands/dd-debate.md     # Orchestrierungs-Command /dd-debate
  config/sources-whitelist.md   # erlaubte Primärquellen für Retrieval
  schemas/                  # JSON-Schemata (Deal, Ledger, Record, Prognose)
  playbook/                 # Checklisten, Basisraten, gelernte Lessons
  beteiligungen/_TEMPLATE/  # Vorlage der lokalen Deal-Historie
```

## Installation als persönliche Agenten

Da `~/.claude/` in dieser Remote-Umgebung ephemer ist, ist **dieses Repo die Quelle der
Wahrheit**. Zum Aktivieren als persönliche Agenten:

```bash
bash pe-lifecycle/install.sh
```

Das kopiert `agents/*.md` → `~/.claude/agents/` und `commands/dd-debate.md` → `~/.claude/commands/`.

## Nutzung

1. Neuen Deal-Ordner aus der Vorlage anlegen: `beteiligungen/<deal-id>/` (Kopie von `_TEMPLATE/`).
2. Data-Room-Dokumente + `00_profile.json` befüllen.
3. Debatte starten: `/dd-debate <deal-id>`

Der Command steuert: **Pseudonymisierung → Bull/Bear/Referee je Workstream (max. 6 Runden bis
Konvergenz) → Entscheidungs-Record + Prognosen**. Offene Punkte werden als `needs-human`
eskaliert, nie erzwungen entschieden.

## Agentenübersicht

| Agent | Rolle |
|-------|-------|
| `pe-bull` | Vertritt den Pro-/Investment-Case, faktenbasiert |
| `pe-bear` | Vertritt den Contra-/Risiko-Case, faktenbasiert |
| `pe-referee` | Neutral: Fakten-Ledger führen, Konvergenz prüfen, Record schreiben |
| `pe-legal-ch` / `pe-legal-de` | Rechtsfragen CH / DE, nur Primärquellen |
| `pe-tax-ch` / `pe-tax-de` | Steuerfragen CH / DE, nur Primärquellen |
| `pe-valuation` | Bewertung/Returns (MOIC/IRR, Wasserfall) für die IC-Phase |
| `pe-anonymizer` | Pseudonymisiert Identitäten vor externen Aufrufen |
| `pe-report-extractor` | Extrahiert KPIs aus heterogenen Reporting-PDFs |
| `pe-reconciler` | Gleicht Prognosen mit Ist ab, erzeugt Lessons (Lern-Loop) |

## Phasen-Commands

| Command | Phase |
|---------|-------|
| `/dd-debate <deal-id>` | Due Diligence (Financial, Tax, Legal, Commercial) |
| `/ic-debate <deal-id>` | Investment Committee / Investment Decision (Go/No-Go, Bewertung, CPs) |
| `/signing-debate <deal-id>` | Signing / Closing (CP-Tracking, SPA-/Vertragswerk-Prüfung) |
| `/monitor <deal-id> [pdf]` | Monitoring / Value Creation (PDF→KPI, Reconciliation/Lern-Loop, Action-Review) |
| `/exit-debate <deal-id>` | Exit (Timing, Kanal, Preis/Struktur, realisierter MOIC) |

Playbooks je Phase unter `playbook/` (`phase-dd.md`, `phase-ic.md`, `phase-signing.md`, `phase-monitoring.md`, `phase-exit.md`).

**Lebenszyklus vollständig abgedeckt:** DD → IC → Signing/Closing → Monitoring → Exit.

## Betrieb & Backlog
- `ops/it-aufgaben.md` — offene Infrastruktur-Aufgaben für IT/DevOps (Retrieval-Freischaltung, Persistenz, Datengovernance …)
- `ops/test-backlog.md` — empfohlene, noch durchzuführende Tests

Konzept-Hintergrund: siehe `docs/beteiligungs-agenten-konzept.md` und
`docs/dd-modul-beispieldurchlauf.md`.
