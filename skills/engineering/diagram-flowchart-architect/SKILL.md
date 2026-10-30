---
name: diagram-flowchart-architect
description: Autonomous flowchart, system architecture, swimlane, sequence, ER, and whiteboard diagram generator supporting Draw.io (.drawio), Excalidraw (.excalidraw), and themed Mermaid. Triggered automatically whenever the user requests a flowchart, architecture diagram, process map, sequence diagram, mind map, or visual schema.
---

# Diagram & Flowchart Architect (`diagram-flowchart-architect`)

This skill synthesizes the official Draw.io architecture of **`jgraph/drawio-mcp`** and **`Agents365-ai/drawio-skill`**, the hand-drawn spatial canvas discipline of **`coleam00/excalidraw-diagram-skill`** (`yctimlin/mcp_excalidraw`), and high-contrast themed **Mermaid** engineering.

## 1. Mandatory Automatic Activation Rule

Whenever the user asks to create, draw, design, or export a **flowchart (流程图), swimlane diagram (泳道图), system architecture diagram (系统架构图), sequence diagram (时序图), state machine (状态机), ER schema (实体关系图), or mind map (思维导图)**, this skill activates automatically without requiring manual skill selection.

---

## 2. Automatic Format Selection Matrix (3-Tier Output Routing)

Select the output format automatically based on the user's target surface (or provide the dual **Mermaid Preview + Editable `.drawio`/`.excalidraw` Source File** when producing formal deliverables):

| Target Scenario | Primary Output Format | Why & When to Use |
| :--- | :--- | :--- |
| **1. Enterprise / Formal Engineering / Office Deliverable** | **Native `.drawio` XML** (`*.drawio` / `.drawio.svg`) | When the user needs a formal swimlane flowchart, cloud/K8s/system architecture, ER diagram, or diagram to embed in Word/PPT and drag-and-drop edit in Draw.io / VS Code Draw.io extension. |
| **2. Product Brainstorming / System Design Whiteboard / Technical Blog** | **Native `.excalidraw` JSON** (`*.excalidraw`) | When the user wants a clean, high-craft hand-drawn aesthetic with color-coded domain zones, callout sticky notes, and visual hierarchy. |
| **3. Markdown Documentation / GitHub README / Instant Chat Preview** | **Themed `Mermaid` Code Block** | Always include a syntax-validated, custom-themed Mermaid diagram directly in the response or Markdown doc for immediate visual preview alongside any `.drawio` or `.excalidraw` file. |

---

## 3. Strict Layout & Anti-Spaghetti Engineering Rules

### Rule 1: Spatial Zoning & Visual Hierarchy
- **Never dump 20+ ungrouped nodes into a flat graph.** Group related nodes into **Subgraphs / Swimlanes / Color-Coded Containers** (e.g., `Client Layer`, `API Gateway & Auth`, `Core Domain Services`, `Data & Cache Layer`).
- **Maximum 7–9 nodes per container**; if a flow has more than 18 steps, split it into a **Macro Overview Diagram** + **Focused Sub-Flow Diagram**.

### Rule 2: Semantic Color Palette (No Default Neon/Rainbow Chaos)
Apply a consistent semantic palette across Mermaid `classDef`, `.drawio` styles, and `.excalidraw` elements:
- **Entry / User / Trigger Nodes**: Slate Blue (`fill:#EEF2FF,stroke:#4F46E5,color:#1E1B4B`)
- **Core Process / Service Nodes**: Clean Neutral (`fill:#F8FAFC,stroke:#334155,color:#0F172A`)
- **Decision / Gate / Router Diamonds**: Amber Gold (`fill:#FEF3C7,stroke:#D97706,color:#78350F`)
- **Database / Storage / State**: Emerald Teal (`fill:#ECFDF5,stroke:#059669,color:#064E3B`)
- **Error / Exception / Security Block**: Rose Red (`fill:#FFE4E6,stroke:#E11D48,color:#881337`)

### Rule 3: Zero-Overlap & Edge-Routing Discipline
- **In `.drawio` (`mxGraphModel`)**:
  - Use explicit grid-snapped coordinates (`x`, `y`, `width`, `height` multiples of `10` or `20`), minimum `60px` horizontal gap and `50px` vertical gap between sibling nodes.
  - Use orthogonal edge routing (`edgeStyle=orthogonalEdgeStyle;rounded=1;orthogonalLoop=1;jettySize=auto;html=1;`) with explicit `exitX/exitY` and `entryX/entryY` ports so arrows never cut through node text boxes.
- **In `.excalidraw`**:
  - Maintain explicit bounding-box separation (`>= 40px` padding inside zone rectangles, `>= 60px` between connected boxes) and bind text elements (`containerId`) properly to their parent shapes.
- **In `Mermaid`**:
  - Only use supported diagram types (`flowchart TD/LR`, `sequenceDiagram`, `stateDiagram-v2`, `classDiagram`, `erDiagram`, `xychart-beta`).
  - **Quote all node labels containing parentheses, brackets, colons, or slashes** (e.g., `A["Auth Gateway (JWT / OAuth2)"]` instead of `A[Auth Gateway (JWT / OAuth2)]`) and avoid raw HTML tags inside labels.
