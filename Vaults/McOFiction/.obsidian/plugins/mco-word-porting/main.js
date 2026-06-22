const { Plugin, Notice, Modal, PluginSettingTab, Setting } = require("obsidian");
const { execFile } = require("child_process");
const fs = require("fs");
const path = require("path");

const DEFAULT_SETTINGS = {
  sourceFile: "assets://Shades of Silence - Fractured mosaic.docx",
  sourceDocumentTitle: "Shades of Silence - Fractured mosaic",
  destDir: "Notes/02_CH",
  bookTitle: "Shades of Silence - Fractured mosaic",
  chapterNumberPadding: 2,
  paragraphNumberPadding: 2,
  chapterLevel: "02",
  chapterModule: "CH",
  revisionNumber: 0,
  includeFrontmatter: true,
  noIndex: false,
  autoConvertWord: true,
  pandocCommand: "pandoc",
  convertedMarkdownDirectory: "",
  keepConvertedMarkdown: false,
  enablePostProcessing: true,
  useChapterTemplate: true,
  chapterTemplatePath: "Templates/Chapter Template - Fast Drafting Minimal.md",
  newChapterDefaultFolder: "Notes/02_CH",
  frontmatterTags: "imported, chapter, mcofiction",
  scriptRelativePath: "scripts://split_chapters.ps1",
  autoRunOnStartup: false,
  autoWatchEnabled: false,
  autoWatchFolder: "INBOX/02",
  autoWatchIntervalSeconds: 45,
  processedFiles: {}
};

class PortingFormModal extends Modal {
  constructor(app, initialValues, onSubmit) {
    super(app);
    this.initialValues = initialValues;
    this.onSubmit = onSubmit;
  }

  onOpen() {
    this.modalEl.addClass("mco-porting-modal");

    const { contentEl } = this;
    contentEl.empty();

    contentEl.createEl("h2", { text: "Porting Word/Markdown in capitoli" });

    const shell = contentEl.createDiv({ cls: "mco-porting-shell" });
    shell.createEl("p", {
      cls: "mco-porting-desc",
      text: "Compila il form e avvia split_chapters.ps1 con frontmatter Obsidian, naming standard e output in Notes."
    });

    const grid = shell.createDiv({ cls: "mco-porting-grid" });

    const sourceInput = this.createTextField(grid, "Documento sorgente (.md o .docx)", this.initialValues.sourceFile);
    const sourceDocTitleInput = this.createTextField(grid, "Titolo documento", this.initialValues.sourceDocumentTitle);
    const destDirInput = this.createTextField(grid, "Directory output", this.initialValues.destDir);
    const bookTitleInput = this.createTextField(grid, "Book title", this.initialValues.bookTitle);

    const row = shell.createDiv({ cls: "mco-porting-row" });
    const includeFrontmatterToggle = this.createCheckbox(row, "Includi frontmatter", this.initialValues.includeFrontmatter);
    const noIndexToggle = this.createCheckbox(row, "Disattiva index", this.initialValues.noIndex);
    const autoConvertWordToggle = this.createCheckbox(row, "Auto-converti .docx", this.initialValues.autoConvertWord);

    const actions = shell.createDiv({ cls: "mco-porting-actions" });
    const cancelButton = actions.createEl("button", { text: "Annulla" });
    cancelButton.addEventListener("click", () => this.close());

    const submitButton = actions.createEl("button", {
      cls: "mco-porting-submit",
      text: "Avvia porting"
    });

    submitButton.addEventListener("click", () => {
      this.onSubmit({
        sourceFile: sourceInput.value.trim(),
        sourceDocumentTitle: sourceDocTitleInput.value.trim(),
        destDir: destDirInput.value.trim(),
        bookTitle: bookTitleInput.value.trim(),
        includeFrontmatter: includeFrontmatterToggle.checked,
        noIndex: noIndexToggle.checked,
        autoConvertWord: autoConvertWordToggle.checked
      });
      this.close();
    });
  }

  createTextField(parent, label, value) {
    const wrapper = parent.createDiv({ cls: "mco-porting-field" });
    wrapper.createEl("label", { cls: "mco-porting-label", text: label });
    return wrapper.createEl("input", {
      cls: "mco-porting-input",
      type: "text",
      value: value || ""
    });
  }

  createCheckbox(parent, label, checked) {
    const labelEl = parent.createEl("label");
    labelEl.style.display = "flex";
    labelEl.style.alignItems = "center";
    labelEl.style.gap = "6px";

    const input = labelEl.createEl("input", { type: "checkbox" });
    input.checked = !!checked;
    labelEl.createSpan({ text: label });
    return input;
  }
}

class NewChapterFromTemplateModal extends Modal {
  constructor(app, initialValues, onSubmit) {
    super(app);
    this.initialValues = initialValues;
    this.onSubmit = onSubmit;
  }

  onOpen() {
    this.modalEl.addClass("mco-porting-modal");

    const { contentEl } = this;
    contentEl.empty();

    contentEl.createEl("h2", { text: "Nuovo capitolo da template" });
    const shell = contentEl.createDiv({ cls: "mco-porting-shell" });

    const grid = shell.createDiv({ cls: "mco-porting-grid" });
    const chapterNumberInput = this.createTextField(grid, "Numero capitolo", this.initialValues.chapterNumber);
    const chapterTitleInput = this.createTextField(grid, "Titolo capitolo", this.initialValues.chapterTitle);
    const destinationInput = this.createTextField(grid, "Cartella destinazione", this.initialValues.destinationFolder);

    const actions = shell.createDiv({ cls: "mco-porting-actions" });
    const cancelButton = actions.createEl("button", { text: "Annulla" });
    cancelButton.addEventListener("click", () => this.close());

    const submitButton = actions.createEl("button", {
      cls: "mco-porting-submit",
      text: "Crea capitolo"
    });

    submitButton.addEventListener("click", () => {
      this.onSubmit({
        chapterNumber: chapterNumberInput.value.trim(),
        chapterTitle: chapterTitleInput.value.trim(),
        destinationFolder: destinationInput.value.trim()
      });
      this.close();
    });
  }

  createTextField(parent, label, value) {
    const wrapper = parent.createDiv({ cls: "mco-porting-field" });
    wrapper.createEl("label", { cls: "mco-porting-label", text: label });
    return wrapper.createEl("input", {
      cls: "mco-porting-input",
      type: "text",
      value: value || ""
    });
  }
}

module.exports = class McoWordPortingPlugin extends Plugin {
  async onload() {
    await this.loadSettings();

    this.addRibbonIcon("file-symlink", "Porting documento in capitoli", () => {
      this.openPortingForm();
    });

    this.addCommand({
      id: "mco-word-porting-run",
      name: "Avvia porting documento (split chapters)",
      callback: () => this.openPortingForm()
    });

    this.addCommand({
      id: "mco-word-porting-new-chapter-from-template",
      name: "Crea nuovo capitolo da template",
      callback: () => this.openNewChapterModal()
    });

    this.registerEvent(this.app.workspace.on("file-menu", (menu, file) => {
      if (!file || !file.path) {
        return;
      }

      const sourceExt = path.extname(file.path).toLowerCase();
      if (sourceExt !== ".md" && sourceExt !== ".docx") {
        return;
      }

      menu.addItem((item) => {
        item
          .setTitle("Porting in capitoli da questo file")
          .setIcon("scissors")
          .onClick(async () => {
            const formValues = {
              ...this.settings,
              sourceFile: file.path,
              sourceDocumentTitle: this.stripExtension(path.basename(file.path))
            };
            await this.runSplitChapters(formValues);
          });
      });
    }));

    this.addSettingTab(new McoWordPortingSettingsTab(this.app, this));

    if (this.settings.autoRunOnStartup) {
      this.runSplitChapters(this.settings, true);
    }

    if (this.settings.autoWatchEnabled) {
      this.startAutoWatcher();
    }
  }

  onunload() {
    this.stopAutoWatcher();
  }

  stripExtension(fileName) {
    const ext = path.extname(fileName);
    if (!ext) {
      return fileName;
    }
    return fileName.slice(0, -ext.length);
  }

  openPortingForm() {
    const modal = new PortingFormModal(this.app, this.settings, async (formValues) => {
      const merged = { ...this.settings, ...formValues };
      await this.runSplitChapters(merged);
    });
    modal.open();
  }

  openNewChapterModal() {
    const initialChapterNumber = String(this.settings.chapterNumberPadding || 2).padStart(2, "0");
    const modal = new NewChapterFromTemplateModal(
      this.app,
      {
        chapterNumber: initialChapterNumber,
        chapterTitle: "Nuovo Capitolo",
        destinationFolder: this.settings.newChapterDefaultFolder || this.settings.destDir || "Notes"
      },
      async (values) => {
        await this.createChapterFromTemplate(values);
      }
    );
    modal.open();
  }

  getVaultBasePath() {
    const adapter = this.app.vault.adapter;
    if (!adapter || !adapter.basePath) {
      throw new Error("Impossibile risolvere il percorso del vault su filesystem.");
    }
    return adapter.basePath;
  }

  getProjectRootPath() {
    // Project root contains sibling folders like scripts/ and assets/ next to Vaults/.
    return path.resolve(this.getVaultBasePath(), "..", "..");
  }

  normalizePathInput(pathInput) {
    if (!pathInput) {
      return "";
    }

    let normalized = String(pathInput).trim().replace(/\\/g, "/");

    if (normalized.startsWith("![[") && normalized.endsWith("]]")) {
      normalized = normalized.slice(3, -2).trim();
    } else if (normalized.startsWith("[[") && normalized.endsWith("]]")) {
      normalized = normalized.slice(2, -2).trim();
    }

    const stripMatchingQuotes = (value) => {
      if (value.length < 2) {
        return value;
      }

      const first = value.charAt(0);
      const last = value.charAt(value.length - 1);
      if ((first === '"' || first === "'") && first === last) {
        return value.slice(1, -1).trim();
      }

      return value;
    };

    // Support accidental quoted values from settings, e.g. "assets://file.docx".
    let previous = normalized;
    normalized = stripMatchingQuotes(normalized);
    while (normalized !== previous) {
      previous = normalized;
      normalized = stripMatchingQuotes(normalized);
    }

    // Support accidental quoted filename with extension, e.g. assets://"file name".docx.
    normalized = normalized.replace(/(["'])([^"']+)\1(?=\.[^\/.]+$)/, "$2");

    return normalized;
  }

  resolveFromVault(relativeOrAbsolutePath) {
    if (!relativeOrAbsolutePath) {
      return "";
    }

    const normalizedInput = this.normalizePathInput(relativeOrAbsolutePath);
    const lowerInput = normalizedInput.toLowerCase();

    if (lowerInput.startsWith("scripts://")) {
      const relativePath = normalizedInput.slice("scripts://".length).replace(/^\/+/, "");
      return path.resolve(this.getProjectRootPath(), "scripts", relativePath);
    }

    if (lowerInput.startsWith("assets://")) {
      const relativePath = normalizedInput.slice("assets://".length).replace(/^\/+/, "");
      return path.resolve(this.getProjectRootPath(), "assets", relativePath);
    }

    if (lowerInput.startsWith("vault://")) {
      const relativePath = normalizedInput.slice("vault://".length).replace(/^\/+/, "");
      return path.resolve(this.getVaultBasePath(), relativePath);
    }

    if (path.isAbsolute(relativeOrAbsolutePath)) {
      return relativeOrAbsolutePath;
    }

    return path.resolve(this.getVaultBasePath(), normalizedInput);
  }

  parseTags(tagsCsv) {
    return (tagsCsv || "")
      .split(",")
      .map((tag) => tag.trim())
      .filter((tag) => tag.length > 0);
  }

  normalizeVaultPath(vaultPath) {
    return (vaultPath || "").replace(/\\/g, "/").replace(/^\/+/, "").trim();
  }

  toChapterShortTitle(rawTitle) {
    const tokens = (rawTitle || "").match(/[A-Za-z0-9]+/g) || [];
    if (tokens.length === 0) {
      return "Untitled";
    }

    return tokens
      .map((token) => {
        if (token.length === 1) {
          return token.toUpperCase();
        }
        return token.charAt(0).toUpperCase() + token.slice(1).toLowerCase();
      })
      .join("");
  }

  makeChapterNodeName(shortTitle, level, module, date, revisionNumber) {
    const datePart = date.toISOString().slice(0, 10);
    const revPart = `r${String(revisionNumber).padStart(2, "0")}`;
    return `${level}_${module}_${shortTitle}_${datePart}_${revPart}`;
  }

  getNextRevisionNumber(destinationPath, level, module, shortTitle, date, minimumRevision) {
    if (!fs.existsSync(destinationPath)) {
      return minimumRevision;
    }

    const datePart = date.toISOString().slice(0, 10);
    const escapedPrefix = `${level}_${module}_${shortTitle}_${datePart}_r`.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
    const regex = new RegExp(`^${escapedPrefix}(\\d{2,3})\\.md$`, "i");
    let maxRevision = -1;

    for (const name of fs.readdirSync(destinationPath)) {
      const match = name.match(regex);
      if (!match) {
        continue;
      }

      const current = Number(match[1]);
      if (Number.isFinite(current) && current > maxRevision) {
        maxRevision = current;
      }
    }

    if (maxRevision >= 0) {
      return Math.max(maxRevision + 1, minimumRevision);
    }

    return minimumRevision;
  }

  buildFrontmatterLines(meta, tags) {
    const quote = (value) => `"${String(value ?? "").replace(/"/g, '\\"')}"`;
    const lines = [
      "---",
      `title: ${quote(meta.title)}`,
      `book: ${quote(meta.book)}`,
      `source_document: ${quote(meta.sourceDocument)}`,
      `chapter_number: ${meta.chapterNumber}`,
      `chapter_number_padded: ${quote(meta.chapterNumberPadded)}`,
      `chapter_short_title: ${quote(meta.shortTitle)}`,
      `node: ${quote(meta.node)}`,
      `level: ${quote(meta.level)}`,
      `module: ${quote(meta.module)}`,
      `revision: ${meta.revision}`,
      `imported_at: ${quote(new Date().toISOString().slice(0, 19))}`
    ];

    if (tags.length > 0) {
      lines.push("tags:");
      for (const tag of tags) {
        lines.push(`  - ${quote(tag)}`);
      }
    }

    lines.push("---");
    return lines;
  }

  postProcessContent(content) {
    const lines = content.split(/\r?\n/);
    const result = [];
    let lastBlank = false;

    for (const line of lines) {
      const clean = line.replace(/\s+$/g, "");
      const blank = clean.trim().length === 0;
      if (blank && lastBlank) {
        continue;
      }

      result.push(clean);
      lastBlank = blank;
    }

    return `${result.join("\n")}\n`;
  }

  renderTemplate(templateText, tokens) {
    let rendered = templateText;
    for (const [key, value] of Object.entries(tokens)) {
      rendered = rendered.split(`{{${key}}}`).join(value ?? "");
    }
    return rendered;
  }

  getFallbackChapterTemplate() {
    return [
      "{{FRONTMATTER}}",
      "",
      "{{CHAPTER_HEADING}}",
      "",
      "> [!summary] Meta",
      "> Node: {{NODE}}",
      "> Source: {{SOURCE_DOCUMENT}}",
      "",
      "## Beat",
      "- Goal:",
      "- Conflict:",
      "- Outcome:",
      "",
      "{{BODY}}",
      ""
    ].join("\n");
  }

  async createChapterFromTemplate(values) {
    try {
      const chapterNumberRaw = Number(values.chapterNumber);
      if (!Number.isFinite(chapterNumberRaw) || chapterNumberRaw <= 0) {
        throw new Error("Numero capitolo non valido.");
      }

      const chapterNumber = Math.floor(chapterNumberRaw);
      const chapterNumberPadded = String(chapterNumber).padStart(Number(this.settings.chapterNumberPadding || 2), "0");
      const rawTitle = (values.chapterTitle || "").trim() || "Untitled";
      const destinationFolder = this.normalizeVaultPath(values.destinationFolder || this.settings.newChapterDefaultFolder || this.settings.destDir || "Notes");
      const destinationPath = this.resolveFromVault(destinationFolder);
      fs.mkdirSync(destinationPath, { recursive: true });

      const shortTitle = this.toChapterShortTitle(rawTitle);
      const now = new Date();
      const revision = this.getNextRevisionNumber(
        destinationPath,
        this.settings.chapterLevel,
        this.settings.chapterModule,
        shortTitle,
        now,
        Number(this.settings.revisionNumber || 0)
      );

      const node = this.makeChapterNodeName(shortTitle, this.settings.chapterLevel, this.settings.chapterModule, now, revision);
      const fileName = `${node}.md`;
      const relativeFilePath = this.normalizeVaultPath(path.posix.join(destinationFolder, fileName));

      if (await this.app.vault.adapter.exists(relativeFilePath)) {
        throw new Error(`Il file esiste gia: ${relativeFilePath}`);
      }

      const chapterTitle = `Chapter ${chapterNumber}: ${rawTitle}`;
      const tags = this.parseTags(this.settings.frontmatterTags);
      const frontmatterLines = this.settings.includeFrontmatter
        ? this.buildFrontmatterLines(
            {
              title: chapterTitle,
              book: this.settings.bookTitle,
              sourceDocument: this.settings.sourceDocumentTitle,
              chapterNumber,
              chapterNumberPadded,
              shortTitle,
              node,
              level: this.settings.chapterLevel,
              module: this.settings.chapterModule,
              revision
            },
            tags
          )
        : [];

      const templateRelativePath = this.normalizeVaultPath(this.settings.chapterTemplatePath || "");
      let templateText = this.getFallbackChapterTemplate();
      if (this.settings.useChapterTemplate && templateRelativePath && (await this.app.vault.adapter.exists(templateRelativePath))) {
        const templateAbsPath = this.resolveFromVault(templateRelativePath);
        templateText = fs.readFileSync(templateAbsPath, "utf8");
      }

      const bodySkeleton = ["## Paragraph 01", "", "[Scrivi qui il contenuto del capitolo]", ""].join("\n");
      const rendered = this.renderTemplate(templateText, {
        FRONTMATTER: frontmatterLines.join("\n"),
        TITLE: chapterTitle,
        CHAPTER_HEADING: `# ${chapterTitle}`,
        CHAPTER_NUMBER: String(chapterNumber),
        CHAPTER_NUMBER_PADDED: chapterNumberPadded,
        RAW_TITLE: rawTitle,
        SHORT_TITLE: shortTitle,
        BOOK_TITLE: this.settings.bookTitle,
        SOURCE_DOCUMENT: this.settings.sourceDocumentTitle,
        NODE: node,
        LEVEL: this.settings.chapterLevel,
        MODULE: this.settings.chapterModule,
        REVISION: String(revision),
        BODY: bodySkeleton
      });

      const finalContent = this.settings.enablePostProcessing ? this.postProcessContent(rendered) : rendered;
      await this.app.vault.create(relativeFilePath, finalContent);

      const createdFile = this.app.vault.getAbstractFileByPath(relativeFilePath);
      if (createdFile) {
        await this.app.workspace.getLeaf(true).openFile(createdFile);
      }

      new Notice(`Capitolo creato: ${relativeFilePath}`, 8000);
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error);
      new Notice(`Errore creazione capitolo: ${message}`, 12000);
    }
  }

  resolvePandocCommand(configuredPandocCommand) {
    const configured = (configuredPandocCommand || "").trim();
    if (configured.length > 0) {
      if (configured.toLowerCase() !== "pandoc") {
        return configured;
      }

      const userLocalPandoc = path.join(process.env.LOCALAPPDATA || "", "Pandoc", "pandoc.exe");
      if (userLocalPandoc && fs.existsSync(userLocalPandoc)) {
        return userLocalPandoc;
      }

      return "pandoc";
    }

    const fallback = path.join(process.env.LOCALAPPDATA || "", "Pandoc", "pandoc.exe");
    if (fallback && fs.existsSync(fallback)) {
      return fallback;
    }

    return "pandoc";
  }

  async runSplitChapters(runOptions, silent = false) {
    if (this.isRunning) {
      if (!silent) {
        new Notice("Porting gia in esecuzione.");
      }
      return;
    }

    this.isRunning = true;

    try {
      const vaultBasePath = this.getVaultBasePath();
      const sourcePath = this.resolveFromVault(runOptions.sourceFile);
      const scriptPath = this.resolveFromVault(runOptions.scriptRelativePath || this.settings.scriptRelativePath);
      const outputPath = this.resolveFromVault(runOptions.destDir);

      if (!fs.existsSync(scriptPath)) {
        throw new Error(`Script non trovato: ${scriptPath}`);
      }
      if (!fs.existsSync(sourcePath)) {
        throw new Error(`Documento sorgente non trovato: ${sourcePath}`);
      }

      fs.mkdirSync(outputPath, { recursive: true });

      const chapterNumberPadding = Number(runOptions.chapterNumberPadding || 2);
      const paragraphNumberPadding = Number(runOptions.paragraphNumberPadding || 2);
      const revisionNumber = Number(runOptions.revisionNumber || 0);
      const sourceDocumentTitle = runOptions.sourceDocumentTitle || this.stripExtension(path.basename(sourcePath));
      const tags = this.parseTags(runOptions.frontmatterTags);
      const pandocCommand = this.resolvePandocCommand(runOptions.pandocCommand || this.settings.pandocCommand);
      const chapterTemplatePath = this.normalizeVaultPath(runOptions.chapterTemplatePath || this.settings.chapterTemplatePath || "");
      const resolvedChapterTemplatePath = chapterTemplatePath ? this.resolveFromVault(chapterTemplatePath) : "";

      const args = [
        "-NoProfile",
        "-ExecutionPolicy",
        "Bypass",
        "-File",
        scriptPath,
        "-SourceFile",
        sourcePath,
        "-DestDir",
        outputPath,
        "-BookTitle",
        runOptions.bookTitle,
        "-ChapterNumberPadding",
        String(chapterNumberPadding),
        "-ParagraphNumberPadding",
        String(paragraphNumberPadding),
        "-ChapterLevel",
        runOptions.chapterLevel,
        "-ChapterModule",
        runOptions.chapterModule,
        "-RevisionNumber",
        String(revisionNumber),
        "-SourceDocumentTitle",
        sourceDocumentTitle,
        "-IncludeFrontmatter",
        runOptions.includeFrontmatter ? "1" : "0",
        "-AutoConvertWord",
        runOptions.autoConvertWord ? "1" : "0",
        "-PandocCommand",
        pandocCommand,
        "-KeepConvertedMarkdown",
        runOptions.keepConvertedMarkdown ? "1" : "0",
        "-EnablePostProcessing",
        runOptions.enablePostProcessing ? "1" : "0",
        "-UseChapterTemplate",
        runOptions.useChapterTemplate ? "1" : "0"
      ];

      if (resolvedChapterTemplatePath) {
        args.push("-ChapterTemplatePath", resolvedChapterTemplatePath);
      }

      if (runOptions.convertedMarkdownDirectory && runOptions.convertedMarkdownDirectory.trim().length > 0) {
        args.push("-ConvertedMarkdownDirectory", runOptions.convertedMarkdownDirectory.trim());
      }

      if (runOptions.noIndex) {
        args.push("-NoIndex");
      }

      if (tags.length > 0) {
        args.push("-FrontmatterTags", ...tags);
      }

      if (!silent) {
        new Notice("Porting in esecuzione...");
      }

      const output = await this.execPwsh(args, vaultBasePath);

      if (!silent) {
        const generated = output
          .split(/\r?\n/)
          .map((line) => line.trim())
          .filter((line) => line.length > 0);

        const info = generated.length > 0 ? `File generati: ${generated.length}` : "Completato.";
        new Notice(`Porting completato. ${info}`, 8000);
      }

      if (this.settings.autoWatchEnabled && runOptions.__autoSourcePath) {
        this.settings.processedFiles[runOptions.__autoSourcePath] = new Date().toISOString();
        await this.saveSettings();
      }
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error);
      new Notice(`Errore porting: ${message}`, 12000);
    } finally {
      this.isRunning = false;
    }
  }

  execPwsh(args, cwd) {
    return new Promise((resolve, reject) => {
      execFile("pwsh", args, { cwd, windowsHide: true }, (error, stdout, stderr) => {
        if (error) {
          const stderrMessage = (stderr || "").trim();
          reject(new Error(stderrMessage || error.message));
          return;
        }

        if (stderr && stderr.trim().length > 0) {
          reject(new Error(stderr.trim()));
          return;
        }

        resolve(stdout || "");
      });
    });
  }

  startAutoWatcher() {
    this.stopAutoWatcher();

    const intervalMs = Math.max(15, Number(this.settings.autoWatchIntervalSeconds || 45)) * 1000;
    this.watcherHandle = window.setInterval(() => {
      this.runAutoWatcherCycle();
    }, intervalMs);

    this.runAutoWatcherCycle();
  }

  stopAutoWatcher() {
    if (this.watcherHandle) {
      window.clearInterval(this.watcherHandle);
      this.watcherHandle = null;
    }
  }

  async runAutoWatcherCycle() {
    if (!this.settings.autoWatchEnabled || this.isRunning) {
      return;
    }

    try {
      const folderPath = this.resolveFromVault(this.settings.autoWatchFolder);
      if (!fs.existsSync(folderPath)) {
        return;
      }

      const entries = fs.readdirSync(folderPath, { withFileTypes: true });
      const candidates = entries
        .filter((entry) => {
          if (!entry.isFile()) {
            return false;
          }

          const ext = path.extname(entry.name).toLowerCase();
          if (ext === ".md") {
            return true;
          }

          return ext === ".docx" && this.settings.autoConvertWord;
        })
        .map((entry) => path.join(folderPath, entry.name))
        .sort((a, b) => fs.statSync(a).mtimeMs - fs.statSync(b).mtimeMs);

      for (const absoluteSource of candidates) {
        const relativeSource = path.relative(this.getVaultBasePath(), absoluteSource).replace(/\\/g, "/");
        if (this.settings.processedFiles[relativeSource]) {
          continue;
        }

        const runOptions = {
          ...this.settings,
          sourceFile: relativeSource,
          sourceDocumentTitle: this.stripExtension(path.basename(relativeSource)),
          __autoSourcePath: relativeSource
        };

        await this.runSplitChapters(runOptions, true);
      }
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error);
      new Notice(`Auto-porting fermato: ${message}`, 12000);
    }
  }

  async loadSettings() {
    this.settings = Object.assign({}, DEFAULT_SETTINGS, await this.loadData());
  }

  async saveSettings() {
    await this.saveData(this.settings);
  }
};

class McoWordPortingSettingsTab extends PluginSettingTab {
  constructor(app, plugin) {
    super(app, plugin);
    this.plugin = plugin;
  }

  display() {
    const { containerEl } = this;
    containerEl.empty();

    containerEl.createEl("h2", { text: "MCO Word Porting" });

    new Setting(containerEl)
      .setName("Script path relativo al vault")
      .setDesc("Supporta path relativi oppure alias virtuali: scripts://..., assets://..., vault://...")
      .addText((text) =>
        text
          .setPlaceholder("scripts://split_chapters.ps1")
          .setValue(this.plugin.settings.scriptRelativePath)
          .onChange(async (value) => {
            this.plugin.settings.scriptRelativePath = value.trim();
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Documento sorgente default")
      .setDesc("Supporta path relativi oppure alias virtuali: assets://..., vault://...")
      .addText((text) =>
        text
          .setPlaceholder("assets://Shades of Silence - Fractured mosaic.md")
          .setValue(this.plugin.settings.sourceFile)
          .onChange(async (value) => {
            this.plugin.settings.sourceFile = value.trim();
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Titolo documento default")
      .addText((text) =>
        text
          .setValue(this.plugin.settings.sourceDocumentTitle)
          .onChange(async (value) => {
            this.plugin.settings.sourceDocumentTitle = value.trim();
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Directory output default")
      .setDesc("Output nel vault (es. Notes) oppure alias virtuale vault://Notes")
      .addText((text) =>
        text
          .setValue(this.plugin.settings.destDir)
          .onChange(async (value) => {
            this.plugin.settings.destDir = value.trim();
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Book title default")
      .addText((text) =>
        text
          .setValue(this.plugin.settings.bookTitle)
          .onChange(async (value) => {
            this.plugin.settings.bookTitle = value.trim();
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Tag frontmatter")
      .setDesc("Lista separata da virgole")
      .addText((text) =>
        text
          .setValue(this.plugin.settings.frontmatterTags)
          .onChange(async (value) => {
            this.plugin.settings.frontmatterTags = value;
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Auto-conversione Word (.docx)")
      .setDesc("Se attiva, lo script converte automaticamente .docx in markdown prima dello split")
      .addToggle((toggle) =>
        toggle
          .setValue(this.plugin.settings.autoConvertWord)
          .onChange(async (value) => {
            this.plugin.settings.autoConvertWord = value;
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Comando Pandoc")
      .setDesc("Nome comando o percorso completo dell'eseguibile pandoc")
      .addText((text) =>
        text
          .setValue(this.plugin.settings.pandocCommand)
          .onChange(async (value) => {
            this.plugin.settings.pandocCommand = value.trim() || "pandoc";
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Cartella markdown convertiti")
      .setDesc("Opzionale. Se vuota usa Notes/.converted")
      .addText((text) =>
        text
          .setValue(this.plugin.settings.convertedMarkdownDirectory)
          .onChange(async (value) => {
            this.plugin.settings.convertedMarkdownDirectory = value.trim();
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Mantieni markdown convertiti")
      .setDesc("Se disattivo, i markdown temporanei da .docx vengono eliminati a fine run")
      .addToggle((toggle) =>
        toggle
          .setValue(this.plugin.settings.keepConvertedMarkdown)
          .onChange(async (value) => {
            this.plugin.settings.keepConvertedMarkdown = value;
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Abilita post-processing")
      .setDesc("Pulisce automaticamente spazi finali e righe vuote duplicate nei capitoli generati")
      .addToggle((toggle) =>
        toggle
          .setValue(this.plugin.settings.enablePostProcessing)
          .onChange(async (value) => {
            this.plugin.settings.enablePostProcessing = value;
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Usa template capitolo")
      .setDesc("Applica un template con placeholder sia durante lo split sia nella creazione manuale di nuovi capitoli")
      .addToggle((toggle) =>
        toggle
          .setValue(this.plugin.settings.useChapterTemplate)
          .onChange(async (value) => {
            this.plugin.settings.useChapterTemplate = value;
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Template capitolo")
      .setDesc("Percorso file template relativo al vault")
      .addText((text) =>
        text
          .setValue(this.plugin.settings.chapterTemplatePath)
          .onChange(async (value) => {
            this.plugin.settings.chapterTemplatePath = value.trim();
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Cartella default nuovo capitolo")
      .setDesc("Usata dal comando 'Crea nuovo capitolo da template'")
      .addText((text) =>
        text
          .setValue(this.plugin.settings.newChapterDefaultFolder)
          .onChange(async (value) => {
            this.plugin.settings.newChapterDefaultFolder = value.trim();
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Includi frontmatter")
      .addToggle((toggle) =>
        toggle
          .setValue(this.plugin.settings.includeFrontmatter)
          .onChange(async (value) => {
            this.plugin.settings.includeFrontmatter = value;
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Non creare index")
      .addToggle((toggle) =>
        toggle
          .setValue(this.plugin.settings.noIndex)
          .onChange(async (value) => {
            this.plugin.settings.noIndex = value;
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Auto-run all'avvio")
      .setDesc("Lancia il porting del documento default quando si apre il vault")
      .addToggle((toggle) =>
        toggle
          .setValue(this.plugin.settings.autoRunOnStartup)
          .onChange(async (value) => {
            this.plugin.settings.autoRunOnStartup = value;
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Auto-porting da cartella")
      .setDesc("Monitora una cartella del vault e processa automaticamente nuovi .md")
      .addToggle((toggle) =>
        toggle
          .setValue(this.plugin.settings.autoWatchEnabled)
          .onChange(async (value) => {
            this.plugin.settings.autoWatchEnabled = value;
            if (value) {
              this.plugin.startAutoWatcher();
            } else {
              this.plugin.stopAutoWatcher();
            }
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Cartella auto-porting")
      .setDesc("Supporta path relativi oppure alias virtuali, es. assets:// o INBOX/02")
      .addText((text) =>
        text
          .setValue(this.plugin.settings.autoWatchFolder)
          .onChange(async (value) => {
            this.plugin.settings.autoWatchFolder = value.trim();
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Intervallo auto-porting (secondi)")
      .addText((text) =>
        text
          .setValue(String(this.plugin.settings.autoWatchIntervalSeconds))
          .onChange(async (value) => {
            const parsed = Number(value);
            if (!Number.isFinite(parsed)) {
              return;
            }
            this.plugin.settings.autoWatchIntervalSeconds = Math.max(15, Math.floor(parsed));
            if (this.plugin.settings.autoWatchEnabled) {
              this.plugin.startAutoWatcher();
            }
            await this.plugin.saveSettings();
          })
      );

    new Setting(containerEl)
      .setName("Esegui ora")
      .setDesc("Esegue subito con le impostazioni salvate")
      .addButton((button) =>
        button.setButtonText("Run").onClick(async () => {
          await this.plugin.runSplitChapters(this.plugin.settings);
        })
      );
  }
}
