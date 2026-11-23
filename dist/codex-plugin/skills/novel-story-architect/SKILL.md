---
name: novel-story-architect
description: Autonomous long-form fiction, web novel, and screenplay creation engine with Story Bible continuity compilation, scene beat sheets, and anti-AI-cliche prose refinement. Triggered automatically whenever the user asks to write, outline, edit, or continue a novel, story, fiction, or script.
---

# Novel & Story Architect (`novel-story-architect`)

This skill synthesizes the end-to-end web-novel and long-form fiction workflows of **`zenstory-ai/oh-story-claudecode`**, the continuity compiler and Story Bible contracts of **`danjdewhurst/story-skills`**, and the 5-stage narrative pipeline of **`MJbae/awesome-novel-studio`**.

## 1. Mandatory Automatic Activation Rule

Whenever the user requests writing, outlining, world-building, continuing, or polishing a **novel, short story, web fiction, light novel, or narrative script**, this skill activates automatically without requiring manual skill selection.

---

## 2. The 5-Stage Anti-Collapse Narrative Pipeline

Never draft a chapter directly from a 1-line prompt without anchoring to the story's structural state. Execute the following 5 stages proportionally to the task scope:

### Stage 1: Story Bible, Single-Source State Ledger & 3-Layer Knowledge Isolation (`.story-bible/`)
For any multi-chapter novel or ongoing story workspace, maintain or consult a lightweight, structured Story Bible directory (`.story-bible/` or `story-bible.md`) backed by a single-source state ledger (`_tracking-state.json` $\rightarrow$ `context.md` / `追踪/上下文.md`, capped at `<= 12 KiB` active working context):
- **`world-and-rules.md`**: Core premise, power/magic/technology rules, hard constraints, and socio-political factions.
- **`character-sheets.md`**: Name, role, core desire vs. hidden flaw, distinct speech cadence/idioms (so characters never sound identical), current location, inventory/status, and relationship matrix.
- **`timeline-and-foreshadowing.md`**: Chronological event log, active plot threads, planted clues (Chekhov's guns), and resolved payoffs.
- **3-Layer Epistemic Separation (Anti-Spoiling / Anti-Omniscience Rule)**: Strictly separate:
  1. **Author Truth (`作者真相`)**: Full hidden conspiracy, true identities, and future plot twists (stored only in author notes, never leaked into character dialogue prematurely).
  2. **Reader Known (`读者已知`)**: Dramatic irony and clues already revealed to the audience by chapter $N$.
  3. **Character Current Knowledge (`角色当下认知`)**: What the POV character actually knows right now in chapter $N$ (a character must never act on information they have not witnessed or deduced in-scene).

### Stage 2: Macro Arc & Pacing Design (`Design-Big`)
- Structure arcs using proven narrative tension curves (Hook $\rightarrow$ Inciting Incident $\rightarrow$ Rising Complications / Mini-Payoffs $\rightarrow$ Midpoint Reversal $\rightarrow$ All-Hope-Lost Crisis $\rightarrow$ Climax & Resolution).
- For serialized web fiction, enforce the **Golden 3-Chapter Rule** (immediate sensory hook, clear protagonist agency/conflict in Chapter 1, concrete world/system reveal in Chapter 2, first decisive reversal/cliffhanger by Chapter 3).

### Stage 3: Scene Beat Sheet (`Design-Small` — Mandatory Before Chapter Drafting)
Before writing full chapter prose, generate or verify a **Scene-by-Scene Beat Sheet** and lock the **Target Word-Count Range** (e.g., `2,500–3,500` chars per web-novel chapter):
- For each scene: **POV Character + Epistemic Boundary + Location/Time $\rightarrow$ Scene Goal $\rightarrow$ Active Conflict/Obstacle $\rightarrow$ Emotional Shift (Value Charge +/-) $\rightarrow$ Chapter Exit Hook (Cliffhanger or Unanswered Question)**.

### Stage 4: Sensory Prose Drafting with Deterministic `story-deslop` Filter (`Create`)
Write immersive, show-don't-tell prose while strictly enforcing the **Anti-AI Cliché & Deterministic `story-deslop` Blocking Rules**:
- **BANNED AI Clichés (Chinese)**: 严禁出现“嘴角勾起一抹不易察觉的弧度”、“眼神中闪过一丝复杂的神色”、“三分薄凉三分讥笑四分漫不经心”、“倒吸一口凉气”、“空气仿佛凝固了一般”、“心中五味杂陈”、“深吸一口气，仿佛做出了某种决定”等机械套话。
- **BANNED AI Clichés (English)**: Ban *"a testament to"*, *"a tapestry of"*, *"shivers down their spine"*, *"let out a breath they didn't know they were holding"*, *"eyes widened in shock"*, *"a symphony of"*, and repetitive summarizing endings (*"Little did they know..."*).
- **5 Deterministic `story-deslop` Blocking Lint Patterns (`oh-story-claudecode` v0.10.2)**:
  1. `em-dash`: Ban overuse of `——` / `—` dramatic pauses (max 1–2 per chapter).
  2. `not-is-comparison`: Ban mechanical *"这不是X，而是Y"* / *"It was not X, it was Y"* rhetorical contrast templates.
  3. `negation-parade`: Ban consecutive negative definitions (*"没有A，没有B，也没有C"*).
  4. `voice-contrast`: Ban formulaic *"声音很轻，却如惊雷般..."* cliches.
  5. `cliche-density-tic`: Keep somatic/physiological tics (pupils shrinking, knuckles whitening, cold sweat) below threshold.
- **Concrete Sensory Anchoring**: Replace abstract emotional labels ("he felt angry/sad") with concrete physical actions, dialogue subtext, environmental interaction, and rhythm variation (short punchy sentences during high-tension action; longer cadenced sentences during atmosphere building).

### Stage 5: Continuity Compiler & Voice Audit (`Polish`)
Before delivering any drafted chapter, run the **5-Point Continuity & Deslop Check**:
1. **Dead/Absent Character & Location Check**: Did any character speak or act who is not physically present in the scene or whose status in `character-sheets.md` conflicts?
2. **Epistemic Leak Check (`作者真相` vs `角色当下认知`)**: Did any character reference facts, motives, or secrets they could not possibly know yet?
3. **Timeline, Inventory & Word-Count Check**: Do time-of-day, injuries, items held, power levels, and chapter length match the beat sheet and previous chapter's end state?
4. **Voice Distinction & `story-deslop` Pass**: Cover the speaker tags—can you tell which character is speaking purely from their vocabulary, sentence length, and attitude? Are all 5 `story-deslop` blocking patterns clean?
5. **Update Ledger**: Sync any new character state changes, injuries, items gained/lost, or newly planted foreshadowing hooks back into `.story-bible/` (`_tracking-state.json` / `context.md`).
