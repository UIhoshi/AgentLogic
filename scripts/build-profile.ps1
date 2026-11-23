# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param(
    [string]$ProfileName = "core-enhanced",
    [ValidateSet("codex", "claude", "antigravity", "generic")]
    [string]$TargetHost = "generic",
    [string]$OutputPath,
    [switch]$Verify
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

function Get-RepoRoot {
    return (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

function Get-Manifest {
    param([string]$RepoRoot)

    $manifestPath = Join-Path $RepoRoot "manifest.json"
    return Get-Content -Raw -Encoding UTF8 -Path $manifestPath | ConvertFrom-Json
}

function Resolve-OutputPath {
    param(
        [string]$RepoRoot,
        [object]$Manifest,
        [string]$TargetHost,
        [string]$RequestedOutputPath
    )

    if ($RequestedOutputPath) {
        return $RequestedOutputPath
    }

    $relative = $Manifest.host_outputs.$TargetHost
    if (-not $relative) {
        throw "No host output configured for '$TargetHost'."
    }

    return Join-Path $RepoRoot $relative
}

function Build-Bundle {
    param(
        [string]$RepoRoot,
        [object]$Manifest,
        [string]$ProfileName,
        [string]$TargetHost
    )

    $profile = $Manifest.profiles.$ProfileName
    if (-not $profile) {
        throw "Unknown profile '$ProfileName'."
    }

    $files = @($profile.files)
    if ($files.Count -eq 0) {
        throw "Profile '$ProfileName' has no files."
    }

    $emDash = [regex]::Unescape('\u2014')
    $zhStartupPrompt = [regex]::Unescape('\u5f53\u524d\u4efb\u52a1\u662f\u5426\u5c5e\u4e8e\u4e0a\u4e00\u8f6e coding \u7684\u5ef6\u7eed\uff1f\u82e5\u4e0d\u662f\uff0c\u8bf7\u786e\u8ba4\u662f\u5426\u9700\u8981 forget/compress context\u3002')

    $builder = New-Object System.Text.StringBuilder
    [void]$builder.AppendLine("# MANDATORY AGENT EXECUTIVE PROTOCOL (AgentLogic $($Manifest.current_version))")
    [void]$builder.AppendLine()
    [void]$builder.AppendLine("- Host target: $TargetHost")
    [void]$builder.AppendLine("- Profile: $ProfileName")
    [void]$builder.AppendLine("- Stable entry: $($Manifest.entry)")
    [void]$builder.AppendLine("- Version: $($Manifest.current_version)")
    [void]$builder.AppendLine()
    [void]$builder.AppendLine("> [!CRITICAL]")
    [void]$builder.AppendLine("> **CROSS-HOST MANDATORY BLOCKING GATES (Antigravity / Claude Code / OpenAI Codex / Generic)**:")
    [void]$builder.AppendLine(">")
    [void]$builder.AppendLine("> **Gate 1 $emDash Startup Context-Reset & Autonomous Role Recommendation Gate (Turn 1 Blocking)**:")
    [void]$builder.AppendLine("> Do NOT merely read, recite, or summarize AgentLogic rules as passive background text. On Turn 1 of any new project or formal non-continuation task (coding, planning, UI, creative, Office, or audit $emDash trivial 1-turn read-only Q&A may answer directly without blocking), you MUST interactively execute BOTH:")
    [void]$builder.AppendLine('> 1. **Context-Reset Confirmation**: Ask whether the current task extends the previous coding round, and if not, whether to `forget/compress context` (in the user''s active language):')
    [void]$builder.AppendLine(">    - Chinese: '$zhStartupPrompt'")
    [void]$builder.AppendLine(">    - English: 'Does the current task extend the previous coding round? If not, please confirm whether to forget/compress context.'")
    [void]$builder.AppendLine('> 2. **Autonomous Role Recommendation & Dual-Axis Subagent Squads (`role-persona-router` / `contracts/role-personas.json`)**: Analyze the project domain, recommend the #1 best-fit Lead Role (with a 1-sentence rationale; plus a 1-line Supporting Subagent Squad for complex cross-domain tasks), and present the 11-role menu (`[1] Principal Systems Architect & Full-Stack Lead`, `[2] UI/UX Creative Design Director`, `[3] Reverse Engineering Specialist`, `[4] Management Consultant & Office Architect`, `[5] Multimodal Creative Director`, `[6] Chief Showrunner & Novel Architect`, `[7] Enterprise Flowchart Cartographer`, `[8] AppSec & DevSecOps Guardian`, `[9] Data Analytics & Visualization Architect`, `[10] Interactive Game & Graphics Lead`, `[11] Screenwriter, Manga-Script & Short-Video Showrunner`). When spawning subagents, assign BOTH execution posture (`explore|plan|implement|review|verify`) and specialist sub-role (`[1]-[11]`, `codebase-explorer`, or `independent-verifier`), propagate `Bound Skills`, enforce disjoint write ownership, and keep `max_depth = 1`.')
    [void]$builder.AppendLine(">")
    [void]$builder.AppendLine("> **Gate 2 $emDash Pure UI Design (``ui-ux-pro-max``) + Mandatory Text-to-Image Preview Gate (Blocking Before UI Code)**:")
    [void]$builder.AppendLine('> Before writing or modifying production frontend/UI code for any new UI or substantial redesign (unless the user explicitly opts out): (a) run `product-requirements-grilling` one question at a time -> (b) run `ui-ux-pro-max` (`skills/design/ui-ux-pro-max/SKILL.md`) to derive a pure UI/UX design specification (industry color palette, font pairing, grid anatomy) -> (c) combine that specification with `imagegen` / `image-generator` / `multimodal-media-director` / `nano-banana-pro` to generate a visual UI mockup image -> (d) obtain user approval before writing UI code; (e) enforce real-world media download + `read_file` visual inspection for real-world SVGs/Canvas/animations and side-by-side Design QA (`P0`/`P1`/`P2` blocking loop) after implementation.')
    [void]$builder.AppendLine(">")
    [void]$builder.AppendLine("> **Gate 3 $emDash Skill-First Reflex & Auto-Use Domain Capabilities (Zero Manual Skill Selection)**:")
    [void]$builder.AppendLine("> **SKILL-FIRST REFLEX HABIT**: Never wait for the user to name a skill. Before writing code, designing UI/charts, reviewing security/PRs, creating Office/PDF/media/games, or auditing skills, ALWAYS run a 3-second Scenario -> Skill scan; on any match, immediately read its `SKILL.md`, announce ``[Skill Activated: <name>]``, and execute it by default (chaining multiple skills across multi-domain tasks):")
    [void]$builder.AppendLine('> - **Binaries / Bytecode / Obfuscated Bundles** -> `decompile-reconstruction` (`GhidraMCP` / `ida-reverse` / `jadx` / `ilspycmd` / `pycdc` / `webcrack`)')
    [void]$builder.AppendLine('> - **Post-Implementation Polish / Code Refactoring** -> `code-simplifier` (`ast-grep` structural rewrite + guard clauses + zero behavior regression)')
    [void]$builder.AppendLine('> - **Word / Excel / PPT / PDF Documents (`.docx`/`.xlsx`/`.pptx`/`.pdf`)** -> `office-pro-suite` (Word styles/three-line tables, live Excel formulas + tie-out QA, 16:9 action-title slides + QC, PDF `pdftoppm` visual inspection)')
    [void]$builder.AppendLine('> - **Text-to-Image / Video / Programmatic Video / Music** -> `multimodal-media-director` (art direction, shot-by-shot camera storyboards, Remotion/HyperFrames code video, BPM/Key/Metatag arrangement)')
    [void]$builder.AppendLine('> - **Novel / Fiction / Script Writing** -> `novel-story-architect` (`.story-bible/` continuity compiler, scene beat sheets, anti-AI-cliche prose filter)')
    [void]$builder.AppendLine('> - **Flowcharts / Swimlanes / Architecture Diagrams** -> `diagram-flowchart-architect` (`.drawio` XML, `.excalidraw` JSON, and themed `Mermaid`)')
    [void]$builder.AppendLine('> - **Modern Web Frontend (HTML/CSS/DOM/JS/CWV/A11y)** -> `modern-web-guidance` (query `npx -y modern-web-guidance@latest` or local `guides/` first, plus `legacy-scan`)')
    [void]$builder.AppendLine('> - **Chrome / Browser Extensions (Manifest V3 & Web Store)** -> `chrome-extensions` (MV3 service workers, side panels, CSP sandboxes, store compliance)')
    [void]$builder.AppendLine('> - **Security Review / Diff Audit / Threat Model / Ownership** -> `appsec-review` (diff-scoped reachability, `SECURITY.md` resolution, `confirmed`/`not_actionable`/`needs_review` verdicts, STRIDE)')
    [void]$builder.AppendLine('> - **Web Data Visualization (Charts / Dashboards / Maps / D3 / Vega / Canvas2D)** -> `web-data-visualization` (evidence-bearing encodings, dual desktop/mobile views, URL state, a11y)')
    [void]$builder.AppendLine('> - **2D / 3D Browser Games (Phaser / Canvas2D / Three.js / R3F)** -> `web-game-studio` (modular `core/entities/ui`, asset pipeline, browser playtest loop)')
    [void]$builder.AppendLine('> - **GitHub Actions CI Failures & PR Review Comments (`gh` CLI)** -> `gh-pr-ci-triage` (verify `gh auth status`, inspect logs/threads, plan before fixing)')
    [void]$builder.AppendLine('> - **Skill & Plugin Quality / Token-Budget Evaluation** -> `skill-evaluator` (`At a Glance` / `Fix First` report, frontmatter/links/token budget)')
    [void]$builder.AppendLine('> - **Manga/Webtoon Scripts, Short-Video/Micro-Drama Scripts, & Screenplays** -> `screenplay-manga-director` (panel breakdown, 0-3s hook multi-track table, `INT./EXT.` format, `.story-bible/` & media handoff)')
    [void]$builder.AppendLine()
    [void]$builder.AppendLine("This is a generated primary-logic bundle. Regenerate it from scripts/build-profile.ps1 instead of editing it by hand.")
    [void]$builder.AppendLine()

    foreach ($relativePath in $files) {
        $fullPath = $RepoRoot
        foreach ($seg in $relativePath.Split('/')) { $fullPath = Join-Path $fullPath $seg }
        if (-not (Test-Path $fullPath)) {
            throw "Profile file missing: $relativePath"
        }

        $content = Get-Content -Raw -Encoding UTF8 -Path $fullPath
        if ($relativePath.EndsWith('.json', [System.StringComparison]::OrdinalIgnoreCase)) {
            $parsedJson = $content | ConvertFrom-Json
            $content = $parsedJson | ConvertTo-Json -Depth 30 -Compress
        }
        [void]$builder.AppendLine("---")
        [void]$builder.AppendLine()
        [void]$builder.AppendLine("## BEGIN FILE: $relativePath")
        [void]$builder.AppendLine()
        [void]$builder.AppendLine($content.TrimEnd())
        [void]$builder.AppendLine()
        [void]$builder.AppendLine("## END FILE: $relativePath")
        [void]$builder.AppendLine()
    }

    return [System.Text.RegularExpressions.Regex]::Replace($builder.ToString(), "\r\n|\r|\n", "`n")
}

$repoRoot = Get-RepoRoot
$manifest = Get-Manifest -RepoRoot $repoRoot
$resolvedOutputPath = Resolve-OutputPath -RepoRoot $repoRoot -Manifest $manifest -TargetHost $TargetHost -RequestedOutputPath $OutputPath
$bundle = Build-Bundle -RepoRoot $repoRoot -Manifest $manifest -ProfileName $ProfileName -TargetHost $TargetHost

if ($Verify) {
    if (-not (Test-Path $resolvedOutputPath)) {
        throw "Generated bundle is missing: $resolvedOutputPath"
    }

    $existingBundle = [System.IO.File]::ReadAllText($resolvedOutputPath)
    $normalizedExistingBundle = [System.Text.RegularExpressions.Regex]::Replace($existingBundle, "\r\n|\r|\n", "`n")
    if (-not [string]::Equals($normalizedExistingBundle, $bundle, [System.StringComparison]::Ordinal)) {
        throw "Generated bundle is stale: $resolvedOutputPath. Regenerate it with scripts/build-profile.ps1."
    }

    Write-Host "Verified profile '$ProfileName' for host '$TargetHost' -> $resolvedOutputPath"
    return
}

$outputDir = Split-Path -Parent $resolvedOutputPath
if ($outputDir) {
    New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
}

[System.IO.File]::WriteAllText($resolvedOutputPath, $bundle, [System.Text.UTF8Encoding]::new($false))
Write-Host "Built profile '$ProfileName' for host '$TargetHost' -> $resolvedOutputPath"
