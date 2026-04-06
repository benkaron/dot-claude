---
name: metabase-text-cards
description: >-
  Generate Metabase dashboard text card markdown — section blurbs, Claude deep links,
  and formatted descriptions. Use when writing Metabase text, creating dashboard
  explanations, building Claude deep links for dashboards, or generating markdown
  for Metabase text cards.
argument-hint: "<description of what to generate>"
---

# Metabase Text Card Markdown Generator

Generate markdown content for Metabase dashboard text cards — section descriptions,
Claude deep links, and formatted explanations of data.

## What This Skill Covers

1. **Section blurbs** — descriptive text for dashboard sections
2. **Claude deep links** — 🤖 links that open Claude with a pre-filled prompt
3. **Metabase markdown syntax** — what works and what doesn't in text cards
4. **Dashboard filter variables** — `{{variable}}` and `[[optional]]` syntax

---

## Output Format

Always output the generated markdown in TWO ways:

1. **Show it inline** in the response so the user can review it
2. **Write to `/tmp/metabase-text-card.md`** and copy to clipboard via `pbcopy`

```bash
# After writing the file:
cat /tmp/metabase-text-card.md | pbcopy
```

Tell the user it's on their clipboard.

---

## Section Blurb Pattern

When generating a text card description for a dashboard section, follow this structure:

```markdown
**Section Title**

---

Description of the data with **bold key terms** for emphasis. Explain what the
data represents, where it comes from, and any important methodology.

**Important caveat**: Call out any data limitations, self-reported fields,
or known gaps directly — don't bury them.

**Available Filters**: List, Of, Filters
```

### Real Examples From Past Work

**Email Activity:**

```markdown
**Email Activity**

---

**Total emails** includes all emails sent by AEs and SDRs tracked in HubSpot.
**Unify emails** are a subset — identified by the `unify_opt_out_url` property
on the email engagement.

**Available Filters**: Date, Time Grouping, AEs & SDRs
```

**LinkedIn Connections:**

```markdown
**LinkedIn connection data** comes from HubSpot tasks — both native LinkedIn
connection tasks and Unify-triggered connection requests. "Completed" means
the rep marked the task as done (i.e., the connection request was sent).
"Incomplete" means the task was assigned but not yet acted on.

**Important caveat**: This data is self-reported. Completing a task means the
rep clicked "done" — there is no integration with LinkedIn to verify the
connection was actually sent or accepted. Tasks can also be bulk-completed,
so high completion numbers may not reflect actual LinkedIn activity.

**Available Filters**: Date, Time Grouping, AEs & SDRs
```

**Deal Pipeline by Sequence Attribution:**

```markdown
**Deal Pipeline by Sequence Attribution**

---

Each deal is attributed to the **most recent sequence enrollment that occurred
before the deal was created** — ensuring only pre-deal outreach gets credit.
Only new business deals are included (upsells are excluded).

**Available Filters**: Date, Sequence, Deal Stage
```

### Style Guidelines

- Lead with the data source in bold
- Explain methodology concisely — how is this counted/attributed?
- Call out caveats explicitly with **Important caveat**: prefix
- End with **Available Filters**: listing the dashboard filters that apply
- Use horizontal rules (`---`) to separate title from body
- Keep it scannable — someone glancing at the dashboard should understand
  the data in 10 seconds

---

## Claude Deep Links

### Format

```
https://claude.ai/new?q=URL+encoded+prompt+text
```

The `q` parameter takes a URL-encoded prompt. When clicked, it opens a new
Claude chat with the prompt pre-filled.

### Standard Markdown Pattern

Always use the 🤖 robot emoji prefix:

```markdown
[🤖 Ask Claude](https://claude.ai/new?q=URL+encoded+prompt+here) descriptive text of what it does
```

### How to URL-Encode

Use JavaScript-style encoding rules:
- Spaces → `+`
- Commas → `%2C`
- Parentheses → `%28` / `%29`
- Backticks → `%60`
- Question marks → `%3F`
- Forward slashes → `%2F`
- Apostrophes → `%27`
- Newlines → `%0A`
- Ampersands → `%26`
- Equals → `%3D`
- Colons → `%3A`
- Periods, hyphens, underscores → leave as-is

When generating a Claude deep link, use Python to URL-encode accurately:

```bash
python3 -c "import urllib.parse; print('https://claude.ai/new?q=' + urllib.parse.quote_plus('Your prompt text here'))"
```

### Example

User asks for: "Ask Claude which SDR has the most connected calls based on the `view_hubspot_calls` table"

Generate:

```markdown
[🤖 Ask Claude](https://claude.ai/new?q=Which+SDR+has+the+most+connected+calls+based+on+the+%60view_hubspot_calls%60+table%3F) which SDR has the most connected calls
```

### Adding Context to Prompts

When the deep link relates to Redshift data, prepend context to the prompt:

```
You have access to Redshift's Public schema. <actual question here>
```

This helps Claude understand it can reference tables directly.

---

## Metabase Markdown Reference

### Supported Syntax

| Feature | Syntax | Notes |
| --- | --- | --- |
| Headings | `# H1` through `###### H6` | Use for section titles |
| Bold | `**text**` | Key terms, data sources |
| Italic | `*text*` | Emphasis |
| Links | `[text](url)` | External links, Claude deep links |
| Images | `![alt](url)` | Must be externally hosted |
| Bullet lists | `- item` or `* item` | Unordered lists |
| Numbered lists | `1. item` | Ordered lists |
| Code inline | `` `code` `` | Table names, column names |
| Code blocks | ` ``` ` | No syntax highlighting |
| Blockquotes | `> text` | Callouts |
| Horizontal rule | `---` | Section dividers |
| Tables | `\| col \| col \|` | Inline tables |

### Variables and Filters

- **Variable**: `{{variable_name}}` — wired to a dashboard filter
- **Optional text**: `[[text with {{variable}}]]` — only shows when filter has a value
- Variable names cannot contain spaces
- Variables display raw `{{VARIABLE}}` text when no filter value is selected,
  so always wrap in `[[ ]]` to hide when empty

### Known Limitations

- **No URL encoding of variables**: Metabase inserts `{{variable}}` values
  as-is into URLs. Filter values with spaces will break links. Workarounds:
  - Use filter values without spaces (underscores instead)
  - Hardcode separate links per known value
  - Use a generic prompt that doesn't depend on the filter value
- **No syntax highlighting** in code blocks
- **No image uploads** — images must be externally hosted URLs
- **No HTML** — only markdown is supported
- **No nested formatting** in table cells (bold/italic in tables is limited)

---

## Combining It All

A complete text card for a dashboard section might look like:

```markdown
**Call Activity**

---

**Call data** comes directly from HubSpot's built-in call tracking. Calls made
through Nooks are included — they log to HubSpot automatically. "Connected"
means the call reached a person (not voicemail or no answer).

**Important caveat**: Call outcomes are set by the rep at the end of each call.
"Connected" is self-reported.

[🤖 Ask Claude](https://claude.ai/new?q=Which+SDR+has+the+most+connected+calls+based+on+the+%60view_hubspot_calls%60+table%3F) which SDR has the most connected calls

**Available Filters**: Date, Time Grouping, AEs & SDRs
```
