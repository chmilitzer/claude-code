# Offene Aufgaben für IT / DevOps (Delegation)

Stand: 2026-07-02. Kontext: Agenten-System für den PE-Beteiligungslebenszyklus (`pe-lifecycle/`).
Diese Punkte sind Infrastruktur-/Betriebsaufgaben und liegen außerhalb der Agenten-Logik.

| ID | Priorität | Aufgabe | Details / Akzeptanzkriterium |
|----|-----------|---------|------------------------------|
| IT-1 | **Hoch** | **Primärquellen-Retrieval freischalten** | Beim Testlauf lieferten die Whitelist-Hosts über den Agent-Proxy durchgehend **HTTP 403** (Bot-/Egress-Block). Egress/Allowlist so konfigurieren, dass direkter `WebFetch`-Abruf funktioniert für: `fedlex.admin.ch`, `www.admin.ch`, `estv.admin.ch` (CH) sowie `gesetze-im-internet.de`, `bundesfinanzministerium.de`, `bzst.de` (DE). **AK:** Ein Test-Fetch je Domain liefert HTTP 200 mit Normtext. Ohne dies liefern `pe-legal-ch`/`pe-tax-ch` nur „unsicher – prüfen lassen". |
| IT-2 | **Hoch** | **Persistenz der Agenten** | In der Web-/Remote-Umgebung ist `~/.claude/` ephemer; nach Container-Neustart sind die Agenten weg. **AK:** Entweder (a) SessionStart-Hook, der `bash pe-lifecycle/install.sh` automatisch ausführt, oder (b) durable Home/Volume für `~/.claude`. Empfehlung: (a). |
| IT-3 | **Hoch** | **Datengovernance vertrauliche Deal-Daten** | Echte Data Rooms & `pseudonyms.json` dürfen **nie** ins Git (aktuell via `beteiligungen/.gitignore` geschützt). Verbindlichen, zugriffsgeschützten/verschlüsselten Ablageort für reale Deal-Ordner festlegen. **AK:** Dokumentierter Speicherort + Zugriffskonzept; Bestätigung, dass `pseudonyms.json` lokal bleibt. |
| IT-4 | **Hoch** | **Freigabe externer LLM-Datenfluss** | Governance-Sign-off, dass pseudonymisierte (identitätsmaskierte) Deal-Inhalte an den externen LLM-Dienst gehen dürfen; Klärung Datenresidenz/Retention. **AK:** Schriftliche Freigabe + dokumentierte Policy. |
| IT-5 | Mittel | **Reporting-Zufluss M365/SharePoint** | Reporting-PDFs kommen heterogen. Prüfen, ob `pe-report-extractor` Reports automatisch aus M365/SharePoint (bestehende MCP-Anbindung) ziehen soll. **AK:** Definierter Eingangskanal + Ordnerkonvention `reporting/`. |
| IT-6 | Mittel | **Reconciliation-Automatik** | Geplanter Lauf (Hook/Cron), der beim Eintreffen neuer Reporting-PDFs `pe-report-extractor` + `pe-reconciler` gegen offene Prognosen startet. **AK:** Trigger konfiguriert, dokumentiert. |
| IT-7 | Niedrig | **Backup Lern-Artefakte** | `playbook/lessons.jsonl` und `base-rates.json` sind das „Gedächtnis" — versioniert im Repo, aber Backup-/Aufbewahrungsregel bestätigen. **AK:** Backup-Policy dokumentiert. |

**Hinweis für die Delegation:** IT-1 und IT-2 sind Voraussetzung für belastbare Rechts-/Steuer-Rulings bzw. dauerhafte Nutzung — zuerst angehen.
