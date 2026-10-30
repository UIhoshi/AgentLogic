---
name: office-pro-suite
description: Professional design, formatting, and standardization suite for Word (.docx), Excel (.xlsx), and PowerPoint (.pptx) documents. Triggered automatically whenever the user asks to create, edit, format, redesign, audit, or convert .docx, .xlsx, or .pptx files.
---

# Office Professional Design & Standardization Suite (`office-pro-suite`)

This skill synthesizes the industry-gold-standard document design and engineering rules from **Anthropic Official Document Skills** (`anthropics/skills` — `docx`, `xlsx`, `pptx`) with AgentLogic's **OfficeCLI** governance contract (`iOfficeAI/OfficeCLI`, Module 50).

## 1. Mandatory Automatic Activation Rule

Whenever the user requests creating, editing, styling, formatting, auditing, or converting **Word (`.docx`)**, **Excel (`.xlsx`)**, or **PowerPoint (`.pptx`)** files, this skill activates automatically. Never output plain unstyled text dumps or raw CSVs when an Office document is requested.

---

## 2. Word (`.docx`) — Executive & Publication Typography Standard

When generating or formatting `.docx` files (via `OfficeCLI`, `python-docx`, or OOXML manipulation):
1. **Page Geometry & Margins**: Standardize paper size (`A4` or `US Letter`), margins (`2.54 cm / 1 inch` standard, or mirrored margins for bound reports), and running headers/footers with dynamic page numbering (`Page X of Y`).
2. **Strict Style Hierarchy (Never Use Ad-Hoc Font Overrides Alone)**:
   - Define and apply named paragraph styles: `Title`, `Subtitle`, `Heading 1`, `Heading 2`, `Heading 3`, `Body Text`, `Caption`, and `Block Quote`.
   - **Typography Pairing**: Clean executive sans/serif hierarchy (e.g., `Calibri Light` / `Aptos Display` / `Source Han Sans` for headings; `Calibri` / `Cambria` / `Source Han Serif` / `Microsoft YaHei` for body), `1.15x–1.25x` line spacing, `6pt` after-paragraph spacing, zero orphan/widow headings (`keep_with_next = True`).
3. **Professional Tables & Callouts**:
   - Use **Three-Line Academic/Consulting Tables** (top/bottom `1.5pt` primary border, header divider `0.75pt`, no vertical clutter lines) or **Subtle Zebra-Striped Tables** (`#F8FAFC` alternating rows) with explicit cell padding and right-aligned numeric columns.
   - Include shaded Executive Summary / Callout boxes (`4pt` left accent border + soft `#F1F5F9` fill).
4. **Redlining & Tracked Changes**: When editing legal, contract, or reviewed documents, preserve or generate proper `<w:ins>` / `<w:del>` tracked-change XML nodes and structured margin comments (`<w:comment>`).

---

## 3. Excel (`.xlsx`) — Investment-Banking & Financial Modeling Standard

When generating or editing `.xlsx` spreadsheets (via `OfficeCLI`, `openpyxl`, or `xlsxwriter`):
1. **Zero Hardcoded Calculated Values (Non-Negotiable)**:
   - Every total, subtotal, growth rate, KPI, variance, and projection MUST use live Excel formulas (`SUM`, `AVERAGE`, `INDEX/MATCH`, `XLOOKUP`, `SUMIFS`, `IFERROR`), never pre-calculated static numbers pasted from Python.
2. **Institutional Color-Coding Convention (Wall Street / Consulting Standard)**:
   - **Blue Text (`#0000FF` or `#1D4ED8`)**: Hardcoded inputs and assumptions entered by users.
   - **Black Text (`#000000` or `#0F172A`)**: Same-sheet formula calculations.
   - **Green Text (`#008000` or `#15803D`)**: Cross-sheet links and external references.
   - **Soft Yellow Fill (`#FEF9C3`)**: Key scenario drivers / editable assumption cells.
3. **Number Formatting & Grid Hygiene**:
   - Explicitly apply number formats: Currency (`$#,##0;($#,##0);"-"` or `¥#,##0`), Percentages (`0.0%`), Multiples (`0.0"x"`), Integers (`#,##0`).
   - Hide gridlines (`showGridLines = False` or subtle `#E2E8F0` borders), freeze header rows/columns (`freeze_panes`), auto-fit column widths with a 15% safety buffer so `###` truncation never occurs, and verify **zero formula errors (`#REF!`, `#DIV/0!`, `#VALUE!`, `#NAME?`)**.

---

## 4. PowerPoint (`.pptx`) — Consulting & Keynote Presentation Standard

When generating or redesigning `.pptx` decks (via `OfficeCLI`, `pptxgenjs`, or `python-pptx`):
1. **16:9 Widescreen Canvas & Action Titles**:
   - Default to `16:9` (`13.333 x 7.5 inches`).
   - Every content slide MUST have an **Action Title (结论先行标题)** at the top—a complete 1-line takeaway sentence stating the *insight*, not a vague topic label (e.g., use *"Q3 Cloud Revenue Grew 42% YoY Driven by Enterprise Tier Adoption"*, NOT *"Q3 Revenue Overview"*).
2. **Anti-Wall-of-Text Layout Variety**:
   - **Maximum 4–5 bullet points per card**, maximum 12–15 words per bullet.
   - Never use the same "title + vertical bullet list" layout on 3 consecutive slides. Rotate across **Bento KPI Cards (3–4 metric callouts)**, **Split Comparison (2-column Before/After or Pros/Cons)**, **Process Chevron / Timeline Flow**, **2x2 Matrix**, and **Chart + Key Takeaway Sidebar**.
3. **Palette, Contrast & Overflow Verification**:
   - Enforce a cohesive 3-color deck theme (Primary Brand Surface, High-Contrast Ink, Single High-Impact Accent).
   - Explicitly calculate bounding-box coordinates (`x`, `y`, `w`, `h`) so shapes never overlap slide margins (`>= 0.5 inch` safe zone) or footer trackers.

---

## 5. Mandatory Verification Closure
After creating or mutating any `.docx`, `.xlsx`, or `.pptx` file:
1. Inspect the generated XML/structure (sheet names, slide count, style definitions, formula cells).
2. Verify that the file opens cleanly without corruption and check visual/layout boundaries (via `OfficeCLI` / LibreOffice / PDF-to-image screenshot when available).
