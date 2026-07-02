Betreff: Infrastruktur-Anforderungen für unser PE-Beteiligungs-Agentensystem (Priorität: 2 Punkte kurzfristig)

Hallo zusammen,

wir haben einen Prototyp eines KI-Agentensystems aufgebaut, das unseren Beteiligungs-
Lebenszyklus (Due Diligence → Investment Committee → Signing/Closing → Monitoring → Exit)
unterstützt: Zwei Agenten vertreten je Prozessschritt Bull- und Bear-Case und challengen sich
faktenbasiert; Entscheidungen werden lokal protokolliert und Prognosen später gegen das
Reporting abgeglichen (selbstlernender Loop). Der fachliche Teil läuft; für den produktiven,
belastbaren Betrieb brauchen wir eure Unterstützung bei einigen Infrastrukturpunkten.

Die zwei wichtigsten zuerst:

• Rechts-/Steuer-Recherche freischalten (hoch): Die Agenten dürfen für CH/DE-Rechts- und
  Steuerfragen nur offizielle Primärquellen zitieren. Aktuell liefern diese Hosts über unseren
  Netzwerk-Proxy durchgehend HTTP 403 (Bot-/Egress-Sperre), sodass die Schweizer Rulings nur
  „unklar – bitte extern prüfen" zurückgeben. Bitte direkten Abruf freischalten für:
  fedlex.admin.ch, admin.ch, estv.admin.ch (CH) sowie gesetze-im-internet.de,
  bundesfinanzministerium.de, bzst.de (DE).
  Erledigt, wenn: ein Test-Abruf je Domain HTTP 200 mit Rechtstext liefert.

• PDF-Reporting-Pipeline (hoch): Beteiligungs-Reportings sind teils reine Bild-PDFs (Folien als
  Grafik) – Textextraktion liefert dann nichts. Auf der Umgebung fehlt zudem „poppler-utils“,
  was die Bild-/Vision-Verarbeitung blockiert.
  Erledigt, wenn: poppler-utils + eine PDF-nach-Bild-Renderkomponente (z. B. pymupdf) bereitstehen;
  für reine Bild-Decks bitte OCR/Vision einplanen.

Weitere Punkte (mittelfristig):

• Persistenz der Agenten (hoch): Die Agenten-Konfiguration liegt in einem nutzerlokalen Verzeichnis,
  das in der Cloud-Umgebung nach Neustart gelöscht wird. Bitte dauerhaft ablegen – z. B. über einen
  Startskript-Hook, der die Installation automatisch ausführt, oder ein persistentes Volume.

• Datengovernance vertrauliche Deal-Daten (hoch): Echte Data-Room-Inhalte und die lokale
  Klarnamen-Zuordnung dürfen nie in die Versionsverwaltung. Bitte einen zugriffsgeschützten,
  verschlüsselten Ablageort festlegen. (Technisch sind Deal-Ordner bereits per .gitignore
  ausgeschlossen.)

• Freigabe externer KI-Datenfluss (hoch): Governance-Sign-off, dass identitäts-maskierte
  (pseudonymisierte) Deal-Inhalte an den externen KI-Dienst gehen dürfen; Klärung von
  Datenresidenz und Aufbewahrung.

• Reporting-Zufluss (mittel): Prüfen, ob die Reporting-PDFs automatisch aus Microsoft 365 /
  SharePoint gezogen werden sollen (Anbindung ist vorhanden).

• Automatischer Abgleich (mittel): Geplanter Lauf (Hook/Cron), der bei neuem Reporting die
  Extraktion und den Prognose-Ist-Abgleich automatisch startet.

• Backup der Lern-Artefakte (niedrig): Das „Gedächtnis“ des Systems (gelernte Lektionen,
  Kalibrierung) versioniert im Repo – bitte Backup-/Aufbewahrungsregel bestätigen.

Kurzum: Mit der Retrieval-Freischaltung (Punkt 1), der PDF-Pipeline (Punkt 2) und der Persistenz
kommen wir von „Prototyp“ zu „belastbar nutzbar“. Für Rückfragen oder eine kurze Demo stehe ich
gerne bereit.

Besten Dank und viele Grüße
