# Example 4 — Short answers stay normal

AFRS only activates for long or complex responses. A short answer gets no
summary, no headings and no recaps, because scaffolding on a two-line answer is
pure noise.

**Prompt:** "How do I undo my last git commit but keep the changes?"

**Correct response (AFRS not applied):**

```bash
git reset --soft HEAD~1
```

This removes the commit and leaves the changes staged.

---

**Wrong response (AFRS over-applied):**

```markdown
**Summary:** You can undo the last commit with a soft reset.

**This covers:** 1) the command 2) what it does

## 1/2 — The command
...

**Recap:** ...
```

This is the "inflation" failure mode the skill explicitly forbids.
