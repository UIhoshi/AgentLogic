---
name: multimodal-media-director
description: Autonomous director and execution router for Text-to-Image, Text-to-Video, and Text-to-Music generation. Triggered automatically whenever the user requests generating images, illustrations, UI mockups, videos, animations, motion clips, music, BGM, soundtracks, or songs.
---

# Multimodal Media Director (`multimodal-media-director`)

This skill synthesizes the multimodal architecture of **Google Cloud GenMedia Creative Studio** (`GoogleCloudPlatform/vertex-ai-creative-studio` — Imagen / Veo / Lyria), **EachLabs Multimodal Skills** (`eachlabs/skills`), **MiniMax MCP** (`MiniMax-AI/MiniMax-MCP`), and **`guinacio/claude-image-gen`**.

## 1. Mandatory Automatic Activation Rule

Whenever the user's task involves **Text-to-Image (文生图)**, **Text-to-Video / Image-to-Video (文生视频/图生视频)**, or **Text-to-Music / Audio (文生音乐/配乐)**—or when paired with `ui-ux-pro-max` for mandatory UI design previews—this skill activates automatically without requiring the user to name a skill.

---

## 2. Mode A: Text-to-Image Director (`text_to_image`)

### A.1 Prompt Engineering & Art Direction
Before invoking any image generator, expand the user's brief into a structured visual specification:
1. **Subject & Composition**: Foreground focal point, midground context, background environment, rule-of-thirds / golden-ratio framing.
2. **Medium & Aesthetic Style**: Editorial photography (lens focal length e.g. `35mm f/1.8`, film stock), high-craft UI mockup (paired with `ui-ux-pro-max`), 3D isometric render, vector illustration, or concept art.
3. **Color Palette & Lighting**: Key light direction, color temperature, exact HSL/Hex accents, volumetric or soft studio lighting.
4. **Aspect Ratio & Reference Control**: Specify `16:9`, `9:16`, `1:1`, or `4:3`; if editing or restyling an existing image/UI, pass the reference image path (`reference-guidance` / inpainting mask).

### A.2 Execution Backend Routing
1. **Host Native Image Subagent / Tool**: Invoke Antigravity's `image-generator` subagent (`invoke_subagent` with `TypeName: "image-generator"`), `imagegen`, or `nano-banana-pro`.
2. **External Multimodal MCP / CLI (if configured)**: Route to `mcp-genmedia` (Imagen 3), `MiniMax-MCP`, or `claude-image-gen`.
3. **Deliverable**: Save generated image(s) to the project workspace (e.g., `.specify/mockups/` or `assets/generated/`), verify file existence, and present the exact path and preview to the user.

---

## 3. Mode B: Text-to-Video & Storyboard Director (`text_to_video`)

### B.1 Cinematic Storyboard & Motion Specification
Never feed raw, unstructured sentences to a video model. First produce a **Shot-by-Shot Cinematic Storyboard Table**:
1. **Shot Number & Duration**: e.g., `Shot 01 (0s–5s)`, `Shot 02 (5s–10s)`.
2. **Camera Movement**: e.g., `Slow dolly-in`, `Orbital tracking shot`, `Crane up`, `Locked-off tripod`, `Handheld subtle motion`, `FPV drone sweep`.
3. **Subject Action & Physics**: Micro-expressions, fluid/cloth dynamics, pacing, interaction with environment.
4. **Lighting, Atmosphere & Continuity**: Time of day, color grading LUT style, transition anchor (First-Frame / Last-Frame keyframe lock).
5. **Audio / Foley Cue**: Ambient soundscape, dialogue lip-sync timing, or SFX markers.

### B.2 Execution Backend Routing
1. **If Video Generation MCP/API/CLI is available** (e.g., Google `Veo` via `mcp-genmedia`, `MiniMax-MCP` Hailuo Video, Kling/Runway/Wan via `eachlabs` or local script): Execute generation using the structured shot prompt and save the `.mp4` output + keyframe reference images.
2. **Keyframe-First Fallback**: When direct video generation API credentials are not yet configured on the host, automatically generate **First-Frame & Keyframe Concept Stills** via `image-generator` AND output the copy-ready **Veo / Kling / Runway / Sora Master Prompt Pack** in `.specify/<task>/video-storyboard.md`, clearly disclosing whether live `.mp4` rendering or keyframe+storyboard synthesis was used.

---

## 4. Mode C: Text-to-Music & Audio Arrangement Director (`text_to_music`)

### C.1 Musical Arrangement & Acoustic Specification
Before invoking a music model or delivering a composition package, construct a **Professional Music Production Sheet**:
1. **Genre, Sub-Genre & Mood**: e.g., `Cinematic Neo-Classical Orchestral`, `Cyberpunk Synthwave`, `Lo-Fi Jazz Hop`, `Upbeat Indie Pop`.
2. **Tempo (BPM), Time Signature & Key**: e.g., `124 BPM`, `4/4`, `D Minor` (or `A Major`).
3. **Instrumentation & Timbre Palette**: Lead instruments, rhythm section, bassline character, synth pads, spatial reverb/mix profile.
4. **Structural Timeline & Metatags**:
   - `[Intro - 8 bars: Sparse Rhodes piano and vinyl crackle]`
   - `[Verse 1 - 16 bars: Warm sub-bass enters, crisp rimshot groove]`
   - `[Pre-Chorus - 8 bars: Rising string ostinato, filter sweep]`
   - `[Chorus / Drop - 16 bars: Full arrangement, soaring lead melody, wide stereo image]`
   - `[Bridge - 8 bars: Stripped-back acoustic breakdown]`
   - `[Outro - 8 bars: Gradual fadeout on unresolved ninth chord]`
5. **Vocal vs. Instrumental Mode**: For instrumental/BGM, enforce `[Instrumental Only - No Vocals]`. For songs with vocals, write syllable-balanced, rhyme-checked lyrics aligned to the bar structure and specify vocal timbre (e.g., `Warm baritone`, `Ethereal female soprano`).

### C.2 Execution Backend Routing
1. **If Music Generation MCP/API/CLI is available** (e.g., `MiniMax-MCP` Music, Google `Lyria` via `mcp-genmedia`, Suno/Mureka/Udio via `eachlabs` or local script): Execute generation and save the `.mp3`/`.wav` file to `assets/audio/`.
2. **Structured Production Fallback**: When an audio generation API is not yet configured on the host, write the complete **Music Production Sheet + Style Tags + Metatagged Lyrics/Arrangement** to `.specify/<task>/music-arrangement.md` (ready for 1-click paste into Suno v4 / Udio / MiniMax Music / Lyria) and optionally synthesize a reference MIDI/WebAudio preview script if requested.
