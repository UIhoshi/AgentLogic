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
    [void]$builder.AppendLine("> Do NOT merely read, recite, or summarize AgentLogic rules as passive background text. On Turn 1 of any new project or non-continuation task, you MUST interactively execute BOTH:")
    [void]$builder.AppendLine('> 1. **Context-Reset Confirmation**: Ask whether the current task extends the previous coding round, and if not, whether to `forget/compress context` (in the user''s active language):')
    [void]$builder.AppendLine(">    - Chinese: '$zhStartupPrompt'")
    [void]$builder.AppendLine(">    - English: 'Does the current task extend the previous coding round? If not, please confirm whether to forget/compress context.'")
    [void]$builder.AppendLine('> 2. **Autonomous Role Recommendation & Selection (`role-persona-router`)**: Analyze the project domain, recommend the #1 best-fit Lead Role (with a 1-sentence rationale), and present the 7-role selection menu (`[1] Principal Systems Architect & Full-Stack Lead`, `[2] UI/UX Creative Design Director`, `[3] Reverse Engineering & Reconstruction Specialist`, `[4] Management Consultant & Office Architect`, `[5] Multimodal Creative Director (Image/Video/Music)`, `[6] Chief Showrunner & Novel Architect`, `[7] Enterprise Flowchart & Architecture Cartographer`) so the user can confirm or switch the executing persona.')
    [void]$builder.AppendLine(">")
    [void]$builder.AppendLine("> **Gate 2 $emDash Pure UI Design (``ui-ux-pro-max``) + Mandatory Text-to-Image Preview Gate (Blocking Before UI Code)**:")
    [void]$builder.AppendLine('> Before writing or modifying production frontend/UI code for any new UI or substantial redesign (unless the user explicitly opts out): (a) run `product-requirements-grilling` one question at a time -> (b) run `ui-ux-pro-max` (`skills/design/ui-ux-pro-max/SKILL.md`) to derive a pure UI/UX design specification (industry color palette, font pairing, grid anatomy) -> (c) combine that specification with `imagegen` / `image-generator` / `multimodal-media-director` / `nano-banana-pro` to generate a visual UI mockup image -> (d) obtain user approval before writing UI code.')
    [void]$builder.AppendLine(">")
    [void]$builder.AppendLine("> **Gate 3 $emDash Encounter -> Auto-Use Domain Capabilities (Zero Manual Skill Selection)**:")
    [void]$builder.AppendLine("> Never wait for the user to name a skill. Automatically activate the matching first-party skill when encountering:")
    [void]$builder.AppendLine('> - **Binaries / Bytecode / Obfuscated Bundles** -> `decompile-reconstruction` (`GhidraMCP` / `ida-reverse` / `jadx` / `ilspycmd` / `pycdc` / `webcrack`)')
    [void]$builder.AppendLine('> - **Post-Implementation Polish / Code Refactoring** -> `code-simplifier` (`ast-grep` structural rewrite + guard clauses + zero behavior regression)')
    [void]$builder.AppendLine('> - **Word / Excel / PPT Documents (`.docx`/`.xlsx`/`.pptx`)** -> `office-pro-suite` (executive typography, live Excel formulas with blue/black/green color coding, 16:9 action-title slides)')
    [void]$builder.AppendLine('> - **Text-to-Image / Video / Music Generation** -> `multimodal-media-director` (art direction, shot-by-shot camera storyboards, musical arrangement with BPM/Key/Metatags)')
    [void]$builder.AppendLine('> - **Novel / Fiction / Script Writing** -> `novel-story-architect` (`.story-bible/` continuity compiler, scene beat sheets, anti-AI-cliche prose filter)')
    [void]$builder.AppendLine('> - **Flowcharts / Swimlanes / Architecture Diagrams** -> `diagram-flowchart-architect` (`.drawio` XML, `.excalidraw` JSON, and themed `Mermaid`)')
    [void]$builder.AppendLine()
    [void]$builder.AppendLine("This is a generated primary-logic bundle. Regenerate it from scripts/build-profile.ps1 instead of editing it by hand.")
    [void]$builder.AppendLine()

    foreach ($relativePath in $files) {
        $fullPath = Join-Path $RepoRoot $relativePath
        if (-not (Test-Path $fullPath)) {
            throw "Profile file missing: $relativePath"
        }

        $content = Get-Content -Raw -Encoding UTF8 -Path $fullPath
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
