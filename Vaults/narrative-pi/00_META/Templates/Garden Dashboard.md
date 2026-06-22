---
allow_preamble: true
front_matter_title: (string, default  *title\s*[:=])"
level: 1
---
# Garden Dashboard

## Track Your Seedlings (Raw Ideas)

This query looks for any note marked as a `seedling` and sorts them by
the date they were last modified, helping you see what needs attention.

```dataview
LIST FROM "" WHERE status = "seedling" 
SORT file.mtime DESC
```

### Track Your Sprouts (Developing Ideas)

As notes grow, this block will capture everything currently in the
mid-tier `sprout` stage.

```text
```dataview
LIST
FROM ""
WHERE status = "sprout"
SORT file.mtime DESC
```

## 3. Creating an Advanced Dashboard Table

```text
```dataview
TABLE file.mtime AS "Last Modified", tags AS "Topics"
FROM ""
WHERE status = "evergreen"
SORT file.mtime DESC

### How the Dashboard Looks in Live Preview / Reading Mode:

---

## Pro-Tip for Maintenance

If you don't want to type out the metadata manually every time, use the
core **Templates** plugin (or the **Templater** community plugin) to create
a "New Note Template" that automatically includes this structure:

```markdown
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

![[Notebook 1/#]]


---

![[#Clippings/"New notebook 3"#"The 3 Syntax Levels (A Quick Primer)"|New notebook 3]]

```markdown
```
[[Clippings/New notebook 3#Level 1 Command Tag (<%... %>)|New notebook 3]]
