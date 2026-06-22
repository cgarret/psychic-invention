---
title: Idea of MOC Knowledge
---
{{FRONTMATTER}}
### Seedling state
```dataview
LIST
FROM ""
WHERE status = "seedling" and area = "knowledge"
SORT file.mtime DESC
```

### Track Your Sprouts (Developing Ideas) As notes grow, this block will capture everything currently in the mid-tier `sprout` stage. ```text 
```dataview 
LIST FROM "" WHERE status = "sprout"
SORT file.mtime DESC
```

--- 
## 3. Creating an Advanced Dashboard Table If you prefer a clean, scannable spreadsheet look instead of a bulleted list, you can use a `TABLE` query. This will display the note, the date it was last modified, and any other tags you've attached to it. ```text 
```dataview 
TABLE file.mtime AS "Last Modified", tags AS "Topics" FROM "" WHERE status = "evergreen" SORT file.mtime DESC
```
---
### How the Dashboard Looks in Live Preview / Reading Mode:
--- ## Pro-Tip for Maintenance If you don't want to type out the metadata manually every time, use the core **Templates** plugin (or the **Templater** community plugin) to create a "New Note Template" that automatically includes this structure: 
```markdown 
--- status: seedling created: {{date}} {{time}} 
--- # Tags: Links: [[Garden MOC]] 
--- ## Context (Your raw thoughts go here..)
```
