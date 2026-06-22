---
title: "New notebook"
source: "https://gemini.google.com/app/c0be7df9b97da059"
author:
published:
created: 2026-06-17
description: "Gemini conversation with 2 messages"
tags:
  - "clippings"
---
**You**

i need config examples of markdownlint.json

---

**Gemini**

Here are a few standard configuration examples for `markdownlint.json`, ranging from a simple, relaxed setup to a strict, production-ready config.

### 1\. The "Sensible Defaults" Config

This is a great starting point. It keeps most of the built-in rules but disables or tweaks the ones that usually cause the most frustration (like line length and list indentation).

```
{
  "default": true,
  "MD013": false,
  "MD007": {
    "indent": 4
  },
  "MD025": {
    "level": 1
  }
}
```

- **`"default": true`**: Enables all built-in rules by default.
- **`MD013` (Line length)**: Set to `false` because modern editors wrap text automatically, and forcing hard line breaks in Markdown can break rendering.
- **`MD007` (Unordered list indentation)**: Set to 4 spaces, which plays much nicer with nested code blocks inside lists.
- **`MD025` (Multiple top-level headings)**: Ensures you only have one `<h1>` (`# Heading`), but allows front matter title tags to exist without throwing an error.

### 2\. The Strict / Production Config

If you are managing public documentation (like a Docusaurus or MkDocs site) and want absolute consistency across multiple contributors, this is the way to go.

```
{
  "default": true,
  "MD003": { "style": "atx" },
  "MD004": { "style": "dash" },
  "MD013": {
    "line_length": 120,
    "code_blocks": false,
    "tables": false
  },
  "MD022": { "lines_above": 1, "lines_below": 1 },
  "MD033": {
    "allowed_elements": ["kbd", "br", "details", "summary"]
  },
  "MD041": { "level": 1 }
}
```

- **`MD003` / `MD004`**: Forces everyone to use standard `### Hash Headings` (atx) and dashes `-` for bullet points.
- **`MD013`**: Limits line lengths to 120 characters, but intelligently ignores long code blocks and markdown tables.
- **`MD033` (Inline HTML)**: By default, markdownlint hates inline HTML. This blocks most HTML but whitelists safe tags like `<kbd>` (for keyboard shortcuts) or `<details>` (for dropdowns).
- **`MD041`**: Forces the very first line of the file to be an `<h1>` heading.

### 3\. The "Bare Minimum" (Ultra-Relaxed) Config

If you just want markdownlint to stop nagging you about formatting styles and only care about functional errors (like broken link syntax or duplicate headings), use this:

```
{
  "default": true,
  "MD013": false,
  "MD004": false,
  "MD007": false,
  "MD012": false,
  "MD033": false
}
```

- This turns off rules regarding line length, bullet styles, list indentation, consecutive blank lines, and inline HTML entirely, leaving only the critical structure checks active.

### Pro-Tip: How to ignore a rule for a single file

If your `markdownlint.json` is strict but you need a one-off exception in a specific markdown file, you don't need to change the JSON. Just add this comment to the top of your `.md` file:

```
This super long line won't trigger an error now!
```