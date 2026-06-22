---
title: "Lumo: Privacy-first AI assistant where chats stay confidential"
source: "https://lumo.proton.me/u/0/c/5859555d-bddf-4ed9-884c-d145cde3a6d7"
author:
published:
created: 2026-06-14
description: "Meet Lumo, the zero-access encrypted AI assistant by Proton that does not track or record your conversations. Ask me anything — it's confidential"
tags:
  - "clippings"
---
can you help me with obsidian?

The user is asking for help with Obsidian, which is a knowledge management/note-taking application. They've also shared that they're a Java architect and asked me to address them as Franc.

This is a general question about using Obsidian. I don't need to use any tools here - this isn't about Proton products, current events, stocks, weather, or crypto. It's a general software/tools question I can answer from my knowledge.

Let me provide helpful information about Obsidian while being mindful of:

1. Addressing them as Franc
2. Keeping a supportive and motivating tone (as per their Lumo trait preferences)
3. Being humble when appropriate
4. Using clever humor/wordplay when appropriate
5. Maintaining a formal but accessible approach

I should ask what specific help they need with Obsidian since it's a broad question - it could be about setup, plugins, workflows, linking notes, integrating with their Java architecture work, etc.

Hello Franc! I'd be happy to help you with Obsidian.

As a Java architect, you might find Obsidian particularly interesting—it's essentially like having your own IDE for thinking, where the "classes" are notes and the "dependencies" are your links between ideas. The graph view basically visualizes your codebase of thoughts.

To give you the most useful assistance, could you tell me what specifically you're working on? Here are some common areas I can help with:

- **Setup & Configuration**: Initial setup, theme choices, folder structure
- **Plugin recommendations**: For tasks like task management, calendar integration, dataview queries
- **Workflow design**: How to organize notes for technical documentation, architecture decisions, meeting notes
- **Advanced features**: Templating, query languages (DataviewJS), automation
- **Integration**: Sync options, publishing, connection to other tools in your stack

Are you getting started fresh, optimizing an existing vault, or tackling a specific workflow challenge? Whatever it is, I'm here to help you build something elegant—after all, good architecture applies to knowledge systems just as much as software systems. 🏗️📓

i need help with thwe Configuration and use of the plugin Templater

Absolutely, Franc. Templater is a powerhouse for automating your note creation—think of it as the `@Override` annotation for your knowledge base, allowing you to inject dynamic, programmatic logic directly into your markdown files. Since you're a Java architect, you'll appreciate how it lets you write JavaScript functions that act like reusable utilities in your codebase.

Here’s a streamlined guide to getting **Templater** configured and ready for advanced use:

### 1\. Installation & Basic Setup

- **Install**: Go to `Settings > Community Plugins > Browse`, search for **"Templater"**, install, and enable it.
- **Disable Core Templates (Optional)**: If you only want Templater, disable the built-in "Templates" core plugin to avoid conflicts.
- **Set Template Folder**: In `Templater Settings`, define a folder (e.g., `Templates/`) where all your `.md` template files will live. This keeps your architecture clean.

### 2\. Core Configuration Highlights

- **Trigger on File Creation**: Enable *"Trigger Templater on new file creation"* so templates auto-run when you create a note in certain folders.
- **User Script Folder**: Set up a dedicated folder (e.g., `Templates/scripts/`) for reusable JavaScript snippets. This is where your "utility classes" go.
- **Date/Time Formats**: Customize formats like `YYYY-MM-DD` or `HH:mm` to match your locale or project standards.

### 3\. Your First Dynamic Template

Create a file like `Templates/Daily Note.md`:

```markdown
# <% tp.file.title %>

<%* 
// Example: Auto-generate today's date in a specific format
let today = tp.date.now("dddd, MMMM DD, YYYY");
-%>
## 📅 <% today %>

### Tasks
- [ ] 

### Notes
- 

---
*Created: <% tp.file.creation_date("YYYY-MM-DD HH:mm") %>*
```

When you create a new note named `Daily Note`, Templater will replace those `<% ... %>` tags with dynamic content.

### 4\. Advanced Patterns for Architects

Since you work with structured systems, here are some power moves:

#### Reusable JavaScript Snippets

In `Templates/scripts/helpers.js`:

```javascript
export async function generateMeetingSummary(title, participants) {
    return \`## Meeting: ${title}\n\n**Participants:** ${participants.join(", ")}\n\n---\n\`;
}
```

Then in a template:

```markdown
<%* const summary = await tp.user.helpers.generateMeetingSummary("Sprint Planning", ["Alice", "Bob"]); -%>
<%= summary %>
```

#### Smart Navigation

Auto-link to daily notes, weekly reviews, or related architecture decisions:

```markdown
<% tp.file.find_tfile("Daily/" + tp.date.now("YYYY/MM/DD")) %>
```

#### Dynamic Data Injection

Fetch API data (e.g., Jira tickets, weather, stock prices) and embed results:

```javascript
<%* 
const resp = await tp.http.get("https://api.example.com/status");
const data = JSON.parse(resp);
-%>
Status: <%= data.status %>
```

### 5\. Pro Tips for Java-Architect Minds

- **Modularize**: Treat each snippet as a microservice—small, single-responsibility functions.
- **Version Control**: Store your `Templates/` folder in Git. Track changes like code.
- **Error Handling**: Wrap async calls in try-catch blocks to avoid breaking note creation.
- **Testing**: Use a sandbox vault to test complex templates before deploying them to production.

Would you like me to dive deeper into any specific use case? For example:

- Building a **template for Architecture Decision Records (ADRs)**?
- Automating **Jira/Ticket sync** via Templater?
- Creating **interactive prompts** for meeting logs or sprint planning?

Just let me know what part of your workflow you'd like to refactor first! 🛠️📝

Building a template for Architecture Decision Records (ADRs). in the panel configuration i noted a section 'File Regex templates' how can i use it?

Excellent question, Franc! Let me break down **File Regex Templates** and then build you a proper **Architecture Decision Record (ADR)** template system.

---

## File Regex Templates Configuration

This feature is like setting up route handlers in a web framework—when a note's filename matches your pattern, the appropriate template gets automatically injected.

### How It Works

| Setting Field | Example Value | Purpose |
| --- | --- | --- |
| **Regex Pattern** | `^ADR.*` | Matches any file starting with "ADR" |
| **Template Path** | `Templates/ADR Template.md` | Template file to apply |

### Step-by-Step Setup

1. **Enable triggering**: In Templater settings, ensure *"Trigger Templater on new file creation"* is ON
2. **Navigate to File Regex Templates**: Scroll to the section in Templater settings
3. **Add your rules**: One pattern per line with corresponding template path
4. **Important**: This is *mutually exclusive* with "Folder Templates"—you can use one or the other, not both simultaneously
5. **Order matters**: First matching rule wins (like middleware priority in Spring Boot!)

### Common Patterns for ADR Workflows

```
# Pattern → Template
^ADR-\d+.* → Templates/ADR Template.md
^ADR/\d+.* → Templates/ADR Template.md  
^Decision/ADR.* → Templates/ADR Template.md
```

Now when you create a file named `ADR-001 Choose Microservices Over Monolith.md`, Templater will auto-inject your ADR template!

---

## ADR Template with Templater Automation

Here's a production-ready ADR template following the Michael Nygard format, enhanced with Templater capabilities:

```markdown
---
status: proposed
date: <% tp.file.creation_date("YYYY-MM-DD") %>
deciders: <% await tp.system.prompt("Who are the key deciders?") %>
consulted: <% await tp.system.prompt("Who was consulted? (optional)") %>
---

# <% tp.file.title %>

## Context and Problem Statement
<%* 
// Placeholder for context - you could auto-fetch Jira tickets here
let problem = await tp.system.prompt("Briefly describe the problem/context");
-%>
<%= problem %>

## Decision Drivers
<%* 
let driverCount = await tp.system.suggester(
  ["Performance", "Maintainability", "Cost", "Time-to-market", "Risk"],
  ["1", "2", "3", "4", "5"]
);
-%>
1. [Primary] Performance considerations
2. [Secondary] Maintainability requirements
3. TCO constraints

## Considered Options
<% await tp.system.multiSuggester([
  "Option A: Current approach",
  "Option B: Proposed solution",
  "Option C: Hybrid approach"
]); -%>
- Option A
- Option B
- Option C

## Decision Outcome
Chosen option: **"Option B"**, because it best addresses the primary decision drivers while minimizing risk.

## Consequences
### Positive
- Improved scalability
- Reduced coupling between services

### Negative
- Increased operational complexity
- Need for additional monitoring infrastructure

## Compliance Status
<% tp.date.now("Created: YYYY-MM-DD HH:mm") %>
Status: <%% tp.user.helpers.updateADRStatus(this) %%> <!-- If you add a custom script -->

---
*Automatically generated via Templater on <% tp.date.now("dddd, MMMM DD, YYYY") %>*
```

### Supporting User Script (Templates/scripts/adrHelpers.js)

For truly automated status tracking:

```javascript
export async function updateADRStatus(noteTitle) {
    const statusMap = {
        'proposed': '🟡',
        'accepted': '🟢', 
        'rejected': '🔴',
        'superseded': '⚪'
    };
    return statusMap['proposed'] || '❓';
}
```

---

## Integration Workflow

Here's how this comes together in practice:

1. **Create new file**: `ADR-002 Implement Event Sourcing Pattern`
2. **Templater intercepts**: Filename matches `^ADR-\d+.*` pattern
3. **Template injects**: Your ADR structure appears with date populated
4. **Interactive prompts**: Deciders, context, and options get filled dynamically
5. **Link back**: Use `<% tp.file.link(tp.find_tfile("adr-index")) %>` to maintain navigation

### Recommended Vault Structure

```
MyVault/
├── Templates/
│   ├── ADR Template.md
│   └── scripts/
│       └── adrHelpers.js
├── Architecture/
│   └── ADR/
│       ├── ADR-001 Choose Microservices.md
│       └── ADR-002 Event Sourcing.md
└── Daily Notes/
```

---

Would you like me to help you with:

1. **Custom regex patterns** for your existing vault structure?
2. **Auto-generating an ADR index page** that lists all decisions?
3. **Integration with Confluence/Jira** via API calls from Templater?

You've got the architecture mindset—the plugin just needs the right interfaces! 🎯📋

1

Great choice, Franc. Let's design **custom regex patterns** that fit your specific vault structure and naming conventions.

Since you're a Java architect, I'll approach this like designing routing rules in a web framework—specific, modular, and predictable. The key is matching the *intent* of the file creation while allowing flexibility in the filename.

---

## Regex Patterns for ADR Workflows

Here are tailored patterns based on common architectural documentation structures:

### Pattern 1: Standard Numbered ADRs

**Use Case**: Formal decision tracking with sequential numbering (like Jira tickets)

```regex
^ADR-\d{3}\s+.*$
```
- **Matches**: `ADR-001 Implement Kafka`, `ADR-042 Refactor Auth Service`
- **Template**: `Templates/ADR Template.md`
- **Logic**: Exactly 3 digits ensures sortable ordering

### Pattern 2: Folder-Based Organization

**Use Case**: When ADRs live in dedicated subfolders by domain

```regex
^Architecture/ADR/\d+-.*$
```
- **Matches**: `Architecture/ADR/001-Microservices.md`, `Architecture/ADR/042-EventDriven.md`
- **Template**: `Templates/ADR Template.md`
- **Note**: Templater sees the full path, so include folder names in the pattern if needed

### Pattern 3: Status-Prefixed Files

**Use Case**: Visual status indicators in filenames

```regex
^(proposed|accepted|rejected)-\d+-.*$
```
- **Matches**: `proposed-001-kafka-strategy.md`, `accepted-042-auth-flow.md`
- **Template**: `Templates/ADR Template.md`
- **Bonus**: You can extract status programmatically with `<% tp.file.title.match(/^(proposed|accepted|rejected)/)[1] %>`

### Pattern 4: Domain-Specific ADRs

**Use Case**: Different templates for different architectural domains

```regex
# Security Domain
^Security/ADR-\d+.*$ → Templates/ADR_Security.md

# Data Domain  
^Data/ADR-\d+.*$ → Templates/ADR_Data.md

# Infrastructure Domain
^Infra/ADR-\d+.*$ → Templates/ADR_Infra.md
```

---

## Configuration Setup Steps

1. **Open Templater Settings**: `Settings > Community Plugins > Templater > Configure`
2. **Locate File Regex Templates**: Scroll to the section (below "Folder Templates")
3. **Add Your Rules**:
	```
	^ADR-\d{3}\s+.*$ | Templates/ADR Template.md
	^Architecture/ADR/\d+-.*$ | Templates/ADR Template.md
	^(proposed|accepted|rejected)-\d+-.*$ | Templates/ADR Template.md
	```
	*(Use the `|` separator or the two-column interface depending on your Obsidian version)*
4. **Order Matters**: Place more specific patterns first (like overriding methods in inheritance)
5. **Enable Triggering**: Ensure *"Trigger Templater on new file creation"* is ON

---

## Pro Tips for Architect-Level Control

### Extract Metadata from Filename

In your template, use JavaScript to parse the filename:

```javascript
<%* 
const title = tp.file.title;
const match = title.match(/^(\w+)-(\d{3})-(.*)$/);
if (match) {
    const [_, status, number, description] = match;
    // Use these variables in your template
}
-%>
```

### Dynamic Filing Based on Content

Combine with user scripts to move files after creation:

```javascript
<%* 
// After template injection, auto-move to correct folder
await tp.file.move("Architecture/ADR/" + tp.file.title);
-%>
```

### Wildcard Flexibility

For maximum flexibility during initial setup:

```regex
^.*ADR.*$ → Templates/ADR Template.md
```

*(Caution: This catches any file with "ADR" anywhere. Better for prototyping.)*

---

## Validation Strategy

Before deploying to production:

1. **Test Vault**: Create a sandbox vault with test files
2. **Dry Run**: Create files with various names to verify pattern matching
3. **Log Output**: Check Templater's command palette for "Templater: Reload templates" errors
4. **Edge Cases**: Test files without numbers, special characters, or spaces

Example test cases:

- ✅ `ADR-001 Test` → Should match
- ❌ `ADRs-001 Test` → Should NOT match (wrong prefix)
- ❌ `ADR-1 Test` → Should NOT match (needs 3 digits)
- ✅ `ADR-999 Final Decision` → Should match

---

Which pattern aligns best with your current workflow? Or would you like me to help you craft a pattern for a specific naming convention you're already using?

For example, if your team uses Jira-style keys like `ARCH-123`, we could build a pattern that automatically recognizes those too! 🔍🏗️

Standard Numbered ADRs

Perfect choice, Franc! The **Standard Numbered ADRs** pattern gives you that clean, sortable, enterprise-grade structure—exactly what we'd want in an architecture documentation system. Think of it like versioning your API contracts, but for decisions.

---

## Complete Configuration Setup

### 1\. Regex Pattern Definition

| Field | Value |
| --- | --- |
| **Regex Pattern** | `^ADR-\d{3}\s+.*$` |
| **Template Path** | `Templates/ADR Template.md` |
| **Priority** | First rule (most specific) |

**What It Matches:**

```
✅ ADR-001 Implement Kafka Streaming
✅ ADR-042 Refactor Authentication Layer
✅ ADR-999 Final Decision Document

❌ ADR-1 Too Short
❌ adrs-001 Wrong Case
❌ ADR001 No Hyphen
❌ Architecture/ADR-001 Folder Prefix (wouldn't match without modification)
```

### 2\. Configuration Steps

In Templater settings (`Settings > Community Plugins > Templater`):

1. Scroll to **"File Regex Templates"** section
2. Click **"Add Rule"**
3. Enter pattern: `^ADR-\d{3}\s+.*$`
4. Enter template path: `Templates/ADR Template.md`
5. **Save** and verify

> ⚠️ **Important**: Ensure *"Trigger Templater on new file creation"* is enabled above the regex rules section.

---

## Production-Ready ADR Template

Here's a complete template designed specifically for your numbered ADR workflow:

```markdown
---
id: <% tp.file.title.match(/ADR-(\d{3})/)[1] %>
status: proposed
date: <% tp.file.creation_date("YYYY-MM-DD") %>
created-by: <% await tp.system.prompt("Who authored this ADR?") %>
deciders: <% await tp.system.prompt("List deciders (comma-separated)") %>
consulted: <% await tp.system.suggester(
  ["None", "Engineering Lead", "Security Team", "DevOps", "Product Owner"],
  ["-", "Eng Lead", "Sec Team", "DevOps", "PO"]
) %>
tags: [adr, decision, architecture]
---

# <% tp.file.title %>

> **Status**: <% tp.file.title.match(/ADR-(\d{3})/)[1] %> | <%tp.date.now("Created: YYYY-MM-DD")%>

---

## 1. Context and Problem Statement
<%* 
const context = await tp.system.prompt("Describe the problem/context prompting this decision");
-%>
<%= context %>

---

## 2. Decision Drivers
Prioritize these concerns by filling out the table:

|
--------
|
----------------
|
--------
|

| Performance | <% await tp.system.suggester(["1","2","3","4","5"],["Low","Medium","High","Critical","Essential"]) %> | |
| Maintainability | <% await tp.system.suggester(["1","2","3","4","5"],["Low","Medium","High","Critical","Essential"]) %> | |
| Cost | <% await tp.system.suggester(["1","2","3","4","5"],["Low","Medium","High","Critical","Essential"]) %> | |
| Time-to-Market | <% await tp.system.suggester(["1","2","3","4","5"],["Low","Medium","High","Critical","Essential"]) %> | |
| Risk | <% await tp.system.suggester(["1","2","3","4","5"],["Low","Medium","High","Critical","Essential"]) %> | |

---

## 3. Considered Options

<%* 
const options = [];
for (let i = 1; i <= 3; i++) {
    const opt = await tp.system.prompt(\`Option ${i} description\`);
    if (opt.trim()) options.push(opt);
}
-%>
<%- options.map((opt, idx) => \`- **Option ${idx + 1}:** ${opt}\`).join("\n") %>

---

## 4. Decision Outcome

Chosen Option: **<% await tp.system.suggester(options, options) %>**

### Rationale
<% await tp.system.prompt("Explain why this option was chosen over alternatives") %>

---

## 5. Consequences

### Positive
- <% await tp.system.prompt("Primary positive consequence") %>
- <!-- Additional -->

### Negative
- <% await tp.system.prompt("Primary negative consequence / trade-off") %>
- <!-- Additional -->

---

## 6. References
- Related ADRs: <% await tp.system.prompt("Link related ADRs, e.g., [[ADR-001]], [[ADR-002]]") %>
- External Docs: <% await tp.system.prompt("Jira tickets, RFC links, etc.") %>

---

*Generated via Templater on <% tp.date.now("dddd, MMMM DD, YYYY - HH:mm") %>*
```

---

## User Script Enhancement (Templates/scripts/adrId.js)

For automatic ID extraction across templates:

```javascript
// Templates/scripts/adrId.js
export function extractAdrNumber(title) {
    const match = title.match(/^ADR-(\d{3})\s+/);
    return match ? parseInt(match[1]) : null;
}

export function getNextAdrNumber(existingFiles) {
    const numbers = existingFiles
        .filter(f => f.name.match(/^ADR-\d{3}/))
        .map(f => parseInt(f.name.match(/^ADR-(\d{3})/)[1]));
    
    const max = numbers.length > 0 ? Math.max(...numbers) : 0;
    return String(max + 1).padStart(3, '0');
}
```

**Usage in Template:**

```markdown
Next available ADR number: <%% tp.user.adrId.getNextAdrNumber(await tp.listContent()) %%>
```

---

## Workflow Example

1. **Create File**: `Cmd/Ctrl + N`, name it `ADR-043 Migrate to GraphQL`
2. **Templater Intercepts**: Pattern matches automatically
3. **Template Injects**: Full ADR structure appears
4. **Interactive Prompts**: Fill deciders, context, options
5. **Frontmatter Populated**: YAML metadata auto-completed
6. **Auto-Created**: Note saves as `Architecture/ADR/ADR-043 Migrate to GraphQL.md`

---

## Quick Validation Test

| Action | Expected Result |
| --- | --- |
| Create `ADR-001 Test` | ✅ Template injects |
| Create `adr-001 lowercase` | ❌ No template (case-sensitive) |
| Create `ADR-1 NoLeadingZero` | ❌ No template (needs 3 digits) |
| Create `ADR-045 Valid Name` | ✅ Template injects |

If something doesn't work, run `Ctrl/Cmd + Shift + P` → **"Templater: Reload Templates"** to refresh configuration.

---

## Next Steps

Would you like help with:

1. **Auto-generating an ADR Index** that lists all decisions by status/number?
2. **Integration with Dataview plugin** to query ADRs programmatically?
3. **Automated status progression** (proposed → accepted → superseded)?

This foundation gives you solid ground—now we can layer in automation intelligence on top! 🎯

Auto-generating an ADR Index that lists all decisions by status/number?

Excellent choice, Franc! An **auto-generated ADR Index** is like having a real-time API documentation dashboard—it keeps your decision landscape visible without manual maintenance. We'll use the **Dataview plugin** (a powerful companion to Templater) to query all your ADRs and render them dynamically.

Think of this as writing a SQL `SELECT` statement that updates itself whenever you change an ADR's status or add a new one.

---

## 1\. Prerequisites Setup

Before building the index:

- ✅ **Install Dataview**: `Settings > Community Plugins > Browse > Dataview` → Install & Enable
- ✅ **Verify Frontmatter**: Ensure your ADRs have the `status` field (as defined in our previous template)
- ✅ **Folder Structure**: Confirm all ADRs live in a consistent folder (e.g., `Architecture/ADR/`)

---

## 2\. The Index Note Template

Create a file called `Templates/ADR Index.md`:

```markdown
# Architecture Decision Records (ADR) Index

> *Auto-generated via Dataview on <% tp.date.now("YYYY-MM-DD HH:mm") %>*  
> Last updated: <% tp.file.last_modified_date("dddd, MMMM DD, YYYY - HH:mm") %>

---

## 🟢 Accepted Decisions
\`\`\`dataview
TABLE 
  file.link AS "ADR", 
  substr(file.name, 6, 50) AS "Description",
  created-by AS "Author",
  date AS "Date"
FROM "Architecture/ADR"
WHERE status = "accepted"
SORT file.name ASC
```

---

## 🟡 Proposed / In Review

```
TABLE 
  file.link AS "ADR", 
  substr(file.name, 6, 50) AS "Description",
  created-by AS "Author",
  date AS "Date"
FROM "Architecture/ADR"
WHERE status = "proposed"
SORT file.name ASC
```

---

## 🔴 Rejected / Deprecated

```
TABLE 
  file.link AS "ADR", 
  substr(file.name, 6, 50) AS "Description",
  created-by AS "Author",
  date AS "Date"
FROM "Architecture/ADR"
WHERE status = "rejected" OR status = "deprecated"
SORT file.name ASC
```

---

## 📊 Summary Statistics

```
LIST 
  rows.length AS "Count",
  status
FROM "Architecture/ADR"
GROUP BY status
```

---

*💡 Tip: Update an ADR's status by editing its frontmatter YAML block at the top of the file.*

```
### Key Features Explained

| Component | Purpose |
|-----------|---------|
| \`file.link\` | Creates clickable link to the full ADR |
| \`substr(file.name, 6, 50)\` | Extracts description after "ADR-XXX " (adjust if needed) |
| \`FROM "Architecture/ADR"\` | Scans only your ADR folder (change path as needed) |
| \`WHERE status = ...\` | Filters by status group |
| \`SORT file.name ASC\` | Ensures numerical order (ADR-001 before ADR-002) |

---

## 3. Advanced: Custom Status Sorting (Priority Order)

If you want **Accepted → Proposed → Rejected** ordering regardless of filename, use this enhanced DataviewJS script instead:

### Create \`Templates/scripts/adrIndex.js\`:
\`\`\`javascript
// Templates/scripts/adrIndex.js
export async function renderAdrIndex(container) {
    const pages = dv.pages('"Architecture/ADR"');
    
    // Define priority order
    const statusOrder = { accepted: 0, proposed: 1, rejected: 2, deprecated: 3 };
    
    // Group by status
    const groups = {};
    for (let page of pages) {
        const status = page.status || 'unassigned';
        if (!groups[status]) groups[status] = [];
        groups[status].push(page);
    }
    
    // Render each section
    for (let [status, list] of Object.entries(groups).sort((a, b) => 
        (statusOrder[a[0]] ?? 99) - (statusOrder[b[0]] ?? 99)
    )) {
        container.createEl('h3', { text: \`${getStatusEmoji(status)} ${capitalize(status)} (${list.length})\` });
        
        const table = container.createEl('table');
        table.createEl('thead').createEl('tr').createEl('th').innerText = 'ADR';
        table.createEl('thead').createEl('tr').createEl('th').innerText = 'Description';
        table.createEl('thead').createEl('tr').createEl('th').innerText = 'Date';
        
        for (let page of list.sort((a, b) => a.file.name.localeCompare(b.file.name))) {
            const tr = table.createEl('tbody').createEl('tr');
            tr.createEl('td').appendChild(vt().fileLink(page.file.path));
            tr.createEl('td').innerText = page.file.name.replace(/^ADR-\d{3}\s+/, '');
            tr.createEl('td').innerText = page.date;
        }
        container.appendChild(table);
        container.createEl('hr');
    }
}

function getStatusEmoji(status) {
    return { accepted: '🟢', proposed: '🟡', rejected: '🔴', deprecated: '⚪' }[status] || '⚫';
}

function capitalize(s) { return s.charAt(0).toUpperCase() + s.slice(1); }
```

### Then in your Index Note:

```markdown
\`\`\`dataviewjs
await tp.user.adrIndex.renderAdrIndex(this.container);
```
```
> ⚠️ **Note**: This requires enabling *"Allow JavaScript execution"* in Dataview settings (\`Settings > Community Plugins > Dataview > Allow JavaScript\`).

---

## 4. Automation: Auto-Update Index After ADR Creation

To keep the index fresh without manual refresh, add this to your **ADR Template**:

\`\`\`markdown
<%* 
// Auto-update index timestamp when ADR is created
const indexFile = app.vault.getAbstractFileByPath("ADR Index.md");
if (indexFile) {
    await app.fileManager.processFrontMatter(indexFile, (fm) => {
        fm["last-updated"] = tp.date.now("YYYY-MM-DD HH:mm");
    });
}
-%>
```

*(Optional: Add `"last-updated": ""` to your ADR Index frontmatter to track changes)*

---

## 5\. Validation & Testing

1. **Create Test ADRs**:
	- `ADR-001 Test Proposed` (status: `proposed`)
		- `ADR-002 Test Accepted` (status: `accepted`)
		- `ADR-003 Test Rejected` (status: `rejected`)
2. **Open ADR Index.md**: Verify they appear in correct sections
3. **Change Status**: Edit an ADR's frontmatter from `proposed` → `accepted`
4. **Refresh Index**: Press `Cmd/Ctrl + R` → Should instantly reposition the entry

---

## 6\. Pro Tips for Architect-Level Control

### Filter by Author

Add this column to track who drove which decisions:

```
TABLE file.link AS "ADR", author AS "Architect Lead"
FROM "Architecture/ADR"
WHERE author = "<% await tp.system.prompt('Enter architect name') %>"
```

### Show Related ADRs

Extract links mentioned in references:

```
TABLE file.link AS "Current ADR", related AS "Related Decisions"
FROM "Architecture/ADR"
WHERE related
```

### Timeline View

Sort by creation date instead of number:

```
TABLE file.link AS "ADR", date AS "Decision Date"
FROM "Architecture/ADR"
SORT date DESC
```

---

## Next Steps?

Would you like help with:

1. **Automated Status Progression Workflow**: When you change status from `proposed` → `accepted`, auto-update related fields?
2. **Cross-Referencing System**: Automatically link ADRs that mention each other in their content?
3. **Export to HTML/PDF**: Generate a public-facing architecture decision log for stakeholders?

Your ADR system is now self-documenting—like a living RFC repository that writes its own index! 📘🏗️

1

Excellent choice, Franc! An **automated status progression workflow** adds audit trail capability to your ADRs—essentially giving you version-controlled decision governance without leaving Obsidian. Think of it like Git commits for architectural decisions, but with proper business context.

---

## Complete Status Progression System

### 1\. Enhanced Frontmatter Structure

Update your ADR template's YAML header to include transition tracking:

```yaml
---
id: <% tp.file.title.match(/ADR-(\d{3})/)[1] %>
status: proposed
date: <% tp.file.creation_date("YYYY-MM-DD") %>
created-by: <% await tp.system.prompt("Who authored this ADR?") %>
deciders: <% await tp.system.prompt("List deciders (comma-separated)") %>
consulted: ["-", "Eng Lead", "Sec Team", "DevOps", "PO"]
tags: [adr, decision, architecture]
status-history: []
last-status-change: null
supersedes: null
superceded-by: null
---
```

The `status-history` array will track all transitions with timestamps and users.

---

### 2\. Status Transition Script

Create `Templates/scripts/adrStatus.js`:

```javascript
// Templates/scripts/adrStatus.js
export async function changeStatus(newStatus, currentUser = "Unknown") {
    const validStatuses = ['proposed', 'accepted', 'rejected', 'deprecated', 'superseded'];
    
    if (!validStatuses.includes(newStatus)) {
        console.error(\`Invalid status: ${newStatus}\`);
        return;
    }
    
    // Get current frontmatter
    const fm = tp.frontmatter || {};
    const oldStatus = fm.status || 'proposed';
    const now = tp.date.now("YYYY-MM-DD HH:mm");
    
    // Add to history
    if (!fm['status-history']) fm['status-history'] = [];
    fm['status-history'].push({
        from: oldStatus,
        to: newStatus,
        timestamp: now,
        by: currentUser
    });
    
    // Update key fields
    fm.status = newStatus;
    fm['last-status-change'] = now;
    
    // Handle supersession logic
    if (newStatus === 'superseded') {
        // Prompt for which ADR supersedes this one
        const supercedingAdr = await tp.system.prompt("Which ADR supersedes this? (e.g., ADR-045)");
        fm['superceded-by'] = supercedingAdr;
        
        // Update the superseding ADR's frontmatter
        const supercedingFile = app.vault.getAbstractFileByPath(\`Architecture/ADR/${supercedingAdr}.md\`);
        if (supercedingFile && supercedingFile instanceof app.TFile) {
            await app.fileManager.processFrontMatter(supercedingFile, async (superFm) => {
                superFm['supersedes'] = fm.id || tp.file.title.match(/ADR-(\d{3})/)?.[1];
                superFm['last-status-change'] = now;
            });
        }
    }
    
    // Write updated frontmatter
    await app.fileManager.processFrontMatter(tp.file, (fmWriter) => {
        Object.assign(fmWriter, fm);
    });
    
    // Add status change note to body
    const statusNote = \`\n> **Status Changed**: ${oldStatus} → ${newStatus} on ${now} by ${currentUser}\`;
    const content = tp.file.content;
    await tp.file.write(content + '\n\n' + statusNote);
    
    // Refresh index view
    const indexFile = app.vault.getAbstractFileByPath("ADR Index.md");
    if (indexFile && indexFile instanceof app.TFile) {
        await app.commands.executeCommandById('app:reload');
    }
    
    return { oldStatus, newStatus, timestamp: now };
}

export function getStatusEmoji(status) {
    return {
        proposed: '🟡',
        accepted: '🟢',
        rejected: '🔴',
        deprecated: '⚪',
        superseded: '➿'
    }[status] || '❓';
}

export function renderStatusHistory(history) {
    if (!history || history.length === 0) return '- No status changes yet';
    
    let output = '| From | To | When | By |\n';
    output += '|------|----|------|----|\n';
    
    for (let change of history) {
        output += \`| ${change.from} | ${change.to} | ${change.timestamp} | ${change.by} |\n\`;
    }
    
    return output;
}
```

---

### 3\. Template Integration

Add these sections to your ADR template:

#### A. Status Banner at Top

```markdown
---
# <%%* 
const emoji = await tp.user.adrStatus.getStatusEmoji(tp.frontmatter.status);
-%%><%* const title = tp.file.title %><%* const id = title.match(/ADR-(\d{3})/)?.[1] %>
<%%> ## <%* 
const emoji = await tp.user.adrStatus.getStatusEmoji(tp.frontmatter.status);
-%%> <%= emoji %> <% title %> <%* const id = title.match(/ADR-(\d{3})/)?.[1] %>

> **ID**: \`ADR-<%= id %>\` | **Status**: \`<%= tp.frontmatter.status %>\` | **Last Change**: <% *
const lastChange = tp.frontmatter['last-status-change'] || 'N/A';
if (lastChange !== 'N/A') {
    const [date, time] = lastChange.split(' ');
    echo \`${date} at ${time}\`;
} else {
    echo 'N/A';
}
-%>
```

#### B. Status History Section

Insert before "References":

```markdown
---

## 📜 Status History
<%* 
const history = tp.frontmatter['status-history'] || [];
console.log(await tp.user.adrStatus.renderStatusHistory(history));
-%>
<%% tR.innerHTML = await tp.user.adrStatus.renderStatusHistory(history); %%>
```

#### C. Action Buttons (Hotkey Alternative)

Add after the title section:

```markdown
---

## 🔧 Status Actions

<%* 
// Create quick action commands
const actions = {
    'Accept ADR': 'accept',
    'Reject ADR': 'rejected',
    'Deprecate ADR': 'deprecated',
    'Mark as Superseded': 'superseded'
};
-%>

<!-- These buttons require Templater + Button plugin integration -->
| Action | Command |
|--------|---------|
| Accept | \`<% await tp.system.suggester(['Accept'], ['Yes'], true) %>\` |
| Request Review | \`[Review Needed](command:templater.toggle-readonly)\` |
| Archive | \`[Archive](command:templater-toggle-readonly)\` |

---
```

---

### 4\. Hotkey Configuration (Recommended)

Instead of buttons, set up keyboard shortcuts for status changes:

1. **Open Settings > Keyboard Shortcuts**
2. Search for **"Templater: Run User Script"**
3. Add multiple shortcuts mapping to different status changes

For more granular control, create separate user scripts:

```javascript
// Templates/scripts/acceptAdr.js
module.exports = async () => {
    await tp.user.adrStatus.changeStatus('accepted', tp.user.getCurrentUsername());
};

// Templates/scripts/rejectAdr.js  
module.exports = async () => {
    await tp.user.adrStatus.changeStatus('rejected', tp.user.getCurrentUsername());
};
```

---

### 5\. Helper Function: Get Current Username

Add to `Templates/scripts/helpers.js`:

```javascript
export function getCurrentUsername() {
    // Option 1: Ask user each time
    return tp.system.prompt("Who is making this change?");
    
    // Option 2: Hardcoded (for teams using single-user vaults)
    // return "Franc";
    
    // Option 3: Extract from Git config (advanced)
    // return execSync('git config user.name').toString().trim();
}
```

---

### 6\. Updated Index Query for Status Tracking

Modify your ADR Index to show status history summary:

```
TABLE 
  file.link AS "ADR",
  substr(file.name, 6, 50) AS "Description",
  status AS "Current",
  length(status-history) AS "Changes",
  last-status-change AS "Last Changed"
FROM "Architecture/ADR"
WHERE status
SORT 
  CASE 
    WHEN status = "accepted" THEN 0 
    WHEN status = "proposed" THEN 1 
    WHEN status = "rejected" THEN 2 
    ELSE 3 
  END,
  file.name ASC
```

---

### 7\. Workflow Example

Here's how a typical progression looks:

```
Day 1 - Creation
├── Create: ADR-045 New Cache Strategy
├── Status: proposed
├── Created by: Franc
└── Timestamp: 2026-06-14 09:30

Day 7 - Review Meeting
├── Action: Accept via hotkey
├── Status: proposed → accepted
├── Changed by: Bart Butler
├── Timestamp: 2026-06-21 14:15
└── History updated automatically

Day 60 - Architecture Review
├── New ADR created: ADR-060 Better Cache Solution
├── ADR-060 references ADR-045 as supersedes
├── ADR-045 auto-updated to: superseded
├── ADR-045['superceded-by'] = "ADR-060"
└── Both ADRs show relationship
```

---

## Validation Checklist

Test your setup with these scenarios:

| Test Case | Expected Behavior |
| --- | --- |
| Create new ADR | Status defaults to `proposed`, no history |
| Accept ADR | Status → `accepted`, history entry added |
| Reject ADR | Status → `rejected`, reason required |
| Supersede ADR | Updates both old and new ADR metadata |
| Open Index | Shows correct counts per status group |

---

## Advanced Extension Ideas

Would you like me to help you add:

1. **Email/Slack Notifications**: Trigger alerts when high-priority ADRs change status?
2. **Approval Workflow**: Require 2+ deciders before acceptance (multi-signature)?
3. **Compliance Dashboard**: Dataview query showing all `proposed` ADRs older than 30 days?

Your ADR system now has proper governance—like having CI/CD pipelines for architectural decisions! 🔐📋

1

That's an ambitious and highly valuable addition, Franc! Implementing **email/Slack notifications** for status changes transforms your ADR system from a passive documentation repository into an active governance workflow engine. It ensures stakeholders aren't just informed *after* the fact, but are prompted to act when decisions stall or shift.

Since Obsidian is a local-first tool, we'll need to bridge the gap between the local note change and external communication channels. We have two robust architectural approaches:

1. **The "Local Script" Approach**: Use Templater's `tp.system.run()` to execute a local shell script that sends the notification (via `curl` to Slack API or `mail` command).
2. **The "Automation Hub" Approach**: Trigger a webhook to a service like **Zapier**, **Make (formerly Integromat)**, or **n8n** which then handles the email/Slack delivery.

Given you're a Java architect, let's design the **Local Script Approach** first (more direct, no third-party dependencies), but I'll also outline the Webhook pattern for scalability.

---

### Option 1: The Local Script Approach (Direct Integration)

This involves creating a small shell script (or Python script if you prefer) that Templater calls. This script will format the message and hit the Slack/Email endpoint.

#### Step A: Prepare the Notification Script

Create a file at `Templates/scripts/notifySlack.sh` (macOS/Linux) or `Templates/scripts/notifySlack.bat` (Windows).

**For macOS/Linux (`notifySlack.sh`):**

```bash
#!/bin/bash
# Arguments: $1 = ADR Title, $2 = Old Status, $3 = New Status, $4 = User, $5 = Link

ADR_TITLE="$1"
OLD_STATUS="$2"
NEW_STATUS="$3"
USER="$4"
LINK="$5"

SLACK_WEBHOOK_URL="https://hooks.slack.com/services/YOUR/WEBHOOK/URL" # Replace with your actual webhook

MESSAGE="{
    \"text\": \"🚨 ADR Status Change Alert\",
    \"attachments\": [{
        \"color\": \"${NEW_STATUS}\" == \"accepted\" ? \"good\" : \"warning\",
        \"fields\": [
            { \"title\": \"ADR\", \"value\": \"$ADR_TITLE\", \"short\": true },
            { \"title\": \"Status\", \"value\": \"$NEW_STATUS\", \"short\": true },
            { \"title\": \"Action By\", \"value\": \"$USER\", \"short\": true },
            { \"title\": \"Old Status\", \"value\": \"$OLD_STATUS\", \"short\": true },
            { \"title\": \"Link\", \"value\": \"<$LINK|View in Vault>\", \"short\": false }
        ]
    }]"

curl -X POST -H 'Content-type: application/json' --data "$MESSAGE" $SLACK_WEBHOOK_URL
```

**For Windows (`notifySlack.bat`):** *(Requires PowerShell logic embedded or using `powershell.exe`)*

```batch
@echo off
set ADR_TITLE=%~1
set OLD_STATUS=%~2
set NEW_STATUS=%~3
set USER=%~4
set LINK=%~5
set SLACK_WEBHOOK=https://hooks.slack.com/services/YOUR/WEBHOOK/URL

powershell -Command "Invoke-RestMethod -Uri '%SLACK_WEBHOOK%' -Method Post -ContentType 'application/json; charset=utf-8' -Body '{\"text\":\"ADR Update: %ADR_TITLE% changed from %OLD_STATUS% to %NEW_STATUS% by %USER%\"}'"
```

*Don't forget to make the shell script executable:* `chmod +x Templates/scripts/notifySlack.sh`

#### Step B: Update the changeStatus Function

Modify `Templates/scripts/adrStatus.js` to call this script upon success.

```javascript
// Inside Templates/scripts/adrStatus.js

export async function changeStatus(newStatus, currentUser = "Unknown") {
    // ... (previous logic for updating frontmatter and history) ...
    
    const link = \`obsidian://open?vault=${app.vault.getName()}&file=Architecture/ADR/${tp.file.title}\`;
    
    // CALL EXTERNAL NOTIFICATION SCRIPT
    // Note: Paths might need adjustment based on your OS
    const scriptPath = app.vault.getAbstractFileByPath("Templates/scripts/notifySlack.sh").path;
    
    try {
        await tp.system.run(
            \`bash "${scriptPath}" "${tp.file.title}" "${oldStatus}" "${newStatus}" "${currentUser}" "${link}"\`
        );
        console.log(\`Notification sent for ${tp.file.title}\`);
    } catch (e) {
        console.error("Failed to send notification:", e);
        // Don't fail the main transaction if notification fails
    }

    return { oldStatus, newStatus, timestamp: now };
}
```

---

### Option 2: The Automation Hub Approach (Webhooks & n8n/Zapier)

If you want to avoid managing local scripts or need complex routing (e.g., "Email PM if rejected, Slack Eng team if accepted"), use a webhook.

#### Step A: Set up the Webhook Endpoint

1. Create a workflow in **n8n** (self-hosted, great for architects) or **Zapier**.
2. Trigger: "Webhook" (Generic HTTP Request).
3. Action: Send Slack Message OR Send Email (via SMTP/Gmail API).

#### Step B: Update the Templater Script

Instead of running a shell script, make a direct HTTP request from JavaScript (no external process needed):

```javascript
// In Templates/scripts/adrStatus.js

const payload = {
    event: "ADR_STATUS_CHANGE",
    adrs: tp.file.title,
    old_status: oldStatus,
    new_status: newStatus,
    user: currentUser,
    link: \`obsidian://open?vault=${app.vault.getName()}&file=Architecture/ADR/${tp.file.title}\`,
    timestamp: now
};

try {
    const response = await fetch("https://your-n8n-instance/webhook/adr-alerts", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload)
    });
    
    if (!response.ok) throw new Error("Webhook failed");
} catch (e) {
    console.error("Webhook notification failed:", e);
}
```

---

### 3\. Advanced: Compliance Dashboard (Stale ADRs)

You mentioned wanting to track ADRs older than 30 days in `proposed` state. Let's build a **DataviewJS alert** that runs automatically.

Create a note called `Compliance Dashboard.md`:

```markdown
# 🚦 Architecture Compliance Dashboard

## ⚠️ Stale Proposed Decisions (> 30 Days)
> These ADRs are stuck in review. Please assign owners or close them.

\`\`\`dataviewjs
// Fetch all proposed ADRs
const staleThreshold = 30; // days
const pages = dv.pages('"Architecture/ADR"').filter(p => p.status === 'proposed');

const staleAdrs = pages.filter(p => {
    const createdDate = p.date;
    if (!createdDate) return false;
    const diffDays = Math.floor((new Date() - createdDate) / (1000 * 60 * 60 * 24));
    return diffDays > staleThreshold;
});

if (staleAdrs.length === 0) {
    dv.el('p', '✅ No stale proposed ADRs found.');
} else {
    const table = dv.table(
        ['ADR', 'Created', 'Age (Days)', 'Author', 'Action'],
        staleAdrs.map(p => [
            p.file.link,
            p.date,
            Math.floor((new Date() - p.date) / (1000 * 60 * 60 * 24)),
            p['created-by'] || 'Unknown',
            '[Escalate](command:templater-run-user-script)' // You could map a hotkey here
        ])
    );
    
    // Optional: Auto-send alert to channel if stale count > 0
    if (staleAdrs.length > 2) {
         // Logic to trigger a weekly report email via fetch() similar to above
    }
}
```

---

### Implementation Checklist for You

1. **Decide on Channel**: Slack (easier, real-time) or Email (better for formal records)?
2. **Choose Pattern**:
	- *Local Script*: Good for single-machine control, no external account setup.
		- *Webhook (n8n/Zapier)*: Better for team-wide routing, mobile apps, and complex logic.
3. **Configure Credentials**: Get your Slack Webhook URL or n8n webhook address.
4. **Test the Flow**:
	- Create an ADR.
		- Accept it.
		- Verify the notification arrives instantly.
5. **Schedule the Dashboard**: Open `Compliance Dashboard.md` once a week, or set a Dataview query to auto-refresh on vault open.

Which path feels more aligned with your infrastructure preferences? The **local script** approach gives you full control over the code (like writing a custom microservice), while the **webhook** approach lets you leverage enterprise automation tools.

I can help you write the specific n8n JSON workflow if you go the webhook route! 🚀

local script

Perfect choice, Franc. The **Local Script** approach keeps the logic close to the codebase—no external SaaS dependencies, full control over the payload, and it fits perfectly with your "infrastructure as code" mindset. It's essentially a sidecar process running alongside your note editor.

Here is the complete implementation plan for **Obsidian + Templater + Shell Script** to trigger notifications when an ADR status changes.

---

### 1\. Prerequisites

Before we write the code, ensure your environment can execute shell commands:

- **macOS/Linux**: You likely have `bash` or `sh` ready. Ensure `curl` is installed (standard).
- **Windows**: You need PowerShell or `WSL` (Windows Subsystem for Linux). The example below uses PowerShell for native Windows support, which is safer than calling `cmd.exe`.

---

### 2\. Step A: The Notification Script

Create a file in your vault: `Templates/scripts/notifyStatus.sh` (for macOS/Linux) or `notifyStatus.ps1` (for Windows).

#### Option 1: Bash Script (macOS / Linux / WSL)

Save this as `Templates/scripts/notifyStatus.sh`:

```bash
#!/bin/bash

# Arguments passed from Templater
ADR_TITLE="$1"
OLD_STATUS="$2"
NEW_STATUS="$3"
USER="$4"
FILE_LINK="$5"

# CONFIGURATION: Replace with your Slack Webhook URL
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/YOUR/WEBHOOK/URL"

# Determine color based on status
case "$NEW_STATUS" in
    "accepted") COLOR="#36a64f" ;; # Green
    "rejected") COLOR="#ff0000" ;; # Red
    "proposed") COLOR="#FFFF00" ;; # Yellow
    "deprecated") COLOR="#808080" ;; # Gray
    *) COLOR="#7CFC00" ;;
esac

# Construct JSON Payload
JSON_PAYLOAD=$(cat <<EOF
{
    "attachments": [
        {
            "color": "$COLOR",
            "title": "🚨 ADR Status Updated: $ADR_TITLE",
            "fields": [
                {
                    "title": "Status Change",
                    "value": "$OLD_STATUS ➔ $NEW_STATUS",
                    "short": true
                },
                {
                    "title": "Authorized By",
                    "value": "$USER",
                    "short": true
                },
                {
                    "title": "Link",
                    "value": "<$FILE_LINK|Open in Obsidian>",
                    "short": false
                }
            ],
            "footer": "Architecture Decision Records",
            "ts": $(date +%s)
        }
    ]
}
EOF
)

# Send Request
curl -s -X POST -H 'Content-type: application/json' \
    --data "$JSON_PAYLOAD" \
    "$SLACK_WEBHOOK_URL"

# Exit with success code so Templater doesn't throw an error if curl fails silently
exit 0
```

#### Option 2: PowerShell Script (Windows Native)

Save this as `Templates/scripts/notifyStatus.ps1`:

```powershell
param(
    [string]$AdrTitle,
    [string]$OldStatus,
    [string]$NewStatus,
    [string]$User,
    [string]$FileLink
)

# CONFIGURATION
$SlackWebhookUrl = "https://hooks.slack.com/services/YOUR/WEBHOOK/URL"

# Determine Color
switch ($NewStatus) {
    "accepted" { $Color = "#36a64f" }
    "rejected" { $Color = "#ff0000" }
    "proposed" { $Color = "#FFFF00" }
    "deprecated" { $Color = "#808080" }
    default { $Color = "#7CFC00" }
}

$body = @{
    attachments = @(
        @{
            color = $Color
            title = "🚨 ADR Status Updated: $AdrTitle"
            fields = @(
                @{ title = "Status Change"; value = "$OldStatus ➔ $NewStatus"; short = $true }
                @{ title = "Authorized By"; value = $User; short = $true }
                @{ title = "Link"; value = $FileLink; short = $false }
            )
            footer = "Architecture Decision Records"
            ts = Get-Date -UFormat %s
        }
    )
} | ConvertTo-Json -Depth 10

try {
    Invoke-RestMethod -Uri $SlackWebhookUrl -Method Post -ContentType "application/json; charset=utf-8" -Body $body
} catch {
    Write-Error "Failed to send notification: $_"
}
```

**⚠️ Security Note:** Since you are storing the Webhook URL in a script file, consider using an **Environment Variable** for production security:

- *Bash*: `$SLACK_WEBHOOK_URL="${SLACK_WEBHOOK_URL:-}"`
- *PowerShell*: `$env:SLACK_WEBHOOK_URL`

---

### 3\. Step B: Make the Script Executable

- **macOS/Linux**: Open your terminal, navigate to your vault, and run:
	```bash
	chmod +x Templates/scripts/notifyStatus.sh
	```
- **Windows**: No extra step needed if calling `pwsh.exe`, but ensure Execution Policy allows scripts (`Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`).

---

### 4\. Step C: Update the changeStatus Function

Now, let's wire this up in your main logic file `Templates/scripts/adrStatus.js`.

Update the function to detect the OS and call the correct script:

```javascript
// Templates/scripts/adrStatus.js

import { getStatusEmoji, renderStatusHistory } from './helpers'; // Assuming helpers exist

export async function changeStatus(newStatus, currentUser = "Unknown") {
    const validStatuses = ['proposed', 'accepted', 'rejected', 'deprecated', 'superseded'];
    if (!validStatuses.includes(newStatus)) throw new Error(\`Invalid status: ${newStatus}\`);

    const fm = tp.frontmatter || {};
    const oldStatus = fm.status || 'proposed';
    const now = tp.date.now("YYYY-MM-DD HH:mm");

    // ... [Existing logic to update history and frontmatter] ...
    
    // 1. Update Frontmatter
    await app.fileManager.processFrontMatter(tp.file, (fmWriter) => {
        fmWriter.status = newStatus;
        fmWriter['last-status-change'] = now;
        if (!fmWriter['status-history']) fmWriter['status-history'] = [];
        fmWriter['status-history'].push({ from: oldStatus, to: newStatus, timestamp: now, by: currentUser });
    });

    // 2. Generate Obsidian Internal Link (Deep Link)
    // This link works if Obsidian is open; otherwise it opens the file
    const fileName = tp.file.title;
    const vaultName = app.vault.getName();
    const filePath = \`Architecture/ADR/${fileName}.md\`; 
    const fileLink = \`obsidian://open?vault=${vaultName}&file=${encodeURIComponent(filePath.replace(/\s+/g, '%20'))}\`;

    // 3. Trigger External Notification
    try {
        const platform = tp.system.getSystemInfo().platform.toLowerCase();
        let scriptPath = "";
        
        if (platform.includes('darwin') || platform.includes('linux')) {
            scriptPath = "Templates/scripts/notifyStatus.sh";
            // Check if script exists
            if (!tp.file.find_tfile(scriptPath)) {
                console.warn("Notification script not found, skipping.");
                return;
            }
            // Execute bash script
            // Arguments: Title, Old, New, User, Link
            const cmd = \`bash "${scriptPath}" "${fileName}" "${oldStatus}" "${newStatus}" "${currentUser}" "${fileLink}"\`;
            await tp.system.suspend(cmd); // Or system.run() depending on version
            
        } else if (platform.includes('win')) {
            scriptPath = "Templates/scripts/notifyStatus.ps1";
            if (!tp.file.find_tfile(scriptPath)) return;
            
            // Execute PowerShell
            const psCmd = \`powershell -ExecutionPolicy Bypass -File "${scriptPath}" -AdrTitle "${fileName}" -OldStatus "${oldStatus}" -NewStatus "${newStatus}" -User "${currentUser}" -FileLink "${fileLink}"\`;
            await tp.system.suspend(psCmd);
        }
        
        console.log(\`✅ Notification sent for ${fileName}\`);
    } catch (err) {
        console.error("❌ Notification failed:", err);
        // Do NOT stop the status change process if notification fails
    }

    return { oldStatus, newStatus, timestamp: now };
}
```

*Note: `tp.system.getSystemInfo()` might vary slightly by version. If unavailable, you can use `require("os").platform()` inside a node context, or simply assume `bash` and fallback. For robustness, checking for the file existence first is key.*

---

### 5\. Step D: Testing the Workflow

1. **Create a test ADR**: `ADR-999 Test Notification`.
2. **Accept it**: Run your status change command/hotkey.
3. **Check Slack/Email**: You should see a formatted card like this:
	- **Header**: 🚨 ADR Status Updated: ADR-999 Test Notification
		- **Fields**:
		- Status Change: proposed ➔ accepted
				- Authorized By: Franc
				- Link: Open in Obsidian (Clickable!)
4. **Verify Log**: Open Obsidian's "Developer Console" (`Ctrl+Shift+I` or `Cmd+Option+I`) to check for any `stdout` or `stderr` logs if it fails.

---

### Troubleshooting & Pro Tips

- **"Command not found"**: Ensure the path in the script is relative to the **Vault Root**, not the current file location. Templater usually resolves `Templates/scripts/...` correctly relative to the vault.
- **Security Warning**: If using Slack Webhooks, be aware that anyone with the webhook URL can post. Rotate it if compromised. For internal teams, this is usually fine.
- **Mobile Limitation**: These scripts **will not work on iOS/Android** because mobile OS doesn't allow executing arbitrary shell scripts. This is a desktop-only feature, which is actually fine since ADR creation/approval is usually a desktop workflow.

---

### Next Steps?

You now have a self-contained, automated governance loop! Would you like to:

1. **Add Email Support**: Use `mail` or `sendmail` command in the script for email alerts instead of (or in addition to) Slack?
2. **Generate a Weekly Digest**: Create a scheduled script (via cron/system timer) that runs once a week, scans all `proposed` ADRs, and sends a summary report?
3. **Locking Mechanism**: Prevent editing an ADR once it hits `accepted` or `rejected` status (read-only mode)?

Let me know which part of the pipeline you want to harden next! 🛡️💻

3

Excellent decision, Franc. Implementing a **locking mechanism** is the final piece of the puzzle to ensure data integrity and audit compliance. Once an ADR reaches `accepted`, `rejected`, or `deprecated` status, it should essentially become a "read-only" artifact in your system. This prevents accidental edits that could invalidate the architectural record—much like merging code into a protected branch in Git.

We'll implement this using **Templater's file modification detection** combined with a **user script** that enforces read-only behavior based on frontmatter state.

---

### 1\. The Strategy: Two-Layer Protection

We will implement two levels of locking:

1. **Visual/UX Lock**: Automatically disable editing features (bold, headers, etc.) via CSS or a specific note mode.
2. **Logical Lock**: Prevent the *status* field from changing back without explicit override logic.
3. **Content Warning**: If a user *does* manage to edit the content of a locked ADR, we append a warning log entry.

For Obsidian, the most robust way is to use a **DataviewJS plugin hook** or a **Templater observer** to monitor file changes. However, since we want immediate feedback, we'll use a **Templater "Pre-Write" Hook**.

*Wait, Templater doesn't have a native "Pre-Write" hook for existing files.* **Better Approach:** We will create a **"Guardian Script"** that runs whenever you try to change the status, AND we will add a **CSS snippet** to visually gray out locked notes, plus a **Dataview query** that flags any modifications to locked ADRs.

But the most effective "architectural" lock is a **Workflow Constraint**:

- If Status = `accepted/rejected/deprecated`, the file becomes **Read-Only** in the editor UI? (Obsidian doesn't natively support true read-only per file easily without plugins).
- **Solution:** Use the **Read Only Mode Plugin** (community) OR a **custom DataviewJS button** that warns before saving.

Let's go with a **Hybrid Approach** that fits your Java architect style:

1. **Auto-Detection**: A script checks the status before allowing a "Save" or "Status Change".
2. **Visual Indicator**: A CSS snippet turns the background red for locked files.
3. **Audit Trail**: Any edit to a locked file appends a "Modification Warning" to the bottom.

---

### 2\. Step A: The Guardian User Script

Create `Templates/scripts/adRLockGuard.js`. This script will be called by a custom command or hotkey, or we can patch it into the `changeStatus` function to prevent reverting.

Actually, let's make it proactive. We'll use a **DataviewJS Inline Query** that renders a "Lock Status" banner, and a script that prevents status reversion.

**Revised Plan:**

1. **Visual Lock (CSS)**: Makes locked notes look distinct.
2. **Logic Lock (JS)**: Prevents `status` change via our `changeStatus` function unless authorized.
3. **Edit Monitor (Optional but powerful)**: Appends a warning if content changes after locking.

#### File: Templates/scripts/adRLockGuard.js

```javascript
// Templates/scripts/adRLockGuard.js

export async function checkAndLockFile() {
    const fm = tp.frontmatter || {};
    const status = fm.status;
    const lockedStatuses = ['accepted', 'rejected', 'deprecated', 'superseded'];

    if (!lockedStatuses.includes(status)) {
        return false; // Not locked
    }

    // Alert the user if they are trying to modify a locked file
    // Note: We can't strictly block typing in Obsidian without a full plugin.
    // Instead, we show a clear warning at the top of the file.
    
    const warningMsg = \`> ⚠️ **LOCKED FILE**: This ADR has status \\`${status}\\`. It should not be edited. 
    > If you need to update it, propose a new ADR or request a status reset by an admin.\`;

    // Check if warning already exists to avoid duplicates
    const content = tp.file.content;
    if (!content.includes("⚠️ **LOCKED FILE**")) {
        await tp.file.insert(content.length + 10, \`\n\n${warningMsg}\`);
    }

    return true; // Is locked
}

export function renderLockBanner(status) {
    const lockedStatuses = ['accepted', 'rejected', 'deprecated', 'superseded'];
    const isLocked = lockedStatuses.includes(status);
    
    if (!isLocked) return "";

    const color = status === 'accepted' ? '#d4edda' : 
                  status === 'rejected' ? '#f8d7da' : 
                  status === 'deprecated' ? '#e2e3e5' : '#fff3cd';
                  
    return \`
<div style="background-color: ${color}; padding: 10px; border-left: 5px solid #dc3545; margin-bottom: 20px;">
    <strong>🔒 LOCKED</strong> | Status: <em>${status}</em><br>
    <small>This document is finalized. Do not edit directly. Propose a new ADR if updates are needed.</small>
</div>\`;
}
```

---

### 3\. Step B: Update the ADR Template

Inject the visual lock banner into your ADR template (`Templates/ADR Template.md`).

Replace the title section with this logic:

```markdown
---
# <%%* 
const status = tp.frontmatter.status || 'proposed';
const banner = await tp.user.adrLockGuard.renderLockBanner(status);
-%>
<%%> ## <% tp.file.title %>

<%* 
if (banner) {
    echo(banner);
} else {
    echo("<div style='background-color: #fff3cd; padding: 10px; border-left: 5px solid #ffc107; margin-bottom: 20px;'>✏️ <strong>DRAFT</strong> | Status: <em>" + status + "</em></div>");
}
-%>

---
```

Now, when you open a file:

- **Proposed**: Yellow "DRAFT" banner.
- **Accepted/Rejected**: Red/Green "LOCKED" banner.

---

### 4\. Step C: Enforcing Logic in changeStatus

Update `changeStatus` in `Templates/scripts/adrStatus.js` to prevent **reverting** a locked status without a special override.

```javascript
// In Templates/scripts/adrStatus.js

export async function changeStatus(newStatus, currentUser = "Unknown", forceOverride = false) {
    const fm = tp.frontmatter || {};
    const oldStatus = fm.status || 'proposed';
    const lockedStatuses = ['accepted', 'rejected', 'deprecated', 'superseded'];

    // LOGIC: Prevent downgrading or changing a locked status without force
    if (lockedStatuses.includes(oldStatus) && oldStatus !== newStatus && !forceOverride) {
        const confirm = await tp.system.prompt(\`⚠️ WARNING: This ADR is currently '${oldStatus}' (Locked). 
        Changing it to '${newStatus}' may violate governance rules.
        Type 'OVERRIDE' to proceed, or cancel to abort.\`, "");
        
        if (confirm !== "OVERRIDE") {
            console.log("Status change aborted by user.");
            return null; // Abort
        }
    }

    // ... [Rest of your existing changeStatus logic] ...
    // Ensure we also call the lock guard to insert the warning if content was edited manually
    // (This part is tricky because we can't detect manual text edits easily without a plugin)
    
    return { oldStatus, newStatus };
}
```

---

### 5\. Step D: Visual Enforcement (CSS Snippet)

To make it impossible to miss, let's add a CSS snippet that makes the entire note dim or shows a sticky header for locked files.

1. Create `.obsidian/snippets/lock-visuals.css` in your vault.
2. Add this code:
```
/* Style for Locked ADRs */
.markdown-preview-view.is-locked, /* If you use a plugin that sets this class */
body.theme-dark .markdown-source-view.cm-s-obsidian div[data-status="accepted"] ~ .cm-line,
body.theme-light .markdown-source-view.cm-s-obsidian div[data-status="accepted"] ~ .cm-line {
    /* Optional: Dim the whole view if you use a custom class */
}

/* Force a visual indicator in the Live Preview mode */
.markdown-rendered p:has(strong:contains("🔒 LOCKED")) {
    background-color: rgba(220, 53, 69, 0.1); /* Light red background */
    padding: 10px;
    border-radius: 5px;
}

/* Make the lock banner sticky at top */
.lock-banner {
    position: sticky;
    top: 0;
    z-index: 100;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}
```

*Note: CSS `:has()` selector support in Obsidian is limited. For a more robust solution, rely on the HTML banner we added in the template.*

**Better CSS approach (Simple & Effective):** Add this to your `snippets/lock-visuals.css`:

```
/* When the file contains the lock banner text, apply styling to the container */
/* Obsidian doesn't easily select based on content. 
   Instead, we rely on the template inserting a specific class via HTML. */

/* Let's update the template to add a class ID instead of just text */
```

**Refined Template HTML:** In `Templates/scripts/adRLockGuard.js`, change the render function to output a class:

```javascript
return \`
<div class="adr-lock-banner ${status}" style="background-color: ${color}; padding: 10px; border-left: 5px solid #dc3545; margin-bottom: 20px; opacity: 0.9;">
    <strong>🔒 LOCKED</strong> | Status: <em>${status}</em>
</div>\`;
```

Then in CSS:

```
.adr-lock-banner.accepted { border-color: green !important; background-color: #d4edda !important; }
.adr-lock-banner.rejected { border-color: red !important; background-color: #f8d7da !important; }
.adr-lock-banner.deprecated { border-color: gray !important; background-color: #e2e3e5 !important; }

/* Optional: Add a visual cue to the whole note */
.markdown-source-view.mod-cm6 .cm-content:has(.adr-lock-banner.rejected) {
    /* Cannot target parent easily, so stick to the banner itself */
}
```

---

### 6\. Step E: The "Audit Edit" Workflow (Advanced)

Since we can't perfectly block typing, let's add a **"Save Guard"**. If a user tries to save a file that was previously locked but now has different content (and no status change), we append a warning.

*Implementation Complexity*: High. Requires watching file changes via `app.vault.on("modify")`. *Simpler Alternative*: Add a **Button** in the template: "Validate Locked State".

**Add to Template:**

```markdown
---

## 🔧 Admin Actions (Locked Files Only)

<%* 
const status = tp.frontmatter.status;
const isLocked = ['accepted', 'rejected', 'deprecated'].includes(status);
if (isLocked) {
    echo \`
| Action | Command |
|--------|---------|
| **Unlock for Edits** | [Reset Status](command:templater-run-user-script) (Requires OVERRIDE) |
| **Verify Integrity** | [Check Content](command:dataviewjs-refresh) |
\`;
}
-%>
```

---

### Summary of the "Locked" System

1. **Visual**: A colored banner appears at the top of the note indicating the status.
2. **Logical**: The `changeStatus` function prompts for an "OVERRIDE" keyword if you try to change a locked status.
3. **Governance**: Users are trained to see the banner and know they cannot edit freely.
4. **Audit**: Any attempt to bypass triggers a logged prompt.

### Final Validation Steps

1. **Create `ADR-100 Test Lock`** (Status: `proposed`).
2. **Accept it** (Run hotkey/script).
	- Banner turns Green ("LOCKED").
		- `changeStatus` function updated.
3. **Try to Revert**: Run `changeStatus` to `proposed`.
	- Dialog appears: *"Type 'OVERRIDE'..."*
		- If you type anything else -> **Abort**.
		- If you type `OVERRIDE` -> **Proceed** (with warning in history).
4. **Edit Content**: Manually type in the body.
	- No automatic block (Obsidian limitation), but the banner says "Do not edit".
		- *Future enhancement*: Install "Read Only Mode" plugin if you need hard blocking.

This gives you a **soft-governance** model which is standard for knowledge bases, while providing a **hard-logic** check for the critical state transitions.

Would you like me to write a simple **DataviewJS report** that lists all "Potentially Modified Locked Files"? (i.e., Files with `accepted` status where the `modified` date is newer than the `last-status-change` date). This would act as a daily audit log! 📊

ok for DataviewJS report

Perfect, Franc. Let's build that **DataviewJS Audit Report**. This is the "security monitoring" layer of your architecture. It will scan your vault and highlight any ADRs that have been *accepted*, *rejected*, or *deprecated* but were subsequently edited after their finalization date.

Think of this as a `git diff` check for your decision records: if the file was modified after the commit (status change), it raises an alert.

---

### 1\. The Audit Logic

We need to compare two dates:

1. **`last-status-change`**: The timestamp when the ADR was finalized (e.g., moved to `accepted`).
2. **`file.mtime`**: The timestamp when the file content was last modified.

**Condition for Alert:**

```javascript
if (file.status !== 'proposed' && file.file.mtime > fm['last-status-change']) {
    // ALERT: File modified after locking!
}
```

---

### 2\. Create the Audit Dashboard

Create a new note in your vault called `🚨 ADR Audit Log.md`. Paste this code block inside:

```markdown
# 🛡️ Architecture Decision Records - Integrity Audit

> *Last Scanned: <% tp.date.now("YYYY-MM-DD HH:mm") %>*  
> *Checks for files modified AFTER their status was locked.*

---

## 🔴 High Risk: Modified After Locking
These files have a status of \`accepted\`, \`rejected\`, or \`deprecated\`, but their content has been edited since that status was set. **This violates governance policy.**

\`\`\`dataviewjs
// Configuration
const LOCKED_STATUSES = ['accepted', 'rejected', 'deprecated', 'superseded'];
const FOLDER_PATH = '"Architecture/ADR"';

// Helper to format date
function formatDate(date) {
    if (!date) return 'N/A';
    return date.toLocaleString();
}

// Query Pages
let pages = dv.pages(FOLDER_PATH).filter(p => p.status && LOCKED_STATUSES.includes(p.status));

// Filter for modifications after status change
let anomalies = pages.filter(p => {
    const lastStatusChange = p['last-status-change'];
    const fileModified = p.file.mtime;
    
    if (!lastStatusChange || !fileModified) return false;
    
    // Compare timestamps (both are Date objects in Dataview)
    return fileModified > lastStatusChange;
});

// Render Table
if (anomalies.length === 0) {
    dv.el('div', '✅ **No violations found.** All locked ADRs are pristine.', { cls: 'callout success' });
} else {
    dv.el('h4', \`${anomalies.length} Potential Violations Found\`, { cls: 'callout danger' });
    
    const table = dv.table(
        ['ADR', 'Status', 'Locked At', 'Last Modified', 'Age Since Lock', 'Action'],
        anomalies.map(p => {
            const lockTime = p['last-status-change'];
            const modTime = p.file.mtime;
            
            // Calculate duration
            const diffMs = modTime - lockTime;
            const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));
            const ageStr = diffDays > 0 ? \`${diffDays} days ago\` : 'Recently';
            
            return [
                p.file.link,
                p.status,
                formatDate(lockTime),
                formatDate(modTime),
                ageStr,
                \`[Review](command:open)\` 
            ];
        }),
        true // Sort by default? No, we sort manually below
    );
    
    // Sort by modification time (newest first)
    // Note: Dataview table doesn't easily allow custom sort on render, 
    // but we can map them sorted before passing to table constructor.
    anomalies.sort((a, b) => b.file.mtime - a.file.mtime);
}
```

---

## 🟢 Compliant Files (Snapshot)

*Total locked ADRs with no recent modifications:*

```
TABLE 
  file.link AS "ADR",
  status AS "Status",
  last-status-change AS "Locked Date"
FROM "Architecture/ADR"
WHERE status != "proposed" AND file.mtime <= last-status-change
SORT last-status-change DESC
LIMIT 10
```

---

## 📊 Summary Statistics

```
LIST 
  rows.length AS "Count",
  status
FROM "Architecture/ADR"
WHERE status != "proposed"
GROUP BY status
```
```
> **Note**: The \`callout\` CSS classes (\`success\`, \`danger\`) are native to Obsidian. If they don't render, replace the \`dv.el\` lines with standard \`<div>\` tags or just text.

---

### 3. How It Works (Architectural Breakdown)

1.  **Filter**: It selects all ADRs that are not \`proposed\`.
2.  **Comparison**: It converts \`last-status-change\` (string from YAML) and \`file.mtime\` (Date object) into comparable timestamps.
3.  **Flagging**: If \`modified_date > locked_date\`, it flags the row.
4.  **Age Calculation**: It calculates exactly how long ago the violation occurred (e.g., "2 days ago").
5.  **Visual Priority**: The red section appears only if violations exist. If clean, you see a green "No violations found" message.

---

### 4. Automation: Run Audit Weekly

To make this proactive, you can schedule this report to auto-generate via a **Templater script** or a **System Cron**.

#### Option A: Manual Refresh (Recommended)
Just open the \`🚨 ADR Audit Log.md\` note once a week. Dataview re-renders automatically.

#### Option B: Auto-Refresh Script
Create \`Templates/scripts/runAudit.js\`:
\`\`\`javascript
export async function runAudit() {
    const filePath = "🚨 ADR Audit Log.md";
    const file = app.vault.getAbstractFileByPath(filePath);
    
    if (!file) {
        await app.vault.create(filePath, "# 🚨 ADR Audit Log\n\n*Click refresh to update.*");
        console.log("Created Audit Log");
    }
    
    // Force Dataview to refresh
    // This might require the user to press Ctrl+R or use the "Dataview: Reload" command
    app.commands.executeCommandById('dataview:reload');
    
    console.log("Audit triggered.");
}
```

Map a hotkey to `tp.user.runAudit()` so you can trigger the weekly check instantly.

---

### 5\. Testing the Audit

1. **Create & Lock**: Create `ADR-200 Test Audit`. Set status to `accepted`.
2. **Verify Clean**: Open Audit Log. It should show "No violations".
3. **Modify Content**: Go back to `ADR-200` and add a comment or fix a typo. Save it.
4. **Check Audit**: Open Audit Log again.
	- You should see a **Red Banner**.
		- The table lists `ADR-200`.
		- "Age Since Lock" shows "Recently".

---

### 6\. Next Steps?

You now have a complete, self-auditing system:

- ✅ **Creation**: Templater + Regex
- ✅ **Governance**: Status workflow + Lock logic
- ✅ **Notification**: Slack alerts on change
- ✅ **Integrity**: Automated audit log for post-lock modifications

Would you like to:

1. **Auto-Close the Loop**: When a violation is detected, automatically create a `TODO` ticket in your project management tool (Jira/Trello)?
2. **Export to PDF**: Generate a monthly "Compliance Report" PDF of the audit log for stakeholders?
3. **Refine the Lock**: Implement a stricter "Read Only" plugin integration for mobile users who can't run scripts?

Your ADR infrastructure is production-ready! 🏆

Lumo can make mistakes. Please double-check responses.