# ADHD-Friendly Reading System (AFRS)

[Português (Brasil)](README.pt-BR.md)

**Summary:** AFRS is a set of plain Markdown instructions,
informed by ADHD and reading research, that make ChatGPT,
Claude Code and OpenAI Codex present long and technical answers in a format that
is easier to follow for people with ADHD. It keeps every detail. It changes the
order, the chunking and the signposting, not the content. Nothing to run or
install besides copying text files.

**This covers:** 1) What it does · 2) Install · 3) Use and customize · 4) Files ·
5) Evidence and limits

---

## 1/5 — What it does

When an answer is long (roughly 300+ words) or is a long-form technical document
(architecture, ADRs, RFCs, API docs, code reviews, implementation plans), the
assistant will:

- **Start with a short summary** of the main point.
- **Use short paragraphs**, one idea each, under headings that state conclusions.
- **Write cause and effect explicitly** instead of leaving them to inference.
- **Restate values where they are needed**, so you never have to scroll back.
- **Number the sections of long answers** (`2/4`) so you can find your place after drifting.
- **Turn next steps into concrete if-then actions.**
- **Use Mermaid diagrams** for flows and architectures with 3+ connected parts, always explained in text too.
- **Keep code, commands and identifiers exactly as they are.**
- **Keep a neutral, non-judgmental tone.**

Short answers stay normal. It never summarizes away content, never
infantilizes, and never fakes colors.

See the before/after examples in [`examples/`](examples/).

---

## 2/5 — Install

First, download this repository (green **Code** button → **Download ZIP**, or
`git clone`). Then pick your platform.

### Claude Code

```bash
# 1. The skill (full rules + templates)
mkdir -p ~/.claude/skills
cp -r skills/adhd-friendly-reading ~/.claude/skills/

# 2. The always-on rules (applies the format automatically)
cat platforms/claude-code/CLAUDE.md >> ~/.claude/CLAUDE.md
```

Restart Claude Code. To check: type `/adhd-friendly-reading`, or ask "Explain how DNS resolution works."

### OpenAI Codex

```bash
# 1. The skill
mkdir -p ~/.agents/skills
cp -r skills/adhd-friendly-reading ~/.agents/skills/

# 2. The always-on rules
mkdir -p ~/.codex
cat platforms/codex/AGENTS.md >> ~/.codex/AGENTS.md
```

Restart Codex. Call the skill explicitly with `$adhd-friendly-reading`.

> **Run the append (`>>`) step only once.** Running it twice duplicates the block.
>
> **Only one project?** For Claude Code, put the rules in `CLAUDE.local.md` at the
> project root (personal and not committed) and the skill in `.claude/skills/`.
> For Codex, use `.agents/skills/` and `AGENTS.md`, but note that `AGENTS.md` is
> usually committed and shared with your team; add it to `.git/info/exclude` if it
> is only for you.
>
> **Windows:** use Git Bash or WSL with the same commands. In PowerShell, copy
> the skill folder to `$HOME\.claude\skills\` (or `$HOME\.agents\skills\`) and
> append the rules with
> `Get-Content platforms\claude-code\CLAUDE.md | Add-Content -Encoding utf8 "$HOME\.claude\CLAUDE.md"`
> (in Windows PowerShell 5.1, `>>` writes UTF-16 and corrupts the file).
>
> **Prefer not to tell the AI you have ADHD?** Replace "The reader has ADHD." in
> the rules with "The reader prefers formatting that is easy to track." It works
> the same.

### ChatGPT

No terminal needed. Open [`platforms/chatgpt/CHATGPT.md`](platforms/chatgpt/CHATGPT.md)
and choose one option:

- **Custom instructions** (every chat, available on all plans): paste two short blocks.
- **Project instructions** (one project): paste one block.
- **Skill upload** (plans with Skills): upload the zipped skill folder.

---

## 3/5 — Use and customize

You don't need to ask for the format. It turns on by itself for long or complex
answers.

**Switch any feature off by just saying so**, in any language:

| Say | Effect |
| --- | --- |
| "no summaries" | Removes the opening summary |
| "no recaps" | Removes mid-answer recaps and takeaways |
| "no section numbers" | Removes `2/4` markers |
| "no diagrams" | Describes structure in text only |
| "no bold" | Removes bold emphasis |
| "no map" | Removes the "This covers" line |
| "fewer examples" | Examples only when essential |
| "AFRS off" / "AFRS on" | Turns the whole format off or on |

To make a preference permanent, edit the `Preferences` line in your
`CLAUDE.md`, `AGENTS.md` or ChatGPT Project instructions (the short Custom
instructions version has no Preferences line; just say "no recaps" etc.), for
example:

```text
summary: on | map: off | recaps: off | progress: on | diagrams: on | bold: on | examples: on
```

**Using it alongside `i-have-adhd`:** that skill makes answers terse and
action-first, while AFRS keeps full depth. They are complementary but conflict
if both are on. Turn one off, or tell the assistant which one wins.

---

## 4/5 — What is in this repository

```text
afrs/
├── README.md                         this file (English)
├── README.pt-BR.md                   Portuguese (Brazil)
├── skills/
│   └── adhd-friendly-reading/        the skill: same folder for all platforms
│       ├── SKILL.md                  full rules
│       └── references/
│           ├── technical-templates.md   ADR, RFC, API, code review, plans…
│           ├── clinical-basis.md        clinical models behind each rule
│           └── sources.md               full citations and credits
├── platforms/
│   ├── claude-code/CLAUDE.md         always-on rules for Claude Code
│   ├── codex/AGENTS.md               always-on rules for Codex
│   └── chatgpt/CHATGPT.md            setup guide + text to paste in ChatGPT
├── examples/                         before/after comparisons
└── docs/
    ├── RESEARCH.md                   evidence, with sources
    └── COMPATIBILITY.md              platform details, tests, limitations
```

---

## 5/5 — Evidence and limits

**The short version:** the rules are informed by research into how ADHD affects
reading, especially working memory, keeping track of main ideas, inferences and
mind wandering. They also draw on clinical models of ADHD (Barkley, Sonuga-Barke,
the World Federation of ADHD consensus) and on official guidelines (W3C, ISO
plain language).

No rule has been tested as an intervention with ADHD readers, so most links
between the research and the rules are indirect.

Two popular ideas are deliberately **not** used:

- **Bionic Reading** (bolding the first letters of words): independent tests
  found no effect on reading speed.
- **BeeLine-style color gradients:** independent evidence is weak and mixed, and
  AI chat interfaces cannot render colored text anyway.

AFRS is a readability aid, not a treatment, and makes no clinical claims. People
with ADHD differ, so every feature can be switched off.

Details and sources: [`docs/RESEARCH.md`](docs/RESEARCH.md). Platform details
and known limitations: [`docs/COMPATIBILITY.md`](docs/COMPATIBILITY.md).

---

## Credits and references

AFRS stands on the work of the researchers, clinicians and standards bodies
below. Each rule is informed by at least one of these sources; most links are
indirect (no rule has been tested with ADHD readers). Full discussion:
[`docs/RESEARCH.md`](docs/RESEARCH.md).

### Clinical consensus statements

- Faraone, S. V., Banaschewski, T., Coghill, D., et al. (2021). The World Federation of ADHD International Consensus Statement: 208 evidence-based conclusions about the disorder. *Neuroscience & Biobehavioral Reviews*, 128, 789–818. <https://doi.org/10.1016/j.neubiorev.2021.01.022>
- Kooij, J. J. S., Bijlenga, D., Salerno, L., et al. (2019). Updated European Consensus Statement on diagnosis and treatment of adult ADHD. *European Psychiatry*, 56, 14–34. <https://pubmed.ncbi.nlm.nih.gov/30453134/>

### Clinical and neuropsychological models of ADHD

- Barkley, R. A. (1997). Behavioral inhibition, sustained attention, and executive functions: constructing a unifying theory of ADHD. *Psychological Bulletin*, 121(1), 65–94.
- Sonuga-Barke, E. J. S. (2003). The dual pathway model of AD/HD: an elaboration of neuro-developmental characteristics. *Neuroscience & Biobehavioral Reviews*, 27(7), 593–604. <https://eprints.soton.ac.uk/18285/>
- Sonuga-Barke, E. J. S. & Castellanos, F. X. (2007). Spontaneous attentional fluctuations in impaired states and pathological conditions: a neurobiological hypothesis (default-mode interference hypothesis). *Neuroscience & Biobehavioral Reviews*, 31(7), 977–986. <https://doi.org/10.1016/j.neubiorev.2007.02.005>
- Bozhilova, N. S., Michelini, G., Kuntsi, J. & Asherson, P. (2018). Mind wandering perspective on attention-deficit/hyperactivity disorder. *Neuroscience & Biobehavioral Reviews*, 92, 464–476. <https://pmc.ncbi.nlm.nih.gov/articles/PMC6525148>
- Norman, L. J., Sudre, G., Price, J., Shastri, G. G. & Shaw, P. (2023). Evidence from "big data" for the default-mode hypothesis of ADHD: a mega-analysis of multiple large samples. *Neuropsychopharmacology*, 48(2), 281–289. <https://pmc.ncbi.nlm.nih.gov/articles/PMC9751118>
- Liu, L., Chen, D., Huang, F., et al. (2024). Interference of default mode on attention networks in adults with ADHD and its association with genetic variants and treatment outcomes. *CNS Neuroscience & Therapeutics*, 30(8), e14900. <https://doi.org/10.1111/cns.14900>
- Zheng, Q., Wang, X., Chiu, K. Y. & Shum, K. K. (2022). Time perception deficits in children and adolescents with ADHD: a meta-analysis. *Journal of Attention Disorders*, 26(2), 267–281. <https://hub.hku.hk/handle/10722/309307>
- Marx, I., Cortese, S., Kölch, M. & Hacker, T. (2022). Meta-analysis: altered perceptual timing abilities in ADHD. *Journal of the American Academy of Child & Adolescent Psychiatry*, 61(7), 866–880. <https://doi.org/10.1016/j.jaac.2021.12.004>
- Shaw, P., Stringaris, A., Nigg, J. & Leibenluft, E. (2014). Emotion dysregulation in attention deficit hyperactivity disorder. *American Journal of Psychiatry*, 171(3), 276–293.
- Faraone, S. V., Rostain, A. L., Blader, J., et al. (2019). Practitioner Review: Emotional dysregulation in ADHD — implications for clinical recognition and intervention. *Journal of Child Psychology and Psychiatry*, 60(2), 133–150. <https://doi.org/10.1111/jcpp.12899>
- Beheshti, A., Chavanon, M.-L. & Christiansen, H. (2020). Emotion dysregulation in adults with ADHD: a meta-analysis. *BMC Psychiatry*, 20, 120. <https://pmc.ncbi.nlm.nih.gov/articles/PMC7069054>
- Soler-Gutiérrez, A. M., Pérez-González, J. C. & Mayas, J. (2023). Evidence of emotion dysregulation as a core symptom of adult ADHD: a systematic review. *PLOS ONE*, 18(1), e0280131. <https://pmc.ncbi.nlm.nih.gov/articles/PMC9821724/>

### Interventions with trial or meta-analytic evidence

- Safren, S. A., Sprich, S., Perlman, C. A. & Otto, M. W. (2017). *Mastering Your Adult ADHD: A Cognitive-Behavioral Treatment Program* (2nd ed.). Oxford University Press.
- Safren, S. A., Sprich, S., Mimiaga, M. J., et al. (2010). Cognitive behavioral therapy vs relaxation with educational support for medication-treated adults with ADHD and persistent symptoms: a randomized controlled trial. *JAMA*, 304(8), 875–880. <https://pmc.ncbi.nlm.nih.gov/articles/PMC3641654>
- Gawrilow, C. & Gollwitzer, P. M. (2008). Implementation intentions facilitate response inhibition in children with ADHD. *Cognitive Therapy and Research*, 32, 261–280. <https://doi.org/10.1007/s10608-007-9150-1>
- Gawrilow, C., Gollwitzer, P. M. & Oettingen, G. (2011). If-then plans benefit executive functions in children with ADHD. *Journal of Social and Clinical Psychology*, 30(6), 616–646.
- Cortese, S., Ferrin, M., Brandeis, D., et al. (2015). Cognitive training for ADHD: meta-analysis of clinical and neuropsychological outcomes from randomized controlled trials. *JAACAP*, 54(3), 164–174. <https://doi.org/10.1016/j.jaac.2014.12.010>
- Melby-Lervåg, M. & Hulme, C. (2013). Is working memory training effective? A meta-analytic review. *Developmental Psychology*, 49(2), 270–291. <https://pubmed.ncbi.nlm.nih.gov/22612437/>

### ADHD and reading comprehension

- Miller, A. C., Keenan, J. M., Betjemann, R. S., Willcutt, E. G., Pennington, B. F. & Olson, R. K. (2013). Reading comprehension in children with ADHD: cognitive underpinnings of the centrality deficit. *Journal of Abnormal Child Psychology*, 41(3), 473–483. <https://pmc.ncbi.nlm.nih.gov/articles/PMC3561476>
- Kofler, M. J., Spiegel, J. A., Soto, E. F., Irwin, L. N., Wells, E. L. & Austin, K. E. (2019). Do working memory deficits underlie reading problems in ADHD? *Journal of Abnormal Child Psychology*, 47(3), 433–446. <https://doi.org/10.1007/s10802-018-0447-1>
- Yeari, M., Vakil, E., Schifer, L. & Schiff, R. (2019). The origin of the centrality deficit in individuals with ADHD. *Journal of Clinical and Experimental Neuropsychology*, 41(1), 69–86. <https://sites.biu.ac.il/memory-and-amnesia-lab/page/1471>
- Yeari, M., Avramovich, A. & Schiff, R. (2017). Online inferential and textual processing by adolescents with ADHD during reading comprehension: evidence from a probing method. *Journal of Clinical and Experimental Neuropsychology*, 39(5), 485–501. <https://doi.org/10.1080/13803395.2016.1236906>
- Yeari, M. & Lavie, A. (2021). The role of surface text processing in centrality deficit and poor text comprehension of adolescents with ADHD: a think-aloud study. *Learning Disabilities Research & Practice*, 36(1), 40–55. <https://doi.org/10.1111/ldrp.12237>
- Moussaoui, S., Siddiqi, A. A., Cheung, T. C. K. & Niemeier, M. (2025). Reading without eye movements: improving reading comprehension in young adults with ADHD. *Journal of the International Neuropsychological Society*, 31(9–10), 731–742. <https://doi.org/10.1017/S1355617725101628>
- Otermans, P. C. J., Seon, J., Cooper, E. E., Roomi, A., Baines, S. & Aditya, D. (2025). How do adults with neurodevelopmental disorders prefer information being presented? *Educational Media International*. Advance online publication. <https://doi.org/10.1080/09523987.2025.2544118> <https://bura.brunel.ac.uk/bitstream/2438/32230/1/FullText.pdf>

### Reading aids evaluated (and why some were not adopted)

- BeeLine Reader (Nick Lum and colleagues): the original idea of line-guiding color gradients that inspired this project. <https://www.beelinereader.com/>
- Koornneef, A. & Kraal, A. (2022). Does BeeLine Reader's gradient-coloured font improve the readability of digital texts for beginning readers? *Computers in Human Behavior Reports*, 6, 100197. <https://doaj.org/article/b48617b6416f4030ae9bf57ab79d1318>
- Klein, B. (2014). Reading Bee-tween the Lines: BeeLine Reader and Spritz raise research questions. *The Psych Report*, republished by *Behavioral Scientist*. <https://behavioralscientist.org/speed-reading-apps-open-research-questions/>
- Snell, J. (2024). No, Bionic Reading does not work. *Acta Psychologica*, 247, 104304. <https://pubmed.ncbi.nlm.nih.gov/38723450/>
- Readwise (2022, company test, not peer-reviewed). Does Bionic Reading actually work? We timed over 2,000 readers. <https://blog.readwise.io/bionic-reading-results/>

### Learning science

- Mayer, R. E. (2021). *Multimedia Learning* (3rd ed.). Cambridge University Press: segmenting, signaling and pre-training principles.
- Rey, G. D., Beege, M., Nebel, S., et al. (2019). A meta-analysis of the segmenting effect. *Educational Psychology Review*, 31, 389–419. <https://doi.org/10.1007/s10648-018-9456-4>
- Alpizar, D., Adesope, O. O. & Wong, R. M. (2020). A meta-analysis of signaling principle in multimedia learning environments. *Educational Technology Research and Development*, 68(5), 2095–2119. <https://doi.org/10.1007/s11423-020-09748-7>

### Standards and guidelines

- W3C. WCAG 2.2, Understanding Success Criterion 1.4.8: Visual Presentation. <https://www.w3.org/WAI/WCAG22/Understanding/visual-presentation>
- W3C. Making Content Usable for People with Cognitive and Learning Disabilities (COGA), Working Group Note. <https://www.w3.org/TR/coga-usable/>
- ISO 24495-1:2023. Plain language — Part 1: Governing principles and guidelines. <https://www.iso.org/standard/78907.html>

### Related work

- `i-have-adhd` skill by ayghri, loosely based on *The Adult ADHD Tool Kit* by J. Russell Ramsay and Anthony L. Rostain. A complementary approach that favors terse, action-first answers. <https://github.com/ayghri/i-have-adhd>
- Neurodivergent Insights (blog). Interest-based nervous system: notes that Dodson's framework comes from clinical practice rather than research. <https://neurodivergentinsights.com/interest-based-nervous-system/>
- The open Agent Skills format, supported by Claude Code, OpenAI Codex and ChatGPT.

---

## License

MIT. See [LICENSE](LICENSE). Share it with anyone it might help.
