---
name: screenplay-manga-director
description: Autonomous director for manga/webtoon panel scripts, short-video & micro-drama shooting scripts, and film/animation screenplays. Trigger automatically whenever creating, outlining, adapting, or polishing comic/manga scripts, vertical webtoon storyboards, Douyin/TikTok/Reels/Shorts scripts, micro-drama episode scripts, or screenplays.
---

# Screenplay, Manga-Script & Short-Video Director (`screenplay-manga-director`)

This skill governs **visual-narrative scripting**—where every beat must translate cleanly into camera shots, comic panels, audio/SFX cues, and retention hooks rather than prose paragraphs.

## 1. Mandatory Automatic Activation Rule

Automatically activate this skill (without waiting for the user to ask by skill name) whenever the task involves:
- **Manga / Comic / Webtoon Scripts (漫剧本 / 条漫分镜脚本)**: Panel-by-panel adaptation or original comic episodes.
- **Short-Video & Micro-Drama Scripts (短视频 / 漫剧 / 微短剧台本)**: 15s–120s high-retention vertical/horizontal scripts, hooks, and multi-track shooting boards.
- **Film / Animation Screenplays (影视 / 动画剧本)**: Standard scene headings (`INT./EXT.`), filmable action lines, and subtext-driven dialogue.

*(Note: For pure long-form prose novels, route to `novel-story-architect`; for rendering storyboard images, AI video clips, or BGM, chain directly into `multimodal-media-director`.)*

---

## 2. Mode A: Manga & Webtoon Panel Scripting (`manga_webtoon_script`)

1. **Pacing & Page-Turn / Scroll Rhythm**:
   - **Page Manga**: 4–6 panels per page on average; reserve full-bleed splash panels for emotional peaks or reveals; place micro-cliffhangers at page turns.
   - **Vertical Webtoon (条漫)**: Design vertical scroll breathing space (gutters as time pauses), 1–2 focal beats per screen height, and hook reveals at scroll midpoints/endings.
2. **Mandatory Panel Breakdown Table**:
   Deliver every scene as a structured panel table:
   - `Panel #` | `Shot / Camera Angle` (e.g., `ECU Eyes`, `Low-Angle Wide`, `Over-Shoulder`) | `Visual Action & Character Consistency Tags` (pose, expression, props, wardrobe continuity) | `SFX / Visual Onomatopoeia` | `Dialogue / Caption`
3. **Speech-Bubble Discipline**:
   - Cap normal bubbles at `<= 25–35` words (or concise `15–25` Chinese characters) and max 2–3 bubbles per panel so art is never buried under text walls.

---

## 3. Mode B: Short-Video & Micro-Drama Shooting Scripts (`short_video_script`)

1. **0–3s Golden Hook (黄金前 3 秒)**:
   - Open directly *in media res* with a visual anomaly, counter-intuitive claim, high-stakes conflict, or immediate payoff tease—never waste seconds 0–3 on slow greetings or background exposition.
2. **Retention & Twist Cadence**:
   - Target a visual cut or new information hook every `2–4s` (`15s–60s` shorts) and at least one reversal/escalation per `45–60s` episode (`微短剧`) with a sharp end-of-episode cliffhanger.
3. **Mandatory Multi-Track Audio-Visual Script Table (多轨分镜台本)**:
   - `时间段 (Timecode)` | `景别 / 运镜 (Shot & Camera)` | `画面动作与构图 (Visual Action)` | `口播 / 台词 (VO / Dialogue)` | `花字 / 字幕强调 (On-Screen Text)` | `音效 / BGM 卡点 (SFX & Music Beat)`

---

## 4. Mode C: Film & Animation Screenplays (`screenplay`)

1. **Standard Scene Format**: `INT./EXT. LOCATION — TIME OF DAY`, present-tense strictly filmable action lines, centered character cue + dialogue + concise parentheticals only when delivery contradicts text.
2. **Show, Don't Tell**: Never write unfilmable internal essays ("He secretly remembers his childhood trauma..."); translate inner state into observable physical behavior, props, lighting, and subtext.

---

## 5. Cross-Skill Chaining & Continuity Closure

1. **Serialized Continuity (`novel-story-architect`)**: When adapting a novel or writing a multi-episode series, read/update `.story-bible/` (`_tracking-state.json`, character designs, prop states, timeline) so character outfits, injuries, and knowledge never drift across episodes.
2. **Visual & Audio Handoff (`multimodal-media-director`)**: When the user also wants panel keyframes, AI video clips (`Veo` / `Kling` / `Remotion` / `HyperFrames`), or BGM/voiceover sheets, pass the panel/timecode table directly to `multimodal-media-director` while locking character appearance tokens across every shot.
3. **Anti-AI-Cliché Script Audit**: Strip narrator info-dumps, repetitive "然后/突然" filler, melodramatic cliché lines, and static talking-head blocks lacking visual movement.
