---
name: web-game-studio
description: Design, prototype, architect, and playtest 2D and 3D browser games using Phaser, Canvas2D, Three.js, React Three Fiber, glTF asset pipelines, and deterministic playtest loops. Trigger automatically when creating, debugging, or polishing any browser game or interactive game loop.
---

# Web Game Studio (`web-game-studio`)

This skill synthesizes the **MIT**-licensed `game-studio` workflow (`openai/plugins`) with AgentLogic's visual reference grounding and multi-state browser verification gates.

## 1. Mandatory Automatic Activation Rule

Automatically activate this skill whenever the user asks to design, prototype, build, optimize, or playtest a **browser game** (arcade, platformer, puzzle, roguelike, strategy, simulation, 2D Phaser/Canvas2D, or 3D Three.js / React Three Fiber / WebGL game).

---

## 2. Stack Selection & Core Stance

1. **Default to 2D Phaser (or Modular Fixed-Timestep Canvas2D)**: Choose a focused 2D Phaser 3 (or clean modular Canvas2D) stack by default for crisp feel, fast iteration, and predictable performance.
2. **3D Path Only When Requested**: Use **Three.js** or **React Three Fiber + Rapier** only when the user explicitly requests 3D gameplay, 3D cameras, or WebGL/shader-driven worlds.
3. **Core Loop Before Content Bloat**: Build and verify one complete playable vertical slice (Title/Start -> Core Input & Physics Loop -> Feedback/Audio/Juice -> Win/Loss -> Clean Restart) before expanding levels or cosmetics.

---

## 3. Modular Game Architecture & Asset Pipeline

Separate concerns strictly so game state never tangles with DOM/UI slop:
- **`core/`**: Fixed-timestep accumulator (`dt` clamped to prevent spiral of death on tab switch), deterministic PRNG seed option, input buffer/mapping (keyboard + pointer/touch), and clean scene/game-state lifecycle.
- **`entities/` & `systems/`**: Hitboxes/hurtboxes, collision resolution, entity pooling (avoid per-frame GC spikes), and enemy/AI state machines.
- **`ui/` (Game HUD)**: Crisp, uncluttered HUD overlay (score, health, pause, mute, restart) respecting safe margins and mobile touch controls (`>= 44x44px`) without blocking the playfield.
- **`assets/` & Reference Grounding**:
  - Use consistent sprite atlas / tilemap sizing or compressed glTF (`KTX2`/`Draco` when needed) with preloading progress and graceful fallbacks.
  - When depicting **real-world subjects/motion** (animals, vehicles, human/creature gaits), enforce AgentLogic's **Real-World Visual & Motion Reference Grounding Gate**: download real reference images/GIFs locally and inspect them via `read_file` before authoring sprites, rigs, or Canvas contours.

---

## 4. Deterministic Playtest & Browser Verification Closure

Before claiming a game works:
1. Expose a lightweight deterministic state/debug hook (e.g., `window.__GAME_DEBUG__` or `?seed=&t=` / `?state=`) when helpful for automated testing.
2. Verify in a real browser across **Start Screen -> Active Gameplay Input -> Collision/Scoring -> Game Over & Clean Restart**:
   - Confirm zero uncaught console/page errors, stable frame pacing, working restart state cleanup (no leaked timers/listeners/entities), and clean viewport containment on both desktop and mobile viewports.

---

## 5. Attribution
- Synthesized from `openai/plugins` (`plugins/game-studio`, `MIT` License).
