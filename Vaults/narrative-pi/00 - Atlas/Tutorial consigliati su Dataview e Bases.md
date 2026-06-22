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
