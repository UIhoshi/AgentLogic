# MANDATORY LOGIC GATE
# MANDATORY LOGIC GATE
#
# Read `AGENTS.md` and `README.md` before making changes here.
# Then follow the repository-declared logic entry chain.
# Before every new coding round, determine whether this task extends the previous round.
# If not, explicitly ask whether to forget/compress context first.
# This is a blocking gate; do not begin implementation before it is complete.

param([ValidateSet('generate','query','website-pipeline')][string]$Mode='generate',[string]$RepoRoot=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path,[string]$Brief='')
$ErrorActionPreference='Stop'
$registry=Get-Content -Raw -Encoding UTF8 (Join-Path $RepoRoot 'contracts\skill-registry.json')|ConvertFrom-Json
if($Mode -eq 'website-pipeline') {
  $graph=Get-Content -Raw -Encoding UTF8 (Join-Path $RepoRoot 'contracts\skill-workflow-graph.json')|ConvertFrom-Json
  $routing=Get-Content -Raw -Encoding UTF8 (Join-Path $RepoRoot 'contracts\skill-routing.json')|ConvertFrom-Json
  $pipeline=@($graph.default_pipelines|Where-Object id -eq 'website-delivery')
  if($pipeline.Count -ne 1){throw 'Missing website-delivery workflow pipeline.'}
  $phases=foreach($nodeId in @($pipeline[0].nodes)){
    $node=@($graph.nodes|Where-Object id -eq $nodeId)[0]
    $routes=@($node.route_ids|ForEach-Object {@($routing.routes|Where-Object id -eq $_)[0]})
    [ordered]@{stage=$node.id;posture=$node.posture;user_skill_selection_required=$node.user_skill_selection_required;routes=@($node.route_ids);candidate_skills=[string[]]@($routes|ForEach-Object {@($_.primary_host_skill_aliases)}|Select-Object -Unique);blocks=@($node.blocks);verification=@($node.verification)}
  }
  [ordered]@{intent='website delivery';orchestration=$graph.orchestration_policy.standard_product_workflow;user_facing_rule=$graph.orchestration_policy.user_interaction_rule;phases=@($phases);restricted_manual_paths=@($graph.orchestration_policy.restricted_manual_paths)}|ConvertTo-Json -Depth 10
  exit 0
}
if($Mode -eq 'query') {
  $tokens=@($Brief.ToLowerInvariant() -split '[^a-z0-9_-]+'|Where-Object {$_.Length -gt 2})
  $hits=@($registry.records|Where-Object {$_.activation.mode -eq 'guided_candidate'}|Where-Object {$hay=("$($_.activation.purpose) $($_.activation.explicit_signals -join ' ') $($_.activation.inferred_signals -join ' ')").ToLowerInvariant(); $explicitTokens=@(("$($_.activation.explicit_signals -join ' ')").ToLowerInvariant() -split '[^a-z0-9_-]+'|Where-Object {$_.Length -gt 2}); $matches=@($tokens|Where-Object {$hay.Contains($_)}); $matches.Count -ge 2 -and @($matches|Where-Object {$explicitTokens -contains $_}).Count -ge 1})
  [ordered]@{brief=$Brief;candidates=@($hits|ForEach-Object {[ordered]@{id=$_.id;entrypoint=$_.entrypoint;purpose=$_.activation.purpose;confirmation_policy=$_.activation.confirmation_policy}});confirmation_required=(@($hits).Count -gt 1);rejected_manual_count=@($registry.records|Where-Object {$_.activation.mode -eq 'manual'}).Count}|ConvertTo-Json -Depth 8
  exit 0
}
$out=Join-Path $RepoRoot 'documentation\skill-catalog.md'; New-Item -ItemType Directory -Force -Path (Split-Path $out) | Out-Null
$lines=@('# Portable Skill Catalog','',"Generated from `contracts/skill-registry.json`. It recommends only selection postures; availability, permissions, trust, and route closure remain separate.",'')
foreach($record in @($registry.records|Sort-Object family,id)){ $a=$record.activation; $lines += "## $($record.id)"; $lines += ('- Entry: `' + $record.entrypoint + '`'); $lines += ('- Lifecycle / posture: `' + $record.lifecycle + '` / `' + $a.mode + '`'); $lines += "- Purpose: $($a.purpose)"; $lines += "- Explicit signals: $(@($a.explicit_signals)-join ', ')"; $lines += "- Inferred signals: $(@($a.inferred_signals)-join ', ')"; $lines += "- Confirmation: $($a.confirmation_policy)"; $lines += '' }
[IO.File]::WriteAllText($out,($lines -join [Environment]::NewLine)+[Environment]::NewLine,[Text.UTF8Encoding]::new($false)); Write-Host "Generated skill catalog: $out"
