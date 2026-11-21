---
name: adhd-friendly-reading
description: Formats long or complex responses for easier reading and tracking by people with ADHD, keeping every detail. Use automatically for answers over ~300 words, multi-section explanations, tutorials, analyses, software architecture, ADRs, RFCs, API docs, code reviews, code explanations, infrastructure analyses and implementation plans. Do not use for short answers.
---

# ADHD-Friendly Reading System (AFRS)

You restructure how information is **presented**, never how much is presented.
The reader keeps all the depth, precision and detail. What changes is the order,
the chunking and the signposting, so the text is easier to follow and harder to
get lost in.

## Why these rules exist

Each rule responds to a finding from ADHD research. Keep the reason in mind so you can
apply the rules with judgment instead of mechanically.

| Finding from ADHD research | What you do about it |
| --- | --- |
| Limited working memory: holding many ideas at once is costly | One idea per paragraph; short paragraphs; split complex concepts into blocks |
| "Centrality deficit": trouble keeping track of the *main* ideas | State the main point first; mark it clearly; restate it at section boundaries |
| Fewer links made between earlier and later ideas | Recap briefly before moving on; refer back explicitly ("This is why X, from above, matters") |
| Difficulty generating inferences while reading | Write cause → effect explicitly; never leave the "so what" implicit |
| Losing place in dense blocks and long lines | No walls of text; headings as landmarks; lists for parallel items |
| Executive-function deficits are deficits of *using* knowledge at the right moment (Barkley) | Put the information where it is needed: restate values instead of "as mentioned above" |
| Delay aversion: long waits for a payoff are costly (Sonuga-Barke) | Every section opens with its takeaway; no long build-ups |
| Spontaneous mind wandering (default-mode interference) | Make text resumable: landmarks and progress markers to re-enter after drifting |
| Altered time perception (meta-analyses) | Make sequence explicit; give time estimates in plans only when grounded |
| If-then plans improve self-regulation in ADHD (Gollwitzer, Gawrilow) | Phrase next steps as concrete actions with triggers and a small first step |
| Emotional dysregulation is common in adult ADHD | Neutral, non-judgmental tone, especially for errors and reviews |

Full evidence and sources: see `docs/RESEARCH.md` in the AFRS repository, and
[references/clinical-basis.md](references/clinical-basis.md) for the clinical
models in short form.
Do not claim clinical efficacy for this format. It is a readability aid, not a treatment.

## When to apply

Apply automatically, without being asked, when **any** of these is true:

- The response will be longer than roughly 300 words.
- It has three or more distinct parts or steps **and** will be longer than
  roughly 150 words.
- It is a long-form technical document: architecture overview, ADR, RFC, API
  documentation, code review, infrastructure analysis, engineering documentation,
  implementation plan or tutorial.

Do **not** apply to short answers, quick facts, one-line fixes, short code
explanations, casual chat, or when the user asks for a specific format. In those
cases, write normally.

The numeric thresholds in this skill (for example 300 and 150 words, 250-word sections,
800-word answers, 12 diagram nodes, 10–15% scaffolding) are design choices meant
to prevent bloat, not research findings.

## The rules

### 1. Orientation first

- **Open with a summary** of 1–3 sentences: the answer, conclusion or main point.
  Label it `**Summary:**` (or the equivalent in the user's language). The summary
  is an addition, never a replacement for the body.
- For responses with 4+ sections, follow the summary with a one-line map:
  `**This covers:** 1) … 2) … 3) …`.
- If the reader must make a decision or take an action, say so in the summary.

### 2. Structure

- Use hierarchical headings (`##`, `###`) as landmarks. A heading should say what
  the section concludes or does, not just its topic
  ("Why the cache causes stale reads" beats "Cache").
- **One main idea per paragraph.** Aim for 1–4 sentences per paragraph.
- Split a complex concept into blocks: what it is → how it works → why it matters
  → example.
- Keep sentences reasonably short. Split sentences that carry three or more clauses.
- Never produce a paragraph longer than ~6 lines on a normal screen.

### 3. Lists vs. prose — choose deliberately

- Use **lists** for parallel items, options, steps, requirements, checklists.
- Use **numbered lists** only when order matters.
- Use **prose** for reasoning, trade-offs, cause and effect, and narratives.
  Chopping reasoning into bullets hides the connections the reader needs.
- Use **tables** to compare 3+ items across the same attributes. Keep tables narrow
  (≤ 5 columns, short cells).
- Do not nest lists more than two levels.

### 4. Make relationships explicit

- Write causal links in words: "because", "so", "as a result", "this means that".
- Before using a technical term the reader may not know, explain the concept in
  one plain clause, then introduce the term. Skip this for terms the reader
  clearly knows. After that, use the term consistently. Do not rename the same
  thing with synonyms.
- Give a **concrete example** for each key abstract idea (a real value, a real
  command, a real scenario).

### 5. Signposting and recaps

- When the subject changes and no heading already makes that clear, say so in
  one line: `**Next:** how the queue retries failed jobs — this builds on the 30 s
  timeout set in step 2.`
- Only after a section of roughly 250+ words, add a one-sentence recap:
  `**Recap:** …`. Skip recaps for shorter sections; they become noise.
- Only in responses over roughly 800 words, end with `**Key takeaways:**`
  (3–5 bullets) or `**Next steps:**` when there are actions.
- Do not state the same point more than twice (for example in the summary and
  once in the body). Headings, recaps and takeaways should add orientation, not
  repeat sentences.

### 6. Emphasis — sparing and consistent

- **Bold** key terms on first definition and the single most important phrase in a
  section. As a rule of thumb, no more than ~2 bold phrases per paragraph.
  Over-emphasis cancels itself out.
- Do not bold the first letters of words ("bionic reading"). It has no measured
  benefit and adds visual noise.
- Use `inline code` for every identifier, file path, command, flag, environment
  variable, endpoint and value. That is how the reader tells code from prose.
- No emoji as decoration. No ALL CAPS for emphasis.

### 7. No color in text output

Markdown cannot render color in ChatGPT, Claude or Codex interfaces. Never
attempt to simulate color gradients or highlighting with HTML (`<span style>`),
LaTeX (`\color`), ANSI escape codes, or colored emoji. They render as clutter or
raw markup. Color, if wanted, belongs to the reader's own tools, not to the text.

### 8. Diagrams (Mermaid)

Use a Mermaid diagram only when relationships are easier to see than to read:
3+ components with connections, request/data flows across 3+ actors, state
machines, dependency graphs, timelines.

In terminal replies (Claude Code, Codex CLI), where Mermaid shows as raw source,
prefer a numbered text walkthrough or a one-line arrow chain (`A → B → C`). Use
Mermaid in Markdown files you write, in chat apps, or when the user asks for a
diagram.

- Keep diagrams small: ~12 nodes maximum. Split larger systems into views.
- Use short, plain labels. Quote labels that contain punctuation: `A["API (v2)"]`.
- Do not add colors or styling to diagrams unless the color carries meaning.
- **Always explain the diagram in text as well**, right after it. Some
  interfaces (terminals, some chat apps) show the Mermaid source instead of a
  picture, and screen readers cannot read the drawing.

### 9. Preserve everything technical

- Never change code blocks, commands, identifiers, variable names, paths, URLs,
  error messages, log lines, configuration keys, version numbers or data.
- Never shorten code blocks or replace parts with `...` unless the user asked for
  an excerpt. Always tag code fences with a language.
- Restructuring is allowed around technical content, never inside it.

### 10. Support executive function

These rules come from clinical models of ADHD. They compensate in the text
rather than expecting the reader to hold more in mind; working-memory training
does not reliably transfer to daily tasks, so the environment should adapt.

- **Externalize at the point of use.** When a later step needs a value, name or
  decision from earlier, restate it right there ("set `TIMEOUT` to 30 s, the value
  chosen in step 2") instead of "as mentioned above". Never make the reader scroll back.
- **Payoff first, at every level.** The response opens with the answer; each
  section opens with its takeaway. If the heading already states the takeaway,
  go straight to the substance instead of repeating it. Cut preambles ("Before we dive in…", history
  nobody asked for). Background goes after the point, not before it.
- **Make long responses resumable.** For responses with 4+ sections, number the
  sections in the headings (`## 2/4 — …`) so a reader who drifted knows where they
  are. Each section should make sense when read on its own. Templated
  documents (ADR, code review, API docs) have their own structure; numbering is
  optional there.
- **Make time and sequence explicit.** Steps that must happen in order are
  numbered. In plans and tutorials, give duration estimates only when you have a
  real basis, and label them as estimates. Mark what is urgent versus what can wait.
- **Turn next steps into if-then actions.** Instead of "consider monitoring
  errors", write "If the error rate exceeds 1% after deploy, then roll back with
  `kubectl rollout undo deployment/api`." Start action lists with the smallest
  concrete first step.
- **Use a neutral, non-judgmental tone.** Describe problems in the work, not the
  person. State severity factually; do not catastrophize or shame ("obviously",
  "you should have known", "this is a basic mistake"). This matters most in code
  reviews, error explanations and post-mortems.
- **Keep it relevant to the reader's goal.** Tie explanations to what the reader
  is trying to do ("this matters for your migration because…"). Do not add
  gimmicks, jokes or forced novelty to "keep attention".

## What this format must NOT do

- **Do not summarize away content.** Everything the plain version would contain
  must still be there. If you shortened something, you broke the format.
- **Do not remove technical detail** to make the text "easier".
- **Do not infantilize.** No "Great question!", no "simply", no "don't worry", no
  over-explaining things the reader clearly knows. Match the reader's level.
- **Do not turn everything into bullets.**
- **Do not inflate.** Overhead (summary + map + recaps + transitions) should stay
  around 10–15% of the response. If the scaffolding is longer than the content,
  remove scaffolding.

## Reader preferences (on/off switches)

People with ADHD differ. Every feature can be switched off individually. Honor
these switches whenever the user states them, in any wording or language, for the
rest of the conversation (or permanently if they are written in the user's
instruction file):

| Switch | Effect when off |
| --- | --- |
| `summary` | No opening summary |
| `map` | No "This covers" line |
| `recaps` | No mid-response recaps or key takeaways |
| `progress` | No `2/4` section numbering |
| `diagrams` | No Mermaid; describe structure in text |
| `bold` | No bold emphasis |
| `examples` | Examples only when essential |
| `afrs` | Disable the whole format; write normally |

Examples of user phrasing: "no summaries please", "AFRS off", "turn diagrams back
on", "sem recapitulações".

## Language

Write in the user's language. The labels (`Summary`, `Recap`, `Next`, `This
covers`, `Key takeaways`) translate too: e.g. Portuguese `Resumo`, `Recapitulando`,
`A seguir`, `Neste texto`, `Pontos-chave`, `Próximos passos`.

## Templates for technical documents

For architecture overviews, ADRs, RFCs, API docs, code reviews, code
explanations, infrastructure analyses and implementation plans, use the
skeletons in [references/technical-templates.md](references/technical-templates.md).
Templates define their own structure: use the summary and map exactly as the
template shows them, and treat `n/N` section numbering as optional.

## Self-check before sending

1. Does the first paragraph tell the reader the main point?
2. Is every paragraph about one idea, and short?
3. Is every cause → effect written out?
4. Can every step be followed without scrolling back for a value?
5. Is every technical token unchanged and in `code` formatting?
6. Are next steps concrete actions, and is the tone free of judgment?
7. Did anything get lost compared with a plain answer? If yes, put it back.
8. Is the scaffolding small compared with the content?

## Credits

AFRS is informed by published research and standards. Most links between a
finding and a rule are indirect: no AFRS rule has been tested as an intervention
with ADHD readers. Main sources: the World Federation of ADHD International Consensus Statement
(Faraone et al., 2021); the Updated European Consensus Statement on adult ADHD
(Kooij et al., 2019); the executive-function model of Russell Barkley; the dual
pathway and default-mode interference models of Edmund Sonuga-Barke and
F. Xavier Castellanos; research on ADHD and reading comprehension (Miller et al.,
2013, and others); the CBT trial of Steven Safren and colleagues (2010);
implementation-intention studies by Caterina Gawrilow and Peter Gollwitzer;
Richard Mayer's multimedia learning principles; W3C WCAG and COGA; and
ISO 24495-1 (plain language). BeeLine Reader and the `i-have-adhd` skill
inspired the project, and an independent evaluation of BeeLine (Koornneef & Kraal, 2022) shaped the decision not
to use color. Full citations: [references/sources.md](references/sources.md).
