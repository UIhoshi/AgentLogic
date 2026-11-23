---
name: screenplay-manga-director
description: Autonomous director for manga/webtoon panel scripts, short-video & micro-drama shooting scripts, and film/animation screenplays. Trigger automatically whenever creating, outlining, adapting, or polishing comic/manga scripts, vertical webtoon storyboards, Douyin/TikTok/Reels/Shorts scripts, micro-drama episode scripts, or screenplays.
---

# Screenplay, Manga-Script & Short-Video Director (`screenplay-manga-director`)

This skill governs **visual-narrative scripting** and AI drama/manga pre-production—translating ideas or novels into panel breakdowns, spatial blocking, asset-locked character sheets, multi-track shooting scripts, and model-ready prompts without character drift or plot holes.

For complete templates, 7-file serialized memory schemas, and review rubrics, see [production-checklists.md](references/production-checklists.md).

## 1. Mandatory Automatic Activation Rule

Automatically activate this skill (without waiting for the user to ask by skill name) whenever the task involves:
- **Manga / Comic / Webtoon Scripts (漫剧本 / 条漫分镜)**: Panel-by-panel adaptation, vertical scroll storyboards, or 9:16 hand-drawn/chibi shorts.
- **Short-Video & Micro-Drama Scripts (短视频 / 漫剧 / 微短剧台本)**: 15s–120s high-retention scripts, 0–3s hooks, and multi-track shooting tables.
- **Film / Animation Screenplays (影视 / 动画剧本)**: Standard `INT./EXT.` scenes, filmable action lines, and subtext dialogue.

*(Note: Pure long-form prose novels route to `novel-story-architect`; live image/video/music rendering hands off to `multimodal-media-director`.)*

---

## 2. Complexity Routing (`fast-track` vs `full-crew`)

- **Fast-Track (`1–2` scenes, no recurring cast, or quick single-short request)**: Go straight to the matching script mode (`Section 3`) + optional 6-part prompt compilation.
- **Full-Crew Pipeline (multi-episode micro-drama, serialized webtoon, or novel adaptation)**: Follow the **5-Document Episode Spine** (`剧本.md` $\rightarrow$ `视觉设定.md` $\rightarrow$ `开场站位/分镜.md` $\rightarrow$ `图片提示词.md` $\rightarrow$ `视频提示词.md`) and enforce the **6 Production Gates** in Section 4.

---

## 3. Three Visual-Scripting Modes

### Mode A: Manga & Webtoon Panel Scripting (`manga_webtoon_script`)
- **Rhythm**: Page manga averages `4–6` panels/page with page-turn cliffhangers; vertical webtoon (`条漫`) uses scroll gutters as time pauses and `1–2` focal beats per screen height.
- **Panel Breakdown Table**: `Panel # | Shot/Angle | Visual Action & Asset IDs (CHAR-xx / LOC-xx) | SFX | Dialogue/Caption`
- **Bubble Cap**: Max `2–3` bubbles per panel; `<= 25–35` English words or `15–25` Chinese characters per normal bubble.

### Mode B: Short-Video & Micro-Drama Shooting Scripts (`short_video_script`)
- **0–3s Golden Hook (黄金前 3 秒)**: Open *in media res* with a visual anomaly, high-stakes conflict, or counter-intuitive claim—never slow exposition.
- **Cadence & 9:16 Mobile Framing**: Target a visual cut or hook beat every `2–4s` (`15s–60s` shorts) and at least one reversal every `45–60s` episode (`微短剧`). For vertical 9:16 hand-drawn/chibi shorts, keep subject centered with upper/lower safe zones clear for UI/captions.
- **Multi-Track Audio-Visual Script Table**: `时间段 | 景别/运镜 | 画面动作与资产ID | 口播/台词 | 花字/字幕 | 音效/BGM卡点`

### Mode C: Film & Animation Screenplays (`screenplay`)
- Standard `INT./EXT. LOCATION — TIME OF DAY`, present-tense filmable action lines, and subtext dialogue. Translate inner emotion into observable props, lighting, and physical behavior (`visual_cause`), never unfilmable internal essays.

---

## 4. Six Battle-Tested Production Gates (Complex / Serialized Projects)

1. **Single-Root Character Anchor Sheet (`character-refs`)**: Generate ONE text-to-image root anchor per character (**Tier 1: Front Full-Body**). All derived views (**Tier 2 default**: Front Headshot + 90° Side + Back; **Tier 3 optional**: up to 8 detail crops) MUST reference ONLY the Tier 1 root anchor—never chain-reference derived views, so any bad render regenerates without cascading drift. Always include the Front Headshot so video models preserve facial likeness.
2. **Opening Spatial Staging / Blocking Before Storyboarding (`novel-staging`)**: Before writing Shot 1 of any scene, inventory concrete scene props/furniture (`4–20` items visible in the scene art) on a top-down floor plan, assign who is present/seated/standing/facing which side, and lock a verbatim **Opening Blocking Sentence** (including empty seats / absence of unnamed crowds). Shot 1 MUST copy that sentence verbatim so video models do not hallucinate extra people or swap outfits/seats.
3. **Asset-ID Reference Chain & Identity Invariants vs. State Variables (`muse-video` + `ManjuForge`)**: Assign stable IDs (`CHAR-xx`, `LOC-xx`, `PROP-xx`, `REF-xx` / `PLAN-xx`) referenced by ID across every downstream prompt instead of re-paraphrasing appearances. Split character memory into **Identity Invariants** (locked appearance, core personality, speech ticks) vs. **State Variables** (episode mood, outfit, injuries, held props, relationship stage) and maintain a **Foreshadow Engine** (`伏笔表.md`) for multi-episode arcs.
4. **Virtual Film-Crew Dual-Axis Subagent Squad (`muse-video` + Module 44/54)**: For complex productions, Lead `[11]` may dispatch specialist subagents (Writer, Art Director with explicit `visual_cause` lighting/palette rules, DP, VFX/Sound, and `independent-verifier` Reviewer) with `<= 2` review loops per stage, disjoint file ownership, and `max_depth = 1`.
5. **Independent Cross-Shot Review & Hook Protection (`short-drama-review`)**: Audit along the chain `Script -> Visual Assets -> Opening Staging -> Shot Start/End -> Keyframe Prompts -> Video Motion -> Edit Cuts` (checking 180° axis, sightlines, held props, and continuity locks) using `Blocker / Major / Minor / Note` (`REV-xxx`) issue cards. The reviewer never directly rewrites source drafts, prescribes minimal local patches only, and logs any accidentally trimmed hooks/punchlines under `## 被删的强钩子`.
6. **Downstream Visual & Video Handoff (`multimodal-media-director`)**: Branch reference images cleanly (`REF-...` when existing asset is ready, `PLAN-...` when pending generation, or explicit T2V). Compile downstream video prompts using the 6-part structure (Subject/Asset ID + Action/Physics + Scene/Blocking + Camera/Lens + Lighting/Style + Audio/Duration) and strip AI clichés (narrator info-dumps, repetitive transitions, flat talking heads).

---

## 5. Attribution
- Synthesizes MIT / Apache-2.0 / MIT-0 production workflows from: `zenstory-ai/drama-skills` (`MIT`), `eternityspring/shuohao-skills` (`Apache-2.0`), `LuoJiangYong/muse-video-skill` (`MIT`), `mengxiujie/ManjuForge` (`MIT-0`), and `kaomei/hand-drawn-video-prompts` (`MIT`).
