# AFRS templates for technical documents

Skeletons that apply the AFRS rules to common engineering documents. Use the
sections that fit; drop the ones that don't. Every template keeps the same
spine: **summary first → context → the substance in chunks → explicit
consequences → what to do next.**

Headings below are suggestions. Translate them to the user's language.
Templates define their own structure: `n/N` section numbering is optional here,
and "Key takeaways" only belongs in documents over roughly 800 words.

---

## Architecture overview

````markdown
**Summary:** <what the system does and its single most important design choice, 1–3 sentences>

**This covers:** 1) scope 2) components 3) main flow 4) key decisions 5) risks

## What the system is responsible for
<1 short paragraph on scope; 1 on what is explicitly out of scope>

## Components
| Component | Responsibility | Talks to |
| --- | --- | --- |

## How a request flows through it
<Mermaid flowchart or sequence diagram, ≤ 12 nodes>
<Numbered walkthrough of the diagram in text — one step per item>

## Key design decisions and why
### <Decision, phrased as a conclusion>
<Context → choice → consequence, in prose>

**Recap:** <one sentence; only if the section above is over ~250 words>

## Risks and limits
- <risk> — <impact> — <mitigation>

**Key takeaways:**
- …
````

---

## ADR (Architecture Decision Record)

````markdown
# ADR-<number>: <decision stated as a conclusion>

**Status:** Proposed | Accepted | Superseded by ADR-<n>

**Date:** YYYY-MM-DD

**Summary:** We will <decision> because <main reason>. The main trade-off is <cost>.

## Context
<The problem and the forces at play. One force per paragraph.>

## Options considered
| Option | Pros | Cons |
| --- | --- | --- |

## Decision
<What was chosen, in one paragraph.>

## Consequences
- **Positive:** …
- **Negative:** …
- **Follow-up work:** …
````

---

## RFC

````markdown
# RFC: <title>

**Summary:** <proposal in 2–3 sentences: what changes and why now>

**This covers:** 1) motivation 2) proposal 3) alternatives 4) rollout 5) risks 6) open questions

## Motivation
<Current pain, with a concrete example or numbers.>

## Proposal
### <Part 1, phrased as what it does>
<Explanation → example → consequence>

<Mermaid diagram if components interact>

**Recap:** <one sentence; only if the section above is over ~250 words>

## Alternatives considered
<Each alternative: what it is, why it was rejected — in prose.>

## Rollout and migration
1. …

## Risks
## Open questions
- [ ] …
````

---

## API documentation (per endpoint)

````markdown
## `POST /v1/orders` — create an order

**Summary:** Creates an order and reserves stock. Returns `201` with the order, or `409` if stock is insufficient.

### Request
| Field | Type | Required | Description |
| --- | --- | --- | --- |

```json
{ "sku": "ABC-123", "quantity": 2 }
```

### Responses
| Status | Meaning | When it happens |
| --- | --- | --- |

### Example
```bash
curl -X POST https://api.example.com/v1/orders -H "Content-Type: application/json" -d '{"sku":"ABC-123","quantity":2}'
```

### Things that commonly go wrong
- <symptom> → <cause> → <fix>
````

---

## Code review

````markdown
**Summary:** <overall verdict in 1–2 sentences: e.g. "Approve after fixing 2 blocking issues: a race in X and a missing auth check in Y.">

## Blocking
### 1. <issue as a conclusion> — `path/file.ext:42`
**What:** …

**Why it matters:** <explicit consequence: what breaks, when, for whom>

**Fix:**
```<lang>
<code>
```

## Should fix
## Nits (optional)
## What is good
<Brief; specific.>
````

Order issues by severity, not by file order. One issue per heading.

---

## Code explanation

````markdown
**Summary:** <what the code does, in one sentence, in domain terms>

## The big picture
<What problem it solves and where it is called from.>

## Walkthrough
### Step 1: <what this part achieves> (lines X–Y)
```<lang>
<unchanged code excerpt>
```
<Explanation: what → why → consequence.>

## Things that are not obvious
- <subtle behavior> — <why it happens>

**Key takeaways:**
````

---

## Infrastructure analysis

````markdown
**Summary:** <current state, main finding, recommended action>

## Current setup
<Mermaid diagram of the topology> + <text explanation>

## Findings
### <Finding as a conclusion>
**Evidence:** <metrics, configs, logs — quoted exactly>

**Impact:** <cost / risk / performance, explicit>

**Recommendation:** …

## Recommended changes, in order
1. …

## Risks of changing vs. not changing
````

---

## Implementation plan

````markdown
**Summary:** <goal, approach, rough size, main risk>

**This covers:** 1) scope 2) phases 3) risks 4) definition of done

## Scope
- **In:** …
- **Out:** …

## Phases
### Phase 1: <outcome, not activity>
- Tasks: …
- Depends on: …
- Done when: …

<Mermaid gantt or flowchart if dependencies are non-trivial>

## Risks
| Risk | Likelihood | Impact | Mitigation |
| --- | --- | --- | --- |

## Definition of done
- [ ] …

**Next steps:**
````
