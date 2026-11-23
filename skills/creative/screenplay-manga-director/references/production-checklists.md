# Production Checklists & Templates (`screenplay-manga-director`)

Use these templates on-demand for serialized micro-dramas, manga/webtoon adaptations, and multi-shot AI video pre-production.

---

## 1. Five-Document Episode Spine (`drama-skills` — `MIT`)

For each episode (`EPxxx`), keep five concise Markdown deliverables without duplicate shadow JSON copies:
1. `剧本.md` — Scene headings, action, dialogue, beat timings, and emotional hooks (`EPxxx-SCxxx`).
2. `视觉设定.md` — Active `CHAR-xx`, `LOC-xx`, `PROP-xx`, voice/SFX tags, and `REF-xx` / `PLAN-xx` image slots.
3. `开场站位与分镜.md` — Top-down spatial blocking per scene + `SHOT-EPxxx-xxx` start/end state & camera specs.
4. `图片提示词.md` — Tier 1/2 character anchors, scene stills, and start/end keyframe prompts linked by Asset ID.
5. `视频提示词.md` — 6-part motion prompts, multi-shot container groups (when used), duration math, and audio/BGM cues.

**Reference-Image Branching Rule**:
- Existing approved image available $\rightarrow$ attach `REF-<ID>`.
- Image planned but not yet generated $\rightarrow$ write `PLAN-<ID>` and proceed without blocking unless user explicitly pauses for asset generation.
- Pure text-to-video shot $\rightarrow$ state `- 输入参考图：无 (T2V)`.

---

## 2. Opening Spatial Blocking Check (`novel-staging` — `Apache-2.0`)

Before writing Shot 1 of any new scene:
1. **Inventory Visible Props (`4–20` items)** strictly from the approved `LOC-xx` scene image/description.
2. **Project to Top-Down Floor Plan** (North / South / East / West / Center) so front/back depth never blurs.
3. **Assign Cast & Extras**: Map every speaking character and explicit extra to a real prop side, posture (`seated` / `standing`), and facing direction (no two people stacked on the exact same side unless scripted).
4. **Emit Verbatim Opening Blocking Sentence**: e.g., *"CHAR-01 sits on the north side of PROP-02 facing south; CHAR-02 stands at the east doorway facing west; remaining seats are empty with no extra bystanders."* Copy this sentence verbatim into Shot 1.

---

## 3. Seven-File Serialized Memory & Foreshadow Engine (`ManjuForge` — `MIT-0`)

For 10+ episode serials, separate **Identity Invariants** from **State Variables** across `.story-bible/`:
- `角色档案.md`: Split each character into **Locked Invariants** (facial structure, age/silhouette, core trait, speech pattern) vs. **Per-Episode State Variables** (current outfit ID, injury/prop held, emotion, relationship stage).
- `世界观.md` & `场景布局.md`: Rules, factions, top-down recurring set layouts.
- `剧情摘要.md`, `故事圣经.md` (refreshed every 5 episodes), and `角色关系图.md`.
- `伏笔表.md` (**Foreshadow Engine**):

| Foreshadow ID | Introduced Ep/Scene | Setup Detail | Intended Payoff Window | Status (`Open` / `Advanced` / `Paid Off`) | Notes |
| :--- | :--- | :--- | :--- | :--- | :--- |

---

## 4. Six-Role Virtual Film-Crew Subagent Cards (`muse-video-skill` — `MIT`)

When Lead `[11]` dispatches subagents in complex productions (keeping `max_depth = 1` and disjoint file ownership):
- **Writer (`implement` × `[11]`/`[6]`)**: Drafts scenes, dialogue, and `0–3s` hooks; never invents new Asset IDs outside `视觉设定.md`.
- **Art Director (`plan`/`implement` × `[5]`)**: Translates abstract mood tags into concrete `visual_cause` lighting, color palette, lens, and wardrobe tokens.
- **Director of Photography (`plan` × `[5]`/`[11]`)**: Designs camera blocking, 180° axis continuity, shot sizes, and transitions.
- **VFX & Sound Designer (`plan` × `[5]`)**: Specifies foley, SFX beat sync, BGM BPM/mood transitions, and subtitle/on-screen text timing.
- **Independent Reviewer (`review` × `independent-verifier`)**: Runs Section 5 rubric (`<= 2` loops/stage); outputs `REV-xxx` cards without editing drafts.

---

## 5. Independent Cross-Shot Review Rubric (`short-drama-review` — `MIT`)

Trace strictly in order: `剧本.md` $\rightarrow$ `视觉设定.md` $\rightarrow$ `开场站位` $\rightarrow$ `分镜起止帧` $\rightarrow$ `图片提示词` $\rightarrow$ `视频动态` $\rightarrow$ `剪辑切点`.

**Issue Card Format**:
```markdown
## <Blocker|Major|Minor|Note> · REV-001 · <Concise Title>
- 位置：<File / Scene / Shot ID>
- 证据：<Quoted upstream vs. downstream mismatch>
- 影响：<Axis flip / prop teleport / identity drift / missing hook>
- 修改要求：<Minimal local patch assigned to owning stage/skill>
- 规则：<structural_invariant | reviewed_invariant | craft_default>
```

**Mandatory Hook-Protection Section (`## 被删的强钩子`)**: Whenever comparing a revised cut/script against an earlier draft, list any accidentally removed opening hook, reversal punchline, or climax line with its original location so the creator decides whether to restore it.

---

## 6. Six-Part Downstream Video Prompt Structure (`muse-video-skill` — `MIT`)

Compile each video shot cleanly into six deterministic slots:
1. **Subject & Anchor (`CHAR-xx` / `REF-xx`)**: Identity invariants + current outfit state.
2. **Action & Physics**: Concrete verb + timing + secondary motion (cloth, hair, props).
3. **Scene & Opening Blocking (`LOC-xx`)**: Exact spatial placement and background exclusions.
4. **Camera & Motion**: Shot size, focal feel, camera move (`dolly-in`, `pan`, `locked`), and 180° gaze direction.
5. **Lighting, Color & Style (`visual_cause`)**: Key light angle, color temperature, film/anime/chibi medium.
6. **Audio & Duration**: Duration (`3s`–`10s`), dialogue/lip-sync or ambient SFX, BGM beat cue.
