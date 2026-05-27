# Supervisely Docs — Copilot Instructions

This is the Supervisely product documentation repository, synced to GitBook.
All pages are Markdown with GitBook-specific syntax extensions.

**GitBook syntax reference: [`/SKILL.md`](/SKILL.md)** — read it before using any GitBook block you are unsure about (stepper, tabs, columns, embed, hint, include, variables, frontmatter fields, SUMMARY.md structure).

---

## Core Principle

Every page must answer three questions within the first 2–4 sentences:

1. **What is this?** — one-line definition of the feature.
2. **What problem does it solve?** — the concrete limitation it removes.
3. **What does the user get?** — measurable outcome (speed, scale, accuracy, time saved).

**Weak intro (avoid):**
> This article about the new labeling interface for 3D Point Clouds in Supervisely that introduces a significantly enhanced workflow, offering extended functionality and improved usability.

**Strong intro (use):**
> The 3D Point Cloud labeling tool annotates LiDAR and RADAR data at scale. It unifies single-frame and episode-based workflows into one interface and handles point clouds of up to 50 million points per frame without sacrificing responsiveness.

---

## Page Structure

```
Frontmatter (description = one tight, self-contained sentence)
H1 — exact feature name as in UI
Intro (2–4 sentences: what / problem / outcome)
Feature highlights list  ← overview pages only
Quickstart               ← any feature requiring activation or setup
Sub-sections (H2/H3 per capability)
Summary                  ← required for pages > ~600 words
```

### Frontmatter `description`

One sentence, specific enough to stand alone in a search result. No "This article...", no vague adjectives.

```markdown
---
description: >-
  Live Training continuously fine-tunes a detection or segmentation model
  in parallel with human annotation, producing pre-labels from the 5th image onward.
---
```

### H1 Title

Exact feature name as it appears in the UI. No taglines, no version numbers.

### Intro Paragraph

- 2–4 sentences. State the feature, the problem it removes, and the concrete result.
- Include at least one specific number if available.
- Do not repeat the H1 title verbatim.

### Feature Highlights List

**bold name** — plain description. One level deep only.

```markdown
- **AI-assisted labeling** — Smart Tool and Auto Labeling cut annotation time
- **Cuboid Tracking** — propagate annotations across frames automatically
- **Timeline navigation** — step through episode frames without leaving the view
```

### Quickstart / How-to Steps

- Each step must name the **exact UI element** (match in-app capitalization).
- ≤ 4 steps: plain numbered list.
- ≥ 5 steps or steps with sub-actions: use `{% stepper %}` (see SKILL.md for syntax).

---

## Voice and Tone

| Do | Avoid |
|---|---|
| Second person: "you", "your" | "we", "our tool" |
| Active voice: "Click **Run**" | Passive: "the button should be clicked" |
| Present tense for UI state | Future tense: "will be shown" |
| Specific: "up to 1,000 objects" | Vague: "many objects", "large datasets" |
| Problem-first framing | Feature-first marketing language |

**Problem-first framing example:**
> Conventional workflows require manual coordination between labeling and training phases, creating idle time. Live Training eliminates this by fine-tuning the model continuously as you annotate.

---

## Formatting Rules

### Bold and backticks

- `**bold**` — UI element names (buttons, tabs, panels), key terms on first mention, name in a name — description list.
- `` `backticks` `` — keyboard shortcuts (`Space`, `3`), class names, file names, exact strings.
- Do not bold entire sentences.

### Lists

- `-` (dash) for all unordered lists. Never mix `-` and `*` in the same file.
- `1.` only for ordered steps where sequence matters.

### Directory trees and folder structures

When documenting input/output file structures, use a fenced `text` block with consistent tree formatting.

- Use **thin tree connectors**: `├`, `│`, `└`.
- Add a **space after every emoji icon**: `📦 folder`, `📂 pointcloud`, `📜 frame_pointcloud_map.json`.
- Keep indentation consistent and visually aligned across sibling branches.
- Use emoji by item type:
  - Root archive / project: `📦`
  - Directory/folder: `📂`
  - Image file: `🖼️` or `🏞️`
  - Video file: `🎬`
  - Medical volume: `🩻`
  - Point cloud file: `📄`
  - JSON / text file: `📜` or `📄`

```text
📦 root
├ 📂 folder1
│ ├ 📜 file1.json
│ └ 📜 file2.json
└ 📂 folder2
  └ 📄 data.pcd
```

For side-by-side structure examples, keep both trees in a single `text` block and preserve branch readability in each column.

### Hint blocks

| Intent | Style |
|---|---|
| Availability (Enterprise, beta, browser requirement) | `{% hint style="info" %}` |
| Tip or shortcut that saves time | `{% hint style="success" %}` |
| Risk of data loss or irreversible action | `{% hint style="warning" %}` |
| Breaking limitation or known issue | `{% hint style="danger" %}` |

1–3 lines max. Use for callouts, not for primary content.

### Images

`alt` describes what the screenshot shows, not what the feature does.

```markdown
<figure><img src="../../.gitbook/assets/live-training/live-training.jpg" alt="Auto Labeling dropdown with Live Training option selected"></figure>
```

### Embedded videos

Always include a one-line caption describing what the video demonstrates.

```markdown
{% embed url="https://youtu.be/..." %}
Annotating a vehicle in a dense urban scene using the Cuboid tool with AI auto-adjustment.
{% endembed %}
```

---

## Technical Explanations

Always follow a technical description with a practical consequence. Never end on the technical detail alone.

> *WebGPU provides lower-level GPU access and more rendering parallelism.*
> **In practice:** the tool renders more points per frame and stays smooth on low-end hardware.

---

## Numbers and Metrics

- Always include benchmark data when available. Prefer a table over inline prose.
- Use `\~` prefix for approximate values: `\~50 fps`.
- Write large numbers with commas (`100,000,000`) or shorthand (`100M`).
- Always state conditions: "50 fps on MacBook Air M-series with 10M points", not just "50 fps".

---

## Internal Linking

- Link to related pages the first time a concept is mentioned, not every time.
- Use the page's H1 as link text for overview page links.
- Use descriptive anchor text for section links — never "here" or "this page".

```markdown
See [Experiments](../training/experiments.md) for checkpoint management.  ✓
See [here](../training/experiments.md) for more details.                  ✗
```

---

## What to Avoid

- **Marketing adjectives without numbers**: "powerful", "seamless", "revolutionary", "cutting-edge", "enhanced", "improved usability", "easy to use", "various", "significantly" (without a figure).
- **Restating the title in the intro**: page titled "Live Training" should not open with "Live Training is a feature of Supervisely...".
- **Passive phrasing**: "it can be used to", "can be applied when" — write what it does directly.
- **Steps without UI anchors**: every step must name the exact button, tab, or panel.
- **Algorithm dumps without user impact**: always follow technical detail with a practical consequence.
- **Captions missing on media**: every `{% embed %}` and every `<figure>` that is ambiguous must have a caption / alt text.

---

## Summary Section

Required for pages > ~600 words. Bullet list, one line per point, outcome-first.

```markdown
## Summary

- **WebGPU rendering** enables smooth annotation at 100M+ points.
- **Low-end hardware** handles 40M-point scenes at usable frame rates.
- **Pen and Select tools** stay responsive regardless of scene density.
- No configuration required — improvements apply automatically on supported browsers.
```

---

## Pre-publish Checklist

- [ ] `description` is specific and self-contained (no "This article...")
- [ ] Intro: what the feature is, what problem it solves, concrete outcome
- [ ] All UI elements are **bolded** and match exact in-app labels
- [ ] Steps are numbered; each names the specific UI element
- [ ] Every `{% embed %}` has a caption
- [ ] Every `<figure>` has a descriptive `alt` attribute
- [ ] Hint blocks used for availability, tips, warnings — not primary content
- [ ] No vague marketing language
- [ ] Internal links use descriptive anchor text
- [ ] Pages > 600 words have a `## Summary` section
- [ ] Consulted SKILL.md for any GitBook block syntax used

---

## GitBook Quick Reference

For full syntax details, **read [`SKILL.md`](/SKILL.md)**. Short reminders:

| Need | Block |
|---|---|
| Sequential steps (≥ 5 or with sub-actions) | `{% stepper %}...{% endstepper %}` |
| Alternative options (OS, language, plan) | `{% tabs %}...{% endtabs %}` |
| Callout / warning / tip | `{% hint style="info\|success\|warning\|danger" %}` |
| Embedded video | `{% embed url="..." %}caption{% endembed %}` |
| Expandable section | `<details><summary>Title</summary>content</details>` |
| Side-by-side comparison | `{% columns %}...{% endcolumns %}` |
| Reusable content block | `{% include "/reusable-content/rc..." %}` |
| Image | `<figure><img src="../../.gitbook/assets/..." alt="..."></figure>` |
| Internal link | `[text](../folder/page.md)` |
