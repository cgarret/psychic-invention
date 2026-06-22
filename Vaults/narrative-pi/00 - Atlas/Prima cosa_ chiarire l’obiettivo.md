<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

## Prima cosa: chiarire l’obiettivo

Si trovano un sacco di risorse su Dataview, Bases, MoC e PKM, ma non esiste un “super tutorial unico” che copra tutto in modo perfetto; conviene combinare 2–3 fonti ben fatte e poi costruire il tuo flusso passo‑passo.[^1_1][^1_2]

Ti propongo questo approccio:

1. Capire quando usare Dataview e quando usare Bases.
2. Seguire 1 tutorial pratico per Dataview.
3. Seguire 1 tutorial pratico per Bases (in italiano, se ti fa comodo).
4. Collegare il tutto alla struttura PKM/MoC del tuo vault.

Se ti va, possiamo poi costruire insieme una struttura concreta per il tuo vault (es. studio, lavoro, progetti, letture).

***

## Dataview vs Bases: quando usare cosa

Un’ottima “cheat sheet” online suggerisce di usarli così:[^1_2][^1_1]

- Usa **Bases** quando:
    - Vuoi tabelle/cards cliccabili e modificabili direttamente (tipo mini‑Notion dentro Obsidian).[^1_3][^1_4]
    - Ti servono filtri e ordinamenti “punta‑e‑clicca” e viste riutilizzabili (es. una base “Progetti” che embeddi ovunque).[^1_3][^1_1]
    - Gestisci cose operative: task, pipeline progetti, reading list, ecc.[^1_1][^1_2]
- Usa **Dataview** quando:
    - Vuoi “report” e dashboard dinamiche dentro le note, basate su query testuali.[^1_2][^1_1]
    - Ti servono raggruppamenti, conteggi, colonne derivate, aggregazioni, ecc.[^1_1][^1_2]
    - Ti basta una vista in sola lettura (modifichi i file, non le celle), a meno di usare DataviewJS.[^1_2]

Spesso la combinazione consigliata è:

- tenere tutti i dati in **properties/frontmatter**,
- usare **Bases** per le board operative,
- usare **Dataview** per analisi/report (es. “tutti i progetti in `status: active` raggruppati per area”).[^1_1][^1_2]

***

## Tutorial consigliati su Dataview e Bases

### Dataview (plugin community)

Per capire Dataview in modo pratico, puoi usare una guida che parte da zero e mostra tabelle, elenchi e dashboard di esempio:[^1_1]

Passaggi tipici che troverai:

- Installare il plugin Dataview.
- Aggiungere proprietà nei file (es. `type: articolo`, `status: draft`).
- Scrivere query del tipo:
    - `table file.name, status where contains(tags, "progetto")`
- Creare una nota “dashboard” che raccoglie varie viste (task, note per area, letture, ecc.).[^1_1]


### Bases (plugin core “Base”)

Per Bases, due risorse utili:

- Documentazione ufficiale in italiano “Introduzione a Base” (spiega cosa sono viste, layout, filtri, formule).[^1_4]
- Una guida pratica Dataview + Bases che mostra come creare una base, filtrare per cartella/tag e modificare proprietà inline.[^1_1]

Nella pratica, per iniziare:

- Abilita il plugin **Base** nei plugin principali.[^1_4]
- Crea una nuova base e filtra, ad esempio, solo le note dentro `Projects/` o con tag `#project`.[^1_3][^1_1]
- Aggiungi colonne per proprietà chiave (es. `status`, `area`, `priorità`) e prova a modificare i valori direttamente nella tabella.[^1_3][^1_1]

Se ti interessa il passaggio da Dataview a Bases, ci sono articoli che spiegano la migrazione (come usare le stesse properties e ricreare le viste principali).[^1_5][^1_6]

***

## MoC e PKM in Obsidian (come legare il tutto)

Per PKM e Map of Content, molti utenti Obsidian usano questa idea: le MoC sono note “indice” non lineari che collegano note, non solo liste rigidamente strutturate.[^1_7][^1_8][^1_9]

Un flusso tipico che puoi adottare:

- Struttura di base:
    - Una cartella per le **MOC** (es. `00_Maps/`), con file come `0_Atlas`, `0_Studio`, `0_Progetti`.[^1_9][^1_7]
    - Note “inbox”, “notebox”, “outbox” per gestire il ciclo delle note (grezze → in lavorazione → permanenti).[^1_7]
- Creare MoC:
    - Crea una nota tipo `MOC – Psicologia` e usala come “indice” dei concetti chiave, aggiungendo link alle note atomiche.[^1_8]
    - Usa backlink e ricerche per trovare note correlate e trascinarle nella MoC.[^1_8]
- Integrare Dataview/Bases:
    - Aggiungi un tag o property (es. `area: psicologia`) alle note di un’area.
    - Dentro la MoC, inserisci:
        - una **tabella Dataview** che elenca tutte le note con `area: psicologia`, magari raggruppate per `tipo` (articolo, libro, idea).[^1_2][^1_1]
        - oppure embeddi una **Base** filtrata su quella area (vista tabella o cards).[^1_3][^1_1]

In questo modo, la tua MoC diventa sia una mappa visuale di link, sia una “dashboard” aggiornata automaticamente delle note rilevanti.

***

## Da dove iniziare, concretamente

Per non perdersi, conviene fare un percorso guidato:

1. **Scegli un’area** (es. “studio”, “progetti lavoro”, “letture”).
2. Crea:
    - 1 **MOC** per quell’area.
    - 1 **Base** che mostra tutte le note di quell’area.
    - 1–2 **query Dataview** nella MoC per viste specifiche (es. solo note `status: da_rivedere`).[^1_2][^1_1]
3. Usa quella combinazione per una settimana, poi la estendi ad altre aree del tuo PKM.

Per tarare meglio tutto sul tuo caso: che uso principale fai di Obsidian in questo momento (studio universitario, lavoro, progetti personali, altro)?
<span style="display:none">[^1_10][^1_11][^1_12][^1_13][^1_14][^1_15]</span>

<div align="center">⁂</div>

[^1_1]: https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html

[^1_2]: https://medium.com/@lennart.dde/obsidian-cheat-sheet-bases-vs-dataview-225b08f5bcf2

[^1_3]: https://obsidian.md/help/bases

[^1_4]: https://obsidian.md/it/help/bases

[^1_5]: https://practicalpkm.com/moving-to-obsidian-bases-from-dataview/

[^1_6]: https://www.youtube.com/watch?v=OR40wWJPEHs

[^1_7]: https://publish.obsidian.md/les-aventures-quotidiennes/MOC

[^1_8]: https://forum.obsidian.md/t/3-larger-questions-regarding-pkm-and-obsidian-workflow-s/19910/1

[^1_9]: https://www.reddit.com/r/ObsidianMD/comments/1lcvqmf/new_obsidian_pkms_user_couple_questions/

[^1_10]: https://www.reddit.com/r/ObsidianMD/comments/1q8fhgx/dataview_vs_bases/

[^1_11]: https://www.youtube.com/watch?v=HwFgaZZbsPY

[^1_12]: https://www.youtube.com/watch?v=nWUQbK8KlOo

[^1_13]: https://remkusdevries.com/from-dataviews-to-bases-in-obsidian/

[^1_14]: https://effortlessacademic.com/using-obsidian-bases-for-academic-note-taking/

[^1_15]: https://www.youtube.com/watch?v=nJ660t5ku9A


---

# progetti personali,lavoro, scrittura

Perfetto, allora impostiamo Dataview + Bases proprio su **progetti personali, lavoro e scrittura**.

Ti propongo una struttura semplice da cui partire e che puoi raffinare strada facendo.

***

## 1. Struttura del vault per te

Immagina tre “blocchi” principali:

- `01_ProgettiPersonali/`
- `02_Lavoro/`
- `03_Scrittura/` (articoli, newsletter, romanzi, post, ecc.)

Per ciascun blocco:

- 1 nota **MOC** (mappa dei contenuti), ad esempio:
    - `MOC – Progetti Personali`
    - `MOC – Lavoro`
    - `MOC – Scrittura`
- tutte le note singole con **properties** comuni: ad esempio `type`, `status`, `area`, `deadline`, `priority`.[^2_1][^2_2]

Così Bases può leggere e modificare questi campi in modo uniforme, e Dataview può filtrarli facilmente.[^2_2][^2_1]

***

## 2. Bases per gestire progetti e scrittura

Per l’uso che descrivi, Bases è ideale come “pannello operativo” dei tuoi progetti e dei pezzi che stai scrivendo.[^2_3][^2_2]

Esempio pratico:

- Crea una **Base Progetti** che includa:
    - tutti i file dentro `01_ProgettiPersonali/` e `02_Lavoro/`
    - colonne: `status` (idea, in corso, finito), `area` (personale, clienteX, clienteY), `deadline`, `priority`.[^2_2]
- Crea una **Base Scrittura** con:
    - tutti i file dentro `03_Scrittura/`
    - colonne: `stato_bozza` (idea, outline, first draft, revisione), `tipo` (post, articolo, sales page, ecc.), `pubblicato?` (checkbox).[^2_3][^2_2]

Con Bases puoi:

- filtrare velocemente i progetti attivi, quelli in scadenza, o le bozze in revisione;
- spuntare checkbox e cambiare status direttamente in tabella, senza aprire ogni nota.[^2_1][^2_2]

***

## 3. Dataview per dashboard dentro le MoC

Dentro ogni MOC, Dataview ti serve come “vista intelligente” che si aggiorna da sola.[^2_4][^2_1]

Esempi:

- In `MOC – Progetti Personali`:
    - tabella con tutti i progetti `area: personale` e `status != "finito"`.
- In `MOC – Lavoro`:
    - elenco dei progetti per cliente raggruppati per `area` (cliente A, cliente B, ecc.).
- In `MOC – Scrittura`:
    - lista delle bozze con `stato_bozza: "outline"` o `"first draft"` per sapere cosa completare prima.[^2_4]

Un buon video in italiano mostra proprio come usare Dataview per creare “database alla Notion” dentro Obsidian, passando per proprietà, tipi di query e filtri, quindi molto adatto al tuo caso.[^2_4]

***

## 4. Come collegare tutto in pratica (mini‑workflow)

Per iniziare domani, potresti:

1. Definire le **properties standard** (es. `area`, `status`, `tipo`, `stato_bozza`, `deadline`) e aggiungerle ai template di progetto e di pezzo di scrittura.[^2_2][^2_4]
2. Creare una **Base Progetti** e una **Base Scrittura** e linkarle nelle rispettive MoC con un semplice embed.[^2_3][^2_2]
3. Dentro le MoC, aggiungere 1–2 **query Dataview** molto semplici (es. “tutti i progetti attivi” e “tutte le bozze da finire”).[^2_4]

Così avrai:

- Bases come “scrivania operativa”,
- Dataview per le liste intelligenti dentro le MoC,
- le MoC come mappa concettuale con i link tra le note.

***

Per iniziare davvero operativo: ti interessa partire prima dai **progetti di lavoro**, dai **progetti personali** o dalla parte di **scrittura** (bozze, articoli, ecc.), così ti suggerisco esattamente quali campi usare e che prima Base/Dataview impostare?
<span style="display:none">[^2_10][^2_11][^2_12][^2_13][^2_14][^2_15][^2_5][^2_6][^2_7][^2_8][^2_9]</span>

<div align="center">⁂</div>

[^2_1]: https://www.reddit.com/r/ObsidianMD/comments/1q8fhgx/dataview_vs_bases/

[^2_2]: https://obsidian.md/help/bases

[^2_3]: https://effortlessacademic.com/using-obsidian-bases-for-academic-note-taking/

[^2_4]: https://www.youtube.com/watch?v=GH2vo9lVOg4

[^2_5]: https://www.youtube.com/watch?v=HwFgaZZbsPY

[^2_6]: https://www.youtube.com/watch?v=nWUQbK8KlOo

[^2_7]: https://remkusdevries.com/from-dataviews-to-bases-in-obsidian/

[^2_8]: https://www.reddit.com/r/ObsidianMD/comments/1fgvyx7/how_can_i_best_organize_2000_notes_by_topicarea/

[^2_9]: https://www.copy42.it/tool-per-lavoro-copywriter/

[^2_10]: https://practicalpkm.com/moving-to-obsidian-bases-from-dataview/

[^2_11]: https://it.indeed.com/q-progetto-scrittura-offerte-lavoro.html

[^2_12]: https://www.youtube.com/watch?v=5CjIh457VOE

[^2_13]: https://twproject.com/blog/it/progetti-e-carico-di-lavoro-delle-risorse-cosa-ce-da-sapere/

[^2_14]: https://www.youtube.com/watch?v=yyced7gwPEI

[^2_15]: https://lacontent.it/lavori-scrittura/


---

# dalla parte di scrittura

Perfetto, allora concentriamoci su **scrittura** e costruiamo un mini‑sistema Dataview + Bases + MoC solo per quello.

***

## 1. Decidere cosa tracci per la scrittura

Prima di toccare Dataview/Bases, chiarisci quali “pezzi” vuoi gestire:

- Idee di articoli/post.
- Bozze in corso.
- Testi consegnati a clienti.
- Pubblicato / non pubblicato.

Per quasi tutti questi casi, tutorial su Dataview e Bases consigliano di usare sempre **properties frontmatter** condivise, perché sono la base sia per le query che per le tabelle di Bases.[^3_1][^3_2]

Un set di campi semplice per ogni nota di scrittura potrebbe essere:

- `tipo`: idea, articolo, newsletter, post, sales page…
- `stato_bozza`: idea, outline, first_draft, revisione, pronto
- `cliente` o `contesto`: personale, blog, ClienteX…
- `pubblicato`: true/false
- `data_scadenza`: se c’è una deadline
- `parole_target`: opzionale

Tutorial Dataview in italiano mostrano proprio come sfruttare questi campi per filtrare e creare “database alla Notion” delle tue note.[^3_3][^3_2]

***

## 2. Bases come “kanban” dei tuoi testi

Per la scrittura ti conviene usare Bases come “lavagna” dove vedere tutte le bozze, cambiare stato, filtrare per cliente o tipo.[^3_4][^3_5]

Passi concreti (dopo aver abilitato Bases):

1. Crea una cartella `03_Scrittura/` dove metti tutte le note di scrittura.
2. Crea una **Base Scrittura**:
    - Scope: filtra per cartella `03_Scrittura/`.[^3_2][^3_5]
    - Colonne: `tipo`, `stato_bozza`, `cliente`, `pubblicato`, `data_scadenza`.
3. Aggiungi una vista **Table** e, se vuoi, una vista **Cards** per avere una sorta di kanban raggruppato per `stato_bozza`.[^3_5][^3_4]

Il bello di Bases (come mostrano i tutorial dedicati) è che puoi:

- cambiare `stato_bozza` direttamente dalla tabella;
- filtrare in un click per “non pubblicato”, “cliente X”, “in revisione”, ecc.;
- embedare questa base dentro una nota MOC (vedi punto 4).[^3_2][^3_4]

***

## 3. Dataview per le liste intelligenti (per es. “cosa scrivo oggi?”)

Una volta che ogni nota ha i suoi campi, Dataview ti serve per creare **liste mirate** dentro le note.[^3_3][^3_2]

Esempi utili per un’autrice/un autore:

- “Tutte le idee non ancora iniziate” (stato_bozza = idea).
- “Bozze in revisione con scadenza vicina”.
- “Testi pubblicati quest’anno”.

Il tutorial Dataview in italiano che ti segnalavo prima mostra come creare query `table` e `list` filtrando per tag, cartella e proprietà come farebbe un database.[^3_3][^3_2]

***

## 4. MOC – Scrittura come cockpit

Ora arriva la parte MoC/PKM: una singola nota tipo `MOC – Scrittura` che diventa il **cruscotto della tua attività di scrittura**.[^3_6][^3_7]

Dentro `MOC – Scrittura` puoi avere:

- Una sezione “Mappa”:
    - link alle note chiave: “Stile”, “Tone of voice clienti”, “Liste di titoli”, “Template articoli”.
    - link alle serie (es. una serie di newsletter).[^3_7]
- Una sezione “Pipeline”:
    - embed della **Base Scrittura**, magari filtrata solo su `pubblicato: false`.[^3_4][^3_2]
- Una sezione “Focus oggi”:
    - 1–2 query Dataview, tipo:
        - tutte le bozze `stato_bozza = "revisione"` con `data_scadenza` nei prossimi X giorni;
        - tutte le `idea` per cui non hai ancora scritto un outline.[^3_2][^3_3]

Così, aprendo una sola nota:

- vedi la mappa concettuale della tua scrittura (PKM vero e proprio),
- hai la lavagna operativa (Bases),
- hai le liste intelligenti guidate dal contesto (Dataview).

***

## 5. Tutorial mirati da seguire mentre imposti il sistema

Per costruire questo setup mentre lo leggi, ti aiutano molto:

- **Dataview in italiano**: come trasformare le note in un database con tabelle e liste filtrate.[^3_3]
- **Tutorial Bases in italiano**: come creare Base, impostare viste, filtri, colonne e incorporare una base in una nota (utile per la tua `MOC – Scrittura`).[^3_4]
- Una “cheat sheet” che chiarisce ancora quando ha più senso usare Bases e quando Dataview (utilissima per evitare di complicarti la vita).[^3_1]

Puoi letteralmente tenere aperto il video Dataview e quello Bases da una parte, e dall’altra creare:

1. cartella `03_Scrittura/`,
2. template per “nota di pezzo” con le properties,
3. Base Scrittura,
4. MOC – Scrittura con qualche query Dataview.

***

Per farlo super concreto nel tuo caso: che tipo di scrittura è più urgente ottimizzare adesso (articoli per il blog, contenuti per clienti, newsletter, romanzo, altro)? In base a quello possiamo definire subito i 4–5 campi esatti da usare e la prima query Dataview da creare.
<span style="display:none">[^3_10][^3_11][^3_12][^3_13][^3_14][^3_15][^3_16][^3_8][^3_9]</span>

<div align="center">⁂</div>

[^3_1]: https://medium.com/@lennart.dde/obsidian-cheat-sheet-bases-vs-dataview-225b08f5bcf2

[^3_2]: https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html

[^3_3]: https://www.youtube.com/watch?v=GH2vo9lVOg4

[^3_4]: https://www.youtube.com/watch?v=D5GCovyR2DM

[^3_5]: https://obsidian.md/help/bases

[^3_6]: https://forum.obsidian.md/t/3-larger-questions-regarding-pkm-and-obsidian-workflow-s/19910/1

[^3_7]: https://www.youtube.com/watch?v=U7Dw9gaYrfc

[^3_8]: https://www.youtube.com/watch?v=HwFgaZZbsPY

[^3_9]: https://practicalpkm.com/moving-to-obsidian-bases-from-dataview/

[^3_10]: https://publish.obsidian.md/simoneriflesso/Obsidian/Personal+Knowledge+Management

[^3_11]: https://remkusdevries.com/from-dataviews-to-bases-in-obsidian/

[^3_12]: https://www.youtube.com/watch?v=nJ660t5ku9A

[^3_13]: https://www.youtube.com/watch?v=nWUQbK8KlOo

[^3_14]: https://www.youtube.com/watch?v=nUHdlVWeWLw

[^3_15]: https://www.reddit.com/r/ObsidianMD/comments/1f4o2ch/how_i_use_obsidian_and_mocs_to_manage_my_vault/

[^3_16]: https://www.youtube.com/watch?v=OR40wWJPEHs


---

# romanzo, contenuti per clienti, articoli

Perfetto, allora impostiamo Obsidian in modo che ti aiuti davvero su **romanzo, clienti e articoli** con un unico schema coerente.

***

## 1. Un solo modello di nota per tutta la scrittura

Prima cosa: un **template di “pezzo di scrittura”** valido per romanzo, contenuti clienti e articoli. I tutorial su Dataview e Bases insistono molto sul riusare sempre le stesse properties per avere basi e query pulite.[^4_1][^4_2]

Campi suggeriti (in alto nella nota, nelle properties):

- `tipo`: romanzo, capitolo, articolo, contenuto_cliente
- `progetto`: titolo del romanzo o nome del cliente, o il nome della serie di articoli
- `stato_bozza`: idea, outline, first_draft, revisione, pronto
- `pubblicato`: true/false
- `data_scadenza`: solo per clienti o articoli, se serve
- `parole_target`: opzionale (utile per romanzo/articoli)

Questi campi sono perfetti sia per **Dataview** (query) sia per **Bases** (tabelle e card editabili).[^4_2][^4_1]

***

## 2. Una Base Scrittura che li vede tutti

Secondo passo: creare una **Base Scrittura** che raccolga romanzo, clienti e articoli nella stessa vista, poi filtrare. I tutorial completi su Bases mostrano come creare una base, scegliere lo scope (cartelle/tag) e impostare colonne e filtri.[^4_3][^4_4]

Impostazione pratica:

- Cartella: `03_Scrittura/` con dentro:
    - sottocartella `Romanzo/` (capitoli, note di trama, ecc.)
    - sottocartella `Clienti/`
    - sottocartella `Articoli/`
- Base:
    - Scope: cartella `03_Scrittura/`.[^4_4][^4_2]
    - Colonne: `tipo`, `progetto`, `stato_bozza`, `pubblicato`, `data_scadenza`, `parole_target`.
    - Viste utili:
        - **Table** filtrata su `tipo = "contenuto_cliente"` per avere la pipeline clienti.
        - **Table** filtrata su `tipo in ("articolo")`.
        - **Cards** raggruppate per `stato_bozza` per vedere a colpo d’occhio cosa è idea, draft, revisione.[^4_3][^4_4]

Da tutorial e guide emerge che questo approccio (un’unica base filtrabile) è più semplice da mantenere rispetto a una base diversa per ogni tipo di scrittura.[^4_5][^4_2]

***

## 3. Dataview per le viste intelligenti per tipo di scrittura

A questo punto hai i dati. Dataview ti serve per farti le **domande giuste** dentro le note MOC.[^4_6][^4_1]

Esempi di viste (basate sui campi sopra):

- **Romanzo** (per la tua `MOC – Romanzo`):
    - lista dei capitoli `tipo = "capitolo"` ordinati per numero, filtrando quelli `stato_bozza != "pronto"`;
    - elenco di note di trama, personaggi, luoghi collegate al progetto del romanzo.[^4_1]
- **Contenuti per clienti** (per `MOC – Clienti` o una MOC per singolo cliente):
    - tutti i pezzi `tipo = "contenuto_cliente"` per un certo `progetto` (es. “Cliente X”) con `pubblicato = false`, ordinati per `data_scadenza`.[^4_6][^4_1]
- **Articoli** (per `MOC – Articoli`):
    - articoli `stato_bozza in ("outline","first_draft")` per scegliere cosa scrivere oggi;
    - articoli `pubblicato = true` nell’ultimo periodo, per avere lo storico.[^4_6]

I tutorial Dataview mostrano proprio questo modo di usare il plugin: properties + query per trasformare i file in dashboard dinamiche.[^4_7][^4_6]

***

## 4. MoC come “hub” separati: Romanzo, Clienti, Articoli

Qui entra il PKM: trasformi tutto in tre **Map of Content** principali che sono il tuo “cervello di scrittura”:[^4_8][^4_9]

- `MOC – Romanzo`
    - link a note di trama, personaggi, luoghi;
    - sezione “Capitoli in lavorazione” con una query Dataview sui capitoli non pronti;
    - embed di una vista filtrata della Base Scrittura solo sul progetto del romanzo (opzionale).[^4_4][^4_1]
- `MOC – Clienti`
    - una sezione per ogni cliente (Clienti A, B, C) con link a briefing, linee guida, ecc.;
    - per ogni cliente, vista Dataview o filtro su Base Scrittura che mostra solo i contenuti di quel cliente non ancora pubblicati.[^4_4][^4_6]
- `MOC – Articoli`
    - sezione idee, sezione articoli in corso, sezione articoli pubblicati;
    - query Dataview per “idee non ancora lavorate” e “articoli in revisione”.[^4_9][^4_6]

Le risorse PKM su Obsidian sottolineano proprio questo: MOC come hub concettuali, basi/query come modo per vedere il “flusso di lavoro” dentro questi hub.[^4_10][^4_8]

***

## 5. Cosa impostare come primissima cosa (domani)

Per partire in modo molto pratico (seguendo ad esempio i tutorial Dataview + Bases che abbiamo citato) puoi fare così:[^4_4][^4_6]

1. Creare il **template di nota di scrittura** con i campi che abbiamo elencato.
2. Applicarlo a:
    - 1–2 capitoli del romanzo,
    - 2–3 contenuti clienti attuali,
    - 2–3 articoli.
3. Creare la **Base Scrittura** che vede solo questi file per iniziare a giocare con filtri e colonne.
4. Creare la nota `MOC – Scrittura` o separare subito in `MOC – Romanzo` / `MOC – Clienti` / `MOC – Articoli` con almeno una query Dataview in ciascuna.

Così in una giornata puoi avere l’ossatura funzionante, e poi la estendi.

***

Per aiutarti davvero passo‑passo: quale dei tre vuoi che impostiamo per primo in modo super concreto, con suggerimento di campi specifici e flusso (romanzo, contenuti per un cliente reale, o articoli per un tuo canale)?
<span style="display:none">[^4_11][^4_12][^4_13][^4_14][^4_15][^4_16][^4_17][^4_18][^4_19]</span>

<div align="center">⁂</div>

[^4_1]: https://blacksmithgu.github.io/obsidian-dataview/

[^4_2]: https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html

[^4_3]: https://www.youtube.com/watch?v=34NAe62IH-M

[^4_4]: https://www.youtube.com/watch?v=D5GCovyR2DM

[^4_5]: https://www.reddit.com/r/ObsidianMD/comments/1o4tqa8/what_are_you_guys_using_obsidians_bases_for/

[^4_6]: https://www.youtube.com/watch?v=GH2vo9lVOg4

[^4_7]: https://www.youtube.com/watch?v=buOxN65U0qE

[^4_8]: https://publish.obsidian.md/simoneriflesso/Obsidian/Personal+Knowledge+Management

[^4_9]: https://www.youtube.com/watch?v=U7Dw9gaYrfc

[^4_10]: https://forum.obsidian.md/t/3-larger-questions-regarding-pkm-and-obsidian-workflow-s/19910/1

[^4_11]: https://www.youtube.com/watch?v=1Mgsdpy7awE

[^4_12]: https://effortlessacademic.com/using-obsidian-bases-for-academic-note-taking/

[^4_13]: https://www.youtube.com/watch?v=9Yt52zJIIG0

[^4_14]: https://alessandromastrofini.it/it/2022/09/22/utilizzare-obsidian/

[^4_15]: https://forum.obsidian.md/t/bases-migration-quick-start-guide/101571

[^4_16]: https://it.linkedin.com/pulse/obsidian-il-re-degli-strumenti-di-produttività-luca-nardotto-hjgqf

[^4_17]: https://www.reddit.com/r/ObsidianMD/comments/17siuxx/writers_how_do_you_use_obsidian_and_what_do_you/

[^4_18]: https://evernote.com/it-it/user-stories/the-pkm-enthusiast-who-tried-obsidian-tana-logseq-and

[^4_19]: https://www.youtube.com/watch?v=38rRx8Ll8uU


---

# romanzo

Perfetto, allora costruiamo il sistema intorno al **romanzo**.

***

## 1. Struttura minimo per il romanzo

Per il romanzo, molti scrittori che usano Obsidian tengono separati **capitoli** e **note di worldbuilding** (personaggi, luoghi, trama).[^5_1][^5_2]

Una struttura semplice:

- `03_Scrittura/Romanzo/`
    - `Capitoli/`
    - `Personaggi/`
    - `Luoghi/`
    - `Trama/`
    - `MOC – Romanzo.md` (il tuo hub principale)[^5_2]

***

## 2. Template di nota capitolo

Tutorial Dataview/Bases consigliano un set ridotto di properties ben pensate, riusate dappertutto.[^5_3][^5_4]

Per ogni **capitolo**:

- `tipo`: capitolo
- `progetto`: titolo romanzo (es. “Romanzo_X”)
- `numero_capitolo`: 1, 2, 3…
- `stato_bozza`: idea, outline, first_draft, revisione, pronto
- `parole_target`: es. 1500
- `parole_reali`: da aggiornare ogni tanto (manuale o con plugin)
- `punto_vista`: personaggio, se usi POV
- `data_scadenza`: opzionale (se ti dai deadline interne)

Questi campi funzionano benissimo sia in **Bases** (vista tabellare dei capitoli) sia in **Dataview** (liste e raggruppamenti).[^5_4][^5_3]

***

## 3. Base “Capitoli Romanzo”

Con questa struttura puoi creare una **Base** dedicata ai capitoli:

- Scope: cartella `03_Scrittura/Romanzo/Capitoli/`.[^5_5][^5_3]
- Colonne principali:
    - `numero_capitolo`
    - `stato_bozza`
    - `parole_target`
    - `parole_reali`
    - `punto_vista`
- Viste utili:
    - Table ordinata per `numero_capitolo` per vedere dove sei nella pipeline.[^5_6][^5_5]
    - Cards raggruppate per `stato_bozza` per capire quante sono in outline/draft/revisione.[^5_6]

I tutorial Bases mostrano proprio questo uso per “libri/progetti”: una tabella dove vedi tutti i capitoli, modifichi lo stato, controlli avanzamento parole.[^5_7][^5_6]

***

## 4. Dataview dentro “MOC – Romanzo”

Dentro la nota `MOC – Romanzo`, puoi usare Dataview come cruscotto.[^5_2][^5_4]

Sezioni utili:

- **Mappa narrativa**
    - link alla nota “Trama generale”
    - link a `MOC – Personaggi`, `MOC – Luoghi`, ecc.[^5_8][^5_2]
- **Capitoli in lavorazione**
    - query Dataview che mostra i capitoli con `stato_bozza != "pronto"`, ordinati per `numero_capitolo`.[^5_9][^5_4]
- **Focus oggi**
    - query Dataview che filtra capitoli `stato_bozza in ("outline","first_draft")` magari limitata ai prossimi N capitoli sul cronoprogramma.[^5_10][^5_4]

I tutorial Dataview spiegano bene come filtrare per cartella (`Capitoli`), per proprietà (`stato_bozza`) e ordinare per `numero_capitolo`, quindi sei copert* con gli strumenti tecnici.[^5_4][^5_9]

***

## 5. Workflow pratico di scrittura col romanzo

Mettendo tutto insieme, il flusso potrebbe essere:

1. Crei le note di capitolo con il template e compili i campi base (numero, stato, parole target).[^5_3][^5_4]
2. Apri `MOC – Romanzo`:
    - vedi a colpo d’occhio quali capitoli sono da outline, da scrivere o da revisionare (grazie a Dataview),
    - se vuoi, hai embed della Base dei capitoli per cambiare stato/parole direttamente dalla tabella.[^5_5][^5_6]
3. Ogni volta che lavori su un capitolo:
    - aggiorni `stato_bozza` (es. da outline → first_draft → revisione → pronto),
    - aggiorni eventualmente `parole_reali`.[^5_6]

Così il PKM non è solo archivio, ma ti guida nel processo creativo.

***

Per renderlo subito concreto: hai già note di capitolo in Obsidian o stai ancora scrivendo il romanzo altrove (Word, Google Docs, ecc.)? In base a questo, il prossimo passo può essere creare il **template capitolo** oppure capire come importare e trasformare i capitoli esistenti.

<div align="center">⁂</div>

[^5_1]: https://www.reddit.com/r/ObsidianMD/comments/17siuxx/writers_how_do_you_use_obsidian_and_what_do_you/

[^5_2]: https://publish.obsidian.md/simoneriflesso/Obsidian/Personal+Knowledge+Management

[^5_3]: https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html

[^5_4]: https://blacksmithgu.github.io/obsidian-dataview/

[^5_5]: https://www.youtube.com/watch?v=34NAe62IH-M

[^5_6]: https://www.youtube.com/watch?v=D5GCovyR2DM

[^5_7]: https://www.reddit.com/r/ObsidianMD/comments/1o4tqa8/what_are_you_guys_using_obsidians_bases_for/

[^5_8]: https://www.youtube.com/watch?v=38rRx8Ll8uU

[^5_9]: https://www.youtube.com/watch?v=buOxN65U0qE

[^5_10]: https://www.youtube.com/watch?v=1Mgsdpy7awE


---

# ho bozze di capitoli, per la quasi totalita in woerd, voglio migrare il tuttoo su obssidian

Answer skipped.
<span style="display:none">[^6_1][^6_10][^6_2][^6_3][^6_4][^6_5][^6_6][^6_7][^6_8][^6_9]</span>

<div align="center">⁂</div>

[^6_1]: https://obsidian.md/it/help/import/markdown

[^6_2]: https://obsidian.md/it/help/data-storage

[^6_3]: https://www.youtube.com/watch?v=HmQCJo964Pc

[^6_4]: https://www.youtube.com/watch?v=FjkMf2KprnA

[^6_5]: https://obsidian.md/it/help/plugins/format-converter

[^6_6]: https://obsidian.md/it/help/import/html

[^6_7]: https://obsidian.md/it/help/plugins/file-explorer

[^6_8]: https://obsidian.md/it/help/obsidian

[^6_9]: https://www.youtube.com/watch?v=0I_NDSL4enE

[^6_10]: https://alessandromastrofini.it/it/2022/11/02/obsidian-massimizzato/


---

# ho capitoli

Perfetto, allora lavoriamo proprio sul caso: **capitoli del romanzo oggi in Word, da migrare tutti in Obsidian**.

Ti propongo un flusso semplice in 3 blocchi:

1. Come portare i capitoli da Word a Markdown/Obsidian.
2. Come applicare il template “capitolo” quando arrivano in Obsidian.
3. Come controllare che Bases + Dataview li vedano bene.

***

## 1. Migrare i capitoli da Word a Obsidian

Obsidian lavora al meglio con file **Markdown** salvati nella cartella del vault.[^7_1][^7_2]

Opzione pratica (un po’ manuale ma pulita):

- Apri un capitolo in Word.
- Salva/esporta il testo in un formato semplice:
    - o copia‑incolla in un nuovo file `.md` dentro la cartella `Capitoli` del vault,
    - oppure, se il tuo Word lo permette, esporta in `.txt`/`.md` e poi sposta il file in Obsidian.[^7_2]
- Ripeti per ogni capitolo (anche solo per i 3–4 più recenti per iniziare).

Obsidian ha strumenti di import per markdown e formati semplici, quindi una volta che i testi sono in `.md` e nella cartella del vault, per lui sono note normali.[^7_3][^7_2]

Per ora, non preoccuparti di formattazione perfetta: l’importante è che ogni capitolo sia una **nota separata**.

***

## 2. Aggiungere properties e template ai capitoli importati

Quando i capitoli sono in Obsidian, il passo chiave è dare a ciascuno le **properties** standard che userai in Dataview/Bases.[^7_4][^7_5]

Per ogni nota capitolo:

- Metti in alto (properties):
    - `tipo`: capitolo
    - `progetto`: nome del romanzo (sempre lo stesso per tutti i capitoli)
    - `numero_capitolo`: 1, 2, 3…
    - `stato_bozza`: ad esempio `first_draft` per quelli già scritti in Word, `revisione` se li stai rivedendo
    - `parole_target`: opzionale
    - `parole_reali`: se vuoi puoi lasciarlo vuoto e riempirlo dopo
- Poi sotto lasci il testo del capitolo.

Dopo aver fatto questo per 3–4 capitoli, vale la pena creare un **template “Capitolo Romanzo”** con queste properties già pronte, per i nuovi capitoli che scriverai direttamente in Obsidian.[^7_6][^7_7]

***

## 3. Controllare con Bases e Dataview che tutto funzioni

A questo punto entra la parte “database”:

- Crea una **Base** sulla cartella `Capitoli` del romanzo.
    - Obsidian (con Bases abilitato) ti permette di scegliere la cartella come sorgente e vedere tutte le note capitolo in tabella.[^7_3][^7_6]
    - Aggiungi colonne per `numero_capitolo`, `stato_bozza`, `parole_target`, `parole_reali`.[^7_8][^7_4]
    - Se vedi i capitoli corretti e riesci a cambiare `stato_bozza` dalla tabella, la migrazione è “viva”.
- Crea nella nota `MOC – Romanzo` una prima **query Dataview** molto semplice che elenchi tutti i capitoli con `tipo = "capitolo"` ordinati per `numero_capitolo`.[^7_5][^7_9]

Così verifichi subito che:

- i capitoli importati sono letti correttamente dalle query;
- le properties che hai scelto ti permettono già di vedere lo stato del romanzo “a colpo d’occhio”.

***

Per non farlo astratto: quanti capitoli circa hai già in Word (una decina, di più, di meno)? In base a questo, possiamo decidere se conviene importarli tutti subito o fare prima una “prova” con 3–4 capitoli e verificare che il sistema ti piace.
<span style="display:none">[^7_10][^7_11][^7_12][^7_13][^7_14][^7_15][^7_16][^7_17][^7_18][^7_19]</span>

<div align="center">⁂</div>

[^7_1]: https://obsidian.md/it/help/data-storage

[^7_2]: https://obsidian.md/it/help/import/markdown

[^7_3]: https://obsidian.md/it/help/plugins/format-converter

[^7_4]: https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html

[^7_5]: https://blacksmithgu.github.io/obsidian-dataview/

[^7_6]: https://obsidian.md/it/help/plugins/file-explorer

[^7_7]: https://alessandromastrofini.it/it/2022/11/02/obsidian-massimizzato/

[^7_8]: https://www.youtube.com/watch?v=34NAe62IH-M

[^7_9]: https://www.youtube.com/watch?v=buOxN65U0qE

[^7_10]: https://it.wikipedia.org/wiki/Capitolo_(testo)

[^7_11]: https://www.treccani.it/vocabolario/capitolo/

[^7_12]: https://www.treccani.it/enciclopedia/capitolo_(Enciclopedia-Italiana)/

[^7_13]: https://it.wikipedia.org/wiki/Capitolo

[^7_14]: https://dizionari.corriere.it/dizionario_italiano/C/capitolo.shtml

[^7_15]: https://it.wikipedia.org/wiki/Capitolo_(cristianesimo)

[^7_16]: https://it.wikipedia.org/wiki/Capitoli_di_Beelzebub

[^7_17]: https://sapere.virgilio.it/parole/sinonimi-e-contrari/capitoli

[^7_18]: https://it.wikipedia.org/wiki/Capitoli_di_Pok%C3%A9mon_-_La_grande_avventura

[^7_19]: https://it.wikipedia.org/wiki/Capitoli_di_Tokyo_Ghoul?oldformat=true


---

# ho 10 capitoli , conviene fare la prova con 3 articoli

Ottima scelta: con 10 capitoli, fare una **prova con 3** è perfetto per testare template, Bases e Dataview senza incasinare tutto.

Ti propongo un mini‑percorso molto concreto.

***

## 1. Scegli i 3 capitoli “pilota”

Prendi:

- 1 capitolo abbastanza pulito,
- 1 un po’ più lungo,
- 1 magari ancora in revisione.

Così testi diversi stati della bozza nel sistema.

***

## 2. Porta questi 3 capitoli in Obsidian

Per ciascuno dei 3:

1. Apri il file Word.
2. Crea in Obsidian una nuova nota in `03_Scrittura/Romanzo/Capitoli/` (es. `Capitolo 01`, `Capitolo 02`…).
3. Copia‑incolla il testo dal Word alla nota.
Obsidian lavora nativamente con file Markdown, quindi il semplice copia‑incolla in una nota va benissimo per iniziare.[^8_1][^8_2]

Non curarti troppo della formattazione: l’importante ora è **avere 3 note capitolo separate** dentro la cartella `Capitoli`.[^8_1]

***

## 3. Aggiungi le properties ai 3 capitoli

In ognuna delle 3 note, in alto, aggiungi le properties che userai poi per tutte:

- `tipo`: capitolo
- `progetto`: nome del romanzo (sempre lo stesso)
- `numero_capitolo`: 1, 2, 3…
- `stato_bozza`: es. `first_draft` per quelli già scritti, `revisione` se li stai sistemando
- `parole_target`: solo se ti aiuta
- `parole_reali`: puoi lasciarlo vuoto per ora

Questo è il pezzo che permette poi a Bases/Dataview di funzionare bene.[^8_3][^8_4]

Se vedi che questo schema ti torna, potrai trasformarlo in **template “Capitolo Romanzo”** e non pensarci più per i futuri capitoli.[^8_5]

***

## 4. Crea la Base solo sui 3 capitoli

Ora testa se “il cervello di Obsidian” vede i tuoi capitoli.

- Crea una **Base** nuova e scegli come sorgente la cartella `Capitoli`.[^8_6][^8_5]
- Aggiungi colonne:
    - `numero_capitolo`
    - `stato_bozza`
    - `parole_target`
- Ordina per `numero_capitolo`.[^8_7]

Se vedi comparire i 3 capitoli in tabella e riesci a cambiare `stato_bozza` da lì, vuol dire che il modello funziona e vale la pena migrare gli altri 7 allo stesso modo.[^8_8][^8_7]

***

## 5. Primo passo Dataview nella MOC – Romanzo

Infine, crea `MOC – Romanzo` e, per ora, mettici solo:

- qualche link di contesto (Trama, Personaggi, ecc., anche vuoti),
- una prima query Dataview che elenca i capitoli in ordine di `numero_capitolo`.[^8_4][^8_9]

L’obiettivo è che **da una sola nota** tu possa:

- cliccare sui capitoli,
- vedere a che stato sono (grazie a Dataview e alle properties),
- aprire se vuoi la Base dei capitoli per modificare lo stato in modo “da foglio di calcolo”.[^8_7][^8_8]

***

Se ti va, nel prossimo passo possiamo definire insieme **esattamente** il testo del template “Capitolo Romanzo” (solo struttura e campi, niente contenuto creativo) così lo puoi creare una volta sola e applicarlo ai 10 capitoli: ti interessa che il template includa anche link a Personaggi/Luoghi/Trama oppure preferisci tenerlo minimale all’inizio?
<span style="display:none">[^8_10][^8_11][^8_12][^8_13][^8_14][^8_15][^8_16][^8_17]</span>

<div align="center">⁂</div>

[^8_1]: https://obsidian.md/it/help/import/markdown

[^8_2]: https://obsidian.md/it/help/data-storage

[^8_3]: https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html

[^8_4]: https://blacksmithgu.github.io/obsidian-dataview/

[^8_5]: https://obsidian.md/it/help/plugins/file-explorer

[^8_6]: https://obsidian.md/it/help/plugins/format-converter

[^8_7]: https://www.youtube.com/watch?v=34NAe62IH-M

[^8_8]: https://www.youtube.com/watch?v=D5GCovyR2DM

[^8_9]: https://www.youtube.com/watch?v=buOxN65U0qE

[^8_10]: https://www.reddit.com/r/Universitaly/comments/1d1mk18/scrivere_la_tesi_in_23_giorni/

[^8_11]: https://www.youtube.com/watch?v=CBKIJuIZox8

[^8_12]: https://maddmaths.simai.eu/divulgazione/apologia-delle-prove/

[^8_13]: https://www.uniecampus.it/fileadmin/user_upload/provafinale/La_tesi_di_laurea.pdf

[^8_14]: https://www.scribbr.it/struttura-tesi/indice-tesi/

[^8_15]: https://www.youtube.com/watch?v=BJhm04yOHcw

[^8_16]: https://avvocatomattiafontana.com/messa-alla-prova/

[^8_17]: https://www.tiktok.com/@maestrafede_/video/7187382115560852742


---

# minimale all'inizio

Perfetto, allora partiamo da un **template capitolo super minimale**, pensato per lavorare bene con Bases e Dataview, e poi lo arricchirai quando ti sentirai più a tuo agio.

***

## 1. Quali campi mettere (solo l’essenziale)

Per i capitoli, tieniamo solo ciò che serve per:

- sapere dove si collocano nel romanzo,
- capire a che punto è la bozza,
- poterli filtrare/ordinare.

Campi minimi:

- `tipo`
- `progetto`
- `numero_capitolo`
- `stato_bozza`
- `parole_target` (facoltativo ma utile)
- `parole_reali` (puoi compilarlo in seguito)

Questi sono esattamente il tipo di properties che le guide Dataview/Bases suggeriscono per avere buone tabelle e query.[^9_1][^9_2]

***

## 2. Struttura minimale del template capitolo

Nel template (in Obsidian, se usi i Template core plugin), crea qualcosa di questo tipo come struttura:

- blocco properties in alto con i campi vuoti o preimpostati:
    - `tipo`: capitolo
    - `progetto`: nome fisso del romanzo
    - `numero_capitolo`: da compilare ogni volta
    - `stato_bozza`: default `first_draft` (poi cambi se è revisione)
    - `parole_target`: vuoto o un numero standard
    - `parole_reali`: vuoto
- una semplice intestazione nel corpo della nota (es. titolo capitolo) e poi spazio per il testo.

Così ogni nuovo capitolo che creerai da template nasce già “leggibile” da Bases e Dataview, senza distrazioni.[^9_3][^9_4]

***

## 3. Come usarlo con i 3 capitoli di prova

Per i 3 capitoli che vuoi usare come test:

1. Crea una nota capitolo, applica il template minimale.
2. Incolla il testo del capitolo sotto le properties.
3. Compila solo:
    - `numero_capitolo`
    - `stato_bozza` (es. `first_draft` o `revisione`)
    - eventualmente `parole_target`.

Quando poi avrai la Base dei capitoli e una query Dataview nella MOC, vedrai subito se questi campi ti bastano o se ti manca qualcosa di ovvio da aggiungere.[^9_4][^9_5]

***

## 4. Prossimo micro‑passo

Il passo successivo potrebbe essere:

- importare i 3 capitoli in Obsidian con questo template,
- verificare che:
    - la Base li veda correttamente in tabella,
    - una query Dataview in `MOC – Romanzo` li elenchi in ordine di `numero_capitolo`.[^9_2][^9_6]

Una volta che questo funziona, potrai:

- creare gli altri 7 capitoli con lo stesso schema,
- e solo dopo, pensare a template separati per Personaggi/Luoghi.

Per capire quanto dettaglio mettere nelle properties: ti piacerebbe in futuro tenere traccia anche del **punto di vista** (POV) e dell’**arco narrativo** in ogni capitolo, oppure per ora vuoi proprio solo “numero + stato bozza”?

<div align="center">⁂</div>

[^9_1]: https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html

[^9_2]: https://blacksmithgu.github.io/obsidian-dataview/

[^9_3]: https://obsidian.md/it/help/plugins/file-explorer

[^9_4]: https://www.youtube.com/watch?v=D5GCovyR2DM

[^9_5]: https://www.youtube.com/watch?v=34NAe62IH-M

[^9_6]: https://www.youtube.com/watch?v=buOxN65U0qE


---

# si mi piacerebbe tenerne traccia.  Avevo fatto uno script in powershell che mi scompone il doc in 10 capitoli md. vorrei creare un automatismo che  esegue il porting su  Obsidiane usando i template

Ottimo, allora facciamo due cose insieme:

1. Aggiungiamo ai capitoli i campi per **POV** e **arco narrativo**.
2. Progettiamo l’**automatismo con PowerShell** che prende i 10 `.md` e ci incolla sopra il “template capitolo” in YAML/frontmatter.

Ti tratto come già a tuo agio con un minimo di scripting.

***

## 1. Campi extra per scrittore: POV e arco

Per tenere traccia di POV e arco narrativo, puoi estendere il modello minimale così:

Properties per ogni capitolo:

- `tipo`: capitolo
- `progetto`: nome romanzo
- `numero_capitolo`: 1, 2, …
- `stato_bozza`: idea / outline / first_draft / revisione / pronto
- `parole_target`: numero
- `parole_reali`: numero
- `pov`: nome del personaggio (o “onnisciente”, ecc.)
- `arco`: nome dell’arco narrativo (es. “arco_principale”, “arco_lavoro”, “flashback_infanzia”)

Questo tipo di properties è esattamente quello che altri scrittori usano in Obsidian per marcare scene/chapters con POV, location, arco, ecc.[^10_1][^10_2]

Ti permetterà in Dataview di fare cose come:

- tutti i capitoli in POV “Personaggio X”;
- capitoli che appartengono a un certo arco;
- conteggio di parole per POV o per arco.[^10_3][^10_4]

***

## 2. Idea dell’automatismo con PowerShell

Dato che hai già uno script che spezza il doc in 10 file `.md`, il passo successivo è:

- prendere tutti i `.md` in `Capitoli/`
- **prepending** un blocco YAML/frontmatter con i campi del template (vuoti o con valori calcolati)
- lasciando il testo del capitolo così com’è.

Sul forum Obsidian ci sono esempi di script PowerShell che aggiungono frontmatter in massa ai markdown (aggiungendo proprietà o liste), e funzionano proprio leggendo il contenuto, costruendo il blocco `--- … ---` e riscrivendo il file.[^10_5][^10_6][^10_7]

La logica tipica è:

1. Leggi il contenuto originale del file in una stringa.[^10_7]
2. Costruisci una stringa `frontmatter` con qualcosa tipo:
    - `tipo: capitolo`
    - `progetto: <nome romanzo>`
    - `numero_capitolo: <ricavato dal nome file>`
    - `stato_bozza: first_draft`
    - `pov:`
    - `arco:`
3. Scrivi di nuovo il file come:
    - frontmatter
    - riga vuota
    - testo originale del capitolo.[^10_5][^10_7]

Ci sono anche moduli PowerShell già pronti per aggiungere properties a centinaia di file markdown in un colpo solo.[^10_6][^10_8]

***

## 3. Come sfruttare il nome file per riempire i campi

Se i tuoi file già escono come `Capitolo 01.md`, `Capitolo 02.md`, ecc., lo script può estrarre il numero di capitolo dal nome base e usarlo per `numero_capitolo`.[^10_7][^10_5]

Flusso classico visto negli esempi del forum:

- Loop su tutti i `*.md` in `Capitoli/`.[^10_5]
- Per ogni file:
    - prendi `$file.BaseName`
    - estraine la parte numerica (es. 01 → 1)
    - costruisci YAML con `numero_capitolo: 1`, ecc.
    - prependi questo YAML al contenuto esistente.[^10_7]

Per `pov` e `arco`, ha senso lasciarli vuoti nel frontmatter generato e poi compilarli a mano in Obsidian (lo fai una volta per capitolo). Bases e l’interfaccia Properties rende la modifica veloce.[^10_9][^10_10]

***

## 4. Collegamento con template Obsidian

Due strade possibili:

- **Strada 1 (più semplice)**:
Usi PowerShell per aggiungere il frontmatter direttamente, senza passare dai template Obsidian. I template serviranno solo per i capitoli nuovi che scriverai.
    - Pro: lo script è lineare.
    - Contro: se cambi il template in futuro, dovrai aggiornare i file vecchi via script di nuovo.
- **Strada 2 (più raffinata)**:
Fai sì che lo script generi i file direttamente già con la struttura del template (come fa quello shell pubblicato online che crea nuove note con frontmatter e le apre in Obsidian).[^10_11]
    - Pro: ogni nuovo capitolo nasce uguale.
    - Contro: devi coordinare il flusso tra lo script che genererà i file e Obsidian (più logica nello script).[^10_11]

Visto che hai già 10 capitoli, per ora la Strada 1 (script che aggiunge frontmatter ai `.md` già esistenti) è più rapida.

***

## 5. Prossimo passo pratico

Per restare nel “minimal ma potente”, un buon prossimo passo potrebbe essere:

1. Definire **testualmente** il blocco YAML del tuo template capitolo (solo struttura, senza contenuto creativo).
2. Adattare il tuo script PowerShell che già divide il doc in 10 `.md` per:
    - loopare sui file in `Capitoli/`
    - inserire quel blocco YAML all’inizio di ciascun file (con `numero_capitolo` derivato dal nome).[^10_5][^10_7]

A quel punto:

- apri Obsidian,
- vedi le Properties già impostate,
- Bases e Dataview possono iniziare a lavorare sopra questi capitoli.

***

Per procedere bene: preferisci che ti aiuti prima a definire **con precisione tutti i campi del blocco YAML capitolo (includendo pov e arco)**, oppure vuoi concentrarti subito sulla logica dello script (come strutturare in generale il PowerShell che li aggiunge ai file)?
<span style="display:none">[^10_12][^10_13][^10_14][^10_15][^10_16][^10_17]</span>

<div align="center">⁂</div>

[^10_1]: https://github.com/MattWilcox/obsidian-story-starter

[^10_2]: https://forum.obsidian.md/t/plugin-storyline-obsidian-plugin-for-writers/111494?page=5

[^10_3]: https://blacksmithgu.github.io/obsidian-dataview/

[^10_4]: https://www.youtube.com/watch?v=buOxN65U0qE

[^10_5]: https://forum.obsidian.md/t/insert-title-into-front-matter-powershell-script/23966

[^10_6]: https://forum.obsidian.md/t/add-a-property-to-1-500-files/67793/17

[^10_7]: https://gist.github.com/spech66/d9031d299d664922b347238557bb5d4d

[^10_8]: https://forum.obsidian.md/t/add-a-property-to-1-500-files/67793

[^10_9]: https://www.youtube.com/watch?v=RrxqkIhh9L8

[^10_10]: https://parazettel.com/articles/obsidian-properties-productive/

[^10_11]: https://notes.samfeldstein.xyz/notes/apply-a-default-template-in-obsidian-using-a-shell-script/

[^10_12]: https://forum.obsidian.md/t/adding-frontmatter-with-template/76281

[^10_13]: https://forum.obsidian.md/t/access-frontmatter-in-markdowncodeblockprocessor/58192

[^10_14]: https://www.obsidianstats.com/plugins/auto-front-matter

[^10_15]: https://forum.obsidian.md/t/how-to-add-frontmatter-to-already-existing-notes/48118

[^10_16]: https://news.ycombinator.com/item?id=37484917

[^10_17]: https://forum.obsidian.md/t/transfer-inline-properties-to-front-matter/104577


---

# preferirei definire tutti i campi del blocco YAML

Ottima scelta: se il blocco YAML è pensato bene, tutto il resto (Bases, Dataview, script) diventa molto più semplice.

Ti propongo un **blocco YAML capitolo** pensato per:

- romanzo lungo,
- gestione POV, archi narrativi e stato bozza,
- uso con Bases/Dataview.[^11_1][^11_2]

***

## 1. Campi fondamentali (strutturali)

Questi servono per ordinare e capire “dove” sta il capitolo nel romanzo:

- `tipo`: fisseremo a `capitolo` (ti aiuta a filtrare capitoli vs altre note)[^11_1]
- `progetto`: nome del romanzo (uguale per tutti i capitoli)[^11_3]
- `numero_capitolo`: numero intero (1, 2, 3…) per ordinare in Dataview e Bases[^11_2]
- `titolo_capitolo`: opzionale, se vuoi un titolo “poetico” diverso dal nome file

Questi 4 sono la spina dorsale su cui farai quasi tutte le viste.[^11_2][^11_1]

***

## 2. Stato di lavorazione

Per vedere a colpo d’occhio la pipeline di scrittura/revisione:

- `stato_bozza`: enum tipo
    - `idea`
    - `outline`
    - `first_draft`
    - `revisione`
    - `pronto`

Questo è perfetto per:

- tabelle Bases raggruppate per stato,
- query Dataview tipo “tutti i capitoli non pronti”.[^11_4][^11_5]

***

## 3. Misura del lavoro (parole)

Per gestire il carico e l’avanzamento:

- `parole_target`: quante parole vorresti arrivare
- `parole_reali`: parole effettive (da aggiornare a mano o con plugin)

Con questi puoi:

- vedere in Bases quanto manca per capitolo,
- usare Dataview per sommare parole per POV o arco.[^11_1][^11_2]

***

## 4. POV e arco narrativo

Qui entriamo nella parte “da scrittore”:

- `pov`: il personaggio o la voce narrante (es. `Luca`, `Anna`, `onnisciente`)
- `arco`: nome dell’arco narrativo principale (es. `arco_principale`, `arco_lavoro`, `arco_famiglia`)

In Dataview potrai filtrare per `pov` o `arco` e vedere, ad esempio, tutti i capitoli di un POV o l’avanzamento di un arco specifico.[^11_6][^11_7]

Se in futuro userai scene invece di capitoli, potrai riusare gli stessi campi per le scene.[^11_6]

***

## 5. Altri campi utili ma opzionali

Ti lascio 3 campi “bonus” che potresti voler avere fin da subito, ma che puoi lasciare vuoti:

- `data_scadenza`: se ti dai deadline interne (utile se il romanzo ha una data di consegna)
- `luogo_principale`: se molti capitoli sono legati a luoghi diversi
- `note_editoriali`: breve commento tipo “riscrivere il dialogo”, utile per viste sintetiche

Questi non sono obbligatori, ma in molti setup PKM/Obsidian sono usati come properties per filtrare e annotare.[^11_8][^11_3]

***

## 6. Riassunto dei campi per il tuo YAML capitolo

Mettendo tutto insieme, l’elenco finale dei campi sarebbe:

- `tipo`
- `progetto`
- `numero_capitolo`
- `titolo_capitolo`
- `stato_bozza`
- `parole_target`
- `parole_reali`
- `pov`
- `arco`
- `data_scadenza` (opzionale)
- `luogo_principale` (opzionale)
- `note_editoriali` (opzionale)

È pensato per essere abbastanza ricco da supportare viste serie in Bases/Dataview, ma non così pesante da diventare ingestibile.[^11_3][^11_2][^11_1]

***

Per il prossimo passo, ti andrebbe di scegliere adesso i **valori standard** che vorresti avere precompilati nel blocco YAML (es. `tipo: capitolo`, `progetto: [nome]`, `stato_bozza: first_draft`) così possiamo definire il blocco “tipo” che il tuo script PowerShell andrà a mettere in testa a ogni file?

<div align="center">⁂</div>

[^11_1]: https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html

[^11_2]: https://blacksmithgu.github.io/obsidian-dataview/

[^11_3]: https://parazettel.com/articles/obsidian-properties-productive/

[^11_4]: https://www.youtube.com/watch?v=D5GCovyR2DM

[^11_5]: https://www.youtube.com/watch?v=buOxN65U0qE

[^11_6]: https://github.com/MattWilcox/obsidian-story-starter

[^11_7]: https://forum.obsidian.md/t/plugin-storyline-obsidian-plugin-for-writers/111494?page=5

[^11_8]: https://publish.obsidian.md/simoneriflesso/Obsidian/Personal+Knowledge+Management


---

# si

Perfetto, allora fissiamo insieme i **valori di default** che il blocco YAML dovrebbe avere quando lo script lo incolla in testa a ogni capitolo.

Ti propongo una versione “tipo” con:

- valori **fissi** già compilati (così risparmi clic),
- valori **vuoti** da compilare a mano dopo (POV, arco, ecc.).

***

## 1. Campi con valore fisso di default

Questi hanno senso identici per tutti i capitoli:

- `tipo`: sempre `capitolo`
- `progetto`: il titolo del romanzo (scrivilo come vuoi appaia nelle viste)
- `stato_bozza`: se i tuoi 10 capitoli sono già scritti ma non rifiniti, ha senso default `first_draft`
- `parole_target`: puoi mettere un target medio (es. 1500) oppure lasciarlo vuoto se preferisci
- `parole_reali`: lasciato vuoto; lo riempirai in un secondo momento
- `data_scadenza`: forse vuoto (se non hai una deadline fissa per ogni capitolo)

***

## 2. Campi che lo script può calcolare

Qui lo script può aiutarti:

- `numero_capitolo`: derivato dal nome file (es. “Capitolo 01.md” → 1)
- `titolo_capitolo`: puoi:
    - lasciarlo vuoto (lo compili tu), oppure
    - farlo uguale al nome file senza estensione come base (es. “Capitolo 01”)

***

## 3. Campi che resteranno vuoti da compilare in Obsidian

Questi hanno senso solo decisi da te, capitolo per capitolo:

- `pov`: vuoto → lo compili a mano nella UI di Properties
- `arco`: vuoto → lo compili a mano
- `luogo_principale`: vuoto
- `note_editoriali`: vuoto

Bases e il pannello Properties rendono molto veloce riempire questi campi dopo la migrazione.[^12_1][^12_2]

***

## 4. Blocco YAML “tipo” da cui partire (logica, non codice)

Mettendo insieme le scelte:

- Fissi:
    - `tipo: capitolo`
    - `progetto: <NOME_ROMANZO>`
    - `stato_bozza: first_draft`
- Calcolati dallo script:
    - `numero_capitolo: <estratto dal nome file>`
    - `titolo_capitolo: <uguale al nome file o vuoto>`
- Vuoti da riempire:
    - `parole_target:`
    - `parole_reali:`
    - `pov:`
    - `arco:`
    - `data_scadenza:`
    - `luogo_principale:`
    - `note_editoriali:`

Così, dopo che lo script ha lavorato, tu apri Obsidian e per ogni capitolo devi solo:

- controllare `numero_capitolo`,
- assegnare `pov`, `arco`, eventuali note.

***

Per affinare questo blocco: vuoi che **stato_bozza** di default sia davvero `first_draft` per tutti i 10 capitoli, o hai già qualcuno che consideri più vicino a `revisione` e ti farebbe comodo un altro valore di default?

<div align="center">⁂</div>

[^12_1]: https://www.youtube.com/watch?v=RrxqkIhh9L8

[^12_2]: https://parazettel.com/articles/obsidian-properties-productive/


---

# un altro valore di default

Perfetto, allora adattiamo il blocco YAML in modo che lo **stato di default** rispecchi meglio dove sei davvero col romanzo.

***

## 1. Scegliere lo stato_bozza di default

Per un romanzo già abbozzato in Word, di solito ha senso che il valore predefinito non sia “prima stesura grezza”, ma qualcosa di mezzo.

Con la scala:

- `idea`
- `outline`
- `first_draft`
- `revisione`
- `pronto`

puoi scegliere:

- `revisione` come default se senti che la maggior parte dei capitoli ha già una prima stesura e li stai lavorando;
- oppure creare un valore intermediario tipo `first_draft_riletta`, ma ti complica un po’ i filtri.

Per mantenere pulito il sistema, conviene rimanere con i 5 valori e usare **`revisione`** come default quando i capitoli sono già abbastanza formati.[^13_1][^13_2]

***

## 2. Nuovi default nel blocco YAML

Aggiorniamo quindi la logica del blocco:

- Fissi:
    - `tipo: capitolo`
    - `progetto: <NOME_ROMANZO>`
    - `stato_bozza: revisione`  ← nuovo default
- Calcolati dallo script:
    - `numero_capitolo: <dal nome file>`
    - `titolo_capitolo: <nome file o vuoto>`
- Vuoti da riempire in Obsidian:
    - `parole_target:`
    - `parole_reali:`
    - `pov:`
    - `arco:`
    - `data_scadenza:`
    - `luogo_principale:`
    - `note_editoriali:`

Poi, nei pochi capitoli che sono davvero “grezzi”, quando apri la nota in Obsidian puoi abbassare a `first_draft`.[^13_3][^13_4]

***

## 3. Come userai questo nella pratica

Quando il tuo script avrà inserito questo blocco in tutti e 10 i capitoli, potrai:

- in **Bases**, filtrare per `stato_bozza` per vedere quanti capitoli in revisione hai;[^13_5]
- in **Dataview**, creare viste tipo “tutti i capitoli in revisione per POV X” o “tutti i capitoli non pronti di un arco”.[^13_2][^13_6]

Ti basterà poi ritoccare `stato_bozza` verso `pronto` man mano che sistemi i capitoli.

***

Domanda per rifinire davvero bene i valori: quanti dei tuoi 10 capitoli considereresti *davvero* “solo abbozzo” (first draft) e quanti invece già in una fase di revisione avanzata?

<div align="center">⁂</div>

[^13_1]: https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html

[^13_2]: https://blacksmithgu.github.io/obsidian-dataview/

[^13_3]: https://www.youtube.com/watch?v=RrxqkIhh9L8

[^13_4]: https://parazettel.com/articles/obsidian-properties-productive/

[^13_5]: https://www.youtube.com/watch?v=34NAe62IH-M

[^13_6]: https://www.youtube.com/watch?v=buOxN65U0qE


---

# 8 first draft ,  2 revisione avanzata

Perfetto, questo dato è utilissimo per scegliere **come inizializzare stato_bozza**.

***

## 1. Strategia sui 10 capitoli

Hai:

- 8 capitoli in **first draft**
- 2 capitoli in **revisione avanzata**

Per non complicare troppo lo script, ti conviene:

- mettere **un unico default** nello YAML via script,
- poi correggere solo i pochi casi eccezione direttamente in Obsidian.

Quindi la scelta migliore è:

- `stato_bozza` di default = `first_draft`
- e, dopo la migrazione, cambi **solo i 2 capitoli** più avanti in `revisione`.

Così lo script resta semplice e tu cambi a mano solo 2 valori su 10.

***

## 2. Blocco YAML capitolo, versione definitiva (a livello di campi e valori)

A livello di logica (non codice), il tuo blocco YAML “tipo capitolo” sarà:

- Fissi (uguali per tutti, messi dallo script):
    - `tipo: capitolo`
    - `progetto: <NOME_ROMANZO>` (lo sostituirai col titolo reale)
    - `stato_bozza: first_draft`
- Calcolati dallo script:
    - `numero_capitolo: <estratto dal nome file>`
    - `titolo_capitolo: <puoi farlo uguale al nome file, oppure lasciarlo vuoto>`
- Da compilare in Obsidian:
    - `parole_target:`
    - `parole_reali:`
    - `pov:`
    - `arco:`
    - `data_scadenza:`
    - `luogo_principale:`
    - `note_editoriali:`

Con questo schema, dopo che lo script ha lavorato:

- apri i 2 capitoli “più avanti” e cambi `stato_bozza` in `revisione`;
- poi inizi a riempire `pov` e `arco` nei capitoli, magari partendo proprio da questi 2 che sono messi meglio.

Questo setup è allineato a come molti utilizzano properties e frontmatter per scrittura strutturata in Obsidian, sfruttando Dataview/Bases sopra questi campi.[^14_1][^14_2][^14_3]

***

A questo punto hai il modello concettuale completo del frontmatter: ti andrebbe, nel prossimo passo, di passare alla parte “pratica” e ragionare su come far sì che **lo script PowerShell prenda i 10 .md e ci appiccichi esattamente questi campi** (ad esempio sfruttando il numero nel nome del file)?

<div align="center">⁂</div>

[^14_1]: https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html

[^14_2]: https://blacksmithgu.github.io/obsidian-dataview/

[^14_3]: https://parazettel.com/articles/obsidian-properties-productive/


---

# si

Perfetto, allora passiamo alla parte pratica: **come far lavorare lo script sui 10 capitoli .md** in modo che aggiunga il frontmatter giusto.

Non scrivo codice completo qui, ma ti do la logica chiara che puoi tradurre facilmente nel tuo PowerShell.

***

## 1. Obiettivo dello script

Lo script deve:

1. Prendere tutti i file `*.md` in `Capitoli/`.[^15_1]
2. Leggere il contenuto originale del file.[^15_1]
3. Estrarre il numero del capitolo dal nome file (es. `Capitolo 01.md` → 1).[^15_2]
4. Costruire un blocco YAML con i campi che hai deciso (con alcuni valori fissi, alcuni calcolati, altri vuoti).[^15_3][^15_4]
5. Riscrivere il file come:
    - blocco YAML
    - riga vuota
    - testo del capitolo.[^15_1]

Esempi di script sul forum Obsidian fanno esattamente questo: usano `Get-ChildItem` per cercare i `.md`, `Get-Content -Raw` per leggere, poi costruiscono una stringa con `---`, le righe di frontmatter e di nuovo `---`, e la concatenano al contenuto originale.[^15_2][^15_1]

***

## 2. Come sfruttare il nome file per `numero_capitolo` (e volendo il titolo)

Se i file si chiamano in modo regolare, tipo:

- `Capitolo 01.md`
- `Capitolo 02.md`
- `Capitolo 03.md`

puoi:

- usare `$file.BaseName` in PowerShell (esempio preso da script simili).[^15_2][^15_1]
- da lì, estrarre i numeri con una regex o con `Substring`.
- usare quel numero per:
    - `numero_capitolo: 1`
    - eventualmente `titolo_capitolo: "Capitolo 01"` oppure lasciarlo vuoto.

Questo pattern (prendo il nome file, calcolo qualcosa, lo metto nel frontmatter) è esattamente quello mostrato nello script “add_frontmatter_to_md.ps1”.[^15_1]

***

## 3. Frontmatter che lo script deve generare

In termini di contenuto logico, ogni file alla fine dovrebbe iniziare con un blocco del tipo:

- campi fissi:
    - `tipo: capitolo`
    - `progetto: <NOME_ROMANZO>`
    - `stato_bozza: first_draft`
- campi calcolati:
    - `numero_capitolo: <N>`
    - `titolo_capitolo: <puoi usare il nome file o vuoto>`
- campi vuoti:
    - `parole_target:`
    - `parole_reali:`
    - `pov:`
    - `arco:`
    - `data_scadenza:`
    - `luogo_principale:`
    - `note_editoriali:`

Lo script di esempio per aggiungere frontmatter ai markdown usa proprio questa idea: costruisce un `StringBuilder`, ci appende `---`, poi righe chiave:valore, poi `---`, e sotto il contenuto originale.[^15_3][^15_1]

***

## 4. Alternative: script “fatto in casa” vs modulo dedicato

Hai due strade per implementarlo:

- **Script artigianale** (più leggero, fai tutto tu):
    - usi uno script sul modello di `add_frontmatter_to_md.ps1` che cicla sui file, costruisce la stringa e riscrive il file;[^15_1]
    - ideale se vuoi controllo totale e già sai usare PowerShell.
- **Modulo dedicato frontmatter**:
    - c’è un modulo `Set-MarkdownFrontMatter` o tool simile in PowerShell Gallery, che permette di aggiornare/aggiungere frontmatter passando una hashtable di valori;[^15_5][^15_6]
    - lo useresti per aggiungere i campi in modo più “dichiarativo”.

Per il tuo caso (10 file, logica chiara, script già esistente che spezza il doc), la strada artigianale ispirata a `add_frontmatter_to_md.ps1` è probabilmente la più semplice.[^15_1]

***

## 5. Come testarlo in sicurezza

Le esperienze sul forum Obsidian raccomandano sempre:[^15_6][^15_7]

- fai una **copia di backup** dei 10 `.md` in un’altra cartella,
- prova lo script prima su 1–2 file,
- controlla in Obsidian che:
    - il blocco YAML sia riconosciuto come Properties,
    - Bases e Dataview leggano i campi corretti.

Quando sei soddisfatto, lo lanci sulla cartella intera.

***

Visto tutto questo, per essere sicuro che il tuo schema mentale è chiaro: come ti immagini il flusso completo, in ordine, quando prendi il prossimo doc Word del romanzo (ad esempio con un capitolo 11) e vuoi portarlo in Obsidian usando lo script e il frontmatter che abbiamo definito?
<span style="display:none">[^15_10][^15_11][^15_12][^15_13][^15_14][^15_15][^15_16][^15_8][^15_9]</span>

<div align="center">⁂</div>

[^15_1]: https://gist.github.com/spech66/d9031d299d664922b347238557bb5d4d

[^15_2]: https://forum.obsidian.md/t/insert-title-into-front-matter-powershell-script/23966

[^15_3]: https://docs.github.com/en/contributing/writing-for-github-docs/using-yaml-frontmatter

[^15_4]: https://rspress.rs/guide/use-mdx/frontmatter

[^15_5]: https://www.powershellgallery.com/packages/PSBlogger/0.9.0/Content/public\Set-MarkdownFrontMatter.ps1

[^15_6]: https://forum.obsidian.md/t/add-a-property-to-1-500-files/67793/17

[^15_7]: https://forum.obsidian.md/t/how-to-add-frontmatter-to-already-existing-notes/48118

[^15_8]: https://www.reddit.com/r/commandline/comments/fageo0/journalcli_index_your_markdownbased_journal_with/

[^15_9]: https://learn.microsoft.com/en-us/powershell/utility-modules/platyps/step-2-edit-markdown-help?view=ps-modules

[^15_10]: https://notes.samfeldstein.xyz/notes/apply-a-default-template-in-obsidian-using-a-shell-script/

[^15_11]: https://doi.org/10.53731/r79tfth-97aq74v-ag53f

[^15_12]: https://stackoverflow.com/questions/28221779/how-to-remove-yaml-frontmatter-from-markdown-files

[^15_13]: https://github.com/ProfSynapse/Obsidian_Properties

[^15_14]: https://www.youtube.com/watch?v=RrxqkIhh9L8

[^15_15]: https://github.com/stroiman/obsidian-frontmatter-smith

[^15_16]: https://youtrack.jetbrains.com/projects/IJPL/issues/IJPL-223341/Frontmatter-YAML-formatting-support


---

# il nuovo capitolo deve usare il frontmatter

Perfetto, allora ragioniamo sul **flusso per i capitoli nuovi** in modo che usino sempre il frontmatter giusto, senza sbattimenti.

***

## 1. Due modi per far usare il frontmatter al capitolo nuovo

Per un **capitolo 11 in futuro**, hai due strade:

1. **Flow “manuale ma veloce” dentro Obsidian**
    - Crei una nuova nota in `Romanzo/Capitoli/`.
    - Applichi il **template “Capitolo Romanzo”** che contiene già il blocco YAML con:
        - `tipo: capitolo`
        - `progetto: <NOME_ROMANZO>`
        - `stato_bozza: first_draft` (o come decidi)
        - tutti gli altri campi vuoti (`pov`, `arco`, ecc.).[^16_1][^16_2]
    - Compili solo:
        - `numero_capitolo: 11`
        - eventuale `pov`, `arco`, `parole_target`
    - Sotto inizi a scrivere il testo del capitolo direttamente in Obsidian.

Questo approccio sfrutta il sistema template di Obsidian (che è fatto apposta per riempire frontmatter e struttura ripetitiva) e ti evita di toccare più lo script per i capitoli nuovi.[^16_3][^16_1]
2. **Flow “automazione completa” con script**
    - Continui a scrivere il capitolo 11 in Word.
    - Il tuo script PowerShell:
        - spezza/trasforma il file in `.md` nella cartella `Capitoli/`;
        - aggiunge in automatico lo stesso blocco frontmatter che abbiamo definito (con `numero_capitolo: 11` estratto dal nome).[^16_4][^16_5]
    - Quando apri il file in Obsidian, il frontmatter è già lì.

Questa strada ti fa usare Word come editor “di bozza” e lascia a PowerShell il lavoro sporco, come già fai ora con la scomposizione in 10 capitoli.[^16_6][^16_4]

***

## 2. Come mantenere coerenza tra vecchi e nuovi capitoli

Indipendentemente da quale strada scegli per il **capitolo 11**:

- tutti i capitoli 1–10 avranno il frontmatter generato dallo script,
- i capitoli nuovi:
    - se scritti da zero in Obsidian, useranno il **template** con lo stesso frontmatter,
    - se scritti in Word, passeranno di nuovo dallo script che incolla lo stesso schema YAML.[^16_7][^16_4]

L’importante è che:

- il **set di campi** resti identico (nomi in minuscolo, niente spazi nei key: `stato_bozza`, `numero_capitolo`, `pov`, `arco`, ecc.);[^16_8][^16_7]
- i **valori possibili** per `stato_bozza` restino quelli che hai scelto (idea, outline, first_draft, revisione, pronto), così Dataview/Bases non si trovano valori strani.[^16_9][^16_10]

***

## 3. Flusso “tipo” per un capitolo nuovo (riassunto)

Immagina il **prossimo capitolo**:

- Se decidi di scriverlo direttamente in Obsidian:

1. Nuova nota in `Capitoli/`.
2. Applica template “Capitolo Romanzo” → frontmatter già pronto.[^16_1]
3. Imposti `numero_capitolo`, `pov`, `arco`.
4. Scrivi il testo.
- Se prima lo scrivi in Word:

1. Salvi/esporti in `.md` con un nome tipo `Capitolo 11.md`.
2. Lanci lo script PowerShell → aggiunge frontmatter con `numero_capitolo: 11` e tutti gli altri campi.[^16_5][^16_4]
3. Apri in Obsidian, ritocchi solo `pov`, `arco`, etc.

In entrambi i casi, il **nuovo capitolo usa lo stesso frontmatter** che stai definendo ora, quindi nelle viste di Bases e Dataview è indistinguibile dagli altri.[^16_10][^16_11]

***

Visto questo, per capire dove concentrarci nel prossimo passo: ti vedi più a tuo agio, da subito, a scrivere i prossimi capitoli direttamente in Obsidian (usando il template), o preferisci continuare a scriverli in Word e far fare tutto allo script?

<div align="center">⁂</div>

[^16_1]: https://www.youtube.com/watch?v=RrxqkIhh9L8

[^16_2]: https://parazettel.com/articles/obsidian-properties-productive/

[^16_3]: https://obsidian.md/it/help/plugins/file-explorer

[^16_4]: https://gist.github.com/spech66/d9031d299d664922b347238557bb5d4d

[^16_5]: https://forum.obsidian.md/t/insert-title-into-front-matter-powershell-script/23966

[^16_6]: https://notes.samfeldstein.xyz/notes/apply-a-default-template-in-obsidian-using-a-shell-script/

[^16_7]: https://docs.github.com/en/contributing/writing-for-github-docs/using-yaml-frontmatter

[^16_8]: https://rspress.rs/guide/use-mdx/frontmatter

[^16_9]: https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html

[^16_10]: https://blacksmithgu.github.io/obsidian-dataview/

[^16_11]: https://www.youtube.com/watch?v=34NAe62IH-M


---

# per i prossimi capitoli vorrei usare obsidiana

Ottimo, usare direttamente Obsidian per i prossimi capitoli ti semplifica tantissimo la vita: niente più export da Word per il nuovo materiale, e il frontmatter sarà sempre coerente.

Ti propongo un flusso molto lineare per **capitoli nuovi**.

***

## 1. Cosa preparare una volta sola in Obsidian

Per scrivere direttamente in Obsidian ti servono solo due cose pronte:[^17_1][^17_2]

1. **Cartella capitoli**
    - `03_Scrittura/Romanzo/Capitoli/`
Tutti i nuovi capitoli andranno qui.
2. **Template “Capitolo Romanzo”**
    - Usa il plugin core **Template** di Obsidian (documentato nell’aiuto ufficiale) per avere uno scheletro riutilizzabile.[^17_2][^17_1]
    - Dentro il template inserisci il blocco di frontmatter con i campi che abbiamo deciso (con i valori di default che ti vanno bene).

Quando questo è a posto, ogni nuovo capitolo parte già “giusto” per Bases/Dataview.

***

## 2. Cosa conterrà il template (logica)

Nel template metterai il blocco YAML con:

- Fissi:
    - `tipo: capitolo`
    - `progetto: <NOME_ROMANZO>`
    - `stato_bozza: first_draft` (per i nuovi capitoli che comincerai da zero)
- Da compilare ogni volta:
    - `numero_capitolo:`
    - `titolo_capitolo:` (se ti serve)
    - `parole_target:`
    - `parole_reali:`
    - `pov:`
    - `arco:`
    - `data_scadenza:`
    - `luogo_principale:`
    - `note_editoriali:`

Sotto il frontmatter, nel template puoi mettere solo:

- un titolo (es. `# Cap. {{numero}}` da compilare tu),
- una riga vuota,
- e poi il corpo del capitolo.

Questo è perfettamente in linea con l’uso di template e properties che si trova nelle guide su Obsidian per note strutturate.[^17_3][^17_1]

***

## 3. Flusso pratico quando inizi il “Capitolo 11”

Da ora in poi, quando inizi un nuovo capitolo, il flusso sarà:

1. In Obsidian, vai in `Capitoli/` e crea una nuova nota.
2. Applica il **template “Capitolo Romanzo”**.[^17_2][^17_3]
3. Compila solo le properties chiave:
    - `numero_capitolo: 11`
    - se lo sai già, `pov` e `arco`
4. Scorri sotto il frontmatter e scrivi direttamente il testo del capitolo.

Subito dopo:

- la **Base dei capitoli** vedrà il nuovo capitolo nella tabella (perché condivide struttura e campi),[^17_4][^17_5]
- le **query Dataview** nella tua `MOC – Romanzo` lo includeranno automaticamente nelle liste ordinate per `numero_capitolo` o filtrate per `stato_bozza`, `pov`, ecc.[^17_6][^17_7]

***

## 4. Coesistenza tra vecchi e nuovi capitoli

- I **10 capitoli importati** useranno il frontmatter aggiunto con lo script.
- I **nuovi capitoli** useranno lo stesso schema via template.

Finché i nomi dei campi (key YAML) restano identici, per Bases e Dataview non c’è differenza tra “nato in Word + script” e “nato in Obsidian + template”.[^17_8][^17_9]

***

Adesso che hai chiaro il flusso del fronte “nuovi capitoli in Obsidian”, quale parte ti sembra più urgente mettere in piedi per prima: creare il **template capitolo** in Obsidian o preparare lo **script PowerShell** per aggiungere il frontmatter ai 10 capitoli già esistenti?
<span style="display:none">[^17_10][^17_11][^17_12][^17_13][^17_14][^17_15][^17_16]</span>

<div align="center">⁂</div>

[^17_1]: https://alessandromastrofini.it/it/2022/09/22/utilizzare-obsidian/

[^17_2]: https://obsidian.md/it/help/home

[^17_3]: https://www.youtube.com/watch?v=RrxqkIhh9L8

[^17_4]: https://www.youtube.com/watch?v=z0uBxIpFcTE

[^17_5]: https://www.youtube.com/watch?v=34NAe62IH-M

[^17_6]: https://blacksmithgu.github.io/obsidian-dataview/

[^17_7]: https://www.youtube.com/watch?v=buOxN65U0qE

[^17_8]: https://docs.github.com/en/contributing/writing-for-github-docs/using-yaml-frontmatter

[^17_9]: https://rspress.rs/guide/use-mdx/frontmatter

[^17_10]: https://www.reddit.com/r/ObsidianMD/comments/1duoyq4/obsidian_for_rpg_and_worldbuilding/

[^17_11]: https://taskforge.md/it/blog/obsidian-tasks-guide/

[^17_12]: https://www.youtube.com/watch?v=Cgme9fThbQo

[^17_13]: https://tecnica.substack.com/p/come-utilizzo-obsidian

[^17_14]: https://www.youtube.com/playlist?list=PLDhDfv9Kmg1QEh4thrJW4CAn5ihtsgCDF

[^17_15]: https://www.youtube.com/watch?v=0I_NDSL4enE

[^17_16]: https://www.nxcode.io/it/resources/news/obsidian-ai-second-brain-complete-guide-2026


---

# creare il template capitolo. Ha senso creare un sistema di naming per i nomi dei file .md? esempio:   00_NOT = Note, idee, frammenti 01_SCN = Scene 02_CH = Capitoli 03_ARC = Archi narrativi 04_WB = Worldbuilding 05_GEN = Genealogie 06_MAP = Mappe (diagrammi, timeline) 07_RES = Ricerca, fonti 08_DIA = Diagrammi modulari 09_FIN = Versioni finali 10_MAC = Macro    Grammatica del nome [Livello][Modulo][TitoloBreve][Data][Rev]

Ha super senso avere una grammatica di naming, soprattutto se vuoi far lavorare sopra Dataview, Bases e magari altri script in futuro. Vari scrittori e worldbuilder che usano Obsidian fanno qualcosa di simile: prefissi numerici o di categoria, e poi lasciano a link/tag/properties la parte “semantica” più fine.[^18_1][^18_2]

Ti aiuto a fare due cose:

1) decidere se il sistema che proponi è sostenibile,
2) integrarlo bene con il template capitolo.

***

## 1. Il sistema che proponi: pro e contro

La tua idea:

- Prefissi a due cifre + codice:
    - `00_NOT` = Note, idee, frammenti
    - `01_SCN` = Scene
    - `02_CH` = Capitoli
    - `03_ARC` = Archi narrativi
    - `04_WB` = Worldbuilding
    - `05_GEN` = Genealogie
    - `06_MAP` = Mappe, timeline
    - `07_RES` = Ricerca, fonti
    - `08_DIA` = Diagrammi modulari
    - `09_FIN` = Versioni finali
    - `10_MAC` = Macro
- Grammatica tipo:
`[Livello][Modulo][TitoloBreve][Data][Rev]`


### Pro

- Ordine alfabetico coerente: i prefissi numerici tengono insieme i gruppi (“tutto WB insieme”, “tutti i capitoli insieme”), cosa che molti scrittori fanno con `00_`, `10_`, `20_` ecc.[^18_3][^18_2]
- Ottimo per script: il nome file contiene subito “che cosa è” e dove sta nel sistema, utile se vuoi generare cose in batch (come hai fatto per i capitoli).[^18_4]
- Ti obbliga a pensare in termini di “moduli” (scene, capitoli, archi, worldbuilding…), che è proprio il modo in cui chi usa Obsidian per narrativa tende a ragionare.[^18_5][^18_1]


### Contro / Attenzione

- Un sistema troppo denso nella parte del nome può diventare più rigido di quanto serve: diversi scrittori di Obsidian trovano sufficiente un mix di **cartelle + nomi semplici tipo “Capitolo 01” + properties**, lasciando a tag/MoC la parte più raffinata.[^18_6][^18_1]
- Se cambi idea sulla struttura (es. decidi di scorporare scene o aggiungere nuovi moduli), rinominare in massa tanti file può essere un po’ noioso, anche se gestibile con script.

Conclusione: il sistema è valido, purché lo usi come **cornice leggera** e non come gabbia. Consiglio: usa questo schema per i file “di produzione” (capitoli, scene, worldbuilding) ma non farti problemi ad avere note veloci con nomi più liberi dentro `00_NOT`.[^18_2][^18_3]

***

## 2. Come integrarlo con i capitoli e il template

Per i **capitoli**, potresti decidere una convenzione tipo:

- Nome file:
`02_CH_Cap_01_[titolo breve opzionale]`
oppure più minimale:
`02_CH_01_[titolo breve]`

Qui:

- `02_CH` = modulo “capitoli”
- `01` = numero cap. (coerente con `numero_capitolo` nel frontmatter)
- `[titolo breve]` = giusto per riconoscere a colpo d’occhio.

Mentre nel **frontmatter** continui ad avere:

- `tipo: capitolo`
- `numero_capitolo: 1`
- `progetto: [nome romanzo]`
- ecc.

Per Dataview/Bases, tutto il serio arriva dal frontmatter; il nome file è solo un aiuto visivo e, se vuoi, un appiglio secondario per script.[^18_7][^18_8]

***

## 3. Suggerimento pratico: tieni la grammatica semplice all’inizio

Per evitare di bloccarti sulla tassonomia, potresti:

- bloccare solo queste parti per ora:
    - prefisso di modulo: `00_NOT`, `01_SCN`, `02_CH`, `04_WB`, `07_RES` (quelle che userai subito);
    - numero progressivo dove serve (scene/capitoli).
- rimandare data/revisione nel nome file (puoi tenerle come properties, es. `rev`, `data_ultima_modifica`), e usare Obsidian/Dataview per vederle.[^18_9][^18_10]

Molti scrittori su Obsidian scoprono che **properties + Dataview** sono più flessibili per date/revisioni rispetto a includere tutto nel nome file.[^18_1][^18_4]

***

## 4. Collegamento diretto col template capitolo

Quando crei il **template “Capitolo Romanzo”**, puoi:

- non codificare il nome file nel template (Obsidian non gestisce nativamente il rename automatico su frontmatter),
- ma decidere tu, ogni volta che crei un capitolo nuovo, uno schema tipo:
    - nome file: `02_CH_11_[titolo breve]`
    - frontmatter: `numero_capitolo: 11`

Questo ti dà:

- nomi leggibili e strutturati,
- dati veri per Dataview/Bases nel frontmatter,
- e margine per cambiare un giorno il sistema di naming senza dover toccare la logica delle query.[^18_8][^18_7]

***

Per fissare bene il template capitolo: ti andrebbe di scegliere adesso **un esempio concreto di nome file** per il Capitolo 1 (secondo il tuo sistema) e, accanto, cosa metteresti in `numero_capitolo`, `titolo_capitolo` e `pov` nel frontmatter?
<span style="display:none">[^18_11][^18_12][^18_13][^18_14][^18_15][^18_16][^18_17][^18_18][^18_19]</span>

<div align="center">⁂</div>

[^18_1]: https://loreteller.com/learn/obsidian-fiction-writers-guide/

[^18_2]: https://forum.obsidian.md/t/using-obsidian-for-writing-fiction-zk-imf/11401/15

[^18_3]: https://forum.obsidian.md/t/professional-writers-how-do-you-organize-your-vaults/42146

[^18_4]: https://github.com/MattWilcox/obsidian-story-starter

[^18_5]: https://vault.tjtrewin.com/how-i-use-obsidian

[^18_6]: https://www.reddit.com/r/ObsidianMD/comments/1mp0rgr/for_writers_how_would_you_structure_a_vault_to/

[^18_7]: https://blacksmithgu.github.io/obsidian-dataview/

[^18_8]: https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html

[^18_9]: https://parazettel.com/articles/obsidian-properties-productive/

[^18_10]: https://www.youtube.com/watch?v=RrxqkIhh9L8

[^18_11]: https://forum.obsidian.md/t/note-naming-books-and-chapters/17402

[^18_12]: https://www.youtube.com/watch?v=kcLlBHBjcG0

[^18_13]: https://www.youtube.com/watch?v=LxeclcePg-c

[^18_14]: https://www.facebook.com/groups/30011735728/posts/10161067263845729/

[^18_15]: https://utrechtuniversity.github.io/workshop-computational-reproducibility/chapters/readme-files.html

[^18_16]: https://forum.literatureandlatte.com/t/scrivener-obsidian-and-aeon-timeline-oh-my/147060

[^18_17]: https://www.youtube.com/watch?v=8X2mPaVA1xw

[^18_18]: https://about.gitlab.com/blog/gitlab-markdown-tutorial/

[^18_19]: https://www.youtube.com/watch?v=kfyA1UTo1sI


---

# 02_CH_TheIntrusion_r00.md

Perfetto, questo file è un ottimo punto di partenza per definire sia il **template capitolo**, sia la tua convenzione di naming.

***

## 1. Cosa si capisce da `02_CH_TheIntrusion_r00.md`

Dal nome file si ricava chiaramente:[^19_1]

- `02_CH` → modulo “Capitoli” (coerente con il sistema che hai in mente)
- `TheIntrusion` → titolo breve del capitolo
- `r00` → revisione 0 (prima versione)

Dentro il file, il testo inizia con:

- `## Chapter 1: The Intrusion` come intestazione.[^19_1]

Quindi hai già tre cose che puoi allineare con il frontmatter:

- `numero_capitolo` → 1
- `titolo_capitolo` → “The Intrusion”
- `stato_bozza` → coerente con `r00` (che possiamo mappare a `first_draft`)

***

## 2. Come collegare naming, frontmatter e contenuto

Un modo semplice e pulito di usare questo pattern:

- Nome file (per te e per script):
    - `02_CH_TheIntrusion_r00.md`
- Frontmatter:
    - `tipo: capitolo`
    - `progetto: <NOME_ROMANZO>`
    - `numero_capitolo: 1`
    - `titolo_capitolo: The Intrusion`
    - `stato_bozza: first_draft` (coerente con `r00`)
    - `pov: [es. Mark]`
    - `arco: [es. arco_principale]`
    - ecc.
- Contenuto:
    - intestazione più “umana” tipo `## Chapter 1 – The Intrusion`
    - testo del capitolo (come quello che hai già).[^19_1]

In questo modo:

- lo **schema del nome file** ti serve come etichetta tecnica (modulo + titolo breve + revisione),
- il **frontmatter** contiene tutte le informazioni che Dataview e Bases possono usare per filtrare/ordinare,
- il **testo** resta pulito e leggibile.

Altri scrittori su Obsidian fanno proprio così: nomi file abbastanza compatti e tecnici, e demandano a YAML/Properties le info narrative (POV, arco, stato, ecc.).[^19_2][^19_3]

***

## 3. Template capitolo partendo da questo esempio

Se usi `02_CH_TheIntrusion_r00.md` come modello, il tuo **template “Capitolo Romanzo”** potrebbe assumere che:

- userai nomi file del tipo `02_CH_[TitoloBreve]_r00`,
- compilerai nel frontmatter:
    - `numero_capitolo` a mano (1, 2, 3…),
    - `titolo_capitolo` con lo stesso testo di `[TitoloBreve]` oppure più lungo,
    - `stato_bozza` iniziale (`first_draft`),
    - e poi `pov`, `arco`, ecc.

Così, quando aprirai la Base dei capitoli:

- vedrai colonne come `numero_capitolo`, `titolo_capitolo`, `stato_bozza`, `pov`, `arco`,
- e ti basterà leggere quelle, senza dover interpretare i nomi file ogni volta.[^19_4][^19_5]

***

Per fare il passo concreto sul template: ti va di usare proprio questo capitolo (“The Intrusion”) come primo che arricchiamo con frontmatter (tipo: che POV e che arco gli assoceresti), così il template che creiamo in Obsidian nasce già aderente al tuo romanzo reale?
<span style="display:none">[^19_6]</span>

<div align="center">⁂</div>

[^19_1]: 02_CH_TheIntrusion_r00.md

[^19_2]: https://www.reddit.com/r/ObsidianMD/comments/1mp0rgr/for_writers_how_would_you_structure_a_vault_to/

[^19_3]: https://loreteller.com/learn/obsidian-fiction-writers-guide/

[^19_4]: https://www.youtube.com/watch?v=34NAe62IH-M

[^19_5]: https://blacksmithgu.github.io/obsidian-dataview/

[^19_6]: 00_NOT_Incipit_2026-05-16-2.md


---

# si

Perfetto, allora usiamo proprio **“The Intrusion”** come modello reale per il tuo template capitolo.

***

## 1. Decidere i valori narrativi per questo capitolo

Dal testo si vede che:

- il punto di vista è chiaramente su **Mark Mathias Parker**, con focalizzazione interna sulle sue emozioni;[^20_1]
- a livello di storia, sembra un capitolo di apertura che introduce trauma, vulnerabilità e il “trigger” (il pollo) → ha senso che appartenga all’**arco principale** del romanzo.[^20_1]

Quindi, per “The Intrusion”, i valori narrativi potrebbero essere:

- `pov: Mark`
- `arco: arco_principale`

Se in futuro userai archi più specifici (es. `arco_famiglia`, `arco_lavoro`, `arco_trauma`), potrai rinominare questo valore o dettagliarlo, ma intanto va bene tenerlo generico.

***

## 2. Valori tecnici per questo capitolo

Sempre per questo capitolo:

- `numero_capitolo: 1` (è chiaramente il primo)[^20_1]
- `titolo_capitolo: The Intrusion`
- `stato_bozza`: al momento sembra `first_draft` (testo fluido, ma probabilmente non definitivo)
- `parole_target`: dipende dal tuo obiettivo, ma ipotizziamo qualcosa tipo 1500 o quello che usi di solito
- `parole_reali`: le potrai contare e compilare dentro Obsidian (o con un plugin, se vuoi)

Questi valori tecnici, più `tipo` e `progetto`, sono esattamente quelli che ti permetteranno di usare Dataview/Bases per viste per POV, arco, stato, avanzamento.[^20_2][^20_3]

***

## 3. Come usare questo esempio per il template

Il senso di fare questo lavoro su “The Intrusion” è:

- Una volta che in Obsidian inserisci questo frontmatter sulla nota del capitolo:
    - hai un **primo capitolo reale** con tutti i campi che userai sempre;
    - puoi aprire Bases e Dataview per vedere se la struttura ti piace davvero (come appare `pov`, come appare `arco`, ecc.).[^20_4][^20_2]

Poi, quando crei il **template “Capitolo Romanzo”**:

- riusi gli stessi campi,
- metti solo pochi default (tipo `stato_bozza: first_draft`, `progetto: <NOME_ROMANZO>`),
- lasci vuoti `numero_capitolo`, `titolo_capitolo`, `pov`, `arco`, così li compili caso per caso.

***

Per verificare che hai afferrato bene l’idea: se pensi al **Capitolo 2** del romanzo, quale POV e quale arco narrativo immagini che avrebbe, usando la stessa logica che abbiamo appena applicato a “The Intrusion”?

<div align="center">⁂</div>

[^20_1]: 02_CH_TheIntrusion_r00.md

[^20_2]: https://blacksmithgu.github.io/obsidian-dataview/

[^20_3]: https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html

[^20_4]: https://www.youtube.com/watch?v=34NAe62IH-M


---

# POV, Mark bambino. arco ricordi

Ottimo, stai già usando esattamente il tipo di distinzione che il sistema di properties ti permette di sfruttare benissimo.

***

## 1. Come mappare questa scelta nei campi

Per il **Capitolo 2**:

- `numero_capitolo: 2`
- `pov: Mark_bambino` (o `Mark_child` se preferisci restare in inglese coerente con il resto)
- `arco: arco_ricordi`

Così ottieni subito due cose utili:

- puoi filtrare tutti i capitoli/scene con `pov` relativo a Mark ma distinguendo tra presente e passato (Mark adulto vs Mark bambino);
- puoi avere viste Dataview che mostrano solo i capitoli dell’**arco_ricordi**, a prescindere dalla loro posizione nella cronologia del romanzo.

In molti setup per narrativa in Obsidian si usano proprio combinazioni di `pov` e `arco` per ricostruire in modo non lineare: cronologia interna, flashback, filoni tematici.[^21_1][^21_2]

***

## 2. Impatto sul template

Quello che stai facendo ora, in pratica, è:

- fissare una **grammatica mentale** per i valori:
    - POV: `Mark`, `Mark_bambino`, altri personaggi…
    - Archi: `arco_principale`, `arco_ricordi`, ecc.

Quando andrai a creare il **template “Capitolo Romanzo”**, potrai:

- lasciare `pov:` vuoto,
- lasciare `arco:` vuoto,
- ma saprai già che i valori possibili appartengono a un vocabolario di 4–5 opzioni, facile da filtrare nelle query.

***

## 3. Prossimo passo utile

Ora che:

- hai un esempio concreto per il Capitolo 1 (`pov: Mark`, `arco: arco_principale`),
- e un’idea chiara per il Capitolo 2 (`pov: Mark_bambino`, `arco: arco_ricordi`),

il passo successivo pratico potrebbe essere:

- aprire `02_CH_TheIntrusion_r00.md` in Obsidian,
- aggiungere in alto il frontmatter con i campi che abbiamo definito,
- creare il **template capitolo** copiando questa struttura,
- e usarlo per iniziare il Capitolo 2 direttamente in Obsidian.

Per allenare ancora un po’ la “testa da sistema”: per il tuo romanzo, immagini di avere altri POV oltre a Mark (adulto/bambino)? Se sì, quali personaggi ti vengono in mente come futuri valori di `pov`?

<div align="center">⁂</div>

[^21_1]: https://loreteller.com/learn/obsidian-fiction-writers-guide/

[^21_2]: https://vault.tjtrewin.com/how-i-use-obsidian


---

# 10.1 Mark Mathias Parker (The Protagonist / The Antagonist)

Archetype: The Fractured Creator.
Core Pathology: Alektorophobia (Specific Phobia of Chickens) comorbid with Dissociative Identity Disorder (DID) or severe Dissociative Amnesia.
Psychological Profile: Mark functions on a duality.
The Day Mode: A meticulous "junior programmer" and "designer" who seeks order through code and mandalas. He uses structure to contain his chaos.
The Night Mode: A dormant "Horror Writer" persona that views reality through a lens of violence and paranoia.2 When his "cocoon" is breached (by a chicken or emotional intimacy), he regresses to a fight-or-flight state that manifests as extreme violence.
Trigger Mechanism: The "Cluck" or the "Feather" serves as the somatic marker for paternal abuse.24 It is not just a bird; it is the signal that he has failed to "toughen up," triggering a homicidal rage directed at witnesses of his vulnerability.
10.2 Jenny Parker (The Anchor / The Sister)
Role: The External Superego / The Only Link to Reality.
Relationship: Identified in the narrative as Mark's sister (or sister-figure).24
Function: Jenny is the only person who knows the truth about "The Big Coop." She represents the "rational voice" that Mark cannot generate himself. She utilizes Cognitive Behavioral Therapy (CBT) techniques ("5-4-3-2-1 grounding") to pull him back from the ledge.
Note: Unlike the other women in Mark's life, Jenny survives because she maintains a safe distance (the phone). She is an auditory presence, not a physical one, which protects her from Mark's physical lashing out.
10.3 Shaquille "Shaq" Ryan (The Enabler of Innocence)
Archetype: The Innocent / The Caregiver.
Role: Former colleague and coloring partner.
Significance: Shaq introduced Mark to the Mandala.18 He represents the "safe" masculinity that Mark craves—one that is gentle, creative, and non-judgmental, contrasting sharply with Mark's abusive father.
Fate: Survives by maintaining the friendship on a superficial level ("chat about nonsense"). He does not probe the trauma, thereby avoiding the trigger.
10.4 Dana Goodwin (The Victim: Abandonment Trigger)
Role: Romantic Interest / "The Betrayer."
Psychodynamics: Dana's casual interaction with another male ("Carl") triggered Mark's abandonment melange. The trauma of his mother leaving him ("Mama’s suitcase at sunrise") was superimposed onto Dana.24
The Murder: Mark's strangulation of Dana is a reenactment of his desire to "hold onto" the object that is leaving him. It is a desperate, lethal attempt to freeze the moment of abandonment.
10.5 Kirsten \& Lucy Parker (The Victims: The Intruders)
Role: Half-Sisters / The Unwanted Mirror.
Psychodynamics: They represent the "Second Family"—the successful, untraumatized offspring of the father who broke Mark. Their presence in his kitchen is an invasion of his "cocoon."
The Trigger: Lucy's touch (the scratch) physically mirrored the sensation of the rooster's talons. Mark did not see a sister; he felt a bird. His violence was a defense against the "Big Coop" manifesting in his kitchen.
10.6 Jennifer Lyra Rowe (The Final Echo)
Role: The Failed Replacement.
Significance: Her name ("Jennifer") suggests Mark was unconsciously seeking a replacement for his sister/anchor, Jenny.
The Rejection: When she asks about his scar and admits fear ("I'm scared of you now"), she validates his father's prophecy that he is "weak" and "useless".24 Her departure seals his total isolation.

Hai già fatto un lavoro pazzesco di chiarimento psicologico dei personaggi: questo è oro per il tuo sistema in Obsidian.

Ora usiamo questa scheda per **decidere i valori di `pov` e qualche property chiave** che userai nei capitoli.

***

## 1. POV possibili (direttamente dai tuoi personaggi)

Dalla descrizione emergono almeno questi POV “utili” a livello tecnico:

- `Mark`
    - per il Mark adulto, “Day Mode” / “Night Mode” (puoi gestire la distinzione con un altro campo, vedi sotto).[^22_1]
- `Mark_bambino`
    - per i flashback o i ricordi (come hai già intuito per il Capitolo 2).
- `Jenny`
    - l’ancora razionale, voce al telefono, possibile POV se mai decidessi di mostrarla “da dentro”.
- `Shaq`
    - potrebbe avere POV proprio in scene dove fa da specchio “sicuro”.
- `Dana`
- `Kirsten_Lucy` (puoi separarli in `Kirsten` e `Lucy` se avranno scene distinte)
- `Jennifer_Rowe`

Già solo come lista di valori possibili per `pov`, questo set ti permetterà di fare viste tipo “tutti i capitoli in POV Mark_bambino” o “tutti quelli dove il POV non è Mark, per vedere come il mondo lo percepisce”.[^22_1]

***

## 2. Property extra molto utili per questo tipo di romanzo

Dal modo in cui hai descritto Mark e le sue dinamiche, hai due dimensioni che Obsidian può aiutarti a tracciare bene:

1. **Stato interno di Mark** (quando il POV è suo, ma anche quando appare in scena):
    - puoi usare una property tipo:
        - `modalita_mark`: `day`, `night`, `dissociato`, ecc.
    - questo dialoga bene con “Day Mode vs Night Mode” e la regressione.
2. **Tipo di trigger presente nella scena/capitolo**:
    - es. `trigger: cluck`, `trigger: feather`, `trigger: abandonment`, `trigger: intimacy`, ecc.
    - questi derivano direttamente dai meccanismi che hai descritto:
        - cluck/feather come marker somatico del trauma;
        - abbandono (Dana, Jennifer) come innesco emotivo;
        - intrusione nel “cocoon” (Kirsten \& Lucy).

Queste proprietà ti permetterebbero, in Dataview, di vedere:

- tutte le scene con `trigger: cluck` → quindi tutti gli echi del trauma originario;
- tutte le scene con `modalita_mark: night` → quindi dove la parte “horror writer” è attiva o in agguato.

Questo genere di tagging strutturato è molto simile a come alcuni worldbuilder e autori usano Obsidian per tracciare stati interni e temi.[^22_2][^22_3]

***

## 3. Come farli entrare nel template capitolo

Partendo da tutto quello che hai già definito, al template “Capitolo Romanzo” potresti aggiungere:

- `pov:`
- `modalita_mark:` (solo se il POV è Mark, altrimenti lasci vuoto)
- `trigger:` (lista breve o singolo valore principale)

Oltre a:

- `arco:` (es. `arco_principale`, `arco_ricordi`, `arco_abbandono`, ecc.)

Così, per il Capitolo 1 (“The Intrusion”), avresti qualcosa del tipo:

- `pov: Mark`
- `modalita_mark: day` all’inizio, eventualmente `night` o `dissociato` quando scatta la crisi
- `arco: arco_principale`
- `trigger: cluck` (o `trigger: pollo` se vuoi restare in italiano)

Per il Capitolo 2 (flashback):

- `pov: Mark_bambino`
- `modalita_mark:` (potresti anche ometterla e lasciare che il POV basti da solo)
- `arco: arco_ricordi`
- `trigger:` quello che lì scatena il ricordo (padre, “Big Coop”, ecc.)

***

Con queste informazioni, il tuo template capitolo in Obsidian diventa davvero su misura per **questo romanzo**, non un template astratto.

Per continuare ad allenare questo modo di pensare: se pensi a una futura scena/capitolo con **Jenny** come presenza principale, che valori immagineresti per `pov`, `arco` e `trigger` (per esempio una telefonata in cui lei lo ancora alla realtà)?

<div align="center">⁂</div>

[^22_1]: 02_CH_TheIntrusion_r00.md

[^22_2]: https://loreteller.com/learn/obsidian-fiction-writers-guide/

[^22_3]: https://vault.tjtrewin.com/how-i-use-obsidian


---

# Jenny Parker (The Anchor / The Sister)

Role: The External Superego / The Only Link to Reality.
Relationship: Identified in the narrative as Mark's sister (or sister-figure).24
Function: Jenny is the only person who knows the truth about "The Big Coop." She represents the "rational voice" that Mark cannot generate himself. She utilizes Cognitive Behavioral Therapy (CBT) techniques ("5-4-3-2-1 grounding") to pull him back from the ledge.
Note: Unlike the other women in Mark's life, Jenny survives because she maintains a safe distance (the phone). She is an auditory presence, not a physical one, which protects her from Mark's physical lashing out.

Perfetto, allora usiamo Jenny per fissare meglio come userai le properties nei capitoli/scene in cui lei è centrale.

***

## 1. Che ruolo ha Jenny nelle tue properties

Da quello che scrivi, Jenny è:

- **L’Ancora / La Sorella**
- “External superego”, unica che conosce il vero trauma (“Big Coop”)
- Usa tecniche CBT (5-4-3-2-1 grounding) per riportarlo giù
- È quasi sempre **voce al telefono**, quindi presenza auditiva, non fisica

Tradotto in properties utili per Obsidian, questo ti suggerisce:

- `pov` può essere:
    - `Jenny` quando vuoi entrare nella sua testa
    - oppure restare `Mark` ma con Jenny fortemente presente nella scena
- `arco`:
    - spesso qualcosa tipo `arco_ricordi` (quando parla del Big Coop)
    - o `arco_ancora` / `arco_salvezza` (le scene dove lo contiene)

***

## 2. Come potrebbe apparire una “scena Jenny” nei campi

Immagina una scena in cui:

- Mark sta dissociando dopo un trigger
- Jenny lo guida con il 5-4-3-2-1 grounding al telefono

Le properties potrebbero essere:

- `pov: Mark` (la viviamo dal suo punto di vista)
- `modalita_mark: dissociato` all’inizio, poi magari `day` quando torna in sé
- `arco: arco_ancora` (o nome simile che userai per le scene in cui lei lo “salva”)
- `trigger: cluck` / `trigger: memoria_padre` (dipende cosa scatena l’episodio)
- eventualmente un campo come `tipo_supporto: Jenny_telefono` se vuoi tracciare che la sua presenza è solo auditiva

Oppure, se vuoi far vedere il peso che Jenny si porta addosso:

- `pov: Jenny`
- `arco: arco_ancora`
- `trigger: chiamata_di_Mark` (il “trigger” per lei è la telefonata stessa, non il pollo)

Questo tipo di codifica ti permetterà poi di:

- filtrare tutte le scene dove **Jenny funziona come ancora**;
- vedere in Dataview come l’“arco_ancora” si intreccia con gli altri archi;
- tenere sotto controllo l’alternanza fra POV interni a Mark e POV esterni (Jenny/altre vittime).

***

## 3. Come riflette sul template capitolo/scene

Quello che stai facendo ora è definire il vocabolario che userai nel template:

- `pov:` → tra cui `Mark`, `Mark_bambino`, `Jenny`, ecc.
- `modalita_mark:` → usato solo quando il POV è Mark
- `arco:` → tra cui `arco_principale`, `arco_ricordi`, `arco_ancora`, `arco_abbandono`…
- `trigger:` → `cluck`, `feather`, `abbandono`, `intrusione_cocoon`, ecc.

Il template “Capitolo Romanzo” (o “Scena Romanzo” se deciderai di scendere al livello di scena) avrà questi campi vuoti, e tu potrai scegliere i valori coerenti con quello che hai già definito narrativamente.

***

Per legare ancora meglio personaggi e sistema: se pensi a una scena tipica con **Shaq** (il collega che introduce i mandala), che valori useresti per `pov`, `arco` e `trigger` in quella scena, seguendo la stessa logica?

---

# 10.3 Shaquille "Shaq" Ryan (The Enabler of Innocence)

Archetype: The Innocent / The Caregiver.
Role: Former colleague and coloring partner.
Significance: Shaq introduced Mark to the Mandala.18 He represents the "safe" masculinity that Mark craves—one that is gentle, creative, and non-judgmental, contrasting sharply with Mark's abusive father.
Fate: Survives by maintaining the friendship on a superficial level ("chat about nonsense"). He does not probe the trauma, thereby avoiding the trigger.

Perfetto, continuiamo a usare i personaggi per “allenare” la tua grammatica di properties.

Con **Shaq** hai un ruolo molto chiaro:

- “The Enabler of Innocence”
- Mascolinità sicura e non giudicante
- Mantiene il rapporto in superficie per **non attivare i trigger** di Mark

Questo ti suggerisce bene che valori usare nei campi-scena / capitolo.

***

## 1. Come potrebbe essere una scena “tipo Shaq” nei campi

Immagina una scena in cui:

- Mark e Shaq colorano mandala, chiacchierano di cose leggere,
- Mark è relativamente stabile, proprio perché Shaq *non* tocca il trauma.

Una configurazione molto sensata delle properties sarebbe:

- `pov: Mark`
    - è la sua percezione della “safe masculinity”, quindi ha senso viverla da dentro.
- `modalita_mark: day`
    - Mark è nel suo “Day Mode”: ordinato, funzionale, cerca struttura negli schemi e nei mandala.
- `arco: arco_innocenza` o `arco_sicurezza`
    - potresti definire un arco tematico per ciò che rappresenta Shaq: ciò che *potrebbe* salvare Mark, ma non entra mai abbastanza in profondità.
- `trigger:`
    - qui il bello è che *non c’è* trigger traumatico.
    - Potresti esplicitare questo con qualcosa come `trigger: nessuno` o `trigger: safe_context`, così nelle viste Dataview puoi distinguere scene di sicurezza da scene ad alto rischio.
- eventualmente una property tipo:
    - `tensione_livello: basso`
se vuoi classificare l’intensità emotiva delle scene.

***

## 2. Uso narrativo in Obsidian

Con questo schema:

- puoi chiederti, con Dataview:
    - “Mostrami tutte le scene con `arco_innocenza` e `tensione_livello: basso`” → tutte le scene con Shaq dove si respira.
    - “Mostrami tutte le scene con `pov: Mark` e `modalita_mark: day` → dove Mark funziona “bene”.
- puoi anche confrontare:
    - quante scene con Shaq sono collocate *prima* di certi eventi traumatici (tipo un omicidio),
    - e dove potresti inserirne altre per modulare ritmo e respiro.

Questo è esattamente il tipo di uso che rende Obsidian potente per la narrativa: non solo “archivio di testo”, ma griglia per ragionare su ritmi, tensioni, pesi tematici.

***

## 3. Implicazione per il template “scena/capitolo”

Tutto quello che stai ragionando si traduce in:

- Template con campi fissi:
    - `tipo: capitolo` (o `tipo: scena` se scenderai a quel livello)
    - `progetto: [nome romanzo]`
- Campi da scegliere:
    - `pov:`
    - `modalita_mark:`
    - `arco:`
    - `trigger:`
    - `tensione_livello:`

Con un vocabolario che hai già iniziato a definire per Mark, Jenny, Shaq e le vittime.

***

Per vedere se questa “lente” ti è chiara: se immagini adesso una scena in cui **Mark è con Shaq**, ma durante la serata succede qualcosa (un rumore, una frase) che innesca un micro-trigger in Mark, come descriveresti tu i valori di `modalita_mark`, `arco` e `trigger` per quella scena?

---

# modalita_marc:  nostalgia pace interiore, arc: ricerca pace interiore. trigger: disegno mandala

Ottimo, hai già fatto un passo in più: stai usando le properties quasi come un “linguaggio interno” per leggere la scena.

Prendiamo la tua proposta e la rifiniamo un attimo per integrarla bene nel sistema:

- `modalita_mark: nostalgia_pace_interiore`
    - qui stai dicendo: Mark è calmo, ma con una vena di malinconia; è una modalità diversa dalla pura “day mode” operativa, e molto diversa dalla modalità “dissociato/notte”.
- `arco: ricerca_pace_interiore`
    - questo è un arco tematico fortissimo: tutte le scene dove lui cerca di stare bene (mandala, routine, voce di Jenny, rapporti sicuri) potrebbero condividere questo arco.
- `trigger: disegno_mandala`
    - qui è interessante perché il mandala è sia cura sia potenziale innesco di introspezione; in molte scene con Shaq, potrebbe essere un “trigger buono”, uno stimolo che porta verso la calma invece che verso la spirale.

Con questi tre valori, la scena “Mark + Shaq + mandala” diventa, per il sistema:

- una scena di **bassa minaccia**,
- dentro l’**arco di ricerca della pace**,
- in cui il trigger non è il trauma (cluck/feather/abbandono), ma un gesto di cura (mandala).

In Dataview potresti poi filtrare:

- tutte le scene con `arco = ricerca_pace_interiore`
- e confrontrarle con quelle dove il trigger è traumatico, per bilanciare la struttura del romanzo.

Per consolidare ancora questa “grammatica”: se pensi a una futura scena con **Dana** subito dopo un momento di calma con mandala, come cambierebbero secondo te `arco` e `trigger` (resterebbe “ricerca_pace_interiore” o passerebbe a qualcos’altro?)

---

# no. irrompe la gelosia che è un sentimento che Mrk non sa gestire

Questo è un punto chiave anche per il tuo sistema in Obsidian: stai descrivendo una **rottura di stato interno**.

A livello di properties, quella scena (post‑mandala, con Dana) potrebbe essere letta così:

- `modalita_mark: gelosia_caotica` (o un nome che per te renda l’idea di “non so gestire questo sentimento”)
- `arco: arco_gelosia` o `arco_abbandono`
    - perché la gelosia in realtà è collegata al nucleo di abbandono che hai descritto con Dana e la madre.
- `trigger: gelosia` (magari con un secondo valore tipo `trigger_secondario: contatto_altro_uomo` se vuoi essere più fine)

Così, nella “timeline emotiva” del romanzo dentro Obsidian, avresti:

- scene con Shaq → `modalita_mark: nostalgia_pace_interiore`, `arco: ricerca_pace_interiore`, trigger “buoni” (mandala);
- scena con Dana dopo → `modalita_mark: gelosia_caotica`, `arco: arco_gelosia/abbandono`, trigger traumatico.

Con Dataview puoi poi vedere chiaramente dove, nella struttura, passi da un arco all’altro e come la discesa avviene anche se il contesto esterno non è “oggettivamente pericoloso”.

***

Ti va, la prossima volta che apri Obsidian, di provare a:

1. Prendere una sola scena/capitolo con **Dana**.
2. Aggiungere a mano 3 campi: `modalita_mark`, `arco`, `trigger` seguendo questa logica.

Poi, quando li hai messi, possiamo ragionare insieme su come impostare una prima query Dataview che ti faccia vedere **la sequenza: calma con Shaq → rottura con Dana** solo guardando le properties, senza neanche leggere il testo.

---

# inizio a impostare tutto il sistema. tu potresti individuare gli auomatismi utili e suggerire il workflow corrispondente proponendo altri plug in utili? tipo QuickAdd, Templater , ...

Ottima idea: se imposti bene adesso automatismi + workflow, poi puoi concentrarti sulla storia e non sulla “burocrazia” del vault.

Ti propongo un set di automazioni/plug‑in mirato a come stai già ragionando (romanzo, POV, archi, trigger).

***

## 1. Obiettivo generale del workflow

Per il romanzo ti serve:

- creare **nuovi capitoli/scene** sempre con lo stesso frontmatter;
- aggiornare lo **stato** (bozza/revisione/pronto) e i campi (POV, arco, trigger) senza sbattimenti;
- avere viste in **Bases/Dataview** per:
    - avanzamento capitoli,
    - distribuzione POV,
    - archi (ricordi, gelosia, pace interiore, ecc.).

***

## 2. Plugin fondamentali e cosa automatizzano

### Templater → “cervello dei template”[^27_1][^27_2][^27_3]

Serve per:

- popolare automaticamente campi nel frontmatter (date, titolo, ecc.);
- posizionare il cursore nel punto giusto quando crei un nuovo capitolo/una nuova scena.

Nel tuo caso può:

- impostare default tipo `stato_bozza: first_draft`, `progetto: [NOME_ROMANZO]`;
- generare un titolo interno tipo `## Chapter <% tp.file.cursor() %>`;
- opzionalmente leggere parte del nome file per proporre `titolo_capitolo`.


### QuickAdd → “sportello rapido per creare note giuste nel posto giusto”[^27_4][^27_5][^27_1]

Serve per:

- creare note nuove scegliendo template e cartella da una sola scorciatoia;
- chiederti al volo informazioni (es. numero capitolo, POV) e inserirle nel template.

Nel tuo caso può:

- avere un comando “Nuovo capitolo romanzo” che:
    - ti chiede `numero_capitolo`, `titolo breve`, magari `pov`;
    - crea il file in `02_CH_…` dentro `Capitoli/` usando il template capitolo;
- avere un comando “Nuova scena” (se scenderai al livello scena) che fa lo stesso ma in `01_SCN_…`.

Molti utenti usano QuickAdd + Templater proprio così: una hotkey per “nuova nota con template X in cartella Y, chiedendo prima alcuni campi”.[^27_5][^27_6][^27_1]

### Dataview + Bases → dashboard e tabelle[^27_7][^27_8]

- **Bases**: per la tabella operativa dei capitoli (status, POV, arco, parole, ecc.), modificabile a mano.[^27_8][^27_7]
- **Dataview**: per viste dentro le MoC, tipo:
    - tutti i capitoli con `pov = Mark_bambino`,
    - tutte le scene con `arco = arco_gelosia`,
    - sequenze “calma con Shaq → rottura con Dana”.

***

## 3. Workflow concreto (romanzo) con questi plugin

### A. Creare il template capitolo (una volta sola)

1. Installa e configura **Templater** (cartella dei template, ecc.).[^27_2][^27_1]
2. Crea un file di template “Capitolo Romanzo” con il frontmatter che hai deciso (campi: `tipo`, `progetto`, `numero_capitolo`, `titolo_capitolo`, `stato_bozza`, `pov`, `arco`, `modalita_mark`, `trigger`, ecc.).
3. Usa le funzioni di Templater solo dove servono (es. data, titolo interno), ma lascia i campi narrativi (`pov`, `arco`, `modalita_mark`, `trigger`) da compilare a mano.

Le guide su Templater suggeriscono proprio di mettere il grosso della struttura nei template e usare funzioni solo per dettagli dinamici (date, titoli).[^27_9][^27_3][^27_1]

### B. Creare azioni QuickAdd per capitolo/scene

1. Installa **QuickAdd**.[^27_10][^27_4]
2. Crea un’azione “Nuovo capitolo romanzo” che:[^27_1][^27_5]
    - chiede:
        - `numero_capitolo`
        - `titolo breve`
    - costruisce il nome file seguendo la tua grammatica:
        - es. `02_CH_<TitoloBreve>_r00`
    - crea il file in `Capitoli/` usando il template “Capitolo Romanzo”.

Se vuoi spingerti un po’ oltre, puoi fare sì che QuickAdd passi quei valori a Templater per pre‑riempire `numero_capitolo` e `titolo_capitolo`.[^27_11][^27_6]

***

## 4. Altri plugin utili specifici per narrativa

Dal catalogo “plugins for writers” e discussioni su romanzi:[^27_12][^27_13][^27_14][^27_15]

- **Longform** → gestire romanzo come progetto (capitoli/scene, word count, esport).
- **Novel Word Count / Writing Goals** → tenere traccia parole per capitolo/progetto.[^27_13]
- **Typewriter Scroll** → mantenere il cursore al centro, più comodo per scrivere.[^27_12][^27_13]
- **Draft Bench** (nuovo) → workflow per romanzi/scene basato su frontmatter, simile a ciò che stai costruendo ma “impacchettato”.[^27_14]

Puoi iniziare solo con Templater + QuickAdd + Dataview + Bases; Longform/Draft Bench li puoi valutare dopo, quando il sistema base è stabile.

***

Quando inizi a impostare: da quale pezzo vuoi partire subito in Obsidian, in pratica—installare e configurare **Templater** per fare il template capitolo, o mettere su prima un’azione **QuickAdd** “Nuovo capitolo romanzo” che lo richiama?

<div align="center">⁂</div>

[^27_1]: https://parazettel.com/articles/obsidian-plugins-kept/

[^27_2]: https://www.youtube.com/watch?v=OqjmgyYvB8U

[^27_3]: https://www.obsidianstats.com/tags/template

[^27_4]: https://www.reddit.com/r/ObsidianMD/comments/1lpoe1m/what_is_one_plugin_or_workflow_in_obsidian_that/

[^27_5]: https://paulsvaultmembers.com/yt-videos/mastering-obsidian-templates-my-workflow-and-setup-tips/

[^27_6]: https://actuallysomecat.github.io/blog/2025-05-05 - blog - obsidian templates and use/

[^27_7]: https://effortlessacademic.com/using-obsidian-bases-for-academic-note-taking/

[^27_8]: https://www.xda-developers.com/uninstalled-obsidian-plugins-vault-easier-to-manage/

[^27_9]: https://davidrusho.com/6dd00995-58ca-42bd-b2a8-2f1b5228e2fe

[^27_10]: https://community.obsidian.md

[^27_11]: https://www.ylanallouche.xyz/posts/quickadd-templates/

[^27_12]: https://publish.obsidian.md/hub/02+-+Community+Expansions/02.01+Plugins+by+Category/Plugins+for+Writers

[^27_13]: https://www.reddit.com/r/ObsidianMD/comments/17osltk/suggestions_for_a_plugin_for_novel_and_creative/

[^27_14]: https://forum.obsidian.md/t/draft-bench-a-manuscript-workflow-for-fiction-in-plain-markdown/114342

[^27_15]: https://loreteller.com/learn/obsidian-fiction-writers-guide/


---

# voglio iniziare configurando Templater per il template del capitolo

Ottima scelta partire da Templater: se lo imposti bene, ogni nuovo capitolo nasce già “giusto”.

Ti propongo un percorso in **3 passi concreti**, senza entrare ancora nel codice complesso.

***

## 1. Setup base di Templater

Passi (riassunto dalle guide base):[^28_1][^28_2][^28_3]

1. In Obsidian:
    - Impostazioni → Community plugins → attiva i plugin;
    - “Browse”, cerca **Templater**, installa e abilita.[^28_2][^28_1]
2. Crea una cartella per i template, ad esempio:
    - `00_META/Templates/`
3. In Impostazioni → **Templater**:
    - “Template folder location” → scegli `00_META/Templates/`.[^28_3]
    - Attiva “Trigger Templater on new file creation” se vuoi.
    - (Più avanti potrai usare “Folder templates” per dire: per tutti i file in `Romanzo/Capitoli` usa il template capitolo. )[^28_2][^28_3]

A questo punto i file dentro `00_META/Templates/` sono disponibili come template Templater.

***

## 2. Creare il file di template “Capitolo Romanzo”

Dentro `00_META/Templates/` crea una nota, ad esempio `Template – Capitolo Romanzo`.

Nel corpo della nota metterai:

- In alto: il blocco di **frontmatter** con tutti i campi che abbiamo definito (proprio in stile YAML), con i tuoi valori di default.
- Sotto: una piccola struttura per il contenuto (es. un titolo e due righe vuote).

Le guide su Templater suggeriscono di partire con template “quasi statici” e aggiungere Templater script solo dove serve davvero (es. data, titolo automatico).[^28_4][^28_5][^28_6]

***

## 3. Impostare l’uso del template per i capitoli

Per usare questo template sui capitoli puoi fare in modo semplice, all’inizio:

- Vai nella cartella `03_Scrittura/Romanzo/Capitoli/`.
- Crea una nuova nota per un capitolo (es. `02_CH_TheIntrusion_r00`).
- Lancia il comando Templater “Insert template” e scegli “Template – Capitolo Romanzo”.[^28_5]

Più avanti, quando ti trovi bene:

- in Impostazioni → Templater → **Folder templates**:
    - aggiungi una regola che dice: per la cartella `03_Scrittura/Romanzo/Capitoli/` usa il template “Template – Capitolo Romanzo”;
- così ogni nuova nota in quella cartella partirà già col frontmatter del capitolo, senza doverlo richiamare a mano.[^28_7][^28_3][^28_2]

Questa funzione (“folder templates”) è proprio pensata per avere un template diverso per ogni tipo di nota (capitoli, scene, personaggi, ecc.).[^28_3][^28_7]

***

Quando ti metterai a scriverlo in Obsidian, ti andrebbe di partire creando **materialmente** il file `Template – Capitolo Romanzo` con i campi che abbiamo definito (tipo, progetto, numero_capitolo, pov, arco, modalita_mark, trigger, ecc.) e poi raccontarmi che campi hai effettivamente inserito, così possiamo fare un check veloce e vedere se manca qualcosa di ovvio?
<span style="display:none">[^28_10][^28_11][^28_12][^28_13][^28_14][^28_15][^28_8][^28_9]</span>

<div align="center">⁂</div>

[^28_1]: https://www.youtube.com/watch?v=QpJbeP8f55A

[^28_2]: https://www.reddit.com/r/ObsidianMD/comments/uatsjz/templater_automatically_assign_templates_based_on/

[^28_3]: https://silentvoid13.github.io/Templater/settings.html

[^28_4]: https://cassidoo.co/post/obsidian-templater/

[^28_5]: https://www.youtube.com/watch?v=91H_0ii4S-A\&vl=it

[^28_6]: https://github.com/Ambi93/Obsidian-Sync/blob/main/Comprehensive User Guide for Templater in Obsidian.md

[^28_7]: https://www.reddit.com/r/ObsidianMD/comments/1nen7ym/templater_how_to_insert_specific_frontmatter/

[^28_8]: https://www.youtube.com/watch?v=91H_0ii4S-A

[^28_9]: https://github.com/SilentVoid13/Templater/discussions/187

[^28_10]: https://sascha-kasper.com/obsidian-templates-ask-for-a-title-before-creating-a-note/

[^28_11]: https://www.youtube.com/watch?v=91H_0ii4S-A\&vl=en

[^28_12]: https://forum.obsidian.md/t/adding-frontmatter-with-template/76281

[^28_13]: https://zachyoung.dev/posts/folder-templates-with-quick-switcher/

[^28_14]: https://github.com/chrisgurney/obsidian-note-toolbar/wiki/Templater

[^28_15]: https://github.com/SilentVoid13/Templater/discussions/1264


---

# si

Perfetto, allora facciamo così: ti lascio una “checklist mentale” molto compatta dei campi che ha senso inserire adesso nel tuo `Template – Capitolo Romanzo`, così puoi crearla in Obsidian e poi tornare qui a dirmi cosa hai messo davvero.

***

## 1. Campi core da mettere nel frontmatter del template capitolo

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

Questi sono quelli che serviranno subito a Bases e Dataview e nascono da tutto il lavoro che hai già fatto su POV, archi, trigger, stati interni.[^29_1][^29_2][^29_3]

Sotto il frontmatter puoi aggiungere una piccola struttura, tipo:

- una riga con il titolo capitolo (se ti va di averlo anche nel corpo),
- una riga vuota,
- poi il testo del capitolo.

***

## 2. Cosa fare adesso in pratica

Passi concreti:

1. In Obsidian, crea `Template – Capitolo Romanzo` nella cartella dei template.[^29_4][^29_5]
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

***

Quando hai fatto questo passaggio, mi racconti quali campi hai effettivamente messo nel template (e se ne hai modificati alcuni nomi), così possiamo rivederli insieme e capire se vogliamo aggiungere/togliere qualcosa prima di estenderlo agli altri capitoli?

<div align="center">⁂</div>

[^29_1]: 02_CH_TheIntrusion_r00.md

[^29_2]: https://blacksmithgu.github.io/obsidian-dataview/

[^29_3]: https://www.kevsrobots.com/learn/obsidian/08_dataview_and_bases.html

[^29_4]: https://silentvoid13.github.io/Templater/settings.html

[^29_5]: https://www.youtube.com/watch?v=QpJbeP8f55A


---

# ok

Perfetto, allora ci fermiamo qui con la teoria e il prossimo passo è tutto pratico in Obsidian.

Riassunto operativo per te:

- Crea il file `Template – Capitolo Romanzo` nella cartella dei template.
- Metti nel frontmatter i campi che abbiamo deciso (tipo, progetto, numero_capitolo, stato_bozza, pov, arco, modalita_mark, trigger, ecc.).
- Applica il template a `02_CH_TheIntrusion_r00` e compila i valori per quel capitolo (Mark, arco_principale, trigger cluck, ecc.).

Quando hai fatto, torna qui e scrivi cosa hai effettivamente inserito nel frontmatter del template (anche copiando solo l’elenco dei campi e quali hai lasciato vuoti), così possiamo rifinirlo insieme: secondo te, quali 2–3 campi ti sembrano già ora i più importanti da avere davanti mentre scrivi (pov, arco, trigger, stato_bozza…)?

