# Daily Note Template

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
    - g/daily
    - view/<% fileDate.format("YYYY/MM") %>

---

## <% fileDate.format("LL") %> (<% dayOfWeek %>)

← [[<% yesterdayStr %>|Yesterday]] | **[[<% todayStr %>|Today]]** |
[[<% tomorrowStr %>|Tomorrow]] →

---

## Primary Focus

> **Objective:** <% dailyFocus %>

---

## 🌿 The Garden: Active Growth

*Quick tracker for notes touched, created, or graduated today.*

```dataview
LIST 
FROM ""
WHERE file.mtime >= date(<% todayStr %>) AND file.name != this.file.name
SORT file.mtime DESC
```

- **<% tp.date.now("HH:mm") %>** // Initialized log

<%* if (dayOfWeek === "Friday") { -%>

<%* } else { -%>

<%* } -%>

## Interstitial Log

*Timestamped entries tracking focus, actions, and friction points throughout*
*the day.*

- **<% tp.date.now("HH:mm") %>** // Initialized log.

<%* if (dayOfWeek === "Friday") { -%>

## 🪵 Weekly Retrospective & Pruning

*It's Friday. Take 10 minutes to review the garden dashboards, close*
*out open tasks, and capture lingering seedlings.*

- [ ] Review `/Garden/Seedlings` and assign core links.

- [ ] Archive completed projects from the dashboard.

- [ ] Clear down the digital inbox. <%* } else { -%>

## 🧠 End of Day Processing

- [ ] Migrate open items to tomorrow's focus.

- [ ] Process raw inbox items. <%* } -%>

---

## How It Works Behind the Scenes

- **`moment.js` Integration:** Templater includes internal access to the
    `moment` JavaScript library. Instead of tracking the literal system time
    (which causes issues if you generate tomorrow's daily note tonight), this
    template inspects the **title of the file**. If you name a note
    `2026-06-15`, it accurately builds navigation links to `2026-06-14` and
    `2026-06-16` relative to that file.
- **The Dash `-%>` Operator:** Notice the subtle `-` at the end of execution
    blocks like `<%* ... -%>`. This instructs Templater to consume the empty
    carriage return, preventing your rendered note from having giant blank gaps
    at the top where the code used to live.
- **`tp.system.prompt()`:** The moment this file is initialized, a clean
    modal input field drops down at the top of your Obsidian screen asking for
    your daily focus. What you type is immediately written directly into both
    the YAML frontmatter properties and the core header.
- **Embedded Dataview:** The template includes a built-in Dataview block that
    automatically scans your vault. The moment you open this daily note in
    reading mode, it will show you a clean, updated list of every single file
    you modified or created on that specific day.
- **Conditional Injection:** The `<%* if (dayOfWeek === "Friday") { ... } %>`
    block evaluates the day of the week. If it's a Friday, it injects a
    specialized weekly cleanup checklist; on any other day, it inserts a
    simple end-of-day shutdown routine instead.

---

## To Automate Execution (Trigger on Folder)

To make this template execute flawlessly without manual intervention:

1. Go to **Settings > Templater**.
2. Scroll down to **Folder Templates**.
3. Set your daily note directory (e.g., `Logs/Daily/`) on the left.
4. Select your `Daily Note Template` on the right.
5. Click **Add**.

Now, whenever you use the Core Daily Notes button or create a blank file in
that folder, this template executes automatically.
