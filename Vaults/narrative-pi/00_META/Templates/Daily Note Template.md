<%*
// 1. SETUP LOGIC & VARIABLES
// Pull current file title (expects format:YYYY-MM-DD)
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

```dataview
LIST 
FROM ""
WHERE file.mtime >= date(<% todayStr %>) AND file.name != this.file.name
SORT file.mtime DESC
```