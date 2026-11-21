# Research basis

**Summary:** AFRS draws on what the evidence supports best: structuring
*content* (summary first, chunking, explicit links between ideas, recaps) to
reduce working-memory load. Color gradients in the style of BeeLine Reader have
weak and mixed independent evidence, and Markdown cannot render them in AI chat
interfaces anyway, so AFRS does not use them. Nothing here is a clinical claim.

**This covers:** 1) BeeLine Reader 2) Bionic Reading 3) what is known about ADHD
and reading, plus clinical models of ADHD 4) learning-science principles
5) official guidelines 6) how each AFRS rule maps to the evidence 7) limits of
this evidence

Last reviewed: November 2026.

---

## 1. BeeLine Reader: the theory and the evidence

### The theory

BeeLine colors each line of text with a gradient (for example dark → blue on one
line, blue → dark on the next). The end of one line and the start of the next
share a color, which is meant to guide the eye during the "return sweep" to the
next line and reduce losing your place.

### What the evidence says

- **Company and partner data:** BeeLine reports internal tests and an A/B test
  run by CNET in which readers with the gradient were more likely to finish
  articles (reported on BeeLine's own website). These were not independent,
  peer-reviewed trials.
- **Early commentary:** a 2014 magazine article by Brennan Klein (first
  published in *The Psych Report*, republished by *Behavioral Scientist*) noted
  the company's early findings, including possible benefits for readers with ADD
  and dyslexia, and stressed that independent study was still needed and that
  expectation (placebo) effects were a possible explanation.
- **Independent peer-reviewed study (Koornneef & Kraal, 2022):** two
  experiments with children aged 6–9.
  - Second graders read faster with BeeLine **only** in a poor layout (long
    lines, tight spacing).
  - In an optimized layout (short lines, good spacing), second graders read
    **more slowly** with BeeLine.
  - Third graders' comprehension may have been hampered, and they rated BeeLine
    texts as harder and less convenient.
  - The authors conclude that the visual anchors may help some readers in some
    situations, but can also impair readability.
- **No independent study with adults with ADHD** was found.

### Conclusion for AFRS

The gradient is a plausible aid for line tracking, mainly when layout is poor.
It is not a substitute for good structure, and its benefit is individual. AFRS
does not include it because:

1. ChatGPT, Claude and Codex interfaces do not render colored text from Markdown.
2. Faking it with HTML or emoji produces clutter.
3. The stronger evidence points to layout and content structure.

People who personally find gradients helpful can use a dedicated reader tool on
top of any AI interface. AFRS is compatible with that.

---

## 2. Bionic Reading (bolding the first letters of words)

- A 2024 study in *Acta Psychologica* ("No, Bionic Reading does not work")
  compared reading times for 100 paragraphs and found no significant
  difference.
- Readwise, a reading-app company, ran a non-peer-reviewed test in 2022 with
  2,074 readers (1,916 analysed): reading was 0.8% slower with Bionic Reading, a
  difference that was not statistically significant.

**AFRS explicitly forbids this pattern.**

---

## 3. What is known about ADHD and reading

The findings below come from studies of groups. They describe tendencies, not
every individual.

| Finding | Source | AFRS response |
| --- | --- | --- |
| Children with ADHD show their largest deficit in recalling **central** ideas (a "centrality deficit"); working memory accounted for the most unique variance | Miller et al., 2013 (PMC3561476) | Summary first; main point marked; recaps |
| Adding working-memory demands reduced comprehension much more for children with ADHD than for peers | Kofler et al., 2019, *J. Abnormal Child Psychology* | One idea per paragraph; short paragraphs; chunking |
| University students with ADHD had specific difficulty **retrieving** central ideas, consistent with fewer connections being built between text ideas | Yeari, Vakil, Schifer & Schiff, 2019, *J. Clin. Exp. Neuropsychology* | Explicit links back to earlier ideas; recaps |
| Adolescents with ADHD showed weaker online generation of predictive and bridging **inferences** and kept less relevant text active in working memory while reading | Yeari, Avramovich & Schiff, 2017, *J. Clin. Exp. Neuropsychology* | Cause → effect written out, never implied |
| During reading, participants with ADHD reinstated fewer earlier ideas, especially central ones | Yeari & Lavie, 2021, *Learning Disabilities Research & Practice* (think-aloud) | "Recap" lines and explicit references back |
| Reducing the need for eye movements (one word at a time, RSVP) improved comprehension in young adults with ADHD but not in controls | Moussaoui et al., 2025, *J. Int. Neuropsychological Society* (preliminary: 38 vs 38 students, tested online) | Supports the idea that tracking/eye-movement load matters; out of AFRS scope (needs a reader tool), noted for future work |
| Adults with ADHD, autism, dyslexia, dyscalculia and dyspraxia showed consistent formatting preferences across groups | Otermans et al., 2025, *Educational Media International* (204 adults; background-colour preferences did differ) | Supports configurable, conventional formatting |

---

## 3b. Clinical models of ADHD and what they imply for text

Most are models and consensus statements published by leading ADHD
researchers and clinicians in peer-reviewed journals; the last subsection
covers a popular framework that has not been tested. They explain *why* reading long text is costly, and they
point to compensations that a writer can build into the text.

### Consensus statements (the strongest base)

- **World Federation of ADHD International Consensus Statement (Faraone et al.,
  2021):** 208 conclusions drawn only from large studies and meta-analyses,
  endorsed by 366 signatories. It establishes ADHD as valid and heterogeneous.
  → No single format fits everyone: every AFRS feature can be switched off.
- **Updated European Consensus Statement on adult ADHD (Kooij et al., 2019):**
  63 experts. Adult ADHD is often lifelong and is treated with a combination of
  psychoeducation, CBT and medication, tailored to the person.
  → Write for capable adults; do not infantilize.

### Explanatory models

- **Executive function / self-regulation model (Russell Barkley, 1997 and later):**
  ADHD impairs the *use* of knowledge at the moment it is needed, including
  working memory. Barkley's clinical advice is to put information at the
  "point of performance" instead of relying on memory.
  → AFRS rule: restate values and decisions where they are used; never "see above".
- **Dual pathway model (Edmund Sonuga-Barke):** two partly separate routes,
  executive dysfunction and **delay aversion** (a motivational style that avoids
  waiting for outcomes). Studies support the dissociation, with variation
  between individuals.
  → AFRS rule: payoff first, at the level of the response and of each section.
- **Default-mode interference hypothesis (Sonuga-Barke & Castellanos, 2007):**
  the brain network for internal thought fails to switch off fully during tasks,
  producing spontaneous mind wandering. It is supported by a mind-wandering
  account of ADHD (Bozhilova, Michelini, Kuntsi & Asherson, 2018), a
  mega-analysis of large neuroimaging samples (Norman et al., 2023, which found
  small effects), and a study in adults (Liu et al., 2024). Overall: partially
  supported, with small effects.
  → AFRS rule: assume drift; make text resumable with landmarks and section numbers.
- **Timing deficits:** meta-analyses show consistent time-perception
  impairments (Zheng et al., 2022; Marx et al., 2022).
  → AFRS rule: explicit sequence; grounded duration estimates; mark urgency.
- **Emotional dysregulation:** increasingly considered a core feature of adult
  ADHD (Shaw et al., 2014; Faraone et al., 2019; meta-analysis by Beheshti et
  al., 2020; systematic review by Soler-Gutiérrez et al., 2023).
  → AFRS rule: neutral, non-judgmental tone, especially in reviews and error reports.

### Interventions with trial evidence

- **CBT for adult ADHD (Safren et al., *JAMA*, 2010):** a randomized trial in 86
  medication-treated adults showed CBT beat an attention-matched control. Its
  core modules are organizing and planning, coping with distractibility, and
  adaptive thinking (described in the therapy manual, Safren et al., *Mastering
  Your Adult ADHD*, Oxford University Press).
  → By analogy: break tasks into steps; give long answers a visible outline.
- **Implementation intentions / if-then plans (Gollwitzer; Gawrilow &
  Gollwitzer, 2008; Gawrilow, Gollwitzer & Oettingen, 2011):** children with ADHD
  improved response inhibition, task shifting and delay of gratification when
  they formed "If X, then I will Y" plans.
  → AFRS rule, by analogy: next steps as concrete if-then actions. (In the
  studies, children formed their own plans; AFRS writes the plan for the reader.)
- **Working-memory training (Cortese et al., 2015, European ADHD Guidelines
  Group; Melby-Lervåg & Hulme, 2013):** it improves the trained tasks but transfers
  little to symptoms or daily function under blinded assessment.
  → AFRS principle: reduce the load in the text; do not expect the reader to
  hold more.

### Popular but weakly supported

- **"Interest-based nervous system" (William Dodson):** a clinical framework
  (interest, challenge, novelty, urgency) that many people with ADHD recognize,
  but it comes from clinical observation, not controlled research. AFRS only
  uses its safe implication: tie content to the reader's goal. It adds no
  gimmicks.

---

## 4. Learning-science principles

- **Segmenting:** a meta-analysis of 56 investigations found small-to-medium
  benefits for retention and transfer when material is split into segments
  (Rey et al., *Educational Psychology Review*, 2019). The studies used
  learner-paced segments of multimedia lessons; AFRS applies the idea to text by
  analogy. → Chunking, headings.
- **Signaling:** a meta-analysis of 29 studies found a positive overall effect of
  cues that point to essential information (d = 0.38; Alpizar, Adesope & Wong,
  2020), with results varying by study. → AFRS uses signals (headings, labels,
  bold) but keeps them for what is essential; the "sparing" limit is a design
  choice, not a tested finding.
- **Pre-training** (explain key concepts before the main content) is one of
  Mayer's principles for managing essential processing. → "Explain the concept
  before the jargon."

---

## 5. Official guidelines

- **WCAG 2.2, SC 1.4.8 Visual Presentation (Level AAA):** line width of at most
  80 characters, no justified text, line spacing of at least 1.5, paragraph
  spacing at least 1.5 times the line spacing, user-selectable colors, and text
  that can be resized to 200% without horizontal scrolling. These are mostly
  controlled by the interface, not by the AI's text. AFRS supports them indirectly
  with short paragraphs and narrow tables.
- **W3C COGA, *Making Content Usable for People with Cognitive and Learning
  Disabilities*** (a W3C Working Group Note, i.e. guidance rather than a
  standard): covers neurodiversity explicitly. Relevant patterns: use clear
  content, help users focus, do not rely on memory, use familiar conventions.
- **ISO 24495-1:2023, Plain language:** four principles — readers get what they
  need (relevant), can find it (findable), can understand it, and can use it.
  It applies to technical writing too. AFRS's summary-first structure and
  headings serve "findable"; explicit links serve "understandable".

---

## 6. How each AFRS rule maps to the evidence

No AFRS rule has been tested as an intervention with ADHD readers. The last
column rates the evidence for the difficulty or principle each rule responds
to, not the rule's effect.

| AFRS rule | Main basis | Evidence for the underlying finding |
| --- | --- | --- |
| Summary first | Centrality deficit; plain language "findable" | Moderate |
| One idea per paragraph, chunking | Working memory findings; segmenting meta-analysis | Moderate for general learners; segmenting was tested on learner-paced multimedia lessons, not text |
| Explicit cause → effect | Inference difficulties in ADHD | Moderate |
| Recaps and explicit references back | Fewer reinstatements of central ideas | Moderate (indirect) |
| Concept before jargon | Pre-training principle | Moderate (general learners) |
| Sparing bold | Signaling meta-analysis (positive overall); restraint is a design choice | Moderate for signaling; restraint untested |
| Diagrams + text explanation | Multimedia principle; accessibility (COGA) | Moderate (general learners) |
| No color gradients | Weak/mixed BeeLine evidence; not renderable | — |
| No bionic bolding | Null results | Good (null effect) |
| Individual on/off switches | Individual variation; WFADHD consensus; COGA | Principle, not effect size |
| Restate at point of use | Barkley's executive-function model; working-memory training does not transfer | Moderate (theory + meta-analyses) |
| Payoff first per section | Delay aversion (dual pathway model) | Moderate (indirect) |
| Section numbering, resumable sections | Default-mode interference / mind wandering | Partial support, small effects (indirect) |
| If-then next steps | Implementation-intention experiments in ADHD | Indirect (children formed their own plans; AFRS writes the plan for the reader) |
| Neutral tone | Emotional dysregulation research | Moderate (indirect) |

---

## 7. Limits of this evidence

- Most ADHD reading studies involve children or adolescents; adult and
  professional-reading evidence is thinner.
- None of these studies tested AI-generated responses specifically.
- Effects are averages. A rule that helps the group can be neutral or unhelpful
  for a given person. That is why every AFRS feature can be switched off.

**Recommendation for users:** try AFRS for a week on real work, then turn
individual features off and notice what you miss. Your own experience is the
evidence that matters most for you.

---

## Sources

Full citations, with links, are kept in one place:
[`skills/adhd-friendly-reading/references/sources.md`](../skills/adhd-friendly-reading/references/sources.md).
