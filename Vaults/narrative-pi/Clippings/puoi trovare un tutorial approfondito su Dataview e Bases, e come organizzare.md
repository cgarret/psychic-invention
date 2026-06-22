---
title: "puoi trovare un tutorial approfondito su Dataview e Bases, e come organizzare..."
source: "https://www.perplexity.ai/search/714d1054-9fb2-4fb9-a796-4227ed96fbaa"
author:
published:
created: 2026-06-09
description: "Perplexity is a free AI-powered answer engine that provides accurate, trusted, and real-time answers to any question."
tags:
  - "clippings"
---
## puoi trovare un tutorial approfondito su Dataview e Bases, e come organizzare MoC e PKM in Obsidian

## Prima cosa: chiarire l’obiettivo

Si trovano un sacco di risorse su Dataview, Bases, MoC e PKM, ma non esiste un “super tutorial unico” che copra tutto in modo perfetto; conviene combinare 2–3 fonti ben fatte e poi costruire il tuo flusso passo‑passo.kevsrobots+1

Ti propongo questo approccio:

1. Capire quando usare Dataview e quando usare Bases.
2. Seguire 1 tutorial pratico per Dataview.
3. Seguire 1 tutorial pratico per Bases (in italiano, se ti fa comodo).
4. Collegare il tutto alla struttura PKM/MoC del tuo vault.

Se ti va, possiamo poi costruire insieme una struttura concreta per il tuo vault (es. studio, lavoro, progetti, letture).

---

## Dataview vs Bases: quando usare cosa

Un’ottima “cheat sheet” online suggerisce di usarli così:medium+1

- Usa **Bases** quando:
	- Vuoi tabelle/cards cliccabili e modificabili direttamente (tipo mini‑Notion dentro Obsidian).obsidian+1
		- Ti servono filtri e ordinamenti “punta‑e‑clicca” e viste riutilizzabili (es. una base “Progetti” che embeddi ovunque).kevsrobots+1
		- Gestisci cose operative: task, pipeline progetti, reading list, ecc.medium+1
- Usa **Dataview** quando:
	- Vuoi “report” e dashboard dinamiche dentro le note, basate su query testuali.kevsrobots+1
		- Ti servono raggruppamenti, conteggi, colonne derivate, aggregazioni, ecc.medium+1
		- Ti basta una vista in sola lettura (modifichi i file, non le celle), a meno di usare DataviewJS.[medium](https://medium.com/@lennart.dde/obsidian-cheat-sheet-bases-vs-dataview-225b08f5bcf2)

Spesso la combinazione consigliata è:

- tenere tutti i dati in **properties/frontmatter**,
- usare **Bases** per le board operative,
- usare **Dataview** per analisi/report (es. “tutti i progetti in `status: active` raggruppati per area”).kevsrobots+1

---

## Tutorial consigliati su Dataview e Bases

## Dataview (plugin community)

Per capire Dataview in modo pratico, puoi usare una guida che parte da zero e mostra tabelle, elenchi e dashboard di esempio:[kevsrobots](https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html)

Passaggi tipici che troverai:

- Installare il plugin Dataview.
- Aggiungere proprietà nei file (es. `type: articolo`, `status: draft`).
- Scrivere query del tipo:
	- `table file.name, status where contains(tags, "progetto")`
- Creare una nota “dashboard” che raccoglie varie viste (task, note per area, letture, ecc.).[kevsrobots](https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html)

## Bases (plugin core “Base”)

Per Bases, due risorse utili:

- Documentazione ufficiale in italiano “Introduzione a Base” (spiega cosa sono viste, layout, filtri, formule).[obsidian](https://obsidian.md/it/help/bases)
- Una guida pratica Dataview + Bases che mostra come creare una base, filtrare per cartella/tag e modificare proprietà inline.[kevsrobots](https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html)

Nella pratica, per iniziare:

- Abilita il plugin **Base** nei plugin principali.[obsidian](https://obsidian.md/it/help/bases)
- Crea una nuova base e filtra, ad esempio, solo le note dentro `Projects/` o con tag `#project`.obsidian+1
- Aggiungi colonne per proprietà chiave (es. `status`, `area`, `priorità`) e prova a modificare i valori direttamente nella tabella.obsidian+1

Se ti interessa il passaggio da Dataview a Bases, ci sono articoli che spiegano la migrazione (come usare le stesse properties e ricreare le viste principali).[practicalpkm](https://practicalpkm.com/moving-to-obsidian-bases-from-dataview/) [youtube](https://www.youtube.com/watch?v=OR40wWJPEHs)

---

## MoC e PKM in Obsidian (come legare il tutto)

Per PKM e Map of Content, molti utenti Obsidian usano questa idea: le MoC sono note “indice” non lineari che collegano note, non solo liste rigidamente strutturate.publish.obsidian+2

Un flusso tipico che puoi adottare:

- Struttura di base:
	- Una cartella per le **MOC** (es. `00_Maps/`), con file come `0_Atlas`, `0_Studio`, `0_Progetti`.reddit+1
		- Note “inbox”, “notebox”, “outbox” per gestire il ciclo delle note (grezze → in lavorazione → permanenti).[publish.obsidian](https://publish.obsidian.md/les-aventures-quotidiennes/MOC)
- Creare MoC:
	- Crea una nota tipo `MOC – Psicologia` e usala come “indice” dei concetti chiave, aggiungendo link alle note atomiche.[forum.obsidian](https://forum.obsidian.md/t/3-larger-questions-regarding-pkm-and-obsidian-workflow-s/19910/1)
		- Usa backlink e ricerche per trovare note correlate e trascinarle nella MoC.[forum.obsidian](https://forum.obsidian.md/t/3-larger-questions-regarding-pkm-and-obsidian-workflow-s/19910/1)
- Integrare Dataview/Bases:
	- Aggiungi un tag o property (es. `area: psicologia`) alle note di un’area.
		- Dentro la MoC, inserisci:
		- una **tabella Dataview** che elenca tutte le note con `area: psicologia`, magari raggruppate per `tipo` (articolo, libro, idea).medium+1
				- oppure embeddi una **Base** filtrata su quella area (vista tabella o cards).obsidian+1

In questo modo, la tua MoC diventa sia una mappa visuale di link, sia una “dashboard” aggiornata automaticamente delle note rilevanti.

---

## Da dove iniziare, concretamente

Per non perdersi, conviene fare un percorso guidato:

1. **Scegli un’area** (es. “studio”, “progetti lavoro”, “letture”).
2. Crea:
	- 1 **MOC** per quell’area.
		- 1 **Base** che mostra tutte le note di quell’area.
		- 1–2 **query Dataview** nella MoC per viste specifiche (es. solo note `status: da_rivedere`).medium+1
3. Usa quella combinazione per una settimana, poi la estendi ad altre aree del tuo PKM.

Per tarare meglio tutto sul tuo caso: che uso principale fai di Obsidian in questo momento (studio universitario, lavoro, progetti personali, altro)?

progetti personali,lavoro, scrittura

Perfetto, allora impostiamo Dataview + Bases proprio su **progetti personali, lavoro e scrittura**.

Ti propongo una struttura semplice da cui partire e che puoi raffinare strada facendo.

---

## 1\. Struttura del vault per te

Immagina tre “blocchi” principali:

- `01_ProgettiPersonali/`
- `02_Lavoro/`
- `03_Scrittura/` (articoli, newsletter, romanzi, post, ecc.)

Per ciascun blocco:

- 1 nota **MOC** (mappa dei contenuti), ad esempio:
	- `MOC – Progetti Personali`
		- `MOC – Lavoro`
		- `MOC – Scrittura`
- tutte le note singole con **properties** comuni: ad esempio `type`, `status`, `area`, `deadline`, `priority`.reddit+1

Così Bases può leggere e modificare questi campi in modo uniforme, e Dataview può filtrarli facilmente.obsidian+1

---

## 2\. Bases per gestire progetti e scrittura

Per l’uso che descrivi, Bases è ideale come “pannello operativo” dei tuoi progetti e dei pezzi che stai scrivendo.effortlessacademic+1

Esempio pratico:

- Crea una **Base Progetti** che includa:
	- tutti i file dentro `01_ProgettiPersonali/` e `02_Lavoro/`
		- colonne: `status` (idea, in corso, finito), `area` (personale, clienteX, clienteY), `deadline`, `priority`.[obsidian](https://obsidian.md/help/bases)
- Crea una **Base Scrittura** con:
	- tutti i file dentro `03_Scrittura/`
		- colonne: `stato_bozza` (idea, outline, first draft, revisione), `tipo` (post, articolo, sales page, ecc.), `pubblicato?` (checkbox).effortlessacademic+1

Con Bases puoi:

- filtrare velocemente i progetti attivi, quelli in scadenza, o le bozze in revisione;
- spuntare checkbox e cambiare status direttamente in tabella, senza aprire ogni nota.reddit+1

---

## 3\. Dataview per dashboard dentro le MoC

Dentro ogni MOC, Dataview ti serve come “vista intelligente” che si aggiorna da sola.[youtube](https://www.youtube.com/watch?v=GH2vo9lVOg4) [reddit](https://www.reddit.com/r/ObsidianMD/comments/1q8fhgx/dataview_vs_bases/)

Esempi:

- In `MOC – Progetti Personali`:
	- tabella con tutti i progetti `area: personale` e `status != "finito"`.
- In `MOC – Lavoro`:
	- elenco dei progetti per cliente raggruppati per `area` (cliente A, cliente B, ecc.).
- In `MOC – Scrittura`:
	- lista delle bozze con `stato_bozza: "outline"` o `"first draft"` per sapere cosa completare prima.[youtube](https://www.youtube.com/watch?v=GH2vo9lVOg4)

Un buon video in italiano mostra proprio come usare Dataview per creare “database alla Notion” dentro Obsidian, passando per proprietà, tipi di query e filtri, quindi molto adatto al tuo caso.[youtube](https://www.youtube.com/watch?v=GH2vo9lVOg4)

---

## 4\. Come collegare tutto in pratica (mini‑workflow)

Per iniziare domani, potresti:

1. Definire le **properties standard** (es. `area`, `status`, `tipo`, `stato_bozza`, `deadline`) e aggiungerle ai template di progetto e di pezzo di scrittura.[obsidian](https://obsidian.md/help/bases) [youtube](https://www.youtube.com/watch?v=GH2vo9lVOg4)
2. Creare una **Base Progetti** e una **Base Scrittura** e linkarle nelle rispettive MoC con un semplice embed.effortlessacademic+1
3. Dentro le MoC, aggiungere 1–2 **query Dataview** molto semplici (es. “tutti i progetti attivi” e “tutte le bozze da finire”).[youtube](https://www.youtube.com/watch?v=GH2vo9lVOg4)

Così avrai:

- Bases come “scrivania operativa”,
- Dataview per le liste intelligenti dentro le MoC,
- le MoC come mappa concettuale con i link tra le note.

---

Per iniziare davvero operativo: ti interessa partire prima dai **progetti di lavoro**, dai **progetti personali** o dalla parte di **scrittura** (bozze, articoli, ecc.), così ti suggerisco esattamente quali campi usare e che prima Base/Dataview impostare?

dalla parte di scrittura

Perfetto, allora concentriamoci su **scrittura** e costruiamo un mini‑sistema Dataview + Bases + MoC solo per quello.

---

## 1\. Decidere cosa tracci per la scrittura

Prima di toccare Dataview/Bases, chiarisci quali “pezzi” vuoi gestire:

- Idee di articoli/post.
- Bozze in corso.
- Testi consegnati a clienti.
- Pubblicato / non pubblicato.

Per quasi tutti questi casi, tutorial su Dataview e Bases consigliano di usare sempre **properties frontmatter** condivise, perché sono la base sia per le query che per le tabelle di Bases.medium+1

Un set di campi semplice per ogni nota di scrittura potrebbe essere:

- `tipo`: idea, articolo, newsletter, post, sales page…
- `stato_bozza`: idea, outline, first\_draft, revisione, pronto
- `cliente` o `contesto`: personale, blog, ClienteX…
- `pubblicato`: true/false
- `data_scadenza`: se c’è una deadline
- `parole_target`: opzionale

Tutorial Dataview in italiano mostrano proprio come sfruttare questi campi per filtrare e creare “database alla Notion” delle tue note.[kevsrobots](https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html) [youtube](https://www.youtube.com/watch?v=GH2vo9lVOg4)

---

## 2\. Bases come “kanban” dei tuoi testi

Per la scrittura ti conviene usare Bases come “lavagna” dove vedere tutte le bozze, cambiare stato, filtrare per cliente o tipo.[youtube](https://www.youtube.com/watch?v=D5GCovyR2DM) [obsidian](https://obsidian.md/help/bases)

Passi concreti (dopo aver abilitato Bases):

1. Crea una cartella `03_Scrittura/` dove metti tutte le note di scrittura.
2. Crea una **Base Scrittura**:
	- Scope: filtra per cartella `03_Scrittura/`.obsidian+1
		- Colonne: `tipo`, `stato_bozza`, `cliente`, `pubblicato`, `data_scadenza`.
3. Aggiungi una vista **Table** e, se vuoi, una vista **Cards** per avere una sorta di kanban raggruppato per `stato_bozza`.[youtube](https://www.youtube.com/watch?v=D5GCovyR2DM) [obsidian](https://obsidian.md/help/bases)

Il bello di Bases (come mostrano i tutorial dedicati) è che puoi:

- cambiare `stato_bozza` direttamente dalla tabella;
- filtrare in un click per “non pubblicato”, “cliente X”, “in revisione”, ecc.;
- embedare questa base dentro una nota MOC (vedi punto 4).[kevsrobots](https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html) [youtube](https://www.youtube.com/watch?v=D5GCovyR2DM)

---

## 3\. Dataview per le liste intelligenti (per es. “cosa scrivo oggi?”)

Una volta che ogni nota ha i suoi campi, Dataview ti serve per creare **liste mirate** dentro le note.[youtube](https://www.youtube.com/watch?v=GH2vo9lVOg4) [kevsrobots](https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html)

Esempi utili per un’autrice/un autore:

- “Tutte le idee non ancora iniziate” (stato\_bozza = idea).
- “Bozze in revisione con scadenza vicina”.
- “Testi pubblicati quest’anno”.

Il tutorial Dataview in italiano che ti segnalavo prima mostra come creare query `table` e `list` filtrando per tag, cartella e proprietà come farebbe un database.[youtube](https://www.youtube.com/watch?v=GH2vo9lVOg4) [kevsrobots](https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html)

---

## 4\. MOC – Scrittura come cockpit

Ora arriva la parte MoC/PKM: una singola nota tipo `MOC – Scrittura` che diventa il **cruscotto della tua attività di scrittura**.[forum.obsidian](https://forum.obsidian.md/t/3-larger-questions-regarding-pkm-and-obsidian-workflow-s/19910/1) [youtube](https://www.youtube.com/watch?v=U7Dw9gaYrfc)

Dentro `MOC – Scrittura` puoi avere:

- Una sezione “Mappa”:
	- link alle note chiave: “Stile”, “Tone of voice clienti”, “Liste di titoli”, “Template articoli”.
		- link alle serie (es. una serie di newsletter).[youtube](https://www.youtube.com/watch?v=U7Dw9gaYrfc)
- Una sezione “Pipeline”:
	- embed della **Base Scrittura**, magari filtrata solo su `pubblicato: false`.[kevsrobots](https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html) [youtube](https://www.youtube.com/watch?v=D5GCovyR2DM)
- Una sezione “Focus oggi”:
	- 1–2 query Dataview, tipo:
		- tutte le bozze `stato_bozza = "revisione"` con `data_scadenza` nei prossimi X giorni;
				- tutte le `idea` per cui non hai ancora scritto un outline.[youtube](https://www.youtube.com/watch?v=GH2vo9lVOg4) [kevsrobots](https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html)

Così, aprendo una sola nota:

- vedi la mappa concettuale della tua scrittura (PKM vero e proprio),
- hai la lavagna operativa (Bases),
- hai le liste intelligenti guidate dal contesto (Dataview).

---

## 5\. Tutorial mirati da seguire mentre imposti il sistema

Per costruire questo setup mentre lo leggi, ti aiutano molto:

- **Dataview in italiano**: come trasformare le note in un database con tabelle e liste filtrate.[youtube](https://www.youtube.com/watch?v=GH2vo9lVOg4)
- **Tutorial Bases in italiano**: come creare Base, impostare viste, filtri, colonne e incorporare una base in una nota (utile per la tua `MOC – Scrittura`).[youtube](https://www.youtube.com/watch?v=D5GCovyR2DM)
- Una “cheat sheet” che chiarisce ancora quando ha più senso usare Bases e quando Dataview (utilissima per evitare di complicarti la vita).[medium](https://medium.com/@lennart.dde/obsidian-cheat-sheet-bases-vs-dataview-225b08f5bcf2)

Puoi letteralmente tenere aperto il video Dataview e quello Bases da una parte, e dall’altra creare:

1. cartella `03_Scrittura/`,
2. template per “nota di pezzo” con le properties,
3. Base Scrittura,
4. MOC – Scrittura con qualche query Dataview.

---

Per farlo super concreto nel tuo caso: che tipo di scrittura è più urgente ottimizzare adesso (articoli per il blog, contenuti per clienti, newsletter, romanzo, altro)? In base a quello possiamo definire subito i 4–5 campi esatti da usare e la prima query Dataview da creare.

voglio iniziare configurando Templater per il template del capitolo

Ottima scelta partire da Templater: se lo imposti bene, ogni nuovo capitolo nasce già “giusto”.

Ti propongo un percorso in **3 passi concreti**, senza entrare ancora nel codice complesso.

---

## 1\. Setup base di Templater

Passi (riassunto dalle guide base):[youtube](https://www.youtube.com/watch?v=QpJbeP8f55A) reddit+1

1. In Obsidian:
	- Impostazioni → Community plugins → attiva i plugin;
		- “Browse”, cerca **Templater**, installa e abilita.[reddit](https://www.reddit.com/r/ObsidianMD/comments/uatsjz/templater_automatically_assign_templates_based_on/) [youtube](https://www.youtube.com/watch?v=QpJbeP8f55A)
2. Crea una cartella per i template, ad esempio:
	- `00_META/Templates/`
3. In Impostazioni → **Templater**:
	- “Template folder location” → scegli `00_META/Templates/`.[silentvoid13.github](https://silentvoid13.github.io/Templater/settings.html)
		- Attiva “Trigger Templater on new file creation” se vuoi.
		- (Più avanti potrai usare “Folder templates” per dire: per tutti i file in `Romanzo/Capitoli` usa il template capitolo. )reddit+1

A questo punto i file dentro `00_META/Templates/` sono disponibili come template Templater.

---

## 2\. Creare il file di template “Capitolo Romanzo”

Dentro `00_META/Templates/` crea una nota, ad esempio `Template – Capitolo Romanzo`.

Nel corpo della nota metterai:

- In alto: il blocco di **frontmatter** con tutti i campi che abbiamo definito (proprio in stile YAML), con i tuoi valori di default.
- Sotto: una piccola struttura per il contenuto (es. un titolo e due righe vuote).

Le guide su Templater suggeriscono di partire con template “quasi statici” e aggiungere Templater script solo dove serve davvero (es. data, titolo automatico).[cassidoo](https://cassidoo.co/post/obsidian-templater/) [youtube](https://www.youtube.com/watch?v=91H_0ii4S-A&vl=it) [github](https://github.com/Ambi93/Obsidian-Sync/blob/main/Comprehensive%20User%20Guide%20for%20Templater%20in%20Obsidian.md)

---

## 3\. Impostare l’uso del template per i capitoli

Per usare questo template sui capitoli puoi fare in modo semplice, all’inizio:

- Vai nella cartella `03_Scrittura/Romanzo/Capitoli/`.
- Crea una nuova nota per un capitolo (es. `02_CH_TheIntrusion_r00`).
- Lancia il comando Templater “Insert template” e scegli “Template – Capitolo Romanzo”.[youtube](https://www.youtube.com/watch?v=91H_0ii4S-A&vl=it)

Più avanti, quando ti trovi bene:

- in Impostazioni → Templater → **Folder templates**:
	- aggiungi una regola che dice: per la cartella `03_Scrittura/Romanzo/Capitoli/` usa il template “Template – Capitolo Romanzo”;
- così ogni nuova nota in quella cartella partirà già col frontmatter del capitolo, senza doverlo richiamare a mano.reddit+2

Questa funzione (“folder templates”) è proprio pensata per avere un template diverso per ogni tipo di nota (capitoli, scene, personaggi, ecc.).silentvoid13.github+1

---

Quando ti metterai a scriverlo in Obsidian, ti andrebbe di partire creando **materialmente** il file `Template – Capitolo Romanzo` con i campi che abbiamo definito (tipo, progetto, numero\_capitolo, pov, arco, modalita\_mark, trigger, ecc.) e poi raccontarmi che campi hai effettivamente inserito, così possiamo fare un check veloce e vedere se manca qualcosa di ovvio?

si

Perfetto, allora facciamo così: ti lascio una “checklist mentale” molto compatta dei campi che ha senso inserire adesso nel tuo `Template – Capitolo Romanzo`, così puoi crearla in Obsidian e poi tornare qui a dirmi cosa hai messo davvero.

---

## 1\. Campi core da mettere nel frontmatter del template capitolo

Quando crei il file `Template – Capitolo Romanzo`, in alto inserisci questi campi (con i default che ti tornano):

- `tipo: capitolo`
- `progetto: [NOME_ROMANZO]`
- `numero_capitolo:`
- `titolo_capitolo:`
- `stato_bozza: first_draft`
- `parole_target:`
- `parole_reali:`
- `pov:`
- `modalita_mark:`
- `arco:`
- `trigger:`
- `data_scadenza:`
- `luogo_principale:`
- `note_editoriali:`

Questi sono quelli che serviranno subito a Bases e Dataview e nascono da tutto il lavoro che hai già fatto su POV, archi, trigger, stati interni.[02\_CH\_TheIntrusion\_r00.md](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/149548815/759277c7-804e-4dad-9ea5-9cf397d90fbc/02_CH_TheIntrusion_r00.md?AWSAccessKeyId=ASIA2F3EMEYE5M6D34AQ&Signature=YABsTFMC22zGWTwj%2BBHji1ByoTY%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEAgaCXVzLWVhc3QtMSJHMEUCIDThL88LBEyieYinkINQwJ%2BXmEfBAYF1sbbAhCa%2FniLvAiEA3t20PaS3L66KibdDu2l7ezx034ZoaviZYCbM%2FnuZavsq%2FAQI0P%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARABGgw2OTk3NTMzMDk3MDUiDBMoySQcldkhhDrscCrQBEHLmmbXdyljtAECrdfUKn0wpN33VZ1VeMjXQO6IRtjKY9MeqxisfKJUM28bPxYgwvy3zQLqDcqJAG0EZPSmxGX5v4hdLZ6nHvw%2FVanpLyUTAr55CA137RmV%2FxITZV6jFjlCRO16FUjtZC509xQEDCjJ1tR06kpj7hOQeToDFdlq0sod2OKjavNLM%2FuZ%2FJsih2LbDdeVZwpadhQDhNeEBabZgFqobyh6WLfUvSWYBxZ0iOVuhAxN%2B02XHshFy2iQenkgVUvXHEhQ0ynWc8NA%2BxH3SrtuSoCDce4GaOJCVoo60Y4uODZzt58W8Bt%2B9eRi4ZLrDSrehKcqYqLKCIyyf2y%2F%2BhgzECVM8NEQGr4D%2FMJLeMJvEjlFiSkpZSgu1AqXGrlPlgnNrqjNQNtkbT4M12m0m9%2BBycxMJXFUu%2B4ug889S%2BURt2wJQaEOaap0YKhL8WofwVoAU6EJLiIyXuB17Wg5Zz1yzCARvhQMAVxoYZ3D8pfi4yMwMaAv6OSc3slylqWlE4Wl%2BaMAzlydz7KC1S2E6yDaHUBGuYg%2F9vjzpTHFYbW9vjr9PCsLt%2BW5rnzptYf9BsBykZxo2nVdyYhavz5fNd4r0recmMGWY2M4DH8BIhP3ZreguyNChEYJiSoqtIajwwbnOKa3YFpeWhUKr3%2Fb17qct8viNiKvf74V585RxXqLPFdWDGDmK%2Fn4cHoM1Foo4KDPBUCzE6Ip2ylBUggmGrBPdK7K%2Fw6MTybCDCgHKDQlscEqeFtxKIFnHJ0XELwKtzwsM6wcYK%2BUoOSKJcQw%2Fd2g0QY6mAHjdST%2B7K9NJMdo5AyKYahZC3tUxOBFiMSS4Gi2d0sVYCg4wky5mx67WRDL66B%2FbVxjegbvVowm%2B51vrX7Mx98wGOadz2FFDGZ7bbpMHvvPCol%2Fy8%2FXnumBZ7Kuj2yQB2WwUmSm1PaToaHgLteszLrPj3v8iwFRdnNy1p%2FtFtdjZnFRT7%2BQsDw%2Bt0d1qnEgaY6TwVrES5t68A%3D%3D&Expires=1781021904) blacksmithgu.github+1

Sotto il frontmatter puoi aggiungere una piccola struttura, tipo:

- una riga con il titolo capitolo (se ti va di averlo anche nel corpo),
- una riga vuota,
- poi il testo del capitolo.

---

## 2\. Cosa fare adesso in pratica

Passi concreti:

1. In Obsidian, crea `Template – Capitolo Romanzo` nella cartella dei template.[silentvoid13.github](https://silentvoid13.github.io/Templater/settings.html) [youtube](https://www.youtube.com/watch?v=QpJbeP8f55A)
2. Inserisci il blocco frontmatter con questi campi.
3. Salva.
4. Vai sulla nota `02_CH_TheIntrusion_r00` e applica il template, poi compila:
	- `numero_capitolo: 1`
		- `titolo_capitolo: The Intrusion`
		- `pov: Mark`
		- `arco: arco_principale`
		- `modalita_mark:` come la senti (es. “day” che sfocia in crisi)
		- `trigger: cluck`

Così avrai il **primo capitolo reale** che usa il nuovo sistema.

---

Quando hai fatto questo passaggio, mi racconti quali campi hai effettivamente messo nel template (e se ne hai modificati alcuni nomi), così possiamo rivederli insieme e capire se vogliamo aggiungere/togliere qualcosa prima di estenderlo agli altri capitoli?

ok

Perfetto, allora ci fermiamo qui con la teoria e il prossimo passo è tutto pratico in Obsidian.

Riassunto operativo per te:

- Crea il file `Template – Capitolo Romanzo` nella cartella dei template.
- Metti nel frontmatter i campi che abbiamo deciso (tipo, progetto, numero\_capitolo, stato\_bozza, pov, arco, modalita\_mark, trigger, ecc.).
- Applica il template a `02_CH_TheIntrusion_r00` e compila i valori per quel capitolo (Mark, arco\_principale, trigger cluck, ecc.).

Quando hai fatto, torna qui e scrivi cosa hai effettivamente inserito nel frontmatter del template (anche copiando solo l’elenco dei campi e quali hai lasciato vuoti), così possiamo rifinirlo insieme: secondo te, quali 2–3 campi ti sembrano già ora i più importanti da avere davanti mentre scrivi (pov, arco, trigger, stato\_bozza…)?