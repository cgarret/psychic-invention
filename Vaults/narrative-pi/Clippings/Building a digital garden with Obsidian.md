---
title: "New notebook"
source: "https://gemini.google.com/app/8509c4dd3cc2cc74"
author:
published:
created: 2026-06-17
description: "Gemini conversation with 8 messages"
tags:
  - "clippings"
---
**You**

Building a digital garden with Obsidian

---

**Gemini**

Building a digital garden with Obsidian is a fantastic way to move away from rigid, linear note-taking and toward an interconnected ecosystem of thoughts. Unlike a traditional blog or folder-based system, a digital garden focuses on ideas that grow, change, and link together over time.

Because Obsidian uses local, raw Markdown files and robust internal linking, it is the perfect tool for cultivating this kind of personal knowledge base.

## 1\. The Core Philosophy of a Garden

Before touching any settings, it helps to understand how a digital garden operates compared to traditional notes:

- **Topography over Chronology:** In a blog, the newest post sits at the top. In a digital garden, notes are organized by topic and context through links, not by the date they were created.
- **Continuous Growth:** Notes are rarely "finished." They evolve from rough, quick captures into deeply polished concepts.
- **Public Learning:** If you choose to publish it, a digital garden is about sharing your *learning process* out loud, imperfect thoughts included, rather than just polished final products.

## 2\. Setting Up Your Obsidian Greenhouse

To keep your garden healthy and scannable without drowning in a thousand loose files, a minimal but effective structure is essential.

### The Note Maturity Framework

Many gardeners use a simple tagging or folder system based on the lifecycle of a plant to track how developed an idea is:

| Stage | What it Represents | How to Handle It |
| --- | --- | --- |
| 🌱 **Seedlings** | Fleeting thoughts, raw quotes, or quick daily log captures. | Kept messy, unformatted, just get the idea down. |
| 🌿 **Growing / Sprouts** | Notes you've returned to, added context to, and linked to at least one other note. | Starting to form clear headings; ideas are being synthesized. |
| 🌲 **Evergreen** | Mature, highly atomic notes focused on a single concept, heavily interconnected. | Concise, written in your own words, acting as reliable building blocks. |

### Essential Links: Map of Content (MOC)

Instead of relying strictly on deep folder trees, use **Maps of Content (MOCs)**. An MOC is simply a single hub note that contains a curated list of links to a specific topic (e.g., a `Fiction Writing MOC` or a `System Administration MOC`). This gives you a high-level entry point into your interconnected notes without forcing them into a single, restrictive folder.

## 3\. Recommended Plugins for Maintenance

While Obsidian is powerful right out of the box, a couple of community plugins can drastically improve your workflow when managing a massive network of text files:

- **Dataview:** This turns your vault into a queryable database. You can instantly generate automated lists of all your "Seedlings," track incomplete drafts, or build dynamic tables of specific content based on metadata inside your notes.
- **Auto Note Mover (Optional):** Automatically moves files into designated folders based on tags or properties, keeping your raw storage clean while you focus entirely on linking.

## 4\. Sharing Your Garden with the World

If your goal is to publish your notes online as a public digital garden, you have a few excellent paths depending on how much technical setup you enjoy:

### Option A: Obsidian Publish (The Frictionless Route)

The official paid service by the Obsidian team. It works natively with a single click inside the app. It handles graph views, hovering note previews, and internal links perfectly out of the box with zero configuration or technical overhead.

### Option B: Open-Source Static Site Generators (The Developer Route)

If you prefer complete control, data privacy, and zero monthly fees, you can use a static site generator paired with free hosting (like GitHub Pages, Vercel, or Netlify).

- **Quartz (Highly Recommended):** A free, open-source tool specifically designed to turn an Obsidian vault into a gorgeous, fast public digital garden. It supports Markdown syntax, internal links `[[Note]]`, graph views, and interactive search natively.
- **Digital Garden Plugin:** A community plugin that lets you publish selected notes directly to a GitHub repository using a template, completely bypassing complex command-line setups.

Want to look at a sample Dataview script to track your notes by maturity stage?

---

**You**

yes

---

**Gemini**

Here is how you can set up an automated tracking system using the **Dataview** plugin.

First, ensure you have the **Dataview** plugin installed and enabled via *Settings > Community plugins*.

## 1\. Setting Up Your Note Metadata (Properties)

For Dataview to track your notes, you need to add a standard property (frontmatter) to the top of your files. You can use YAML properties to denote the "status" or "stage" of the note.

For example, at the very top of a note, add this:

```
---
status: seedling
tags:
  - psychology
---
```

As the note matures, you simply update `status: seedling` to `status: sprout` or `status: evergreen`.

## 2\. The Dataview Queries

Create a new note called `🌱 Garden Dashboard` or `My Digital Garden Hub`. Paste the following code blocks into that note. Dataview will automatically scan your entire vault and generate dynamic lists.

### Track Your Seedlings (Raw Ideas)

This query looks for any note marked as a `seedling` and sorts them by the date they were last modified, helping you see what needs attention.

```
\`\`\`dataview
LIST
FROM ""
WHERE status = "seedling"
SORT file.mtime DESC
```

```
### Track Your Sprouts (Developing Ideas)
As notes grow, this block will capture everything currently in the mid-tier \`sprout\` stage.

\`\`\`text
\`\`\`dataview
LIST
FROM ""
WHERE status = "sprout"
SORT file.mtime DESC
```

```
---

## 3. Creating an Advanced Dashboard Table

If you prefer a clean, scannable spreadsheet look instead of a bulleted list, you can use a \`TABLE\` query. This will display the note, the date it was last modified, and any other tags you've attached to it.

\`\`\`text
\`\`\`dataview
TABLE file.mtime AS "Last Modified", tags AS "Topics"
FROM ""
WHERE status = "evergreen"
SORT file.mtime DESC
```

```
### How the Dashboard Looks in Live Preview / Reading Mode:

---

## Pro-Tip for Maintenance

If you don't want to type out the metadata manually every time, use the core **Templates** plugin (or the **Templater** community plugin) to create a "New Note Template" that automatically includes this structure:

\`\`\`markdown
---
status: seedling
created: {{date}} {{time}}
---

# 

Tags: 
Links: [[Garden MOC]]

---
## Context
(Your raw thoughts go here...)
```

Now, every time you plant a new seed, your dashboard will automatically update without you ever having to manually organize a single file link.

---

**You**

looking for an excellent tutorial about the Templater Obsidian plugin

---

**Gemini**

When moving beyond basic template variables into advanced automation, **Templater** is the ultimate power tool. While the standard internal plugin only replaces simple placeholders on command, Templater uses an active template language engine capable of running logic, manipulating file strings, and executing JavaScript.

Rather than pointing to a single generic article, the best masterclasses on this plugin come from two prominent Personal Knowledge Management (PKM) educators, followed by the definitive technical manual.

## The Best Tutorials to Watch & Read

### 1\. For Practical Use-Cases: Nicole van der Hoeven (YouTube)

- **Video Tutorial:** *Using the Obsidian Templater Plugin*
- **Why it’s excellent:** Nicole is famous in the PKM community for breaking down highly complex automation into human terms. She structures her tutorial across three progressive layers: single-line text expansions, automated meeting note pipelines, and writing your own custom user functions (essential for D&D/TTRPG setups or project management tracking). She covers exactly *how* to phase your templates so you don't get overwhelmed by code syntax early on.

### 2\. For System Creators: Dann Berg (YouTube & Blog)

- **Video Tutorial:** *How to Create a Template in Obsidian (Beginner's to Advanced)*
- **Why it’s excellent:** Dann approaches Obsidian from a system-designer perspective. His guide walks you through the exact transition from basic native templates to Templater's internal functions. Crucially, he demonstrates **Auto-Triggers** —how to configure Obsidian so that creating a file in a specific folder (like `/Log/Daily/`) instantly executes a complex Templater script without hitting a single hotkey.

### 3\. For Syntax & Logic Reference: The Official SilentVoid Documentation

- **Documentation Site:** `silentvoid13.github.io/Templater`
- **Why it’s excellent:** Once you understand the concepts from Nicole or Dann, keep this open in a tab. It provides a clean, copy-pasteable library of every internal command (`tp.file`, `tp.date`, `tp.web`).

## The 3 Syntax Levels (A Quick Primer)

To help you get your bearings when diving into these tutorials, Templater operates on three distinct syntax tags:

### Level 1: Command Tag (<%... %>)

Executes an internal Templater function. This is your bread and butter for grabbing dates, file titles, or prompt responses.

```
# Note: <% tp.file.title %>
Created on: <% tp.file.creation_date("YYYY-MM-DD HH:mm") %>
Yesterday's Note: [[<% tp.date.now("YYYY-MM-DD", -1) %>]]
```

### Level 2: Execution Tag (<%\*... %> — Notice the Asterisk)

This tells Templater to execute **pure JavaScript** logic behind the scenes *without* printing the code directly into your note text. This is what you use for conditional statements (`if/else`) or loops.

```
<%*
let title = tp.file.title;
if (title.startsWith("Task-")) {
    _output = "## 🛠️ Action Items";
} else {
    _output = "## 🌱 Raw Thoughts";
}
%>
```

### Level 3: Expression Tag (<%=... %> — Notice the Equals)

Evaluates a JavaScript expression and prints the result right where the tag sits.

## Essential Setup Best Practices

When you install the plugin, configure these options in the settings menu immediately to mimic a professional developer workflow:

1. **Template Folder Location:** Dedicate a specific folder (e.g., `⚙️ System/Templates/`) so Templater doesn't accidentally scan your standard notes for script code.
2. **Trigger Templater on New File Creation:** Toggle this **ON**. This enables the automation that allows templates to run silently the millisecond a blank note is generated.
3. **Folder Templates:** Use this settings section to map specific templates to specific folders. For instance, tie your `Sprout Template` directly to your `/Garden/Sprouts/` folder so your metadata properties generate automatically.

Want to build a daily note or garden file template using Templater right now?

---

**You**

yes

---

**Gemini**

Here is a production-ready, advanced template built specifically for the **Templater** plugin.

This script showcases dynamic file naming, natural language date calculations (yesterday, today, tomorrow), interactive prompt variables, and conditional structure based on the day of the week.

## The Master Template Script

Create a new note inside your designated templates folder (e.g., `⚙️ System/Templates/Daily Note Template`) and paste the exact code block below.

> ⚠️ **Important:** Make sure you paste this as **plain text** or in **Source Mode** so Obsidian doesn’t accidentally strip the code brackets.

```
<%*
// 1. SETUP LOGIC & VARIABLES
// Pull current file title (expects format: YYYY-MM-DD)
let fileDate = moment(tp.file.title, "YYYY-MM-DD");

// Fallback to today's date if the file title isn't a date string
if (!fileDate.isValid()) {
    fileDate = moment();
}

// Calculate relative dates for fluid linking
let todayStr      = fileDate.format("YYYY-MM-DD");
let yesterdayStr  = moment(fileDate).subtract(1, "days").format("YYYY-MM-DD");
let tomorrowStr   = moment(fileDate).add(1, "days").format("YYYY-MM-DD");
let dayOfWeek     = fileDate.format("dddd");

// 2. INTERACTIVE USER PROMPT
// Prompts you for a focal point when the note is generated
let dailyFocus = await tp.system.prompt("What is the primary focus for today?");
if (!dailyFocus) dailyFocus = "Cultivating ideas and execution.";
-%>
---
type: log/daily
status: processing
created: <% tp.file.creation_date("YYYY-MM-DD HH:mm") %>
focus: "<% dailyFocus %>"
tags:
  - log/daily
  - review/<% fileDate.format("YYYY/MM") %>
---

# 📅 <% fileDate.format("LL") %> (<% dayOfWeek %>)

← [[<% yesterdayStr %>|Yesterday]] | **[[<% todayStr %>|Today]]** | [[<% tomorrowStr %>|Tomorrow]] →

---

## 🎯 Primary Focus
> **Objective:** <% dailyFocus %>

---

## 🌿 The Garden: Active Growth
*Quick tracker for notes touched, created, or graduated today.*

\`\`\`dataview
LIST 
FROM ""
WHERE file.mtime >= date(<% todayStr %>) AND file.name != this.file.name
SORT file.mtime DESC
```

## 📝 Interstitial Log

*Timestamped entries tracking focus, actions, and friction points throughout the day.*

- **<% tp.date.now("HH:mm") %>** // Initialized log.

<%\* if (dayOfWeek === "Friday") { -%>

## 🪵 Weekly Retrospective & Pruning

*It's Friday. Take 10 minutes to review the garden dashboards, close out open tasks, and capture lingering seedlings.*

- \[ \] Review `/Garden/Seedlings` and assign core links.
- \[ \] Archive completed projects from the dashboard.
- \[ \] Clear down the digital inbox. <%\* } else { -%>

## 🧠 End of Day Processing

- \[ \] Migrate open items to tomorrow's focus.
- \[ \] Process raw inbox items. <%\* } -%>

```
---

## How It Works Behind the Scenes

*   **\`moment.js\` Integration:** Templater includes internal access to the \`moment\` JavaScript library. Instead of tracking the literal system time (which causes issues if you generate tomorrow's daily note tonight), this template inspects the **title of the file**. If you name a note \`2026-06-15\`, it accurately builds navigation links to \`2026-06-14\` and \`2026-06-16\` relative to that file.
*   **The Dash \`-%>\` Operator:** Notice the subtle \`-\` at the end of execution blocks like \`<%* ... -%>\`. This instructs Templater to consume the empty carriage return, preventing your rendered note from having giant blank gaps at the top where the code used to live.
*   **\`tp.system.prompt()\`:** The moment this file is initialized, a clean modal input field drops down at the top of your Obsidian screen asking for your daily focus. What you type is immediately written directly into both the YAML frontmatter properties and the core header.
*   **Embedded Dataview:** The template includes a built-in Dataview block that automatically scans your vault. The moment you open this daily note in reading mode, it will show you a clean, updated list of every single file you modified or created on that specific day.
*   **Conditional Injection:** The \`<%* if (dayOfWeek === "Friday") { ... } %>\` block evaluates the day of the week. If it's a Friday, it injects a specialized weekly cleanup checklist; on any other day, it inserts a simple end-of-day shutdown routine instead.

---

## To Automate Execution (Trigger on Folder)

To make this template execute flawlessly without manual intervention:

1. Go to **Settings > Templater**.
2. Scroll down to **Folder Templates**.
3. Set your daily note directory (e.g., \`Logs/Daily/\`) on the left.
4. Select your \`Daily Note Template\` on the right.
5. Click **Add**.

Now, whenever you use the Core Daily Notes button or create a blank file inside that folder, Templater will spin up the script, prompt you for your focus, and construct your dashboard instantly.
```