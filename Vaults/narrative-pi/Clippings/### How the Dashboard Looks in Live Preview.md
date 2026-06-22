---
title: "New notebook"
source: "https://gemini.google.com/app/8509c4dd3cc2cc74"
author:
published:
created: 2026-06-12
description: "Gemini conversation with 4 messages"
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