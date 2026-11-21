# Compatibility, testing and limitations

**Summary:** AFRS is Markdown only. It uses each platform's native instruction
mechanism: an always-on instruction file (`CLAUDE.md`, `AGENTS.md`, ChatGPT
Custom/Project instructions) guarantees that the format applies automatically,
and an Agent Skill (`SKILL.md`) adds the full rules and templates on demand. No
code, extension or runtime is required.

**This covers:** 1) how each platform loads instructions 2) the architecture
3) how it was tested 4) known limitations

Last verified against public documentation: November 2026.

---

## 1/4 — How each platform loads instructions

| | Claude Code | OpenAI Codex | ChatGPT |
| --- | --- | --- | --- |
| Always-on file | `CLAUDE.md` (`~/.claude/CLAUDE.md` global, or in the project) | `AGENTS.md` (`~/.codex/AGENTS.md` global, or in the repo and subfolders) | Custom Instructions (global) or Project instructions |
| Skill location | `~/.claude/skills/<name>/SKILL.md` or `.claude/skills/` | `~/.agents/skills/<name>/SKILL.md` or `.agents/skills/` | Upload in the Skills area (where the plan has Skills) |
| Skill format | Agent Skills: YAML front matter (`name`, `description`) + Markdown | Same open format; optional `agents/openai.yaml` for UI metadata | Same open format |
| How a skill loads | Name and description are always visible; the body loads when the task matches or on `/adhd-friendly-reading` | Same progressive loading; explicit call with `$adhd-friendly-reading` | Loads when ChatGPT judges it relevant, or when named |
| Mermaid | Shown as source in the terminal (AFRS prefers text walkthroughs there) | Shown as source in the CLI (same) | Depends on app and version |
| Colored text | Not possible | Not possible | Not possible |

**Key consequence:** skills load *when the model decides the task matches*. A
reading format is cross-cutting (it applies to any long answer), so relying on
the skill alone would make activation unreliable. That is why AFRS always ships
a compact, always-on block as well.

---

## 2/4 — Architecture

```mermaid
flowchart TD
    S["skills/adhd-friendly-reading/SKILL.md<br/>full rules"] --> R1["references/technical-templates.md"]
    S --> R2["references/clinical-basis.md"]
    S --> R3["references/sources.md"]
    C["Core block<br/>(12 compact rules)"] --> CL["platforms/claude-code/CLAUDE.md"]
    C --> AG["platforms/codex/AGENTS.md"]
    C --> CG["platforms/chatgpt/CHATGPT.md<br/>Project instructions + 1,500-char version"]
```

In words:

- **One skill, shared by all three platforms.** The same `SKILL.md` folder works
  in Claude Code, Codex and ChatGPT because all three use the open Agent Skills
  format.
- **One core block, copied into each platform file.** The 12 rules are word for
  word the same in `CLAUDE.md`, `AGENTS.md` and the ChatGPT project
  instructions. Only the short "specifics" section differs per platform.
- **A shorter version for ChatGPT Custom Instructions**, because those fields have
  a character limit.

**If you edit the rules:** change the core block in all three platform files,
the short Custom instructions version in `CHATGPT.md`, the corresponding rule in
`SKILL.md`, and the switch tables in both READMEs.

---

## 3/4 — How it was tested

### Static checks (run on every file in this repository)

| Check | Result |
| --- | --- |
| `SKILL.md` front matter is valid YAML with `name` and `description` | Pass |
| `name` uses lowercase letters and hyphens and matches the folder name | Pass |
| Core block identical in `CLAUDE.md`, `AGENTS.md` and `CHATGPT.md` | Pass |
| ChatGPT Custom instructions blocks fit the 1,500-character Free/Go limit, even combined | Pass (≈220 + ≈1,220 = ≈1,450) |
| Every Mermaid diagram in the repository renders without errors | Pass (Mermaid CLI 11.16.0, 21 Nov 2026) |
| Markdown lint (structure, headings, code fences) | Pass (markdownlint-cli2 0.23.2, 21 Nov 2026; see `.markdownlint.json` for the rules disabled) |
| Examples: every fact in each "Before" is present in the matching "After" | Checked by hand and by an independent review |
| Citations: authors, journals, volumes and DOIs | Spot-checked against publisher and PubMed pages by an independent review |

### Manual behavior test (do this after installing)

Run these prompts on each platform, with AFRS installed, and check the list.

1. **Long technical answer:** "Explain how OAuth 2.0 authorization code flow
   with PKCE works, step by step."
2. **Document type:** "Write an ADR for adopting PostgreSQL read replicas."
3. **Short answer (must stay normal):** "What does `git stash pop` do?"
4. **Switch off:** "No summaries from now on." Then repeat prompt 1.
5. **Language:** ask prompt 1 in Portuguese.

Checklist for prompts 1, 2 and 5:

- [ ] Opens with a 1–3 sentence summary.
- [ ] Short paragraphs, one idea each; headings state conclusions.
- [ ] Cause and effect are written out.
- [ ] Code, commands and identifiers unchanged, in `code` formatting.
- [ ] Diagram (if any) is followed by a text explanation.
- [ ] No HTML color tags, no decorative emoji.
- [ ] Not noticeably shorter or less detailed than without AFRS.

Expected for prompt 3: a normal, short answer. Expected for prompt 4: no
summary line, everything else unchanged.

---

## 4/4 — Known limitations

- **Instructions are guidance, not guarantees.** Language models follow them
  most of the time, not every time. Long conversations can dilute instructions;
  restating "use AFRS" brings the format back.
- **No color rendering.** AI chat interfaces do not render colored text from
  Markdown. AFRS intentionally provides no color gradient. Readers who want one
  can use a separate reading tool on top of any interface.
- **Mermaid is not drawn everywhere.** Terminals show the diagram source. AFRS
  always explains diagrams in text so nothing depends on rendering.
- **Interface layout is out of reach.** Line length, line spacing and fonts
  (WCAG 1.4.8) are set by the app, not by the text.
- **ChatGPT Skills availability varies by plan.** Custom Instructions and
  Projects are the reliable path for most users.
- **Possible conflicts with other formatting instructions.** If another
  instruction or skill asks for terse output (for example `i-have-adhd`), the
  two will conflict. Use one at a time, or tell the assistant which one wins.
- **Evidence limits.** See [RESEARCH.md](RESEARCH.md). The rules are informed by
  research on ADHD and reading, but AFRS itself has not been tested in a
  controlled study. No clinical effect is claimed.
