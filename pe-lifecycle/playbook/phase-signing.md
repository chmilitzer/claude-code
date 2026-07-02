# Playbook – Signing / Closing (Prüfraster)

Diese Phase arbeitet die **IC-Conditions-Precedent** ab und prüft das Vertragswerk (SPA/
Investment Agreement) auf Closing-Reife. Eingang ist der IC-Entscheidungs-Record.

## Eingang (zwingend laden)
- Letzter IC-Record `decisions/<datum>_ic.json` inkl. `conditions` (CPs) und `escalations`.
- SPA-/Investment-Agreement-Entwurf + Disclosure Schedule (aus dem Data Room), sofern vorhanden.
- Offene Prognosen `predictions/open.json`.

## Signing-/Closing-Red-Flag-Gates (Treffer ⇒ zwingend `needs-human`, ggf. hold/abort)
- Gate-kritische IC-CP unerfüllt und nicht bis Closing heilbar (z. B. Seed-Präferenz-Cap ungeklärt,
  Ankerkunden-Renewal offen, IP-Titel ungeheilt)
- Reps & Warranties decken ein identifiziertes Kernrisiko nicht ab
- Indemnity-Cap / Escrow unzureichend gegenüber beziffertem Risiko (IP, Anker, Steuer)
- Fehlender/leerer Disclosure Schedule zu bekannten Risiken
- MAC-/Change-of-Control-Klausel unausgewogen
- Externe CH-Rechts-/Steuerprüfung (403-Punkte) nicht eingeholt

## Prüfdimensionen
### CP-Tracking
- Je IC-CP Status: `erfüllt | teilweise | offen`, mit Beleg. Trenne **Signing-CPs** (vor
  Unterschrift) von **Closing-CPs** (zwischen Signing und Vollzug).

### Vertragswerk (SPA / Investment Agreement) — Legal-Fach-Agenten
- Reps & Warranties (Umfang, Wissensqualifikatoren, Knowledge-Scope)
- Indemnities (Cap, Basket/De-minimis, Survival-Fristen), spezifische Freistellungen (IP/Steuer)
- Escrow / Holdback (Höhe, Dauer, Trigger); ggf. W&I-Versicherung
- Conditions to Closing, MAC-Klausel, Non-Compete/Non-Solicit, Vesting/Leaver
- Governance-Closing-Deliverables (Statuten, ABV/Shareholders' Agreement, Board-Bestellung)

### Funds Flow & Vollzug
- Mittelfluss, Emissionsabgabe/Transaktionskosten (CH), Zahlungsvoraussetzungen, Closing-Mechanik

## Votum (recommendation)
- `proceed` = signing-/closing-reif; `proceed-with-conditions` = Signing mit definierten
  Closing-CPs; `hold` = nicht reif (kritische CP offen); `decline` = Abbruch.
- Gate-kritische offene CP ⇒ höchstens `proceed-with-conditions`; unheilbar ⇒ `hold`/`decline`.

## Prognosen
- milestone: Erfüllung der Closing-CPs bis Vollzugstermin
- valuation/growth/profitability: tragende Annahmen fortschreiben (Abgleich im Monitoring)
