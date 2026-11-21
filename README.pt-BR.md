# ADHD-Friendly Reading System (AFRS)

[English](README.md)

**Resumo:** o AFRS é um conjunto de instruções em Markdown, orientado por
pesquisas sobre TDAH e leitura, que faz o
ChatGPT, o Claude Code e o OpenAI Codex apresentarem respostas longas e técnicas
num formato mais fácil de acompanhar para pessoas com TDAH. Todos os detalhes
continuam lá. O que muda é a ordem, a divisão em blocos e a sinalização, não o
conteúdo. Você nunca precisa chamá-lo: ele liga sozinho. O núcleo é Markdown
puro; um plugin opcional adiciona um pequeno script de shell para que o formato
se mantenha em sessões longas.

**Neste texto:** 1) O que faz · 2) Instalação · 3) Uso e personalização ·
4) Arquivos · 5) Evidências e limites

> A skill e os arquivos de instrução estão em inglês de propósito, para que
> possam ser compartilhados com qualquer pessoa. **As respostas saem no idioma em
> que você escrever**, inclusive os rótulos (Resumo, A seguir, Recapitulando…).

---

## 1/5 — O que faz

Quando uma resposta é longa (cerca de 300 palavras ou mais) ou é um documento
técnico extenso (arquitetura, ADRs, RFCs, documentação de API, code reviews,
planos de implementação), o assistente vai:

- **Começar com um resumo curto** da ideia principal.
- **Usar parágrafos curtos**, com uma ideia cada, sob títulos que dizem a conclusão.
- **Escrever causa e consequência de forma explícita**, sem deixar para você deduzir.
- **Repetir valores onde eles são usados**, para você não precisar voltar no texto.
- **Numerar as seções de respostas longas** (`2/4`), para você se reencontrar depois de se distrair.
- **Transformar próximos passos em ações concretas do tipo "se… então…".**
- **Usar diagramas Mermaid** para fluxos e arquiteturas com 3 ou mais partes conectadas, sempre explicados também em texto.
- **Manter código, comandos e identificadores exatamente como estão.**
- **Manter um tom neutro, sem julgamentos.**

Respostas curtas continuam normais. O formato nunca corta conteúdo para resumir,
nunca infantiliza e nunca simula cores.

Veja os exemplos de antes/depois em [`examples/`](examples/).

---

## 2/5 — Instalação

Primeiro, baixe este repositório: <https://github.com/rikatz/adhd-friendly-reading-skill> (botão verde
**Code** → **Download ZIP**, ou `git clone https://github.com/rikatz/adhd-friendly-reading-skill.git`). Depois escolha a sua plataforma.

### Claude Code — opção A: plugin (recomendada)

Dentro do Claude Code, rode:

```text
/plugin marketplace add rikatz/adhd-friendly-reading-skill
/plugin install afrs@afrs
```

No Claude Code 2.1.275 ou mais recente também funciona em um passo só:
`/plugin install afrs --marketplace rikatz/adhd-friendly-reading-skill`.

O plugin inclui a skill e dois pequenos hooks:

- **No início da sessão** (e depois de `/clear` ou da compactação), ele carrega
  as regras do AFRS, a menos que o seu `CLAUDE.md` já as tenha.
- **A cada mensagem**, ele adiciona um lembrete de uma linha (cerca de 50
  tokens), para o formato não se perder em sessões longas.

Para desligar ou ligar em todas as sessões, use `/afrs:toggle off` e
`/afrs:toggle on`. Numa conversa específica, você ainda pode só dizer "AFRS off".

### Claude Code — opção B: manual, só Markdown

```bash
# 1. A skill (regras completas + modelos)
mkdir -p ~/.claude/skills
cp -r skills/adhd-friendly-reading ~/.claude/skills/

# 2. As regras sempre ativas (aplicam o formato automaticamente)
cat platforms/claude-code/CLAUDE.md >> ~/.claude/CLAUDE.md
```

Reinicie o Claude Code. Para testar, digite `/adhd-friendly-reading` ou pergunte
"Explique como funciona a resolução de DNS."

### OpenAI Codex

```bash
# 1. A skill
mkdir -p ~/.agents/skills
cp -r skills/adhd-friendly-reading ~/.agents/skills/

# 2. As regras sempre ativas
mkdir -p ~/.codex
cat platforms/codex/AGENTS.md >> ~/.codex/AGENTS.md
```

Reinicie o Codex. Para chamar a skill explicitamente, use `$adhd-friendly-reading`.

**Opcional: o hook de lembrete a cada mensagem no Codex.** Plugins do Codex só
levam hooks no app desktop, então, para o CLI, isto usa o seu arquivo pessoal de
hooks:

```bash
mkdir -p ~/.afrs
cp hooks/afrs.sh platforms/codex/AGENTS.md ~/.afrs/
cp platforms/codex/hooks/hooks.json ~/.codex/hooks.json   # se você já tiver um, junte as duas entradas de "hooks"
```

Depois rode `/hooks` no Codex (ou **Settings → Hooks** no app desktop) para
revisar e confiar nos dois hooks do AFRS: o Codex ignora hooks novos até você
confiar neles. Para desligar ou ligar o lembrete, use `sh ~/.afrs/afrs.sh off` e
`sh ~/.afrs/afrs.sh on`.

> **Rode o passo de anexar (`>>`) só uma vez.** Rodar duas vezes duplica o bloco.
>
> **Só para um projeto?** No Claude Code, coloque as regras em `CLAUDE.local.md`
> na raiz do projeto (pessoal e fora do commit) e a skill em `.claude/skills/`.
> No Codex, use `.agents/skills/` e `AGENTS.md`, mas lembre que o `AGENTS.md`
> costuma ir para o commit e ser compartilhado com a equipe; adicione-o a
> `.git/info/exclude` se for só para você.
>
> **Windows:** use o Git Bash ou o WSL com os mesmos comandos. No PowerShell,
> copie a pasta da skill para `$HOME\.claude\skills\` (ou `$HOME\.agents\skills\`)
> e anexe as regras com
> `Get-Content platforms\claude-code\CLAUDE.md | Add-Content -Encoding utf8 "$HOME\.claude\CLAUDE.md"`
> (no Windows PowerShell 5.1, `>>` grava em UTF-16 e corrompe o arquivo).
>
> **Prefere não contar à IA que tem TDAH?** Troque "The reader has ADHD." nas
> regras (no seu `CLAUDE.md`/`AGENTS.md`, ou em `platforms/claude-code/CLAUDE.md`
> antes de instalar o plugin a partir da sua própria cópia) por "The reader prefers formatting that is easy to track." Funciona do
> mesmo jeito.

### ChatGPT

Não precisa de terminal. Abra [`platforms/chatgpt/CHATGPT.md`](platforms/chatgpt/CHATGPT.md)
e escolha uma opção:

- **Instruções personalizadas** (todas as conversas; disponível em todos os planos): cole dois blocos curtos.
- **Instruções do projeto** (um projeto): cole um bloco.
- **Upload da skill** (planos com Skills): envie a pasta da skill compactada em zip.

---

## 3/5 — Uso e personalização

Você não precisa pedir o formato. Ele liga sozinho em respostas longas ou
complexas.

Para desligar qualquer recurso, basta pedir, em qualquer idioma:

| Diga | Efeito |
| --- | --- |
| "sem resumos" | Remove o resumo inicial |
| "sem recapitulações" | Remove recapitulações e pontos-chave |
| "sem numeração de seções" | Remove as marcações `2/4` |
| "sem diagramas" | Descreve a estrutura só em texto |
| "sem negrito" | Remove o negrito |
| "sem mapa" | Remove a linha "Neste texto" |
| "menos exemplos" | Exemplos só quando essenciais |
| "AFRS off" / "AFRS on" | Desliga ou liga o formato inteiro |

Para deixar uma preferência permanente, edite a linha `Preferences` no seu
`CLAUDE.md`, `AGENTS.md` ou nas instruções do projeto no ChatGPT (a versão curta
das instruções personalizadas não tem essa linha; basta dizer "sem
recapitulações" etc.). Por exemplo:

```text
summary: on | map: off | recaps: off | progress: on | diagrams: on | bold: on | examples: on
```

**O AFRS e a `i-have-adhd`:** a [`i-have-adhd`](https://github.com/ayghri/i-have-adhd)
foi uma inspiração para o AFRS. Ela deixa as respostas curtas e focadas na
próxima ação, o que funciona muito bem em tarefas rápidas. O AFRS cobre outro
momento: respostas longas e técnicas que precisam manter todos os detalhes. Como
as duas têm objetivos diferentes, usá-las ao mesmo tempo pode confundir o
assistente; escolha a que combina com o que você está fazendo, ou diga ao
assistente qual seguir.

---

## 4/5 — O que há no repositório

```text
afrs/
├── README.md                         documentação (inglês)
├── README.pt-BR.md                   este arquivo
├── .claude-plugin/                   manifestos do plugin e do marketplace (Claude Code)
├── hooks/                            hooks do plugin: hooks.json + afrs.sh (POSIX sh)
├── commands/toggle.md                /afrs:toggle on|off|status
├── skills/
│   └── adhd-friendly-reading/        a skill: a mesma pasta serve para as três plataformas
│       ├── SKILL.md                  regras completas
│       └── references/
│           ├── technical-templates.md   ADR, RFC, API, code review, planos…
│           ├── clinical-basis.md        modelos clínicos por trás de cada regra
│           └── sources.md               citações completas e créditos
├── platforms/
│   ├── claude-code/CLAUDE.md         regras sempre ativas para o Claude Code
│   ├── codex/AGENTS.md               regras sempre ativas para o Codex
│   ├── codex/hooks/hooks.json        hooks opcionais do Codex (arquivo pessoal de hooks)
│   └── chatgpt/CHATGPT.md            guia + textos para colar no ChatGPT
├── examples/                         comparações antes/depois
└── docs/
    ├── RESEARCH.md                   evidências, com fontes
    └── COMPATIBILITY.md              detalhes por plataforma, testes, limitações
```

---

## 5/5 — Evidências e limites

**Em resumo:** as regras se apoiam em pesquisas sobre como o TDAH afeta a
leitura, principalmente a memória de trabalho, o acompanhamento das ideias
principais, as inferências e a divagação mental. Também se apoiam em modelos
clínicos do TDAH (Barkley, Sonuga-Barke, o consenso da World Federation of ADHD)
e em diretrizes oficiais (W3C e a norma de linguagem simples ABNT NBR ISO 24495-1).
Nenhuma regra foi testada como intervenção com leitores com TDAH: as ligações
entre as pesquisas e as regras são, em sua maioria, indiretas.

Duas ideias populares ficaram **de fora** de propósito:

- **Bionic Reading** (negrito nas primeiras letras das palavras): testes
  independentes não encontraram efeito na velocidade de leitura.
- **Gradientes de cor no estilo BeeLine:** a evidência independente é fraca e
  mista e, de todo modo, as interfaces de chat de IA não exibem texto colorido.

O AFRS é um apoio à leitura, não um tratamento, e não afirma nenhum efeito
clínico. Pessoas com TDAH são diferentes entre si, por isso qualquer recurso pode
ser desligado.

Detalhes e fontes: [`docs/RESEARCH.md`](docs/RESEARCH.md) (em inglês). Detalhes
por plataforma e limitações: [`docs/COMPATIBILITY.md`](docs/COMPATIBILITY.md) (em inglês).

---

## Créditos e referências

O AFRS se apoia no trabalho dos pesquisadores, clínicos e órgãos de normatização
listados abaixo. Cada regra se inspira em pelo menos uma dessas fontes; a maioria
das ligações é indireta (nenhuma regra foi testada com leitores com TDAH).
Discussão completa (em inglês): [`docs/RESEARCH.md`](docs/RESEARCH.md).

### Declarações de consenso clínico

- Faraone, S. V., Banaschewski, T., Coghill, D., et al. (2021). The World Federation of ADHD International Consensus Statement: 208 evidence-based conclusions about the disorder. *Neuroscience & Biobehavioral Reviews*, 128, 789–818. <https://doi.org/10.1016/j.neubiorev.2021.01.022>
- Kooij, J. J. S., Bijlenga, D., Salerno, L., et al. (2019). Updated European Consensus Statement on diagnosis and treatment of adult ADHD. *European Psychiatry*, 56, 14–34. <https://pubmed.ncbi.nlm.nih.gov/30453134/>

### Modelos clínicos e neuropsicológicos do TDAH

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

### Intervenções com evidência de ensaios clínicos ou metanálises

- Safren, S. A., Sprich, S., Perlman, C. A. & Otto, M. W. (2017). *Mastering Your Adult ADHD: A Cognitive-Behavioral Treatment Program* (2nd ed.). Oxford University Press.
- Safren, S. A., Sprich, S., Mimiaga, M. J., et al. (2010). Cognitive behavioral therapy vs relaxation with educational support for medication-treated adults with ADHD and persistent symptoms: a randomized controlled trial. *JAMA*, 304(8), 875–880. <https://pmc.ncbi.nlm.nih.gov/articles/PMC3641654>
- Gawrilow, C. & Gollwitzer, P. M. (2008). Implementation intentions facilitate response inhibition in children with ADHD. *Cognitive Therapy and Research*, 32, 261–280. <https://doi.org/10.1007/s10608-007-9150-1>
- Gawrilow, C., Gollwitzer, P. M. & Oettingen, G. (2011). If-then plans benefit executive functions in children with ADHD. *Journal of Social and Clinical Psychology*, 30(6), 616–646.
- Cortese, S., Ferrin, M., Brandeis, D., et al. (2015). Cognitive training for ADHD: meta-analysis of clinical and neuropsychological outcomes from randomized controlled trials. *JAACAP*, 54(3), 164–174. <https://doi.org/10.1016/j.jaac.2014.12.010>
- Melby-Lervåg, M. & Hulme, C. (2013). Is working memory training effective? A meta-analytic review. *Developmental Psychology*, 49(2), 270–291. <https://pubmed.ncbi.nlm.nih.gov/22612437/>

### TDAH e compreensão de leitura

- Miller, A. C., Keenan, J. M., Betjemann, R. S., Willcutt, E. G., Pennington, B. F. & Olson, R. K. (2013). Reading comprehension in children with ADHD: cognitive underpinnings of the centrality deficit. *Journal of Abnormal Child Psychology*, 41(3), 473–483. <https://pmc.ncbi.nlm.nih.gov/articles/PMC3561476>
- Kofler, M. J., Spiegel, J. A., Soto, E. F., Irwin, L. N., Wells, E. L. & Austin, K. E. (2019). Do working memory deficits underlie reading problems in ADHD? *Journal of Abnormal Child Psychology*, 47(3), 433–446. <https://doi.org/10.1007/s10802-018-0447-1>
- Yeari, M., Vakil, E., Schifer, L. & Schiff, R. (2019). The origin of the centrality deficit in individuals with ADHD. *Journal of Clinical and Experimental Neuropsychology*, 41(1), 69–86. <https://sites.biu.ac.il/memory-and-amnesia-lab/page/1471>
- Yeari, M., Avramovich, A. & Schiff, R. (2017). Online inferential and textual processing by adolescents with ADHD during reading comprehension: evidence from a probing method. *Journal of Clinical and Experimental Neuropsychology*, 39(5), 485–501. <https://doi.org/10.1080/13803395.2016.1236906>
- Yeari, M. & Lavie, A. (2021). The role of surface text processing in centrality deficit and poor text comprehension of adolescents with ADHD: a think-aloud study. *Learning Disabilities Research & Practice*, 36(1), 40–55. <https://doi.org/10.1111/ldrp.12237>
- Moussaoui, S., Siddiqi, A. A., Cheung, T. C. K. & Niemeier, M. (2025). Reading without eye movements: improving reading comprehension in young adults with ADHD. *Journal of the International Neuropsychological Society*, 31(9–10), 731–742. <https://doi.org/10.1017/S1355617725101628>
- Otermans, P. C. J., Seon, J., Cooper, E. E., Roomi, A., Baines, S. & Aditya, D. (2025). How do adults with neurodevelopmental disorders prefer information being presented? *Educational Media International*. Advance online publication. <https://doi.org/10.1080/09523987.2025.2544118> <https://bura.brunel.ac.uk/bitstream/2438/32230/1/FullText.pdf>

### Ferramentas de leitura avaliadas (e por que algumas não foram adotadas)

- BeeLine Reader (Nick Lum e colegas): a ideia original de gradientes de cor que guiam a leitura entre linhas, e o ponto de partida deste projeto. Continua sendo uma boa opção, junto com o AFRS, para quem se dá bem com gradientes. <https://www.beelinereader.com/>
- Koornneef, A. & Kraal, A. (2022). Does BeeLine Reader's gradient-coloured font improve the readability of digital texts for beginning readers? *Computers in Human Behavior Reports*, 6, 100197. <https://doaj.org/article/b48617b6416f4030ae9bf57ab79d1318>
- Klein, B. (2014). Reading Bee-tween the Lines: BeeLine Reader and Spritz raise research questions. *The Psych Report*, republished by *Behavioral Scientist*. <https://behavioralscientist.org/speed-reading-apps-open-research-questions/>
- Snell, J. (2024). No, Bionic Reading does not work. *Acta Psychologica*, 247, 104304. <https://pubmed.ncbi.nlm.nih.gov/38723450/>
- Readwise (2022, teste da empresa, sem revisão por pares). Does Bionic Reading actually work? We timed over 2,000 readers. <https://blog.readwise.io/bionic-reading-results/>

### Ciência da aprendizagem

- Mayer, R. E. (2021). *Multimedia Learning* (3rd ed.). Cambridge University Press: segmenting, signaling and pre-training principles.
- Rey, G. D., Beege, M., Nebel, S., et al. (2019). A meta-analysis of the segmenting effect. *Educational Psychology Review*, 31, 389–419. <https://doi.org/10.1007/s10648-018-9456-4>
- Alpizar, D., Adesope, O. O. & Wong, R. M. (2020). A meta-analysis of signaling principle in multimedia learning environments. *Educational Technology Research and Development*, 68(5), 2095–2119. <https://doi.org/10.1007/s11423-020-09748-7>

### Normas e diretrizes

- W3C. WCAG 2.2, Understanding Success Criterion 1.4.8: Visual Presentation. <https://www.w3.org/WAI/WCAG22/Understanding/visual-presentation>
- W3C. Making Content Usable for People with Cognitive and Learning Disabilities (COGA), Working Group Note. <https://www.w3.org/TR/coga-usable/>
- ISO 24495-1:2023. Plain language — Part 1: Governing principles and guidelines. <https://www.iso.org/standard/78907.html>

### Trabalhos relacionados

- `i-have-adhd`, de ayghri: uma inspiração para este projeto. Ela deixa as respostas da IA curtas e focadas na próxima ação, com base em *The Adult ADHD Tool Kit*, de J. Russell Ramsay e Anthony L. Rostain. O AFRS parte dessa ideia para um caso que ela não pretende cobrir: respostas longas e técnicas que precisam manter toda a profundidade. <https://github.com/ayghri/i-have-adhd>
- Neurodivergent Insights (blog). Interest-based nervous system: observa que o modelo de Dodson vem da prática clínica, não de pesquisa. <https://neurodivergentinsights.com/interest-based-nervous-system/>
- O formato aberto Agent Skills, compatível com o Claude Code, o OpenAI Codex e o ChatGPT.

---

## Licença

MIT. Veja [LICENSE](LICENSE). Compartilhe com quem puder se beneficiar.
