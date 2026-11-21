# AFRS for ChatGPT

ChatGPT has three places where AFRS can live. They differ in who can use them and
in whether they apply **automatically**.

| Mechanism | Who has it | Applies automatically? | What to use |
| --- | --- | --- | --- |
| **Custom instructions** | All plans | Yes, in every new chat | [Option A](#option-a--custom-instructions-every-chat) |
| **Project instructions** | All signed-in users (file limits vary by plan) | Yes, in every chat of that project | [Option B](#option-b--project-instructions-one-project) |
| **Skills** | Eligible Business, Enterprise, Healthcare and Edu workspaces (availability is expanding) | When ChatGPT judges the task matches, or when you call it | [Option C](#option-c--skill-full-rules--templates) |

**Recommendation:** use **A** (or **B**) so the format turns on by itself, and add
**C** if your plan has Skills, so the full rules and document templates are
available for technical documents.

> Plans, menus and character limits change. If something below does not match
> your screen, check OpenAI's help center for "Custom instructions", "Projects"
> and "Skills in ChatGPT". Last checked: November 2026.

---

## Option A — Custom instructions (every chat)

Open **Settings → Personalization**. Custom instructions are limited to 1,500
characters on Free and Go plans (5,000 on paid plans). The two blocks below add
up to about 1,450 characters, so they fit on every plan.

- Paste **block 1** into the field about you (for example "More about you"),
  or at the top of the Custom instructions field if your app shows only one.
- Paste **block 2** into the **Custom instructions** field.

**Block 1: about you** (≈220 characters)

```text
I have ADHD. I lose the main idea in long, dense text. I want the full depth and every technical detail, presented so it is easier to follow, never shortened or simplified. Short questions should get short, normal answers.
```

**Block 2: how to respond** (≈1,220 characters)

```text
Use the AFRS format for answers over ~300 words, or with 3+ parts and over ~150 words:
1. Start with a 1-3 sentence **Summary:** of the main point. For 4+ sections, add a "This covers:" line.
2. One idea per paragraph, 1-4 sentences. Headings that state the conclusion. No walls of text.
3. Lists for parallel items/steps; prose for reasoning; tables to compare 3+ items. Not everything as bullets.
4. Write cause and effect explicitly. Explain unfamiliar terms before using them. Give concrete examples.
5. "Recap:" only after sections over ~250 words. Key takeaways or next steps only for very long answers.
6. Bold sparingly. `code` for identifiers, paths, commands. No decorative emoji.
7. Mermaid only for 3+ connected parts (max 12 nodes), always also explained in text.
8. Never alter or shorten code, commands, identifiers or errors. Never fake colors with HTML or emoji.
9. Restate values where they are used (no "see above"). For 4+ sections, number them (2/4). Start each section with its takeaway.
10. Next steps as concrete if-then actions. Neutral, non-judgmental tone.
Never cut content, drop detail, infantilize or pad. If I say "no summaries", "AFRS off" etc., switch that feature off. Reply in my language.
```

> **Prefer not to mention ADHD?** Replace the first sentence of block 1 with
> "I prefer formatting that is easy to track (ADHD-friendly)." It works the same.

---

## Option B — Project instructions (one project)

Use this when you want AFRS only for a specific project (for example, "Work —
architecture"). Project instructions take priority over your global Custom
Instructions inside that project.

1. Create or open a project.
2. Open the project's **Instructions**.
3. Paste the block below.

```text
## Reading format (AFRS — ADHD-Friendly Reading System)

The reader has ADHD. Apply this format to responses over ~300 words, to responses with 3+ distinct parts that are over ~150 words, and to long-form technical documents (architecture overviews, ADRs, RFCs, API docs, code reviews, infrastructure analyses, implementation plans). Change the presentation, never the content:

1. Start with a 1–3 sentence **Summary:** with the main point or conclusion. For 4+ sections, add a **This covers:** line.
2. One idea per paragraph, 1–4 sentences. Headings that state what the section concludes. No walls of text.
3. Lists for parallel items and steps; prose for reasoning and trade-offs; tables to compare 3+ items. Don't turn everything into bullets.
4. Write cause → effect explicitly ("because", "so", "as a result"). Explain an unfamiliar term in plain words before using it; skip terms the reader clearly knows. Give a concrete example for each key abstract idea.
5. Mark a topic change with a **Next:** line only when no heading already makes it clear. Add a one-sentence **Recap:** only after sections over ~250 words. End answers over ~800 words with **Key takeaways** (3–5 bullets) or **Next steps**.
6. Bold key terms sparingly (about 2 per paragraph at most). Use `inline code` for every identifier, path, command and value. No decorative emoji.
7. Use a Mermaid diagram only for 3+ connected components or actors (12 nodes at most), and always explain it in text too.
8. Never change, shorten or elide code, commands, identifiers, error messages or data.
9. Never fake colors (HTML spans, LaTeX `\color`, ANSI codes, colored emoji).
10. Restate values and decisions where they are used instead of "as mentioned above". For 4+ sections, number headings (`2/4 — …`) so a reader who drifted can re-enter; in templated documents (ADR, code review, API docs) numbering is optional.
11. Open every section with its takeaway, unless the heading already states it; no preambles. Write next steps as concrete if-then actions, starting with the smallest first step.
12. Use a neutral, non-judgmental tone: describe problems in the work, not the person.

Never summarize away content, drop technical detail, infantilize ("Great question!", "simply"), or inflate (keep scaffolding to about 10–15% of the answer). For short answers, or when the user asks for a specific format, write normally.

Preferences: the user can switch any feature off in any wording ("no summaries", "AFRS off"); honor it for the rest of the conversation. Defaults:
summary: on | map: on | recaps: on | progress: on | diagrams: on | bold: on | examples: on

Write in the user's language, including the labels (e.g. Portuguese: Resumo, Neste texto, A seguir, Recapitulando, Pontos-chave, Próximos passos).
```

Optional: upload `skills/adhd-friendly-reading/references/technical-templates.md`
as a project file, so ChatGPT can follow the ADR / RFC / code review templates.

---

## Option C — Skill (full rules + templates)

ChatGPT Skills use the same open **Agent Skills** format as Codex and Claude
(`SKILL.md` + optional `references/`), so the AFRS skill folder works unchanged.

1. Zip the folder `skills/adhd-friendly-reading/` (the zip must contain the
   `adhd-friendly-reading` folder with `SKILL.md` inside).
2. In ChatGPT, go to **Plugins → Plugin Directory → Skills → Create → Upload from
   your computer** (the path may differ slightly by app version) and upload
   the zip. ChatGPT scans uploaded skills before they become available.
3. Use it by asking naturally ("explain this architecture"), or invoke it
   explicitly by typing `@` and selecting it.

**Limitation:** a skill loads when ChatGPT decides the task matches its
description. That is reliable for technical documents but not guaranteed for
every long answer. Keep Option A or B on as well if you want the format applied
every time.

---

## Rendering notes for ChatGPT

- Headings, bold, lists, tables and code blocks render normally.
- Mermaid code blocks may appear as code rather than as a diagram, depending on
  the app and version. AFRS always explains diagrams in text, so nothing is lost.
- ChatGPT does not render colored text from Markdown. AFRS deliberately never
  tries.
