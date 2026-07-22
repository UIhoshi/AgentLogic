# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.
param(
    [Parameter(Mandatory)][string]$BriefPath,
    [ValidateSet('new_ui','existing_layout_change')][string]$Mode='new_ui',
    [switch]$RequireMockupDecision
)
$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $BriefPath)) { throw "Requirements brief not found: $BriefPath" }
$content = Get-Content -Raw -Encoding UTF8 -LiteralPath $BriefPath
$required = @('Goal and users', 'Core flow', 'Scope and non-goals', 'Content, brand, and assets', 'Integrations, data, and permissions', 'Responsive, accessibility, and performance constraints', 'Acceptance criteria', 'Decision log')
function Get-SectionBody([string]$Heading) {
    $pattern = '(?ms)^## ' + [regex]::Escape($Heading) + '\s*\r?\n(.*?)(?=^## |\z)'
    $match = [regex]::Match($content, $pattern)
    if (-not $match.Success) { throw "Brief is missing required section: ## $Heading" }
    return $match.Groups[1].Value.Trim()
}
foreach ($heading in $required) {
    $body = Get-SectionBody $heading
    if ([string]::IsNullOrWhiteSpace($body)) { throw "Brief section has no recorded content: ## $heading" }
}
if ($content -notmatch '(?im)^- User approval:\s*approved\s*$') { throw 'Brief is not user-approved.' }
if ($Mode -eq 'existing_layout_change') {
    $existing = Get-SectionBody 'Existing-layout change brief'
    foreach ($field in @('Current screenshot path', 'User dissatisfaction and requested changes')) {
        if ($existing -notmatch ('(?im)^- ' + [regex]::Escape($field) + '.*?:\s*\S.+$')) { throw "Existing-layout brief is missing a value for: $field" }
    }
}
if ($RequireMockupDecision -and $content -notmatch '(?im)^- Mockup decision:\s*(requested|explicitly opted out)\s*$') { throw 'Brief has no recorded mockup decision.' }
Write-Host "Requirements brief validation passed: $BriefPath"
