#!/usr/bin/env python3
"""
DOCX → Obsidian Converter + Nuovo Documento
GUI + file watcher per il porting e la creazione di documenti nel vault Obsidian.
"""

import tkinter as tk
from tkinter import ttk, filedialog, messagebox, scrolledtext, simpledialog
import subprocess
import re
import os
import threading
from datetime import date
from pathlib import Path

# ── Configurazione vault ──────────────────────────────────────────────────────

VAULT   = Path(r"j:\My Drive\Vaults\postman")
INBOX   = VAULT / "_inbox"

LEVELS = [
    ("00_NOT", "Note, Idee, Frammenti"),
    ("01_SCN", "Scene"),
    ("02_CH",  "Capitoli"),
    ("03_ARC", "Archi narrativi"),
    ("04_WB",  "World Building"),
    ("05_GEN", "Genealogie"),
    ("06_MAP", "Mappe"),
    ("07_RES", "Ricerca"),
    ("08_DIA", "Diagrammi"),
    ("09_FIN", "Versioni finali"),
    ("10_MAC", "Macro"),
]
LEVEL_CODES  = [c for c, _ in LEVELS]
LEVEL_LABELS = ["{} – {}".format(c, d) for c, d in LEVELS]

CATEGORIES = ["Narrativa", "Articoli"]

# ── Helpers ───────────────────────────────────────────────────────────────────

def slug(text, max_len=30):
    """Converti testo in componente PascalCase per nome file."""
    text = re.sub(r"[^\w\s\-]", "", text.strip())
    return "".join(w.capitalize() for w in text.split())[:max_len]

def clean_md(text):
    """Rimuovi artefatti Pandoc dal markdown."""
    text = re.sub(r"\{#[^}]+\}", "", text)
    text = re.sub(r"\{\.TOC-Heading\}", "", text)
    text = re.sub(r"\{\.underline\}", "", text)
    text = re.sub(r"^\[.+?\]\(#.+?\)\n?", "", text, flags=re.MULTILINE)
    text = re.sub(r"\n{3,}", "\n\n", text)
    return text.strip()

def docx_to_md(docx_path):
    """Converti .docx → stringa markdown tramite Pandoc."""
    r = subprocess.run(
        ["pandoc", str(docx_path), "-t", "markdown", "--wrap=none"],
        capture_output=True, text=True, encoding="utf-8"
    )
    if r.returncode != 0:
        raise RuntimeError("Pandoc: " + r.stderr)
    return clean_md(r.stdout)

def split_sections(md, heading_level=1):
    """
    Suddivide il markdown in sezioni al livello heading specificato.
    Restituisce lista di (titolo, corpo).
    """
    pat = re.compile(r"^#{" + str(heading_level) + r"}\s+(.+)$", re.MULTILINE)
    matches = list(pat.finditer(md))
    if not matches:
        return [("Documento", md)]

    sections = []
    if matches[0].start() > 0:
        pre = md[:matches[0].start()].strip()
        if pre and not re.match(r"table of contents", pre, re.I):
            sections.append(("Prefazione", pre))

    for i, m in enumerate(matches):
        title = m.group(1).strip()
        if re.match(r"table of contents", title, re.I):
            continue
        start = m.end()
        end   = matches[i + 1].start() if i + 1 < len(matches) else len(md)
        body  = md[start:end].strip()
        sections.append((title, body))

    return sections

# ── Conversione ───────────────────────────────────────────────────────────────

def convert(docx_path, category, level_code, doc_title, split_level, log):
    today     = date.today().strftime("%Y-%m-%d")
    doc_slug  = slug(doc_title)

    out_dir = VAULT / category / level_code / doc_title
    out_dir.mkdir(parents=True, exist_ok=True)
    log("📁 Output: {}".format(out_dir))

    log("⚙️  Pandoc in corso...")
    md = docx_to_md(docx_path)

    sections = split_sections(md, heading_level=split_level)
    log("✂️  {} sezioni trovate (H{})".format(len(sections), split_level))

    created = []

    for i, (title, body) in enumerate(sections):
        cap_slug = slug(title)
        fname    = "{}_{}_{}_{}_{}.md".format(
            "{:02d}".format(i) if i > 0 else "00",
            level_code, doc_slug, cap_slug, today
        )
        fpath = out_dir / fname

        fm = (
            "---\n"
            'title: "{}"\n'
            'book: "{}"\n'
            "chapter: {}\n"
            'level: "{}"\n'
            'category: "{}"\n'
            "date: {}\n"
            "tags: [{}, {}, importato]\n"
            "---\n\n"
        ).format(title, doc_title, i, level_code, category, today,
                 category.lower(), level_code.lower())

        content = "# {}\n\n{}\n".format(title, body)
        fpath.write_text(fm + content, encoding="utf-8")
        created.append((fpath, title))
        log("  ✅ {}".format(fname))

    # Aggiungi navigazione ← →
    for i, (fp, _) in enumerate(created):
        text = fp.read_text(encoding="utf-8")
        prev = "[[{}]]".format(created[i - 1][0].stem) if i > 0 else "[[00_Index_{}_{}]]".format(doc_slug, today)
        nxt  = "[[{}]]".format(created[i + 1][0].stem) if i + 1 < len(created) else "[[00_Index_{}_{}]]".format(doc_slug, today)
        text += "\n---\n\n← {} | Avanti → {}\n".format(prev, nxt)
        fp.write_text(text, encoding="utf-8")

    # Indice
    idx_name = "00_Index_{}_{}.md".format(doc_slug, today)
    idx_path = out_dir / idx_name
    toc = "\n".join(
        "- [[{}|{}]]".format(fp.stem, title)
        for fp, title in created
    )
    idx_content = (
        "---\n"
        'title: "{} – Indice"\n'
        'book: "{}"\n'
        'level: "{}"\n'
        'category: "{}"\n'
        "date: {}\n"
        "tags: [{}, index, importato]\n"
        "---\n\n"
        "# {} – Indice\n\n"
        "## Contenuti\n\n"
        "{}\n\n"
        "---\n\n"
        "← [[MOC_{}]]\n"
    ).format(
        doc_title, doc_title, level_code, category, today,
        category.lower(), doc_title, toc, category
    )
    idx_path.write_text(idx_content, encoding="utf-8")
    log("  📋 Indice: {}".format(idx_name))

    # Aggiorna MOC categoria
    moc_path = VAULT / "MOC_{}.md".format(category)
    if moc_path.exists():
        moc_text = moc_path.read_text(encoding="utf-8")
        new_row  = "| [[{}/{}/{}/{}\\|{}]] | {} | {} | Importato |".format(
            category, level_code, doc_title,
            "00_Index_{}_{}".format(doc_slug, today),
            doc_title, level_code, today
        )
        # Sostituisci riga placeholder o aggiungi dopo intestazione tabella
        if "Nessun" in moc_text:
            moc_text = re.sub(r"\| —.*\|", new_row, moc_text)
        else:
            moc_text = moc_text.replace(
                "| Titolo | Livello |",
                "| Titolo | Livello |",
            )
            moc_text += "\n" + new_row
        moc_path.write_text(moc_text, encoding="utf-8")
        log("  🔗 MOC aggiornato: MOC_{}.md".format(category))

    log("\n✨ Completato! {} file in:\n   {}".format(len(created), out_dir))
    return out_dir

# ── Creazione nuovo documento ─────────────────────────────────────────────────

def create_new_document(category, level_code, doc_title, author, chapters, log):
    """
    Crea ex-novo una struttura di documento nel vault:
      - una cartella Categoria/LivelloCode/TitoloDocumento/
      - un file per ciascun capitolo con frontmatter e navigazione
      - un indice 00_Index_…md
      - aggiorna il MOC della categoria
    chapters: lista di dict {title, content}
    """
    today    = date.today().strftime("%Y-%m-%d")
    doc_slug = slug(doc_title)

    out_dir = VAULT / category / level_code / doc_title
    out_dir.mkdir(parents=True, exist_ok=True)
    log("📁 Cartella: {}".format(out_dir))

    created = []

    for i, ch in enumerate(chapters, start=1):
        cap_slug = slug(ch["title"])
        fname    = "{:02d}_{}_{}_{}_{}_{}.md".format(
            i, level_code, doc_slug, cap_slug, today, "v1"
        )
        # clean name – no double underscores
        fname = re.sub(r"_+", "_", fname)
        fpath = out_dir / fname

        fm = (
            "---\n"
            'title: "{}"\n'
            'book: "{}"\n'
            'author: "{}"\n'
            "chapter: {}\n"
            'level: "{}"\n'
            'category: "{}"\n'
            "date: {}\n"
            "revision: v1\n"
            "tags: [{}, {}, nuovo]\n"
            "---\n\n"
        ).format(ch["title"], doc_title, author, i, level_code,
                 category, today, category.lower(), level_code.lower())

        body = ch.get("content", "").strip() or "*[Contenuto da aggiungere]*"
        content = "# {}\n\n{}\n".format(ch["title"], body)
        fpath.write_text(fm + content, encoding="utf-8")
        created.append((fpath, ch["title"]))
        log("  ✅ {}".format(fname))

    # Navigazione ← →
    idx_stem = "00_Index_{}_{}".format(doc_slug, today)
    for i, (fp, _) in enumerate(created):
        text = fp.read_text(encoding="utf-8")
        prev = "[[{}]]".format(created[i-1][0].stem) if i > 0 else "[[{}]]".format(idx_stem)
        nxt  = "[[{}]]".format(created[i+1][0].stem) if i+1 < len(created) else "[[{}]]".format(idx_stem)
        text += "\n---\n\n← {} | Avanti → {}\n".format(prev, nxt)
        fp.write_text(text, encoding="utf-8")

    # Indice
    toc = "\n".join(
        "- [[{}|{}]]".format(fp.stem, title)
        for fp, title in created
    )
    idx_name = "{}.md".format(idx_stem)
    idx_path = out_dir / idx_name
    idx_content = (
        "---\n"
        'title: "{} – Indice"\n'
        'book: "{}"\n'
        'author: "{}"\n'
        'level: "{}"\n'
        'category: "{}"\n'
        "date: {}\n"
        "tags: [{}, index, nuovo]\n"
        "---\n\n"
        "# {} – Indice\n\n"
        "**Autore:** {}\n\n"
        "## Capitoli\n\n"
        "{}\n\n"
        "---\n\n"
        "← [[MOC_{}]]\n"
    ).format(
        doc_title, doc_title, author, level_code, category, today,
        category.lower(), doc_title, author or "—", toc, category
    )
    idx_path.write_text(idx_content, encoding="utf-8")
    log("  📋 Indice: {}".format(idx_name))

    # Aggiorna MOC
    moc_path = VAULT / "MOC_{}.md".format(category)
    if moc_path.exists():
        moc_text = moc_path.read_text(encoding="utf-8")
        new_row  = "| [[{}/{}/{}/{}\\|{}]] | {} | {} | Nuovo |".format(
            category, level_code, doc_title, idx_stem,
            doc_title, level_code, today
        )
        if "Nessun" in moc_text:
            moc_text = re.sub(r"\| —.*\|", new_row, moc_text)
        else:
            moc_text += "\n" + new_row
        moc_path.write_text(moc_text, encoding="utf-8")
        log("  🔗 MOC aggiornato: MOC_{}.md".format(category))

    log("\n✨ Documento creato! {} capitoli in:\n   {}".format(len(created), out_dir))
    return out_dir

# ── Watcher ───────────────────────────────────────────────────────────────────

def make_watcher(log, get_cat, get_level, get_split):
    from watchdog.observers import Observer
    from watchdog.events import FileSystemEventHandler

    class Handler(FileSystemEventHandler):
        def on_created(self, event):
            if not event.is_directory and event.src_path.lower().endswith(".docx"):
                p = Path(event.src_path)
                log("\n📥 Rilevato: {}".format(p.name))
                try:
                    convert(p, get_cat(), get_level(), p.stem,
                            int(get_split()), log)
                except Exception as e:
                    log("❌ Errore: {}".format(e))

    obs = Observer()
    obs.schedule(Handler(), str(INBOX), recursive=False)
    obs.start()
    log("👁  Watcher attivo su: {}".format(INBOX))
    return obs

# ── GUI ───────────────────────────────────────────────────────────────────────

class App(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Obsidian Vault Manager")
        self.minsize(660, 560)
        self.configure(padx=12, pady=12)
        self._observer = None
        self._chapters  = []   # lista capitoli per "Nuovo Documento"
        self._build()

    def _build(self):
        self.columnconfigure(0, weight=1)
        self.rowconfigure(0, weight=1)

        nb = ttk.Notebook(self)
        nb.grid(row=0, column=0, sticky="nsew")

        # ── Tab 1: Importa DOCX ───────────────────────────────────────────────
        tab_import = ttk.Frame(nb, padding=10)
        tab_import.columnconfigure(0, weight=1)
        tab_import.rowconfigure(4, weight=1)
        nb.add(tab_import, text="  📥  Importa DOCX  ")
        self._build_import_tab(tab_import)

        # ── Tab 2: Nuovo Documento ────────────────────────────────────────────
        tab_new = ttk.Frame(nb, padding=10)
        tab_new.columnconfigure(0, weight=1)
        tab_new.rowconfigure(4, weight=1)
        nb.add(tab_new, text="  📝  Nuovo Documento  ")
        self._build_new_tab(tab_new)

        # ── Log (condiviso) ───────────────────────────────────────────────────
        frm_log = ttk.LabelFrame(self, text=" Log ")
        frm_log.grid(row=1, column=0, sticky="nsew", pady=(8, 0))
        frm_log.columnconfigure(0, weight=1)
        frm_log.rowconfigure(0, weight=1)
        self.rowconfigure(1, weight=1)

        self.log_box = scrolledtext.ScrolledText(
            frm_log, height=10, state="disabled",
            font=("Consolas", 9), bg="#1e1e1e", fg="#d4d4d4",
            insertbackground="white"
        )
        self.log_box.grid(row=0, column=0, sticky="nsew", padx=4, pady=4)
        ttk.Button(frm_log, text="Pulisci log",
                   command=self._clear_log).grid(row=1, column=0, sticky="e", padx=4, pady=(0, 4))

    # ── Tab Importa ───────────────────────────────────────────────────────────

    def _build_import_tab(self, parent):
        # Sorgente
        src = ttk.LabelFrame(parent, text=" Documento sorgente ")
        src.grid(row=0, column=0, sticky="ew", pady=(0, 8))
        src.columnconfigure(1, weight=1)

        ttk.Label(src, text="File .docx:").grid(row=0, column=0, sticky="w", padx=6, pady=4)
        self.v_file = tk.StringVar()
        ttk.Entry(src, textvariable=self.v_file).grid(row=0, column=1, sticky="ew", padx=4)
        ttk.Button(src, text="Sfoglia…", command=self._browse).grid(row=0, column=2, padx=6)

        ttk.Label(src, text="Titolo:").grid(row=1, column=0, sticky="w", padx=6, pady=4)
        self.v_title = tk.StringVar()
        ttk.Entry(src, textvariable=self.v_title).grid(row=1, column=1, sticky="ew", padx=4, pady=4)

        # Opzioni import
        opt = ttk.LabelFrame(parent, text=" Opzioni ")
        opt.grid(row=1, column=0, sticky="ew", pady=(0, 8))

        ttk.Label(opt, text="Categoria:").grid(row=0, column=0, sticky="w", padx=6, pady=4)
        self.v_cat = tk.StringVar(value="Narrativa")
        ttk.Combobox(opt, textvariable=self.v_cat, values=CATEGORIES,
                     state="readonly", width=22).grid(row=0, column=1, sticky="w", padx=4)

        ttk.Label(opt, text="Livello:").grid(row=1, column=0, sticky="w", padx=6, pady=4)
        self.v_level = tk.StringVar(value="02_CH")
        self.cmb_level = ttk.Combobox(opt, textvariable=self.v_level,
                                       values=LEVEL_CODES, state="readonly", width=22)
        self.cmb_level.grid(row=1, column=1, sticky="w", padx=4)
        self.lbl_level = ttk.Label(opt, text="Capitoli", foreground="#888")
        self.lbl_level.grid(row=1, column=2, sticky="w", padx=4)
        self.cmb_level.bind("<<ComboboxSelected>>", self._on_level_change)

        ttk.Label(opt, text="Suddividi su:").grid(row=2, column=0, sticky="w", padx=6, pady=4)
        self.v_split = tk.StringVar(value="1")
        frm_r = ttk.Frame(opt)
        frm_r.grid(row=2, column=1, sticky="w")
        for lbl, val in [("H1 (capitoli)", "1"), ("H2 (sezioni)", "2"), ("H3 (sottosezioni)", "3")]:
            ttk.Radiobutton(frm_r, text=lbl, variable=self.v_split, value=val).pack(side="left", padx=6)

        # Azioni import
        frm_btn = ttk.Frame(parent)
        frm_btn.grid(row=2, column=0, sticky="ew", pady=(0, 4))
        ttk.Button(frm_btn, text="▶  Converti",
                   command=self._convert).pack(side="left", padx=(0, 8))
        self.btn_watch = ttk.Button(frm_btn, text="👁  Avvia watcher _inbox",
                                    command=self._toggle_watch)
        self.btn_watch.pack(side="left", padx=(0, 8))
        ttk.Button(frm_btn, text="📂 Vault",
                   command=lambda: os.startfile(str(VAULT))).pack(side="right")
        ttk.Button(frm_btn, text="📥 _inbox",
                   command=lambda: os.startfile(str(INBOX))).pack(side="right", padx=8)

    # ── Tab Nuovo Documento ───────────────────────────────────────────────────

    def _build_new_tab(self, parent):
        # Metadati documento
        meta = ttk.LabelFrame(parent, text=" Metadati documento ")
        meta.grid(row=0, column=0, sticky="ew", pady=(0, 8))
        meta.columnconfigure(1, weight=1)
        meta.columnconfigure(3, weight=1)

        ttk.Label(meta, text="Titolo:").grid(row=0, column=0, sticky="w", padx=6, pady=4)
        self.v_new_title = tk.StringVar()
        ttk.Entry(meta, textvariable=self.v_new_title).grid(
            row=0, column=1, sticky="ew", padx=4, pady=4)

        ttk.Label(meta, text="Autore:").grid(row=0, column=2, sticky="w", padx=(12, 4))
        self.v_new_author = tk.StringVar()
        ttk.Entry(meta, textvariable=self.v_new_author, width=20).grid(
            row=0, column=3, sticky="ew", padx=4)

        ttk.Label(meta, text="Categoria:").grid(row=1, column=0, sticky="w", padx=6, pady=4)
        self.v_new_cat = tk.StringVar(value="Narrativa")
        ttk.Combobox(meta, textvariable=self.v_new_cat, values=CATEGORIES,
                     state="readonly", width=18).grid(row=1, column=1, sticky="w", padx=4)

        ttk.Label(meta, text="Livello:").grid(row=1, column=2, sticky="w", padx=(12, 4))
        self.v_new_level = tk.StringVar(value="02_CH")
        self.cmb_new_level = ttk.Combobox(meta, textvariable=self.v_new_level,
                                           values=LEVEL_CODES, state="readonly", width=18)
        self.cmb_new_level.grid(row=1, column=3, sticky="w", padx=4)
        self.cmb_new_level.bind("<<ComboboxSelected>>", self._on_new_level_change)
        self.lbl_new_level = ttk.Label(meta, text="Capitoli", foreground="#888")
        self.lbl_new_level.grid(row=1, column=4, sticky="w", padx=4)

        # Lista capitoli
        ch_frame = ttk.LabelFrame(parent, text=" Capitoli ")
        ch_frame.grid(row=1, column=0, sticky="nsew", pady=(0, 8))
        ch_frame.columnconfigure(0, weight=1)
        ch_frame.rowconfigure(0, weight=1)
        parent.rowconfigure(1, weight=1)

        # Listbox + scrollbar
        lbx_frame = ttk.Frame(ch_frame)
        lbx_frame.grid(row=0, column=0, sticky="nsew", padx=6, pady=4)
        lbx_frame.columnconfigure(0, weight=1)
        lbx_frame.rowconfigure(0, weight=1)

        self.ch_listbox = tk.Listbox(lbx_frame, height=8,
                                      font=("Consolas", 9),
                                      selectmode="single",
                                      bg="#2d2d2d", fg="#d4d4d4",
                                      selectbackground="#264f78",
                                      activestyle="none")
        self.ch_listbox.grid(row=0, column=0, sticky="nsew")
        sb = ttk.Scrollbar(lbx_frame, orient="vertical",
                            command=self.ch_listbox.yview)
        sb.grid(row=0, column=1, sticky="ns")
        self.ch_listbox.configure(yscrollcommand=sb.set)
        self.ch_listbox.bind("<Double-Button-1>", lambda _: self._edit_chapter())

        # Bottoni gestione capitoli
        btn_ch = ttk.Frame(ch_frame)
        btn_ch.grid(row=1, column=0, sticky="ew", padx=6, pady=(0, 6))
        ttk.Button(btn_ch, text="➕ Aggiungi",
                   command=self._add_chapter).pack(side="left", padx=(0, 4))
        ttk.Button(btn_ch, text="✏️ Modifica",
                   command=self._edit_chapter).pack(side="left", padx=(0, 4))
        ttk.Button(btn_ch, text="🗑 Rimuovi",
                   command=self._remove_chapter).pack(side="left", padx=(0, 4))
        ttk.Button(btn_ch, text="⬆", width=3,
                   command=lambda: self._move_chapter(-1)).pack(side="left", padx=(0, 2))
        ttk.Button(btn_ch, text="⬇", width=3,
                   command=lambda: self._move_chapter(1)).pack(side="left")

        # Azioni crea
        frm_new_btn = ttk.Frame(parent)
        frm_new_btn.grid(row=2, column=0, sticky="ew", pady=(0, 4))
        ttk.Button(frm_new_btn, text="✨ Crea documento",
                   command=self._create_new).pack(side="left", padx=(0, 8))
        ttk.Button(frm_new_btn, text="🗑 Svuota lista",
                   command=self._clear_chapters).pack(side="left")
        ttk.Button(frm_new_btn, text="📂 Vault",
                   command=lambda: os.startfile(str(VAULT))).pack(side="right")

    # ── Callbacks capitoli ────────────────────────────────────────────────────

    def _add_chapter(self):
        dlg = ChapterDialog(self, title="Nuovo capitolo")
        if dlg.result:
            self._chapters.append(dlg.result)
            self._refresh_listbox()

    def _edit_chapter(self):
        sel = self.ch_listbox.curselection()
        if not sel:
            return
        idx = sel[0]
        dlg = ChapterDialog(self, title="Modifica capitolo",
                             initial=self._chapters[idx])
        if dlg.result:
            self._chapters[idx] = dlg.result
            self._refresh_listbox()

    def _remove_chapter(self):
        sel = self.ch_listbox.curselection()
        if not sel:
            return
        self._chapters.pop(sel[0])
        self._refresh_listbox()

    def _move_chapter(self, direction):
        sel = self.ch_listbox.curselection()
        if not sel:
            return
        idx = sel[0]
        new_idx = idx + direction
        if 0 <= new_idx < len(self._chapters):
            self._chapters[idx], self._chapters[new_idx] = \
                self._chapters[new_idx], self._chapters[idx]
            self._refresh_listbox()
            self.ch_listbox.selection_set(new_idx)

    def _clear_chapters(self):
        if messagebox.askyesno("Conferma", "Svuotare la lista capitoli?"):
            self._chapters.clear()
            self._refresh_listbox()

    def _refresh_listbox(self):
        self.ch_listbox.delete(0, "end")
        for i, ch in enumerate(self._chapters, 1):
            preview = ch["content"][:40].replace("\n", " ") if ch.get("content") else "—"
            self.ch_listbox.insert("end",
                " {:02d}. {} │ {}…".format(i, ch["title"], preview))

    def _on_new_level_change(self, _=None):
        code = self.v_new_level.get()
        self.lbl_new_level.configure(text=dict(LEVELS).get(code, ""))

    def _create_new(self):
        title  = self.v_new_title.get().strip()
        author = self.v_new_author.get().strip()
        if not title:
            messagebox.showwarning("Attenzione", "Inserisci un titolo.")
            return
        if not self._chapters:
            messagebox.showwarning("Attenzione", "Aggiungi almeno un capitolo.")
            return

        chapters = list(self._chapters)

        def task():
            try:
                create_new_document(
                    self.v_new_cat.get(), self.v_new_level.get(),
                    title, author, chapters, self._log
                )
            except Exception as e:
                self._log("❌ {}".format(e))

        threading.Thread(target=task, daemon=True).start()

    # ── Callbacks import ──────────────────────────────────────────────────────

    def _on_level_change(self, _=None):
        code = self.v_level.get()
        desc = dict(LEVELS).get(code, "")
        self.lbl_level.configure(text=desc)

    def _log(self, msg):
        self.log_box.configure(state="normal")
        self.log_box.insert("end", msg + "\n")
        self.log_box.see("end")
        self.log_box.configure(state="disabled")

    def _clear_log(self):
        self.log_box.configure(state="normal")
        self.log_box.delete("1.0", "end")
        self.log_box.configure(state="disabled")

    def _browse(self):
        path = filedialog.askopenfilename(
            initialdir=str(INBOX),
            title="Seleziona documento Word",
            filetypes=[("Word", "*.docx"), ("Tutti", "*.*")]
        )
        if path:
            self.v_file.set(path)
            if not self.v_title.get():
                self.v_title.set(Path(path).stem)

    def _convert(self):
        docx  = self.v_file.get().strip()
        title = self.v_title.get().strip() or Path(docx).stem if docx else ""
        if not docx:
            messagebox.showwarning("Attenzione", "Seleziona un file .docx.")
            return
        self.v_title.set(title)

        def task():
            try:
                convert(Path(docx), self.v_cat.get(), self.v_level.get(),
                        title, int(self.v_split.get()), self._log)
            except Exception as e:
                self._log("❌ {}".format(e))

        threading.Thread(target=task, daemon=True).start()

    def _toggle_watch(self):
        if self._observer and self._observer.is_alive():
            self._observer.stop()
            self._observer = None
            self.btn_watch.configure(text="👁  Avvia watcher _inbox")
            self._log("⏹  Watcher fermato.")
        else:
            try:
                self._observer = make_watcher(
                    self._log,
                    self.v_cat.get,
                    self.v_level.get,
                    self.v_split.get
                )
                self.btn_watch.configure(text="⏹  Ferma watcher")
            except Exception as e:
                self._log("❌ Watcher: {}".format(e))

    def on_close(self):
        if self._observer:
            self._observer.stop()
        self.destroy()


# ── Dialog capitolo ───────────────────────────────────────────────────────────

class ChapterDialog(tk.Toplevel):
    """Finestra modale per aggiungere/modificare un capitolo."""

    def __init__(self, parent, title="Capitolo", initial=None):
        super().__init__(parent)
        self.transient(parent)
        self.grab_set()
        self.title(title)
        self.resizable(True, True)
        self.result = None
        self._build(initial or {})
        self.protocol("WM_DELETE_WINDOW", self._cancel)
        self.geometry("520x340")
        self.wait_window(self)

    def _build(self, initial):
        self.columnconfigure(0, weight=1)
        self.rowconfigure(2, weight=1)

        frm = ttk.Frame(self, padding=10)
        frm.grid(row=0, column=0, sticky="ew")
        frm.columnconfigure(1, weight=1)

        ttk.Label(frm, text="Titolo capitolo:").grid(row=0, column=0, sticky="w", padx=4)
        self.v_title = tk.StringVar(value=initial.get("title", ""))
        ttk.Entry(frm, textvariable=self.v_title).grid(
            row=0, column=1, sticky="ew", padx=4)

        ttk.Label(self, text="Contenuto iniziale (opzionale):").grid(
            row=1, column=0, sticky="nw", padx=14, pady=(6, 2))

        frm_txt = ttk.Frame(self, padding=(10, 0, 10, 0))
        frm_txt.grid(row=2, column=0, sticky="nsew")
        frm_txt.columnconfigure(0, weight=1)
        frm_txt.rowconfigure(0, weight=1)

        self.txt = scrolledtext.ScrolledText(
            frm_txt, height=8, wrap="word",
            font=("Consolas", 9), bg="#2d2d2d", fg="#d4d4d4",
            insertbackground="white"
        )
        self.txt.grid(row=0, column=0, sticky="nsew")
        if initial.get("content"):
            self.txt.insert("1.0", initial["content"])

        frm_btn = ttk.Frame(self, padding=(10, 6))
        frm_btn.grid(row=3, column=0, sticky="e")
        ttk.Button(frm_btn, text="✅ Salva",
                   command=self._save).pack(side="left", padx=(0, 8))
        ttk.Button(frm_btn, text="Annulla",
                   command=self._cancel).pack(side="left")

    def _save(self):
        title = self.v_title.get().strip()
        if not title:
            messagebox.showwarning("Attenzione", "Il titolo è obbligatorio.", parent=self)
            return
        self.result = {
            "title":   title,
            "content": self.txt.get("1.0", "end-1c").strip()
        }
        self.destroy()

    def _cancel(self):
        self.destroy()


if __name__ == "__main__":
    app = App()
    app.protocol("WM_DELETE_WINDOW", app.on_close)
    app.mainloop()
