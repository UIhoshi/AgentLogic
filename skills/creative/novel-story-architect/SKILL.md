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

### Stage 1: Story Bible & Continuity Ledger (`.story-bible/`)
For any multi-chapter novel or ongoing story workspace, maintain or consult a lightweight, structured Story Bible directory (`.story-bible/` or `story-bible.md`):
- **`world-and-rules.md`**: Core premise, power/magic/technology rules, hard constraints, and socio-political factions.
- **`character-sheets.md`**: Name, role, core desire vs. hidden flaw, distinct speech cadence/idioms (so characters never sound identical), current location, inventory/status, and relationship matrix.
- **`timeline-and-foreshadowing.md`**: Chronological event log, active plot threads, planted clues (Chekhov's guns), and resolved payoffs.

### Stage 2: Macro Arc & Pacing Design (`Design-Big`)
- Structure arcs using proven narrative tension curves (Hook $\rightarrow$ Inciting Incident $\rightarrow$ Rising Complications / Mini-Payoffs $\rightarrow$ Midpoint Reversal $\rightarrow$ All-Hope-Lost Crisis $\rightarrow$ Climax & Resolution).
- For serialized web fiction, enforce the **Golden 3-Chapter Rule** (immediate sensory hook, clear protagonist agency/conflict in Chapter 1, concrete world/system reveal in Chapter 2, first decisive reversal/cliffhanger by Chapter 3).

### Stage 3: Scene Beat Sheet (`Design-Small` — Mandatory Before Chapter Drafting)
Before writing full chapter prose, generate or verify a **Scene-by-Scene Beat Sheet**:
- For each scene: **POV Character + Location/Time $\rightarrow$ Scene Goal $\rightarrow$ Active Conflict/Obstacle $\rightarrow$ Emotional Shift (Value Charge +/-) $\rightarrow$ Chapter Exit Hook (Cliffhanger or Unanswered Question)**.

### Stage 4: Sensory Prose Drafting with Strict Anti-AI-Slop Filter (`Create`)
Write immersive, show-don't-tell prose while strictly enforcing the **Anti-AI Cliché & Translation-ese Ban List**:
- **BANNED AI Clichés (Chinese)**: 严禁出现“嘴角勾起一抹不易察觉的弧度”、“眼神中闪过一丝复杂的神色”、“三分薄凉三分讥笑四分漫不经心”、“倒吸一口凉气”、“空气仿佛凝固了一般”、“心中五味杂陈”、“深吸一口气，仿佛做出了某种决定”等机械套话。
- **BANNED AI Clichés (English)**: Ban *"a testament to"*, *"a tapestry of"*, *"shivers down their spine"*, *"let out a breath they didn't know they were holding"*, *"eyes widened in shock"*, *"a symphony of"*, and repetitive summarizing endings (*"Little did they know..."*).
- **Concrete Sensory Anchoring**: Replace abstract emotional labels ("he felt angry/sad") with concrete physical actions, dialogue subtext, environmental interaction, and rhythm variation (short punchy sentences during high-tension action; longer cadenced sentences during atmosphere building).

### Stage 5: Continuity Compiler & Voice Audit (`Polish`)
Before delivering any drafted chapter, run the **4-Point Continuity Check**:
1. **Dead/Absent Character & Location Check**: Did any character speak or act who is not physically present in the scene or whose status in `character-sheets.md` conflicts?
2. **Timeline & Inventory Check**: Do time-of-day, injuries, items held, and power levels match the end state of the previous chapter?
3. **Voice Distinction Test**: Cover the speaker tags—can you tell which character is speaking purely from their vocabulary, sentence length, and attitude?
4. **Update Ledger**: Sync any new character state changes, injuries, items gained/lost, or newly planted foreshadowing hooks back into `.story-bible/`.
