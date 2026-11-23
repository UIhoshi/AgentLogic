---
name: web-data-visualization
description: Design, critique, implement, test, and export truthful web data visualizations including charts, KPI dashboards, maps, Gantt timelines, statistical plots, real-time telemetry, and D3/Vega-Lite/Canvas2D/WebGL views. Trigger automatically on any data visualization, chart, map, or analytics dashboard task.
---

# Web Data Visualization Architect (`web-data-visualization`)

This skill synthesizes the **MIT**-licensed `build-web-data-visualization` architecture (`openai/plugins`) into a single progressive-disclosure engineering skill for truthful, accessible, dual-viewport web visualizations.

## 1. Mandatory Automatic Activation Rule

Automatically activate this skill whenever the user asks to design, critique, build, optimize, test, or export:
- Charts, statistical/uncertainty plots, sparklines, heatmaps, scatter/bubble plots, funnel/Sankey flows, or Gantt timelines.
- Analytics or real-time monitoring dashboards, KPI scorecards, or scrollytelling data narratives.
- Geospatial/cartographic maps (Choropleth, point/hexbin, GeoJSON/TopoJSON, MapLibre/Leaflet).
- Custom D3/SVG, Canvas2D high-density plots, Vega-Lite / Observable Plot specs, or analytical WebGL/Three.js visualizations.

*(Note: For software architecture diagrams, swimlanes, ERDs, and flowcharts, route to `diagram-flowchart-architect` instead.)*

---

## 2. Core Visual & Analytical Stance

1. **Truthful Simplicity Over Flash**: Choose the simplest truthful view with the lowest decoding burden. Do NOT default to 3D charts, decorative animation, particles, or WebGL unless they carry measurable analytical meaning.
2. **Evidence-Bearing Marks Only**: Explicitly forbid broad translucent brush strokes, wispy ribbons, decorative bokeh/orbs, stock-photo haze, or ornamental gradients masquerading as data layers. Every encoded mark, flow, density, or particle must map to a defined data unit and scale.
3. **Direct Labeling & Visible Caveats**: Prefer direct data labels and clear inline annotations over distant legend hunting; always surface sample sizes, missing-data gaps, aggregation windows, or axis breaks/non-zero baselines.
4. **Dual-Viewport Parity (Desktop + Mobile Portrait)**: Treat desktop and mobile portrait (`320px–390px`) as sibling primary surfaces. Plan compact mobile reading order, touch hit targets (`>= 44px`), label decluttering, and horizontal-scroll/small-multiples fallbacks up front.

---

## 3. Router & Renderer Selection Workflow

1. **Classify Analytical Job & Data Shape**:
   - *Job*: Comparison/ranking, time change, distribution/uncertainty, correlation, composition/flow, hierarchy/network, schedule/Gantt, monitoring, or geospatial.
   - *Shape*: Tabular, time-series, multivariate, matrix, tree/graph, schedule, geospatial, or high-frequency stream.
2. **Define Reading Path & URL State Contract Before Coding**:
   - Establish insight title -> immediate quantitative evidence -> on-demand tooltip/drill-down -> caveats -> mobile collapse order.
   - Persist shareable view state (filters, date range, selected series, zoom/camera, active tab) in URL query/hash where applicable, handling invalid state and back-button navigation cleanly.
3. **Select the Narrowest Fit Renderer**:
   - **Vega-Lite / Observable Plot**: Default for rapid, declarative statistical, analytical, and faceted multi-view charts.
   - **D3 + Semantic SVG**: Bespoke editorial graphics, custom interactive layouts, scrollytelling, or crisp vector exports (`< 1,500` DOM nodes).
   - **Canvas2D**: High-density scatter/time-series/heatmaps (`1,000–100,000+` marks) or real-time streaming telemetry where SVG DOM overhead stalls frame pacing (pair with an accessible off-screen DOM/ARIA summary layer).
   - **WebGL / Three.js**: Strictly for massive point clouds (`100k+`) or genuinely 3D spatial/terrain datasets.
   - **Accessibility & Color**: Enforce colorblind-safe palettes (Okabe-Ito / Viridis / ColorBrewer), redundant shape/pattern encodings, keyboard focus traversal across marks/controls, `aria-label` data summaries, and a downloadable/toggleable accessible data table fallback.

---

## 4. Compact Technical Design & Verification Closure

Before writing visualization code for non-trivial views, outline a brief design note (instance count, renderer ownership, URL/state contract, mobile strategy, fallback). After implementation:
1. Verify **Desktop + Mobile Portrait** rendering, tooltip/hover/touch interactions, and container bounds (zero clipped axis labels, overlapping ticks, or legend overflow) in a real browser/screenshot.
2. Verify numeric precision (`tabular-nums`), empty/loading/error/sparse-data states, and accessibility attributes.

---

## 5. Attribution
- Synthesized from `openai/plugins` (`plugins/build-web-data-visualization`, `MIT` License).
