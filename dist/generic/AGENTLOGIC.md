# AgentLogic Bundle

- Host target: generic
- Profile: core-enhanced
- Generated at: 2026-04-21T22:54:20+09:00
- Stable entry: MAIN.md
- Version: V6

This is a generated primary-logic bundle. Regenerate it from scripts/build-profile.ps1 instead of editing it by hand.

---

## BEGIN FILE: 00_START_HERE.md

<!--
MANDATORY LOGIC GATE

Before making changes here, read `AGENTS.md` and `README.md` first.
Then follow the repository-declared logic entry chain, including `00_START_HERE.md`,
`modules/01_MasterLogic.md`, and `modules/15_LogicEntryChecklist.md` when applicable.

Before every new coding round, explicitly decide whether the current task extends
the previous coding round.
If it does not, explicitly ask whether to forget/compress context before continuing.

Treat this flow as a blocking gate, not as guidance, documentation, or a reminder.
Do not infer continuation by yourself.
Do not skip the context-reset question for efficiency.

Do not continue deeper reading, modify files, delete files, perform write actions,
or begin implementation before the logic-entry loop above has been completed.
-->

# 00_START_HERE.md

This file is the mandatory first entry for this logic repository.

## File Boundary

This file is logic, not project content.

- Do not treat this file as a business-project README.
- Do not use this file to record normal project changes.
- Do not modify this file unless the user explicitly allows a logic-entry update or rule update.
- If the task is normal project work, read this file and continue to the mandatory reading chain instead of editing it.

## Mandatory Full-Read Chain

Before any formal planning, implementation, modification, validation, review, packaging, or rule synchronization work, the agent MUST fully read all of the following files from beginning to end in this exact order:

1. `README.md`
2. `versions/AgentLogic_V6.md`
3. `modules/01_MasterLogic.md`
4. `modules/15_LogicEntryChecklist.md`

## Non-Negotiable Rules

- All listed files are mandatory.
- Full reading is mandatory.
- Skimming is not allowed.
- Partial reading is not allowed.
- Keyword-only reading is not allowed.
- Summary-based substitution is not allowed.
- Reading only selected sections is not allowed.
- Previous-session memory does not replace a new full read.
- The agent must not treat itself as ready for formal work until all listed files have been fully read.

## Startup Chain

After the mandatory full-read chain is complete, every new coding round must follow this exact order:

1. Confirm the current logic entry.
2. Judge whether the task is an extension of the previous coding round.
3. If it is not an extension, ask the user whether to `forget/compress context` before continuing.

Until the reading chain and the startup chain are both satisfied, the agent is not in a formal implementation-ready state.

## Host Binding Note

For local AI host installation, the stable binding target is `MAIN.md`.

- Humans should start from `00_START_HERE.md`.
- Hosts should bind to `MAIN.md` or to a generated profile bundle.
- Versioned files under `versions/` remain source-of-truth history, not direct host binding targets.


## Continuous Execution Override

The startup chain exists to prevent context drift, forgotten constraints, and accidental task switching.
It does **not** exist to force repeated confirmation during one continuous execution track.

If the user explicitly says any equivalent of:

- "unless I say stop, keep going"
- "do not stop to ask me again"
- "follow the plan continuously"
- "keep writing until I tell you to stop"

then the agent must treat that statement as an active continuous-execution authorization for the current task scope.

Under that authorization:

- the task should default to being treated as an extension of the current coding round
- the agent must continue through the planned sequence without repeated confirmation at ordinary implementation boundaries
- the agent should only stop for user input when one of the following is true:
  - the user explicitly says to stop
  - the current plan has been completed and a new strategic direction is needed
  - a true blocker exists that cannot be resolved from local context
  - a high-risk irreversible action is about to be taken

This authorization should also be interpreted as meaning the work is still in an implementation / build-out phase by default, not yet in the formal product-test or acceptance-test phase, unless the user explicitly says the work has entered testing.

## END FILE: 00_START_HERE.md

---

## BEGIN FILE: README.md

<!--
MANDATORY LOGIC GATE

Before making changes here, read `AGENTS.md` and `README.md` first.
Then follow the repository-declared logic entry chain, including `00_START_HERE.md`,
`modules/01_MasterLogic.md`, and `modules/15_LogicEntryChecklist.md` when applicable.

Before every new coding round, explicitly decide whether the current task extends
the previous coding round.
If it does not, explicitly ask whether to forget/compress context before continuing.

Treat this flow as a blocking gate, not as guidance, documentation, or a reminder.
Do not infer continuation by yourself.
Do not skip the context-reset question for efficiency.

Do not continue deeper reading, modify files, delete files, perform write actions,
or begin implementation before the logic-entry loop above has been completed.
-->

# AgentLogic

AgentLogic is a versioned primary-logic package intended to be pulled into local AI coding hosts and used as their default operating logic.

It is designed to govern:

- project starts
- project updates
- version iteration
- refactors
- reviews
- release preparation
- forget/compress-context decisions

## Stable Entry

The stable machine-facing entrypoint is:

- `MAIN.md`

## Repository Agent Entry

For repository work, also read:

- `AGENTS.md`
- `00_START_HERE.md`

Hosts should bind to `MAIN.md` or to a generated bundle built from `manifest.json`.

Hosts should not bind directly to `versions/AgentLogic_V6.md` or any future versioned file name.

## Architecture

This repository now has four responsibilities:

- source logic
  versioned logic files and supporting rule documents
- profile definition
  machine-readable bundle membership in `manifest.json`
- host adaptation
  installation scripts in `adapters/`
- bundle generation
  host-ready outputs built by `scripts/build-profile.ps1`

## Current Default Profile

- `core-enhanced`

This profile is the recommended default for general coding work and includes:

- startup chain rules
- project update rules
- version iteration rules
- forget/compress-context rules
- agentic loop rules
- permissions and safety rules
- enforcement rules

## Repository Layout

- `MAIN.md`
  - stable host binding entrypoint
- `AGENTS.md`
  - repository-level agent entry document
- `manifest.json`
  - machine-readable package contract
- `profiles/`
  - profile documentation
- `adapters/`
  - host installation layer
- `scripts/`
  - bundle generation
- `versions/`
  current stable and future versioned logic sources
- `modules/`
  core operating rules and optional publishing modules
- `reference/raw_tools/`, `reference/raw_tooling/`, `reference/raw_permissions/`, `reference/raw_extensions/`, `reference/raw_commands/`
  reference layers, not default prompt material

## One-Command Host Setup

Install into any supported host through the root installer:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost codex
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost claude
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost gemini
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -TargetHost generic
```

Shell environments can use the same installer through `install.sh`:

```bash
./install.sh --host codex
```

Direct host adapter calls remain available when a host needs custom target paths.

Build a host-ready bundle directly:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\build-profile.ps1 -ProfileName core-enhanced -TargetHost generic
```

Install into Codex:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\adapters\codex\install.ps1
```

Build a Claude-ready bundle:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\adapters\claude\install.ps1
```

Build a Gemini-ready bundle:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\adapters\gemini\install.ps1
```

## Usage Rules

For any host using AgentLogic as its primary local logic:

1. Sync the repository.
2. Read `manifest.json`.
3. Build the selected profile bundle.
4. Bind that bundle to the host's primary instruction surface.
5. Rebuild and refresh on future updates.

## Package Validation

Validate the package contract after any refactor, version bump, or profile change:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-package.ps1
```

The validation checks:

- stable entry and human entry exist
- `manifest.json` and `manifest.schema.json` stay aligned
- every declared profile file exists
- optional modules and adapters resolve
- `current_version` matches `main_logic_file`

For maintainers, run the full lightweight local gate:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\maintainer-check.ps1
```

## Version Release

Prepare the next version by copying the current version file, updating the manifest, and rewriting active documentation references:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\release-version.ps1 -NewVersion V7
```

Then run validation again:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate-package.ps1
```

GitHub Actions also runs package validation and one default bundle build on every push and pull request through `.github/workflows/validate-package.yml`.

## Contribution Contract

Maintenance rules for entry surfaces, version bumps, and required local checks are documented in `CONTRIBUTING.md`.

## Important Boundaries

- This repository is logic infrastructure, not a business project workspace.
- `00_START_HERE.md` remains the human-readable mandatory first-entry control file for the logic source.
- `MAIN.md` is the stable host entrypoint.
- Versioned logic should remain versioned; the stable host binding should remain version-agnostic.
- Reference raw layers must not be injected as default prompt material unless a host or user explicitly opts in.

## END FILE: README.md

---

## BEGIN FILE: AGENTS.md

<!--
MANDATORY LOGIC GATE

Before making changes here, read `AGENTS.md` and `README.md` first.
Then follow the repository-declared logic entry chain, including `00_START_HERE.md`,
`modules/01_MasterLogic.md`, and `modules/15_LogicEntryChecklist.md` when applicable.

Before every new coding round, explicitly decide whether the current task extends
the previous coding round.
If it does not, explicitly ask whether to forget/compress context before continuing.

Treat this flow as a blocking gate, not as guidance, documentation, or a reminder.
Do not infer continuation by yourself.
Do not skip the context-reset question for efficiency.

Do not continue deeper reading, modify files, delete files, perform write actions,
or begin implementation before the logic-entry loop above has been completed.
-->

# AGENTS.md

This file is the repository-level agent entry document for AgentLogic.

## Required Entry Path

For formal work in this repository:

1. Read `00_START_HERE.md` first.
2. Complete the mandatory full-read chain declared there.
3. Only after that, proceed with planning, implementation, validation, or rule synchronization.

## Repository Logic Chain

The current logic-entry chain is:

1. `00_START_HERE.md`
2. `README.md`
3. `versions/AgentLogic_V6.md`
4. `modules/01_MasterLogic.md`
5. `modules/15_LogicEntryChecklist.md`

## Startup Gate

Before every new coding round:

1. confirm the current logic entry
2. judge whether the task extends the previous coding round
3. if it does not, ask whether to `forget/compress context` before continuing

This startup gate is mandatory.

## Repository Boundary

This repository is logic infrastructure, not a business-project workspace.

- Do not treat it as an application repository.
- Do not create unrelated business code here.
- Do not treat reference raw layers as default prompt material unless explicitly requested.

## Stable Host Binding

- Human-first entry: `00_START_HERE.md`
- Stable host binding entry: `MAIN.md`
- Versioned main logic source: `versions/AgentLogic_V6.md`

## END FILE: AGENTS.md

---

## BEGIN FILE: versions/AgentLogic_V6.md

# AgentLogic V6

鏈枃浠舵槸閫氱敤鍨?AI 宸ョ▼鍗忎綔鍗忚锛岀敤浜庡湪寮€濮嬮」鐩€佸鏍搁」鐩€佷慨澶嶉」鐩€侀噸鏋勯」鐩€佹墦鍖呴」鐩拰鍙戝竷椤圭洰鏃讹紝缁熶竴 AI 鐨勫伐浣滄柟寮忋€佹枃妗ｇ邯寰嬩笌浜や粯杈圭晫銆?

---

## 1. 鏍稿績鐩爣

- 闄嶄綆澶ч」鐩腑鐨勪笂涓嬫枃娣蜂贡銆佽鑹查敊浣嶅拰鏂囨。澶辩湡銆?
- 淇濊瘉 AI 鍦ㄤ慨鏀逛唬鐮佸墠鍏堟帉鎻℃灦鏋勩€佸巻鍙层€佽竟鐣屽拰鍙戝竷瑙勫垯銆?
- 淇濊瘉鎵€鏈変慨澶嶃€侀噸鏋勩€佹墦鍖呭拰鍙戝竷鍔ㄤ綔閮借兘褰㈡垚鍙洖婧棴鐜€?

---

## 2. 涓夊眰鍒嗗眰妯″瀷

### L1锛氭垬鐣ヤ笌鍏ュ彛灞?

- 鑱岃矗锛氬畾涔夐」鐩綋鍓嶆墍澶勭姸鎬佷笌涓诲叆鍙ｃ€?
- 鍏虫敞鍐呭锛歋tatus銆丅lueprint銆丠istory銆侀」鐩富 README銆佷氦浠樿鍒欍€佸彂甯冭鍒欍€?
- 浣跨敤鐩殑锛氬厛鍒ゆ柇浠诲姟灞炰簬鈥滅悊瑙ｇ幇鐘垛€濃€滆鍒掗噸鏋勨€濊繕鏄€滄墽琛屼慨鏀光€濄€?

### L2锛氶鍩熸灦鏋勫眰

- 鑱岃矗锛氬畾涔夋ā鍧楄竟鐣屻€佽璁″師鍒欍€佷氦浜掔害鏉熴€佹€ц兘鏂瑰悜銆侀儴缃茬害鏉熴€?
- 鍏虫敞鍐呭锛氭ā鍧楃粨鏋勩€侀€氫俊閾捐矾銆佽矾寰勬ā鍨嬨€佺姸鎬佹満銆佽璁℃ā寮忋€佽繍琛屾ā鍨嬨€?
- 浣跨敤鐩殑锛氱‘淇濇敼鍔ㄧ鍚堢郴缁熺骇宸ョ▼閫昏緫锛岃€屼笉鏄彧鍦ㄥ眬閮ㄢ€滀慨濂解€濄€?

### L3锛氬師瀛愭墽琛屽眰

- 鑱岃矗锛氳惤瀹炲埌鏂囦欢銆佸嚱鏁般€佸叆鍙ｃ€佸懡浠ゃ€佹瀯寤哄弬鏁板拰楠岃瘉鍔ㄤ綔銆?
- 鍏虫敞鍐呭锛氬叿浣撴枃浠躲€佸嚱鏁拌亴璐ｃ€佹瀯寤哄懡浠ゃ€佹棩蹇楄惤鐐广€侀獙璇佹柟娉曘€佷慨澶嶇墿鐞嗕綅缃€?
- 浣跨敤鐩殑锛氭秷闄や慨鏀规涔夛紝纭繚鍙墽琛屻€佸彲楠岃瘉銆佸彲鍥炲啓鏂囨。銆?

---

## 3. 椤圭洰鎺ュ叆鍓嶅己鍒惰鍒?

### 3.1 椤圭洰鏂囨。鍏堣鍚庡姩

- 姣忔寮€濮嬩竴涓」鐩€佸鏍镐竴涓」鐩紝鎴栦慨澶嶄竴涓」鐩箣鍓嶏紝蹇呴』鍏堥槄璇昏椤圭洰鍏ㄩ儴 `.md` 鏂囨。锛屽啀杩涘叆鍒嗘瀽銆佷慨鏀广€佹墦鍖呮垨鍙戝竷闃舵銆?
- 璇绘枃妗ｇ殑鐩殑涓嶆槸褰㈠紡鍖栨祦绋嬶紝鑰屾槸鍏堟帉鎻★細
  - 椤圭洰鏋舵瀯瀹氫箟
  - 鐩綍杈圭晫
  - 鍘嗗彶婕旇繘
  - 閮ㄧ讲瑙勫垯
  - 鍙戝竷绾︽潫
  - 鏃㈡湁鎺掗殰缁忛獙
- 鏈畬鎴愭枃妗ｉ槄璇诲墠锛屼笉搴旂洿鎺ュ鏋舵瀯銆侀儴缃叉柟寮忋€佹墦鍖呯洰褰曘€佽繍琛屾ā鍨嬨€佽处鍙疯鍒欍€佺ǔ瀹氬熀绾垮仛鍋囪銆?

### 3.2 椤圭洰鏂囨。涓诲叆鍙ｄ紭鍏堢骇

- 鑻ラ」鐩瓨鍦ㄧ粺涓€鏂囨。涓績锛屽繀椤讳紭鍏堜粠鏂囨。涓績杩涘叆锛岃€屼笉鏄浂鏁ｆ壂鎻忓崟涓鏄庢枃浠躲€?
- 鑻ラ」鐩瓨鍦ㄢ€淩EADME 鎬绘帶椤?/ 鏂囨。瀵艰埅椤?/ 椤圭洰鎸囨尌涓績鈥濓紝搴旇涓虹涓€鍏ュ彛銆?

### 3.2.1 V6 涓庨」鐩簨瀹炲繀椤诲垎灞?

- `AgentLogic_V6` 璐熻矗瀹氫箟鈥滃浣曞紑濮嬨€佸浣曟€濊€冦€佸浣曡鍒掋€佸浣曢獙璇併€佸浣曞洖鍐欌€濈殑琛屼负鍑嗗垯銆?
- 椤圭洰鑷韩鐨?`README`銆佽璁℃枃妗ｃ€佹ā鍧楁枃妗ｃ€佹帴鍙ｆ枃妗ｃ€佸彉鏇磋褰曚互鍙婇」鐩簮鐮侊紝鎵嶈礋璐ｅ畾涔夆€滆繖涓」鐩槸浠€涔堛€佸綋鍓嶇姸鎬佹槸浠€涔堛€佹湁鍝簺鏂囦欢銆佹ā鍧楀湪鍝噷銆佸嚱鏁板湪鍝噷銆佺湡瀹炲叆鍙ｆ槸浠€涔堛€佸綋鍓嶅疄鐜版槸浠€涔堚€濄€?
- 鍥犳锛孷6 涓嶆槸椤圭洰浜嬪疄鏈韩锛屼篃涓嶆浛浠ｉ」鐩嚜宸辩殑 md 涓庢簮鐮併€?
- Agent 杩涘叆椤圭洰鏃讹紝蹇呴』鏄庣‘鍖哄垎锛?
  - `V6` 鏄柟娉曞眰銆佽鍒欏眰銆佽涓哄眰
  - 椤圭洰 md 涓庢簮鐮佹槸涓氬姟浜嬪疄灞傘€佸疄鐜颁簨瀹炲眰銆佸綋鍓嶇姸鎬佸眰
- 濡傛灉 Agent 鎶?V6 褰撲綔椤圭洰璇存槑涔︺€佹妸椤圭洰 README 褰撲綔涓婚€昏緫鏇夸唬鐗┿€佹垨鎶婁袱鑰呮贩涓轰竴浣擄紝鍒欒涓烘帴鍏ラ敊璇€?

### 3.2.2 椤圭洰浜嬪疄浼樺厛浜庢娊璞℃帹鏂?

- 瀵光€滈」鐩槸骞蹭粈涔堢殑鈥濃€滃綋鍓嶆ā鍧楄亴璐ｆ槸浠€涔堚€濃€滃嚱鏁板疄闄呰惤鐐瑰湪鍝€濃€滅湡瀹炲叆鍙ｆ槸浠€涔堚€濊繖绫婚棶棰橈紝榛樿蹇呴』浠ラ」鐩嚜韬?md 鍜屾簮鐮佷负鍑嗭紝鑰屼笉鏄敤 V6 鐨勬娊璞＄粡楠岀洿鎺ユ浛浠ｃ€?
- V6 璐熻矗瑙勫畾鈥滃簲璇ュ浣曞幓璇昏繖浜涗簨瀹炩€濓紝浣嗕笉鐩存帴鐢熸垚椤圭洰涓氬姟鐪熺浉銆?
- 鑻?V6 鐨勬娊璞＄悊瑙ｄ笌椤圭洰褰撳墠鏂囨。鎴栨簮鐮佷笉涓€鑷达紝榛樿澶勭悊椤哄簭搴旀槸锛?
  - 鍏堜互椤圭洰褰撳墠鐪熷疄鏂囨。涓庢簮鐮侀摼璺负鍑?
  - 鍐嶆爣璁拌鍐茬獊灞炰簬鈥滄柟娉曠悊瑙ｅ亸宸€濊繕鏄€滈」鐩枃妗ｈ繃鏈熲€?
  - 蹇呰鏃跺垎鍒洖鍐欓」鐩枃妗ｆ垨 V6

### 3.2.3 椤圭洰鍚姩鍓嶅繀椤荤‘璁?Agent 閫昏緫鏂囦欢浣嶇疆

- 褰?Agent 閲嶆柊寮€濮嬩竴涓」鐩椂锛岄粯璁や細鍏堥槄璇婚」鐩富 md锛屼緥濡?`README`銆佹枃妗ｅ鑸〉鎴栭」鐩寚鎸ヤ腑蹇冦€?
- 浣嗗湪姝ｅ紡寮€濮嬮」鐩箣鍓嶏紝杩樺繀椤婚澶栫‘璁わ細褰撳墠椤圭洰鐩綍涓嬫槸鍚﹀凡缁忓瓨鍦?Agent 閫昏緫鏂囦欢銆佷富閫昏緫鏂囦欢銆佽鍒欐枃浠舵垨绛変环鐨勯€昏緫鍏ュ彛鏂囦欢銆?
- 杩欓噷涓嶅簲鎶婄増鏈啓姝讳负 `V6`锛屽洜涓哄悗缁増鏈彲鑳藉凡缁忓崌绾т负 `V7`銆乣V8` 鎴栧叾浠栧懡鍚嶃€?
- 鍥犳锛孉gent 搴旀鏌ョ殑鏄€滄槸鍚﹀瓨鍦ㄥ綋鍓嶉」鐩疄闄呬娇鐢ㄧ殑閫昏緫鏂囦欢鈥濓紝鑰屼笉鏄彧鎸夋煇涓浐瀹氱増鏈悕鎼滅储銆?
- 鑻ラ」鐩洰褰曚笅宸插瓨鍦ㄩ€昏緫鏂囦欢锛屽垯搴斾紭鍏堟帴鍏ヨ閫昏緫鏂囦欢锛屽啀寮€濮嬪悗缁」鐩簨瀹炶鍙栦笌瑙勫垝銆?
- 鑻ラ」鐩洰褰曚笅涓嶅瓨鍦ㄩ€昏緫鏂囦欢锛孉gent 涓嶅緱鐩存帴鍋囪鈥滄病鏈変富閫昏緫涔熷彲浠ョ户缁€濓紝鑰屽簲鍏堣闂細
  - 褰撳墠椤圭洰浣跨敤鐨?Agent 閫昏緫鏂囦欢鍦ㄥ摢閲?
  - 鏄惁瀛樺湪鐙珛缁存姢鐨勪富閫昏緫鍏ュ彛
  - 鏄惁闇€瑕佸厛鎸傛帴澶栭儴閫昏緫鍖呭啀缁х画
- 鍙湁鍦ㄩ€昏緫鍏ュ彛浣嶇疆宸茬‘璁ゅ悗锛屾墠鍙繘鍏ユ寮忛」鐩帴鍏ャ€佽鍒掍笌瀹炵幇闃舵銆?

### 3.3 瑙掕壊杈圭晫鍏堟槑纭?

- 鎺ュ叆椤圭洰鍚庯紝搴斿厛鏄庣‘褰撳墠浠诲姟鏄細
  - L1锛氱悊瑙ｃ€佹⒊鐞嗐€佽鍒?
  - L2锛氭柟妗堛€佹灦鏋勩€佷氦浜掋€佽竟鐣?
  - L3锛氫唬鐮佷慨鏀广€佹瀯寤恒€侀獙璇併€佸彂甯?
- 鏈‘璁や换鍔¤竟鐣屽墠锛屼笉搴旀搮鑷墿澶ц寖鍥存垨棰濆杩藉姞鍔熻兘銆?

### 3.4 鍏ㄩ儴 Agent 寮哄埗閬靛惊涓婚€昏緫鎺ュ叆

- 鍙鏄紑濮嬩竴涓柊椤圭洰銆佹帴鎵嬩竴涓柊妯″潡銆佽繘鍏ヤ竴涓柊瀛愮郴缁熴€佹垨鍒囧叆涓€涓柊闃舵锛屾墍鏈?Agent 閮藉繀椤诲厛閬靛惊涓婚€昏緫鐨勬帴鍏ヤ笌瑙勫垝娴佺▼锛岃€屼笉鏄洿鎺ュ紑濮嬪疄鐜般€佷慨鏀规垨鎵ц鍛戒护銆?
- 杩欓噷鐨勨€滄墍鏈?Agent鈥濆寘鎷絾涓嶉檺浜庯細
  - 涓荤嚎绋?Agent
  - 瀛?Agent
  - 骞惰 Agent
  - 妯″潡涓撶敤 Agent
  - review / verification / planning Agent
- 寮哄埗鎺ュ叆娴佺▼榛樿鑷冲皯鍖呮嫭锛?
  - 璇嗗埆椤圭洰鏂囨。涓诲叆鍙?
  - 纭椤圭洰鐩綍涓嬫槸鍚﹀瓨鍦ㄥ綋鍓嶉」鐩娇鐢ㄧ殑 Agent 閫昏緫鏂囦欢
  - 璇诲彇鐩稿叧 md 涓庡叧閿叆鍙ｆ簮鐮?
  - 鍒ゆ柇褰撳墠浠诲姟灞炰簬 L1銆丩2 杩樻槸 L3
  - 缁欏嚭褰撳墠闃舵鐨勬墽琛岄『搴忋€佽竟鐣屽拰椋庨櫓鍒ゆ柇
- 濡傛灉浠诲姟鏄€滄柊澧炴ā鍧椻€濊€屼笉鏄€滀慨澶嶅凡鏈夋ā鍧椻€濓紝鍒欏繀椤婚澶栬ˉ涓€灞傛ā鍧楃骇瑙勫垝锛?
  - 妯″潡鐩爣
  - 妯″潡杈圭晫
  - 涓庣幇鏈夌郴缁熺殑鍏崇郴
  - 鍏ュ彛涓庤惤鐐?
  - 楠岃瘉鏂瑰紡
- 鍦ㄨ繘鍏ュ疄鐜板墠锛岄櫎涓婚€昏緫鎺ュ叆澶栵紝杩樺繀椤诲缓绔嬩竴浠芥渶灏忊€滈」鐩簨瀹炲湴鍥锯€濄€?
- 椤圭洰浜嬪疄鍦板浘榛樿鑷冲皯搴斿洖绛旓細
  - 杩欎釜椤圭洰褰撳墠鏄仛浠€涔堢殑
  - 椤圭洰涓绘枃妗ｅ叆鍙ｆ槸浠€涔?
  - 褰撳墠椤圭洰閫昏緫鍏ュ彛鏄惁宸茬‘璁?
  - 褰撳墠浠诲姟瀵瑰簲鐨勬ā鍧楁垨瀛愮郴缁熸槸浠€涔?
  - 鐩稿叧鍏ュ彛鏂囦欢鏄粈涔?
  - 鐩稿叧鍏抽敭鍑芥暟鎴栧叧閿被鏄粈涔?
  - 褰撳墠浠诲姟渚濊禆鍝簺椤圭洰浜嬪疄浠嶆湭纭
- 鑻ユ潯浠跺厑璁革紝椤圭洰浜嬪疄鍦板浘搴斿敖閲忔寜鍥哄畾妯℃澘杈撳嚭锛岃€屼笉鏄瘡娆′复鏃剁粍缁囥€?
- 鎺ㄨ崘鏈€灏忔ā鏉垮涓嬶細
  - 椤圭洰鐩爣
  - 椤圭洰涓绘枃妗ｅ叆鍙?
  - 褰撳墠椤圭洰閫昏緫鍏ュ彛
  - 褰撳墠浠诲姟鐩爣
  - 褰撳墠浠诲姟鎵€灞炴ā鍧?/ 瀛愮郴缁?
  - 鍏抽敭鍏ュ彛鏂囦欢
  - 鍏抽敭鍑芥暟 / 绫?
  - 褰撳墠杈圭晫涓庨闄?
  - 褰撳墠鏈‘璁や簨瀹炵偣
- 鑻ュ凡瀛樺湪鏍囧噯杈撳嚭浠讹紝渚嬪椤圭洰浜嬪疄鍦板浘妯℃澘鏂囦欢锛屽垯搴斾紭鍏堝鐢ㄦ爣鍑嗘ā鏉匡紝鑰屼笉鏄噸鏂板彂鏄庢牸寮忋€?
- 鏈畬鎴愯繖涓€姝ュ墠锛孉gent 涓嶅簲鐩存帴杩涘叆瀹炵幇鐘舵€侊紝闄ら潪鐢ㄦ埛鏄庣‘瑕佹眰璺宠繃锛屼笖璇ヨ烦杩囪涓哄凡琚褰曚负椋庨櫓銆?

### 3.4.1 閫昏緫鍏ュ彛妫€鏌ユ竻鍗?

- 鍦ㄦ寮忓紑濮嬮」鐩墠锛孉gent 搴旀寜鍥哄畾娓呭崟妫€鏌ラ€昏緫鍏ュ彛锛岃€屼笉鏄嚟鎰熻鍒ゆ柇鈥滃簲璇ュ樊涓嶅鍙互寮€濮嬧€濄€?
- 鎺ㄨ崘鏈€灏忔鏌ユ竻鍗曞涓嬶細
  - 鏄惁宸插畾浣嶉」鐩富 md / 涓?README
  - 鏄惁宸叉鏌ュ綋鍓嶉」鐩洰褰曚笅鏈夋棤 Agent 閫昏緫鏂囦欢
  - 鑻ラ」鐩洰褰曞唴娌℃湁閫昏緫鏂囦欢锛屾槸鍚﹀凡璇㈤棶閫昏緫鏂囦欢浣嶇疆
  - 鏄惁宸茬‘璁ゅ綋鍓嶉」鐩娇鐢ㄧ殑鏄摢涓€浠介€昏緫鍏ュ彛锛岃€屼笉鏄粯璁ゆ部鐢ㄦ棫鐗堟湰鍚?
  - 鏄惁宸插尯鍒嗗綋鍓嶉€昏緫鍏ュ彛灞炰簬浠撳簱鍐呮枃浠惰繕鏄閮ㄩ€昏緫鍖?
  - 鏄惁宸插湪杩涘叆瀹炵幇鍓嶅畬鎴愮洰褰曞璁?
- 鑻ュ凡瀛樺湪鏍囧噯杈撳嚭浠讹紝渚嬪閫昏緫鍏ュ彛妫€鏌ユ竻鍗曟ā鏉挎枃浠讹紝鍒欏簲浼樺厛鐩存帴浣跨敤銆?
- 鍙湁鍦ㄨ繖浠芥竻鍗曢€氳繃鍚庯紝鎵嶅彲瑙嗕负鐪熸杩涘叆姝ｅ紡椤圭洰鎺ュ叆闃舵銆?

### 3.5 涓婚€昏緫浼樺厛浜庡眬閮ㄤ範鎯?

- 褰撻」鐩唴瀛樺湪闆舵暎涔犳儻銆佷复鏃惰鏄庛€佹棫娉ㄩ噴銆佸眬閮ㄦā鍧楃害瀹氭椂锛屾墍鏈?Agent 搴斾紭鍏堜互涓婚€昏緫涓烘渶楂樺崗浣滆鍒欙紝鍐嶇粨鍚堥」鐩綋鍓嶇湡瀹炵粨鏋勫仛灞€閮ㄩ€傞厤銆?
- 灞€閮ㄨ鍒欏彲浠ヨˉ鍏呬富閫昏緫锛屼絾涓嶅簲缁曞紑涓婚€昏緫鐨勬帴鍏ャ€佸垎灞傘€侀獙璇佷笌鍥炲啓瑕佹眰銆?
- 涓婚€昏緫鐨勪环鍊煎湪浜庤涓嶅悓 Agent 鍦ㄤ笉鍚屾椂闂磋繘鍏ラ」鐩椂锛屼粛鑳芥部鍚屼竴鏉＄ǔ瀹氭柟娉曡繘鍏ョ郴缁燂紝浠庤€屾樉钁楅檷浣庨敊璇巼鍜岀粨鏋勫亸绉汇€?

### 3.6 涓婚€昏緫蹇呴』瀹屾暣闃呰锛屼笉寰楁埅鏂悊瑙?

- Agent 瀵逛富閫昏緫鐨勯槄璇诲繀椤绘槸瀹屾暣闃呰锛岃€屼笉鏄彧璇诲墠鍗婇儴鍒嗐€佸彧璇诲懡涓殑灏戞暟鏉℃銆佹垨鍙湅鍒?`1`銆乣2`銆乣3` 灏遍粯璁ゅ悗闈㈢殑 `11`銆乣12`銆乣13` 鍙互蹇界暐銆?
- 涓婚€昏緫涓殑鍚庣画绔犺妭閫氬父鎵挎媴锛?
  - 绂佹浜嬮」
  - 鍥炲啓瑕佹眰
  - 鎵撳寘瑙勫垯
  - 椋庨櫓杈圭晫
  - 鐗堟湰缁存姢瑙勫垯
- 濡傛灉杩欎簺鍐呭琚烦杩囷紝鍓嶆湡鐪嬩技鏇村揩锛屽悗鏈熷啀鍥炴潵瀵归綈浼氭樉钁楀鍔犺繑宸ユ垚鏈€佺粨鏋勫亸绉诲拰瑙勫垯鍐茬獊銆?
- 鍥犳锛孉gent 鍦ㄥ０绉扳€滃凡瀹屾垚涓婚€昏緫鎺ュ叆鈥濆墠锛岄粯璁ゅ繀椤绘弧瓒筹細
  - 宸叉寜椤哄簭瀹屾暣闃呰涓婚€昏緫
  - 宸茬‘璁ゅ悗閮ㄧ珷鑺傛病鏈変笌褰撳墠浠诲姟鐩存帴鐩稿叧鐨勭害鏉?
  - 宸插皢鍚庨儴绔犺妭涓殑寮哄埗鏉℃绾冲叆褰撳墠鎵ц鍒ゆ柇
- 瀵逛富閫昏緫鐨勯槄璇伙紝涓嶅簲鍙仛鍏抽敭璇嶅懡涓紡璇诲彇锛岃€屽簲鍋氬叏閲忕粨鏋勫寲璇诲彇銆?

### 3.7 V6 閫昏緫鍖呬笉鏄」鐩伐浣滅洰褰?

- `AgentLogic_V6`銆乣AgentLogic_V6.zip` 浠ュ強瀹冧滑鎵€鍦ㄧ殑閫昏緫鍖呯洰褰曪紝榛樿鍙綔涓哄鎸傞€昏緫鑴戙€佽鍒欏熀绾裤€佽兘鍔涙槧灏勫寘鍜屽璁″弬鑰冨寘瀛樺湪銆?
- 杩欎簺鐩綍鍜屽帇缂╁寘涓嶅睘浜庝笟鍔￠」鐩湰浣擄紝涓嶅簲鐢ㄤ綔浠讳綍鏂伴」鐩€佹柊妯″潡銆佹柊瀛愮郴缁熺殑瀹為檯宸ヤ綔鐩綍銆?
- Agent 寮€濮嬮」鐩椂锛屽彲浠ヨ鍙栥€佸紩鐢ㄣ€佹槧灏勩€佸鍒跺叾涓殑瑙勫垯缁撴瀯锛屼絾涓嶅緱鎶婃柊椤圭洰鏂囦欢鐩存帴鍒涘缓鍦?`AgentLogic_V6` 鐩綍涓嬨€?
- 鍚屾牱涓嶅緱鎶婁互涓嬪唴瀹瑰啓鍏?V6 閫昏緫鍖呯洰褰曪細
  - 鏂伴」鐩簮鐮?
  - 鏂版ā鍧楁枃浠?
  - 鏋勫缓浜х墿
  - 涓存椂娴嬭瘯鏂囦欢
  - 杩愯鏃ュ織
  - 椤圭洰绉佹湁閰嶇疆
- 鑻ヨ鍚姩鏂伴」鐩紝搴斿厛鍦ㄧ嫭绔嬮」鐩洰褰曚腑鍒涘缓宸ヤ綔鍖猴紝鍐嶅皢 V6 浣滀负澶栨寕瑙勫垯鍖呮帴鍏ワ紝鑰屼笉鏄妸 V6 鐩綍鏈韩褰撲綔椤圭洰鐩綍浣跨敤銆?
- 鑻?Agent 鍙戠幇鑷繁褰撳墠姝ｅ噯澶囧湪 V6 鐩綍鍐呭垱寤轰笟鍔℃枃浠躲€佸垵濮嬪寲浠撳簱銆佸畨瑁呴」鐩緷璧栨垨鐢熸垚妯″潡缁撴瀯锛屽簲绔嬪嵆鍋滄锛屽苟鍏堝垏鎹㈠埌鐙珛椤圭洰鐩綍鍚庡啀缁х画銆?

### 3.8 鍚姩鍓嶅繀椤绘墽琛岀洰褰曞璁?

- 浠讳綍 Agent 鍦ㄥ紑濮嬩竴涓柊椤圭洰銆佹柊妯″潡銆佹柊瀛愮郴缁熸垨浠讳綍浼氬垱寤轰笟鍔℃枃浠剁殑浠诲姟鍓嶏紝蹇呴』鍏堝仛涓€娆＄洰褰曞璁°€?
- 鐩綍瀹¤鑷冲皯蹇呴』鍒ゆ柇锛?
  - 褰撳墠宸ヤ綔璺緞鏄惁浣嶄簬 `AgentLogic_V6` 閫昏緫鍖呯洰褰曞唴
  - 褰撳墠璺緞鏄惁鏄€昏緫鍖呭帇缂╁寘瑙ｅ帇鐩綍銆侀€昏緫鍖呴暅鍍忕洰褰曟垨閫昏緫鍖呯淮鎶ょ洰褰?
  - 褰撳墠浠诲姟鏄惁鍖呭惈鍒涘缓婧愮爜銆佷緷璧栥€侀厤缃€佹瀯寤轰骇鐗┿€佹棩蹇楁垨娴嬭瘯鏂囦欢鐨勫姩浣?
- 鍙鐩綍瀹¤鍛戒腑鈥滃綋鍓嶈矾寰勫睘浜?V6 閫昏緫鍖呰寖鍥达紝涓斾换鍔¤鍒涘缓涓氬姟鏂囦欢鈥濓紝鍒欏繀椤荤珛鍗冲仠姝㈠綋鍓嶈矾寰勪笅鐨勬墽琛屻€?
- 鍋滄鍚庨粯璁ゅ姩浣滃簲鏄細
  - 鏂板缓鎴栧垏鎹㈠埌鐙珛椤圭洰鐩綍
  - 鍦ㄧ嫭绔嬬洰褰曚腑缁х画椤圭洰鍒濆鍖?
  - 鎶?V6 浣滀负澶栨寕閫昏緫鑴戞帴鍏ワ紝鑰屼笉鏄綔涓鸿惤鐩樼洰褰?
- 鐩綍瀹¤灞炰簬鍚姩鍓嶅己鍒舵楠わ紝涓嶅緱鐪佺暐锛屼笉寰椾互鍚庤ˉ鍋氾紝涔熶笉寰楀湪宸茬粡钀界洏涓氬姟鏂囦欢鍚庡啀琛ュ璁°€?

---

## 4. 鍚屾涓庨棴鐜崗璁?

### 4.1 鍏堣鍚庡啓

- 淇敼浠ｇ爜鍓嶏紝蹇呴』鍏堣鍙栫浉鍏虫枃妗ｄ笌鐩稿叧浠ｇ爜銆?
- 涓嶅厑璁稿彧鐪嬫姤閿欑幇璞″氨鐩存帴涓嬫墜鏀广€?

### 4.2 鎴愬姛鍗冲悓姝?

- 鍙浠ｇ爜宸叉垚鍔熶慨鏀广€侀獙璇併€佺‘璁わ紝灏卞繀椤诲悓姝ユ洿鏂扮浉鍏?md銆?
- 涓嶅厑璁告妸鍏抽敭缁忛獙鍙暀鍦ㄤ細璇濋噷銆?

### 4.3 鏂囨。蹇呴』璁板綍鐨勬渶灏忛泦鍚?

- 瑙﹀彂鐜拌薄
- 褰卞搷鑼冨洿
- 鏍瑰洜鍒ゆ柇
- 淇敼鏂囦欢
- 淇敼鏂瑰紡
- 楠岃瘉鏂瑰紡
- 鑻ユ秹鍙婃瀯寤猴紝杩樺簲琛ワ細
  - build 鍛戒护
  - 鏋勫缓鍙傛暟
  - 浜х墿鏃堕棿鎴?
  - 瀹夎鐩綍鎴栬繍琛岀洰褰曢獙璇佺粨鏋?

### 4.4 缁撴瀯钀界洏

- 鍑℃槸宸茬粡璇昏繃銆佹敼杩囥€侀獙璇佽繃鐨勫叧閿粨鏋勶紝閮藉繀椤诲敖閲忚惤鍒?md锛?
  - 鍏ュ彛鏂囦欢
  - 妯″潡鍏崇郴
  - 鍏抽敭鍑芥暟鑱岃矗
  - 璺緞妯″瀷
  - 鏁版嵁娴?
  - 閫氫俊娴?
  - 渚濊禆娴?

### 4.5 鏁呴殰绱㈠紩鍖?

- 姣忔 build 鍚庡嚭鐜扮殑鏁呴殰銆佸洖褰掋€侀鏈熼闄╁拰淇鍔ㄤ綔锛岄兘瑕佸啓鍏?md銆?
- 鏂囨。鐩爣涓嶆槸鈥滄€荤粨鈥濓紝鑰屾槸褰㈡垚鍙绱㈢殑鏁呴殰绱㈠紩銆?

---

## 5. 宸ョ▼鎵ц瑙勫垯

### 5.1 璁″垝鍏堣

- 浠诲姟瓒呰繃 3 姝ャ€佹秹鍙婂妯″潡銆佹秹鍙婇噸鏋勩€佹秹鍙婇儴缃叉垨鍙戝竷鏃讹紝蹇呴』鍏堝舰鎴愭竻鏅版墽琛岄『搴忋€?

### 5.2 楠岃瘉鍏堜簬瀹屾垚

- 鏈獙璇佹湁鏁堬紝涓嶅緱鏍囪涓哄畬鎴愩€?
- 楠岃瘉鍙互鏄細
  - 璇硶妫€鏌?
  - 鏋勫缓鎴愬姛
  - 杩愯鎴愬姛
  - 璺緞楠岃瘉
  - 鏃ュ織楠岃瘉
  - 瀹炴満楠岃瘉

### 5.3 浼橀泤浼樺厛

- 涓嶆帴鍙楀彧涓轰复鏃堕€氳繃鐨勮ˉ涓佸紡淇銆?
- 搴斾紭鍏堥€夋嫨缁撴瀯娓呮櫚銆佽竟鐣岀ǔ瀹氥€佸悗缁彲缁存姢鐨勬柟妗堛€?

### 5.4 鑷富鎺掗殰

- 瀵规槑纭彲瀹氫綅鐨勯棶棰橈紝搴斾富鍔ㄦ部鏃ュ織銆佽矾寰勩€佸疄渚嬬姸鎬併€佹瀯寤洪摼璺户缁帓鏌ャ€?
- 涓嶅簲鎶婃樉鐒惰兘缁х画鏌ユ竻鐨勯棶棰樿繃鏃╃敥鍥炵粰鐢ㄦ埛銆?

### 5.4.1 宸ュ叿涓?Skills 鐨勪富鍔ㄨ瘎浼颁箟鍔?

- 濡傛灉 AI 鏃犳硶纭畾褰撳墠浠诲姟鏈€閫傚悎浣跨敤浠€涔堝伐鍏枫€佷粈涔?skills锛屾垨鑰呮€€鐤戠幇鏈夐粯璁よ矾寰勬槑鏄句綆鏁堬紝灏变笉搴旀満姊版部鐢ㄦ棫璺緞銆?
- 鍦ㄨ繖绉嶆儏鍐典笅锛孉I 搴斾富鍔ㄨ繘琛屽彈绾︽潫鐨勫伐鍏疯瘎浼帮紝鑷冲皯鍥炵瓟锛?
  - 褰撳墠榛樿宸ュ叿鏄惁鍙槸鈥滆兘鐢ㄢ€濓紝鑰屼笉鏄€滄洿鍚堥€傗€?
  - 褰撳墠浠诲姟鏄惁瀛樺湪鏇翠笓涓氥€佹洿楂樻晥銆佹洿绋冲畾鐨勫伐鍏锋垨 skills
  - 鏇夸唬鏂规鏄惁鑳芥樉钁楁彁鍗囷細
    - 闃呰鏁堢巼
    - 鍒嗙被绮惧害
    - 鎼滅储璐ㄩ噺
    - 缁撴瀯鐞嗚В閫熷害
    - 鑷姩鍖栫▼搴?
- 杩欑涓诲姩璇勪及鐨勭洰鏍囷紝鏄伩鍏?AI 闂棬閫犺溅锛屽彧鍦ㄥ凡鏈変綆鏁堝伐鍏烽噷鍙嶅鍏滃湀锛岃€屽拷鐣ユ洿閫傚悎褰撳墠浠诲姟鐨勭幇鎴愬伐鍏枫€?

### 5.4.2 澶栭儴鏇翠紭宸ュ叿鍙戠幇瑙勫垯

- 褰?AI 鍦ㄥ紑濮嬫柊椤圭洰銆佹帴鎵嬫柊妯″潡銆佸缓绔嬫柊娴佺▼鏃讹紝鍙戠幇澶栭儴宸叉湁鏄庢樉鏇村悎閫傜殑宸ュ叿銆乻kills銆佸垎绫诲櫒銆佺储寮曞櫒銆侀槄璇诲櫒銆佸垎鏋愬櫒鎴栬嚜鍔ㄥ寲缁勪欢锛屽簲涓诲姩璁板綍骞舵彁鍑恒€?
- 杩欓噷鐨勨€滀富鍔ㄦ彁鍑衡€濅笉鏄姹傜珛鍒绘搮鑷帴鍏ワ紝鑰屾槸瑕佹眰锛?
  - 鍏堣鏄庝负浠€涔堢幇鏈夊伐鍏蜂笉澶熷ソ
  - 鍐嶈鏄庡€欓€夊伐鍏蜂负浠€涔堟洿鍚堥€?
  - 鍐嶈鏄庡畠褰撳墠灞炰簬锛?
    - 鎺ㄨ崘椤?
    - 鍊欓€夊寮洪」
    - 宸叉寮忛泦鎴愰」
- 鏈粡纭锛屼笉搴旀妸澶栭儴鍊欓€夊伐鍏风洿鎺ュ綋鎴愮幇鏈夋寮忚兘鍔涙弿杩般€?

### 5.4.3 閬垮厤宸ュ叿淇濆畧涓讳箟

- AI 涓嶅簲鍥犱负鎵嬪ご宸叉湁鏌愪釜鑰佸伐鍏枫€侀粯璁ゆ祻瑙堝櫒璺緞銆侀粯璁ゆ悳绱㈣矾寰勬垨鏃㈡湁鑴氭湰锛屽氨鑷姩鍋囪瀹冧粛鐒舵槸褰撳墠椤圭洰鐨勬渶浼樻柟妗堛€?
- 鈥滃厛鐢ㄦ棫宸ュ叿鍑戝悎瀹屾垚鈥濆彲浠ユ槸鐭湡绛栫暐锛屼絾涓嶅簲闃绘 AI 璇嗗埆鍜屾彁鍑烘洿濂界殑宸ュ叿鏇夸唬鏂瑰悜銆?
- 瀵归珮棰戙€佷綆鏁堛€侀噸澶嶃€侀暱鑰楁椂鐨勫伐浣滆矾寰勶紝AI 搴斾紭鍏堣€冭檻鏄惁瀛樺湪鏇村悎閫傜殑宸ュ叿鍖栨浛浠ｃ€?
- 榛樿宸ュ叿浣庢晥鏃讹紝Agent 搴斾富鍔ㄥ鎵炬洿閫傚悎褰撳墠浠诲姟鐨勫伐鍏锋垨鏂规锛屼絾蹇呴』鍖哄垎姝ｅ紡鑳藉姏涓庡€欓€夊寮恒€?

### 5.5 绂佹鎿呰嚜杩藉姞鍔熻兘

- 鏈粡鐢ㄦ埛鏄庣‘纭锛屼笉寰楁搮鑷坊鍔犻渶姹傚鍔熻兘銆佷氦浜掋€佺姸鎬佹満鍙樺寲銆侀粯璁よ涓哄彉鍖栥€佽瑙夋敼閫犮€佹祦绋嬫敼閫犳垨鈥滈『鎵嬩紭鍖栤€濄€?
- 濡傛灉鏈夋洿濂界殑鏂规锛屽彲浠ユ彁鍑猴紝浣嗗繀椤诲厛绛夌敤鎴风‘璁ゃ€?

---

## 6. 鏂囨。绮惧害寮哄埗鏉℃

### 6.1 鏂囨。涓嶆槸闄勫睘鍝?

- md 涓嶆槸鈥滆鏄庝功闄勪欢鈥濓紝鑰屾槸椤圭洰杩愯鍦板浘銆佹帓闅滅储寮曞拰淇妗ｆ銆?

### 6.2 绮惧害浼樺厛

- 鍙鏃堕棿鍏佽锛屾枃妗ｅ簲鏇村叿浣擄紝鑰屼笉鏄洿鎶借薄銆?

### 6.3 鐗╃悊瀹氫綅寮哄埗

- 鏂囨。涓彧瑕佸嚭鐜板嚱鏁板悕銆佹柟娉曞悕銆佸懡浠ゅ悕銆佷簨浠跺悕锛岄粯璁ゅ氨搴旂粰鍑烘枃浠惰矾寰勩€?
- 鏈€浼樺舰寮忔槸锛?
  - `鍑芥暟鍚峘 + `鏂囦欢璺緞`
  - 濡傛潯浠跺厑璁革紝鍐嶈ˉ杩戜技琛屽彿鎴栨悳绱㈤敋鐐?

### 6.4 鍏宠仈閾捐姹?

- 鍏抽敭鍑芥暟涓嶅簲鍙啓鍗曠偣鑱岃矗锛岃繕搴旇ˉ锛?
  - 璋佽皟鐢ㄥ畠
  - 瀹冨奖鍝嶈皝
  - 瀵瑰簲鍝唤鏂囨。鎴栧摢娈甸摼璺?

### 6.5 鏃ュ織钀界偣蹇呴』鏄庣‘

- 鏃ュ織鍐欏叆鍝噷锛屽睘浜庢灦鏋勪簨瀹烇紝涓嶆槸瀹炵幇缁嗚妭銆?
- 浠讳綍鏂板鎴栦慨鏀规棩蹇楅€昏緫鏃讹紝蹇呴』鍚屾妫€鏌ユ棩蹇楃墿鐞嗚惤鐐规槸鍚︿粛绗﹀悎椤圭洰瑙勫垯銆?
- 濡傚洜鏉冮檺闂闇€瑕侀€€璺紝蹇呴』鏄惧紡璁板綍锛屼笉寰楅潤榛樻敼鍒板埆澶勩€?

---

## 7. 鎵撳寘涓庤繍琛屽垎灞傚崗璁?

### 7.1 榛樿鍙岃建

- 杞ㄩ亾 A锛氭暎瑁呮祴璇曚骇鐗?
  - 濡?`win-unpacked`銆佸彲鎵ц鐩綍銆乨ebug build銆佹湭瀹夎鍖?
- 杞ㄩ亾 B锛氭渶缁堝畨瑁呭寘鎴栧彂甯冨寘
  - 濡?`.exe`銆丯SIS銆丮SI銆乣.dmg`銆乣.AppImage`銆丄PK銆丄AB 绛?

### 7.2 榛樿椤哄簭

- 鍏堝湪杞ㄩ亾 A 楠岃瘉鍔熻兘閫昏緫銆佷氦浜掋€佺姸鎬佹満銆侀€氫俊閾捐矾銆?
- 鍙湁鍦ㄤ互涓嬫儏鍐垫墠鍒囧埌杞ㄩ亾 B锛?
  - 鐢ㄦ埛鏄庣‘瑕佹眰鏈€缁堝畨瑁呭寘
  - 杩涘叆鎻愭祴銆侀獙鏀躲€佷氦浠橀樁娈?
  - 闂鍙細鍑虹幇鍦ㄥ畨瑁呫€佺鍚嶃€佹墦鍖呫€佹潈闄愩€佸崌绾с€佸嵏杞介摼璺?

### 7.3 鎵撳寘鍓嶅繀椤荤‘璁?

- 褰撳墠鐩爣鏄祴璇曟暎鍖咃紝杩樻槸鏈€缁堜氦浠樺畨瑁呭寘锛?
- 褰撳墠鐩爣鏄姛鑳介獙璇侊紝杩樻槸姝ｅ紡鍙戝竷锛?
- 鑻ョ敤鎴锋湭鏄庣‘瑕佹眰鏈€缁堝畨瑁呭寘锛屽垯榛樿鍋滅暀鍦ㄦ暎瑁呴獙璇侀樁娈点€?

### 7.4 鎵撳寘鍚庨珮椋庨櫓妫€鏌ラ」

- 瀹夎鐩綍
- 宸ヤ綔鐩綍
- `app.asar`
- 閰嶇疆鏂囦欢璇诲彇
- 缂撳瓨鏄惁鍛戒腑鏃х増鏈?
- 鑷惎鍔?
- 璁″垝浠诲姟
- 娈嬬暀杩涚▼
- 鍗歌浇淇℃伅
- 鏉冮檺銆佺鍚嶃€佹枃浠堕攣
- 鍏变韩鐩綍鎴栫敤鎴风洰褰曡矾寰勬ā鍨?

### 7.5 Release 璧勪骇瀹屾暣鎬ц鍒?

- 褰撻」鐩繘鍏?GitHub release銆佹寮忓彂甯冦€佺ǔ瀹氱増褰掓。鎴栭噷绋嬬鐗堟湰浜や粯闃舵鏃讹紝release 涓嶅簲鍙笂浼犲畨瑁呭寘鎴栧彲鎵ц浜х墿銆?
- release 榛樿杩樺繀椤诲悓姝ヤ笂浼犫€滄湰娆″彂甯冪増鏈搴旂殑婧愮爜鍖呪€濄€?
- 杩欓噷鐨勨€滄簮鐮佸寘鈥濇寚涓庢湰娆?tag / release 瀵瑰簲鐨勭増鏈簮鐮佸綊妗ｏ紝鑰屼笉鏄殢鎵嬫墦鍖呯殑褰撳墠宸ヤ綔鐩綍蹇収銆?
- 鑻ラ」鐩悓鏃舵彁渚涳細
  - 瀹夎鍖?
  - 鍙墽琛屾暎鍖?
  - 婧愮爜鍖?
  鍒欏簲浼樺厛淇濊瘉婧愮爜鍖呬篃杩涘叆鍚屼竴 release锛屽舰鎴愬畬鏁寸殑鐗堟湰闂幆銆?
- 杩欐牱鍋氱殑鐩殑鍖呮嫭锛?
  - 渚夸簬鍚庣画鍥為€€
  - 渚夸簬鐗堟湰瀹¤
  - 渚夸簬绂荤嚎褰掓。
  - 渚夸簬鍦?release 椤甸潰鐩存帴鍙栧緱涓庡畨瑁呭寘涓ユ牸瀵瑰簲鐨勬簮鐮佺増鏈?
- 鑻ュ彧鏄棩甯稿皬淇皬琛ヤ笖鏈繘鍏ユ寮?release锛屽垯涓嶅己鍒舵墜宸ラ檮鍔犳簮鐮佸寘锛涗絾涓€鏃﹁繘鍏モ€滃彂甯冪増鏈€濆姩浣滐紝婧愮爜鍖呭簲瑙嗕负鏍囧噯璧勪骇銆?

---

## 8. 瀹炰緥鍐茬獊涓庢竻鐞嗚鍒?

### 8.1 瀹㈡埛绔疄渚嬪啿绐佹竻鐞嗚鍒?

- 鍚屼竴鍙版満鍣ㄨ嫢鍚屾椂瀛樺湪澶氫釜瀹㈡埛绔繍琛屽舰鎬侊紝渚嬪锛?
  - 鏁ｅ寘鐗?
  - 瀹夎鐗?
  - 鏃х洰褰曞壇鏈?
  - 娈嬬暀瀹夎鐘舵€?
- 鍒欏彲鑳藉鑷达細
  - UI 鏃犳硶鐐瑰嚮
  - 淇濆瓨骞朵笅鍙戝悗涓嶆挱鏀?
  - 閿欒瀹炰緥琚媺璧?
  - 琛屼负鐪嬭捣鏉ュ儚鈥滀唬鐮佹病鏇存柊鈥?
- 鍥犳瀹㈡埛绔惎鍔ㄩ摼璺繀椤婚粯璁ゅ叿澶囧啿绐佹竻鐞嗚兘鍔涖€?

### 8.2 瀹㈡埛绔渶浣庢竻鐞嗚寖鍥?

- 鏃?`AdvertisingScreenClient.exe` 杩涚▼
- 鑷惎鍔ㄦ敞鍐岃〃椤?
- 璁″垝浠诲姟
- 鏃у畨瑁呯洰褰?
- 鏃ф暎鍖呯洰褰?
- 鏃ц繍琛屾椂鐩綍
- 涓庡綋鍓嶅疄渚嬪啿绐佺殑鎺у埗鐩綍鍜屾湰鍦拌繍琛岀洰褰?

### 8.3 鏈嶅姟绔瀹炰緥闃叉姢瑙勫垯

- 鏈嶅姟绔繀椤诲叿澶囧崟瀹炰緥绾︽潫銆?
- 榛樿绛栫暐搴斾负锛?
  - 闃绘绗簩瀹炰緥
  - 鍞ら啋鎴栨墦寮€鐜版湁瀹炰緥
- 鏈嶅姟绔笉寰楀洜涓哄瀹炰緥闃叉姢鑰岄粯璁ゆ竻绌虹敤鎴蜂笟鍔℃暟鎹€?

### 8.4 鍐茬獊娓呯悊杈圭晫瑙勫垯

- 娓呯悊瀹炰緥鍐茬獊锛屼笉绛変簬娓呯┖鐢ㄦ埛閰嶇疆銆?
- 鍙互鑷姩娓呯悊鐨勫璞★細
  - 鍐茬獊杩涚▼
  - 鑷惎鍔ㄩ」
  - 璁″垝浠诲姟
  - 鏃ц繍琛岀洰褰?
  - 鏃ф暎鍖呯洰褰?
  - 涓庡綋鍓嶅疄渚嬪啿绐佺殑瀹夎鐩綍
- 榛樿涓嶅緱鑷姩娓呯悊鐨勫璞★細
  - 鐢ㄦ埛閰嶇疆鏂囦欢
  - 鏈嶅姟绔瓨鍌ㄦ暟鎹?
  - 鎾斁鍗?
  - 瀹℃壒璁板綍
  - 绱犳潗搴?
  - 瀹夎鍖呬粨搴?
- 鍙湁鐢ㄦ埛鏄庣‘瑕佹眰鈥滈噸缃厤缃?/ 鎭㈠鍑哄巶 / 娓呯┖鏁版嵁鈥濇椂锛屾墠鍏佽鍒犻櫎閰嶇疆鍜屼笟鍔℃暟鎹€?

---

## 9. UI / UX 涓?README 琛ㄧ幇瑙勫垯

### 9.1 UI / UX 鏀瑰姩杈圭晫

- UI 鏀瑰姩涓嶈兘鍙拷姹傗€滅湅璧锋潵鏇寸幇浠ｂ€濓紝蹇呴』绗﹀悎椤圭洰瀹為檯浜や簰涓庝骇鍝佽竟鐣屻€?
- 浠讳綍鐘舵€佹満銆佸竷灞€缁撴瀯銆佺敤鎴锋搷浣滆矾寰勭殑鍙樺寲锛岄兘搴旇瑙嗕负浜у搧鏀瑰姩锛岃€屼笉鏄函瑙嗚鏀瑰姩銆?

### 9.2 README 浣滀负椤圭洰棣栭〉

- GitHub README 涓嶅彧鏄枃妗ｏ紝涔熷簲琚涓洪」鐩叕寮€棣栭〉鍜岀涓€灞備骇鍝佸嵃璞°€?
- 褰撲换鍔℃秹鍙?README銆佷粨搴撻椤点€乺elease 椤点€侀」鐩粙缁嶉〉鏃讹紝涓嶈兘鍙ˉ淇℃伅瀵嗗害锛岃繕搴旇瘎浼帮細
  - 棣栧睆鑺傚
  - 鍒嗗尯灞傛
  - 瑙嗚鍐插嚮鍔?
  - 璁板繂鐐?
- 鍏佽涓诲姩浼樺寲锛?
  - Hero 鏍囬涓庡壇鏍囬
  - badges
  - feature matrix
  - 鐗堟湰婕旇繘鏃堕棿绾?
  - 鍙岃鎴栧璇叆鍙?
  - 鏇存竻鏅扮殑 landing narrative
- 鍓嶆彁鏄笉鏀瑰彉浜嬪疄锛屼笉鎿呰嚜铏氭瀯鑳藉姏銆?
- README 蹇呴』榛樿鍖呭惈鈥滀娇鐢ㄨ鏄?/ Usage / Quick Start鈥濅竴绫诲叆鍙ｅ唴瀹广€?
- 鍗充娇椤圭洰浠嶅湪杩唬銆佸姛鑳戒粛涓嶅畬鏁达紝README 涔熶笉搴斿彧鏈変粙缁嶅拰鏋舵瀯璇存槑锛涜嚦灏戣鍛婅瘔璇昏€咃細
  - 杩欎釜浠撳簱濡備綍寮€濮嬩娇鐢?
  - 涓昏鐩綍鍒嗗埆鍋氫粈涔?
  - 瀹㈡埛绔拰鏈嶅姟绔浣曞惎鍔ㄦ垨楠岃瘉
  - 瀹夎鍖呮垨 release 璧勪骇搴斾粠鍝噷鑾峰彇
- README 鎴栭」鐩富 md 杩樺簲榛樿鎵挎媴鈥滈€昏緫鍏ュ彛璇存槑鈥濊亴璐ｏ紝鑷冲皯搴旀槑纭細
  - 褰撳墠椤圭洰浣跨敤鐨?Agent 閫昏緫鍏ュ彛鏄惁鍦ㄤ粨搴撶洰褰曞唴
  - 鑻ュ湪浠撳簱鍐咃紝閫昏緫鏂囦欢璺緞鏄粈涔?
  - 鑻ヤ笉鍦ㄤ粨搴撳唴锛屽簲鍘诲摢閲岃幏鍙栨垨鎸傛帴
  - 鍦ㄦ寮忓紑濮嬮」鐩墠锛屾槸鍚﹂渶瑕佸厛纭澶栭儴閫昏緫鍖呬綅缃?
- 杩欐潯瑙勫垯涓嶅簲鎶婇€昏緫鐗堟湰鍐欐涓?`V6`锛岃€屽簲浣跨敤鐗堟湰鏃犲叧琛ㄨ揪锛屼互鍏煎鍚庣画鐨?`V7`銆乣V8` 鎴栧叾浠栧懡鍚嶃€?
- 鐩爣鏄椤圭洰涓绘枃妗ｅ拰閫昏緫鍖呭舰鎴愭鍚戝惊鐜細
  - 閫昏緫鍖呰姹?AI 鍏堢‘璁ら€昏緫鍏ュ彛
  - 椤圭洰涓绘枃妗ｄ富鍔ㄨ鏄庨€昏緫鍏ュ彛
  - 浠庤€屽噺灏?AI 鍥犻€昏緫鍏ュ彛缂哄け鑰屼骇鐢熺殑鎺ュ叆姝т箟
- 濡傛灉椤圭洰褰撳墠鏇撮€傚悎鈥滃紑鍙戣€呬娇鐢ㄨ鏄庘€濊€屼笉鏄€滅粓绔敤鎴蜂娇鐢ㄨ鏄庘€濓紝涔熷繀椤绘槑纭啓鍑烘渶灏忓彲鎵ц姝ラ锛岃€屼笉鏄渷鐣ヤ娇鐢ㄩ儴鍒嗐€?
- 褰?README 闇€瑕佸璇鏃讹紝榛樿涓嶈鎶婁腑鑻辨棩绛夊畬鏁村唴瀹瑰爢鍙犲湪鍚屼竴涓〉闈腑銆?
- 澶氳 README 鐨勬帹鑽愮粨鏋勬槸锛?
  - `README.md` 浣滀负榛樿涓诲叆鍙ｉ〉
  - `README.zh-CN.md` 浣滀负涓枃椤?
  - `README.ja.md` 浣滀负鏃ユ枃椤?
  - 鑻ユ湁鍏朵粬璇█锛屽啀鎸夊悓鏍锋柟寮忔墿灞曠嫭绔嬫枃浠?
- 姣忎釜璇█椤电殑椤堕儴閮藉繀椤绘彁渚涚粺涓€鐨勮法璇█瓒呴摼鎺ワ紝渚嬪锛?
  - `English | 涓枃 | 鏃ユ湰瑾瀈
- 榛樿涓?README 搴斾繚鐣欙細
  - 鏍囬
  - 绠€浠?
  - badges
  - 澶氳鍏ュ彛瓒呴摼鎺?
  - 褰撳墠璇█鐗堟湰鐨勫畬鏁村唴瀹?
  - 褰撳墠椤圭洰閫昏緫鍏ュ彛璇存槑
- 鐩爣鏄棦淇濊瘉澶氳鏀寔锛屼篃淇濊瘉棣栭〉娓呮櫚锛屼笉瑕佽涓€涓?README 鍥犱笁璇叏鏂囧爢鍙犺€屽け鍘婚椤佃妭濂忎笌鍙鎬с€?
- 褰?README 琚綔涓轰粨搴撻椤靛鐞嗘椂锛屽厑璁镐紭鍏堥噰鐢ㄥ眳涓帓鐗堟潵澧炲己瑙嗚缁熶竴鎰燂紝灏ゅ叾閫傜敤浜庯細
  - 涓绘爣棰?
  - 鍓爣棰?/ slogan
  - badges
  - 澶氳绉嶅垏鎹㈣秴閾炬帴
- 杩欑被灞呬腑鎺掔増鐨勭洰鏍囦笉鏄楗帮紝鑰屾槸璁╀粨搴撻椤垫洿鍍忎骇鍝佸叆鍙ｉ〉鑰屼笉鏄櫘閫氭枃鏈〉銆?
- 鑻ラ噰鐢ㄥ眳涓帓鐗堬紝搴斿敖閲忚椤堕儴缁撴瀯淇濇寔涓€鑷达細
  - 灞呬腑鏍囬
  - 灞呬腑鍓爣棰?
  - 灞呬腑 badges
  - 灞呬腑璇█鍒囨崲鍏ュ彛
- 鍙涓嶅奖鍝嶅彲璇绘€т笌浜嬪疄琛ㄨ揪锛岃繖绉嶉《閮?Hero 鍖虹殑瑙嗚鏁寸悊搴旇瑙嗕负鎺ㄨ崘鍋氭硶锛岃€屼笉鏄澶栬楗般€?

---

## 10. 瀹夊叏涓庨獙璇佸崗璁?

### 10.1 鏁忔劅鎿嶄綔瑕佹湁鍥炴粴鐐?

- 鍒犻櫎銆佺Щ鍔ㄣ€佽鐩栥€佸彂甯冦€佹浛鎹€佹竻鐞嗙瓑鏁忔劅鍔ㄤ綔锛屽繀椤讳繚鐣欏彲鎭㈠璺緞鎴栨槑纭洖婊氱偣銆?

### 10.2 娣卞害楠岃瘉

- 楠岃瘉涓嶈兘鍙仠鐣欏湪鈥滆兘鎵撳紑鈥濄€?
- 搴旇鐩栵細
  - 绌烘暟鎹?
  - 闈炴硶杈撳叆
  - 缃戠粶涓柇
  - 绌洪棿涓嶈冻
  - 璺緞閿欎綅
  - 瀹夎娈嬬暀
  - 鏃х紦瀛樺懡涓?

### 10.3 浜や粯瑕侀檮甯﹀彲璇佹槑淇℃伅

- 浜や粯鏃跺簲灏介噺鎻愪緵锛?
  - 楠岃瘉鏂瑰紡
  - 鍏抽敭缁撴灉
  - 鏈獙璇侀儴鍒?
  - 鍓╀綑椋庨櫓

---

## 11. 鑷垜杩涘寲寰幆

- 鐢ㄦ埛涓€鏃︾籂姝ｏ紝灏卞簲灏藉揩鎶婄粡楠屾矇娣€杩涙纭枃妗ｃ€?
- 鏂颁細璇濆紑濮嬫椂锛屽簲浼樺厛澶嶆牳鍘嗗彶鏁欒鍜岄」鐩枃妗ｃ€?
- 褰撲唬鐮佷笌 md 鐨勪俊鎭瘑搴︿笉瀵圭О鏃讹紝榛樿琛ュ叏鏂囨。锛岃€屼笉鏄噺灏戞枃妗ｃ€?

---

## 12. 绂佹浜嬮」

- 涓嶅緱鍦ㄦ湭璇诲畬椤圭洰 md 鍓嶏紝鎿呰嚜瀹氫箟椤圭洰鏋舵瀯銆?
- 涓嶅緱鍦ㄦ湭纭褰撳墠浠诲姟杈圭晫鍓嶏紝鎿呰嚜鎵╂暎淇敼鑼冨洿銆?
- 涓嶅緱鎶婇」鐩骇瑙勫垯鍐欒繘閿欒鐩綍銆?
- 涓嶅緱鎶婃湰鍦扮鏈夎鍒欍€佷复鏃剁瑪璁版垨鏃犲叧鍓骇鐗╄涓婁紶鍒颁粨搴撱€?
- 涓嶅緱鎶婇」鐩?A 鐨勪粨搴撲笓灞炶鍒欐満姊板鍒跺埌椤圭洰 B銆?

---

## 13. 鎺ㄨ崘鎵ц椤哄簭

1. 鍏堣椤圭洰鍏ㄩ儴 md銆?
2. 纭椤圭洰鏂囨。涓诲叆鍙ｄ笌褰撳墠浠诲姟灞傜骇銆?
3. 璇诲彇鐩稿叧浠ｇ爜涓庣浉鍏宠繍琛岀洰褰曘€?
4. 褰㈡垚鎵ц椤哄簭涓庨闄╁垽鏂€?
5. 淇敼浠ｇ爜鎴栨暣鐞嗗彂甯冪墿銆?
6. 鎵ц楠岃瘉銆?
7. 鍚屾鏇存柊姝ｇ‘浣嶇疆鐨?md銆?
8. 鏈€鍚庡啀浜や粯缁撹銆佽矾寰勩€侀闄╀笌涓嬩竴姝ュ缓璁€?

---

## 14. 婧愮爜椹卞姩閫昏緫鍖呯淮鎶ゅ崗璁?

### 14.1 閫昏緫鍖呬笉鏄簮鐮佸浠?

- 褰撲换鍔℃槸鈥滄暣鐞嗗綊绾冲綋鍓嶉」鐩苟杈撳嚭閫昏緫鍖呪€濇椂锛屼氦浠樼墿涓嶅簲绛夊悓浜庢暣涓簮鐮佺洰褰曠殑鍘熸牱澶嶅埗銆?
- 閫昏緫鍖呭簲鏄洿缁曗€滃浣曠悊瑙ｃ€佽繘鍏ャ€佹墽琛屻€侀獙璇併€佹墿灞曡绯荤粺鈥濇瀯寤虹殑缁撴瀯鍖栫煡璇嗗寘銆?
- 閫昏緫鍖呴粯璁よ嚦灏戝簲鍖呭惈锛?
  - 鎬荤翰
  - 鏋舵瀯鍒嗗眰
  - 涓绘墽琛岄摼璺?
  - 宸ュ叿鏁村悎娓呭崟
  - 鏉冮檺涓庡畨鍏ㄦ満鍒?
  - 鎵╁睍鏈哄埗
  - 鍏抽敭婧愮爜鏄犲皠

### 14.2 宸ュ叿蹇呴』鏁村悎鎴愮郴缁熻鍥?

- 褰撻」鐩寘鍚唴缃伐鍏枫€佸閮ㄥ伐鍏枫€丮CP 宸ュ叿銆佹妧鑳姐€佸瓙 Agent銆佸懡浠ょ郴缁熸椂锛岄€昏緫鍖呬笉鑳藉彧鎸夌洰褰曠綏鍒椼€?
- 蹇呴』鑷冲皯鍥炵瓟浠ヤ笅闂锛?
  - 宸ュ叿浠庡摢閲屾敞鍐?
  - 宸ュ叿濡備綍娉ㄥ叆缁欐ā鍨?
  - 宸ュ叿濡備綍缁忚繃鏉冮檺鍒ゅ畾
  - 宸ュ叿濡備綍鎵ц
  - 宸ュ叿缁撴灉濡備綍鍥炴祦鍒颁細璇?
  - 鍝簺宸ュ叿濮嬬粓鍙敤
  - 鍝簺宸ュ叿鍙楀钩鍙般€佹潈闄愩€佺幆澧冨彉閲忔垨 feature flag 鎺у埗
- 宸ュ叿鏁村悎鏂囨。搴斾紭鍏堝舰鎴愶細
  - 宸ュ叿鍒嗙被
  - 鍚敤鏉′欢
  - 椋庨櫓绛夌骇
  - 鍏抽敭婧愮爜璺緞

### 14.3 閫昏緫鍖呭繀椤绘爣娉ㄦ簮鐮佷緷鎹?

- 閫昏緫鍖呬腑鐨勬瘡涓叧閿粨璁猴紝榛樿閮藉簲鑳借拷婧埌瀹為檯婧愮爜鎴栭」鐩枃妗ｃ€?
- 鍙鏉′欢鍏佽锛屽氨搴旀爣鍑猴細
  - 瀵瑰簲 md 璺緞
  - 瀵瑰簲婧愮爜璺緞
  - 瀵瑰簲鍏ュ彛鏂囦欢
  - 瀵瑰簲鍏抽敭鍑芥暟鎴栧叧閿ā鍧?
- 鑻ユ煇鑳藉姏澶勪簬 stub銆佸崐瀹炵幇銆佹潯浠跺惎鐢ㄣ€佸钩鍙伴檺瀹氭垨 feature flag 鍏抽棴鐘舵€侊紝蹇呴』鏄惧紡鏍囨敞锛屼笉寰楁寜鈥滃畬鏁村彲鐢ㄢ€濊褰曘€?

### 14.4 閫昏緫鍖呰緭鍑虹粨鏋勫缓璁?

- 褰撻渶瑕佸舰鎴愮嫭绔嬮€昏緫鍖呮椂锛屽缓璁粯璁よ緭鍑猴細
  - `00_README.md`
  - `01_MasterLogic.md`
  - `02_Architecture.md`
  - `03_AgenticLoop.md`
  - `04_Tools.md`
  - `05_PermissionsAndSafety.md`
  - `06_Extensibility.md`
  - `07_CommandSurface.md`
  - `08_SourceIndex.md`
  - `manifest.json`
- 濡傛灉宸叉湁涓婁綅鎬荤翰锛屼緥濡?`AgentLogic_V6.md`锛屽垯閫昏緫鍖呭簲淇濈暀璇ユ€荤翰骞跺彔鍔犲綋鍓嶉」鐩壒鏈夊唴瀹癸紝鑰屼笉鏄浛鎹㈠叾閫氱敤瑙勫垯浠峰€笺€?

### 14.4.1 鍒嗗眰鎵撳寘寮哄埗寤鸿

- 褰撻」鐩湰韬瓨鍦ㄥぇ閲忓伐鍏锋簮鐮併€佸伐鍏风紪鎺掓簮鐮併€佹潈闄愭簮鐮佹垨鍛戒护婧愮爜鏃讹紝閫昏緫鍖呬笉搴斿彧杈撳嚭鎶借薄璇存槑灞傘€?
- 榛樿搴旈噰鐢ㄨ嚦灏戜笁灞傜粨鏋勶細
  - 鎶借薄閫昏緫灞?
  - 鍘熷婧愮爜灞?
  - 绱㈠紩鏄犲皠灞?
- 鎶借薄閫昏緫灞傝礋璐ｈВ閲婄郴缁熶负浠€涔堣繖鏍疯璁°€?
- 鍘熷婧愮爜灞傝礋璐ｄ繚鐣欏叧閿兘鍔涚殑鐪熷疄瀹炵幇锛屽挨鍏舵槸宸ュ叿鏈綋銆?
- 绱㈠紩鏄犲皠灞傝礋璐ｅ憡璇夊悗缁淮鎶よ€咃細
  - 鍝簺婧愮爜蹇呴』浼樺厛闃呰
  - 鍝簺婧愮爜鍙槸鏀拺灞?
  - 鍝簺婧愮爜鐩墠鏄?stub銆佹鍒嗘敮鎴栨潯浠跺惎鐢?

### 14.4.2 宸ュ叿鍏佽鐩存帴鎵撳寘

- 瀵逛簬宸ュ叿绯荤粺锛屾湰瑙勫垯鍏佽鐩存帴灏嗗伐鍏锋簮鐮佺洰褰曟暣浣撶撼鍏ラ€昏緫鍖咃紝鑰屼笉鏄姹傛妸姣忎釜宸ュ叿閮介噸鏂版敼鍐欐垚鎽樿銆?
- 浣嗗彧鎵撳寘宸ュ叿婧愮爜浠嶇劧涓嶅锛屽繀椤诲悓鏃惰ˉ涓€浠藉伐鍏锋€昏鏂囨。锛岃鏄庯細
  - 宸ュ叿鍒嗙被
  - 宸ュ叿鍏ュ彛
  - 宸ュ叿娉ㄥ唽鐐?
  - 宸ュ叿鎵ц鍩虹璁炬柦
  - 宸ュ叿鏉冮檺杈圭晫
  - 宸ュ叿鍚敤鏉′欢
- 濡傛灉宸ュ叿鏁伴噺杈冨锛屽厑璁搁噰鐢ㄢ€滃伐鍏锋簮鐮佸師鏍蜂繚鐣?+ 鎬昏鏂囨。鍒嗗眰瑙ｉ噴鈥濈殑鏂瑰紡锛屼笉瑕佹眰鎶婃墍鏈夊伐鍏烽兘骞跺叆涓€浠藉ぇ琛ㄣ€?

### 14.4.3 涓婚€昏緫鍙己鍒舵寚瀹氳緭鍑鸿竟鐣?

- 褰撻€昏緫鍖呯洰鏍囦笉鍙槸闃呰锛岃€屾槸鍚庣画鎸佺画缁存姢涓庡鐢ㄦ椂锛屼富閫昏緫搴旀樉寮忓己鍒舵寚瀹氾細
  - 鍝簺鐩綍蹇呴』杩涘寘
  - 鍝簺鐩綍鍙渶瑕佺储寮曪紝涓嶉渶瑕佸叏鏂囧鍒?
  - 鍝簺鐩綍鍙兘鍋氭憳瑕侊紝涓嶅疁鏁村寘澶嶅埗
- 鍏稿瀷寮哄埗鎸囧畾鏂瑰紡鍖呮嫭锛?
  - 宸ュ叿鐩綍蹇呴』鏁村寘淇濈暀
  - 鏉冮檺鏍稿績鐩綍蹇呴』淇濈暀绱㈠紩鎴栧叧閿疄鐜?
  - 鏂囨。鐩綍鍙互閫夋嫨鎬ф憳褰曡€屼笉鏄叏閮ㄥ鍒?
  - UI 澶у瀷鐩綍鍙彧淇濈暀鍏ュ彛绱㈠紩涓庡叧閿摼璺鏄?
- 鑻ユ湭寮哄埗鎸囧畾锛屽悗缁淮鎶よ€呭鏄撴妸閫昏緫鍖呭仛鎴愨€滃崐鎽樿鍗婁涪澶扁€濈殑涓嶇ǔ瀹氱粨鏋勩€?

### 14.4.4 寤鸿鐨勫己鍒舵墦鍖呬紭鍏堢骇

- 瀵逛簬 Agentic CLI銆佸伐鍏峰瀷绯荤粺銆佸甫鏉冮檺鎺у埗鐨勫伐绋嬮」鐩紝寤鸿榛樿鎸変互涓嬩紭鍏堢骇鍐冲畾鏄惁杩涘寘锛?
  - P0 蹇呴』鏁村寘淇濈暀锛?
    - 宸ュ叿鐩綍
    - 宸ュ叿娉ㄥ唽涓庢墽琛屽熀纭€璁炬柦
  - P1 蹇呴』淇濈暀鍏抽敭瀹炵幇鎴栨暣鍖呬繚鐣欙細
    - 鏉冮檺绯荤粺
    - 瀛?Agent / Agent 瀹氫箟绯荤粺
    - MCP 鏍稿績鏈嶅姟
    - Skills 鏍稿績绯荤粺
  - P2 鍏佽鍙繚鐣欑储寮曚笌鏄犲皠锛?
    - 鍛戒护闈?
    - 涓婁笅鏂囨瀯寤哄眰
    - 鐘舵€佸眰
  - P3 榛樿鍙繚鐣欏叆鍙ｄ笌璇存槑锛?
    - 澶у瀷 UI 缁勪欢灞?
    - 涓婚銆佽瑙夈€佸睍绀烘€х粍浠?
- 濡傛灉椤圭洰鐨勪富瑕佷环鍊兼濂介泦涓湪 UI锛屾湰浼樺厛绾у厑璁歌椤圭洰绾ч€昏緫瑕嗙洊銆?

### 14.4.5 鑳藉姏鐘舵€佸繀椤诲叆鍖?

- 閫昏緫鍖呬笉搴斿彧鍥炵瓟鈥滄湁娌℃湁杩欎釜鐩綍鈥濓紝杩樺繀椤诲洖绛斺€滆兘鍔涚幇鍦ㄥ浜庝粈涔堢姸鎬佲€濄€?
- 鑷冲皯搴旀爣娉ㄤ互涓嬬姸鎬佷箣涓€锛?
  - implemented
  - enabled conditionally
  - disabled by feature flag
  - stub
  - external-only
- 鑻ユ病鏈夎兘鍔涚姸鎬佺煩闃碉紝鍚庣画缁存姢鑰呬細璇妸鈥滀唬鐮佸瓨鍦ㄢ€濆綋鎴愨€滆兘鍔涘彲鐢ㄢ€濄€?

### 14.5 閫昏緫鍖呯増鏈凯浠ｈ鍒?

- 鍙鍦ㄥ綋鍓嶉」鐩腑鍙戠幇鏇村噯纭殑鎵ц閾捐矾銆佸伐鍏疯竟鐣屻€佹潈闄愯涓恒€佹墦鍖呰鍒欐垨鎵╁睍妯″瀷锛屽氨搴斿洖鍐欏埌涓婚€昏緫鏂囦欢锛岃€屼笉鏄彧鏇存柊瀵煎嚭鍖呫€?
- 涓婚€昏緫鏂囦欢涓庡鍑洪€昏緫鍖呬箣闂达紝搴斾繚鎸侊細
  - 涓婚€昏緫璐熻矗鎶借薄瑙勫垯
  - 椤圭洰閫昏緫鍖呰礋璐ｅ疄渚嬪寲鏄犲皠
  - 鐗堟湰鍙烽€掑鏃讹紝搴旇鏄庢柊澧炰簡鍝簺缁撴瀯锛岃€屼笉鏄彧鏀规枃浠跺悕

---

## 15. 鐗堟湰璇存槑

- 鏈増涓?`AgentLogic_V6`
- 鏈増鏄 `agentlogic.md` 涓?`agentlogic test1.md` 鐨勬暣鐞嗙増锛?
  - 淇濈暀閫氱敤宸ョ▼瑙勫垯
  - 淇濈暀鎵撳寘 / 鏂囨。 / 鍐茬獊娓呯悊 / README 琛ㄧ幇瑙勫垯
  - 鍒犻櫎涓庡綋鍓嶉」鐩棤鍏崇殑鍏朵粬浠撳簱涓撳睘闄勫綍

---

# AgentLogic V6 (English Version)

This document is a general AI engineering collaboration protocol. It standardizes how AI should work when starting a project, reviewing a project, fixing a project, refactoring a project, packaging a project, or publishing a project.

---

## 1. Core Goals

- Reduce context confusion, role drift, and documentation distortion in large projects.
- Ensure that AI understands architecture, history, boundaries, and release rules before modifying code.
- Ensure that every fix, refactor, packaging action, and release action forms a traceable closed loop.

---

## 2. Three-Layer Model

### L1: Strategic Entry Layer

- Responsibility: define the current state of the project and its main entry context.
- Focus: Status, Blueprint, History, project README, delivery rules, and release rules.
- Purpose: determine whether the task is about understanding, planning, or execution.

### L2: Architectural Domain Layer

- Responsibility: define module boundaries, design principles, interaction constraints, performance direction, and deployment constraints.
- Focus: module structure, transport flows, path models, state machines, design patterns, and runtime models.
- Purpose: ensure that changes match system-level engineering logic rather than only fixing a local symptom.

### L3: Atomic Execution Layer

- Responsibility: land work at the level of files, functions, entrypoints, commands, build parameters, and verification steps.
- Focus: concrete files, function responsibilities, build commands, log locations, validation methods, and physical fix locations.
- Purpose: remove ambiguity and make work executable, verifiable, and documentable.

---

## 3. Mandatory Rules Before Entering a Project

### 3.1 Read Project Markdown Before Acting

- Every time you start, review, or repair a project, you must read all project `.md` files before entering analysis, modification, packaging, or publishing.
- The purpose is not procedural formality; it is to understand:
  - architecture definitions
  - directory boundaries
  - historical evolution
  - deployment rules
  - release constraints
  - prior troubleshooting lessons
- Before the documentation has been read, do not make assumptions about architecture, deployment, packaging layout, runtime model, account rules, or stable baselines.

### 3.2 Respect the Documentation Entry Hierarchy

- If a project has a unified documentation center, start there instead of scanning random markdown files first.
- If the project has a master README, guide page, or control-center document, treat it as the first entrypoint.

### 3.3 Clarify Task Scope First

- After entering a project, determine whether the current task belongs to:
  - L1: understanding, mapping, planning
  - L2: solution design, architecture, interaction, constraints
  - L3: code changes, builds, validation, release
- Before the task boundary is clear, do not expand scope or add extra work on your own.

### 3.4 Every Agent Must Follow the Master Logic on Entry

- Whenever an agent starts a new project, takes over a new module, enters a new subsystem, or moves into a new phase, it must first follow the master-logic onboarding and planning flow instead of directly implementing, editing, or executing commands.
- 鈥淓very agent鈥?includes, but is not limited to:
  - the main-thread agent
  - sub-agents
  - parallel agents
  - module-specific agents
  - review, verification, and planning agents
- The mandatory onboarding flow should include at least:
  - identifying the documentation entrypoint
  - reading the relevant markdown and key entrypoint source files
  - determining whether the task is L1, L2, or L3
  - defining the execution order, current scope boundary, and risk judgment
- If the task is 鈥渁dding a new module鈥?rather than 鈥渇ixing an existing module鈥? the agent must also add a module-level plan:
  - module objective
  - module boundary
  - relationship to the existing system
  - entrypoints and landing points
  - validation method
- Until this step is completed, the agent should not move into direct implementation unless the user explicitly asks to skip it and that skip has been recorded as a risk.

### 3.5 The Master Logic Takes Priority Over Local Habits

- When a project contains scattered conventions, temporary notes, stale comments, or local module habits, all agents should treat the master logic as the highest collaboration rule and then adapt to the real project structure.
- Local rules may refine the master logic, but they should not bypass the master logic鈥檚 onboarding, layering, validation, and documentation-sync requirements.
- The value of the master logic is that different agents can enter the project at different times and still follow the same stable path into the system, which significantly reduces error rate and structural drift.

### 3.6 The Master Logic Must Be Read in Full

- An agent must read the master logic in full. It is not acceptable to read only the front section, only a few matching clauses, or to assume that once sections `1`, `2`, and `3` are seen, later sections such as `11`, `12`, and `13` can be ignored.
- Later sections of the master logic often contain:
  - prohibitions
  - documentation-sync requirements
  - packaging rules
  - risk boundaries
  - version-maintenance rules
- Skipping those sections may look faster in the beginning, but it substantially increases later realignment cost, structural drift, and rule conflicts.
- Therefore, before an agent claims that master-logic onboarding is complete, it should by default satisfy all of the following:
  - it has read the full master logic in order
  - it has confirmed that later sections do not contain constraints relevant to the current task
  - it has incorporated the mandatory clauses from later sections into the current execution judgment
- Reading the master logic should not be treated as keyword matching; it should be treated as a full structured read.

---

## 4. Synchronization and Closed-Loop Rules

### 4.1 Read Before Writing

- Read relevant documentation and relevant code before modifying anything.
- Do not change code based only on the surface symptom.

### 4.2 Sync Immediately After Success

- Once code changes are successful, validated, and confirmed, update the relevant markdown immediately.
- Important lessons must not remain only in the chat history.

### 4.3 Minimum Documentation Set

- triggering symptom
- impact scope
- root cause assessment
- modified files
- modification method
- validation method
- if build-related, also include:
  - build command
  - build parameters
  - artifact timestamps
  - install-directory or runtime-directory verification result

### 4.4 Persist Structure Into Markdown

- Any critical structure that has been read, changed, or verified should be written into markdown as precisely as practical:
  - entry files
  - module relationships
  - key function responsibilities
  - path models
  - data flow
  - communication flow
  - dependency flow

### 4.5 Index Failures

- Every build failure, regression, expected risk, and repair action after packaging should be written into markdown.
- The goal is not to 鈥渟ummarize鈥? the goal is to create a searchable failure index.

---

## 5. Engineering Execution Rules

### 5.1 Plan First

- If the task has more than 3 steps, spans multiple modules, involves refactoring, or touches deployment or release, form a clear execution sequence first.

### 5.2 Verify Before Marking Done

- Nothing is complete until it is validated.
- Validation may include:
  - syntax checks
  - successful builds
  - successful runtime behavior
  - path verification
  - log verification
  - device or machine verification

### 5.3 Prefer Elegant Solutions

- Do not accept patchy temporary fixes as the default.
- Prefer solutions with clean structure, stable boundaries, and maintainable follow-up behavior.

### 5.4 Troubleshoot Proactively

- When a problem can be traced through logs, paths, instance state, or build chains, keep moving until the likely cause is clear.
- Do not hand obvious next-step troubleshooting back to the user too early.

### 5.4.1 Duty to Evaluate Tools and Skills Proactively

- If AI cannot determine which tool or skill is most appropriate for the current task, or if the default path appears clearly inefficient, it should not mechanically keep using the old path.
- In that situation, AI should perform a constrained tool evaluation and answer at least:
  - whether the current default tool is merely usable instead of actually appropriate
  - whether the task has a more specialized, efficient, or stable tool or skill available
  - whether the alternative can materially improve:
    - reading efficiency
    - classification accuracy
    - search quality
    - structural understanding speed
    - automation level
- The purpose of this proactive evaluation is to prevent AI from operating in a closed loop with weak default tools while overlooking better-fit tools that already exist.

### 5.4.2 External Better-Tool Discovery Rule

- When AI starts a new project, takes over a new module, or establishes a new workflow, and finds that an external tool, skill, classifier, indexer, reader, analyzer, or automation component is clearly better suited, it should proactively record and propose it.
- 鈥淧roactively propose鈥?does not mean silently integrating it immediately. It means:
  - first explain why the current tool path is insufficient
  - then explain why the candidate tool is a better fit
  - then explicitly classify it as one of:
    - recommended
    - candidate enhancement
    - already integrated
- Without confirmation, AI should not describe an external candidate tool as if it were already part of the current system.

### 5.4.3 Avoid Tool Conservatism

- AI should not assume that an old tool, default browser path, default search path, or inherited script is still the best current option just because it already exists.
- 鈥淯se the old tool to get something done first鈥?can be a temporary tactic, but it should not prevent AI from recognizing and proposing better tool directions.
- For high-frequency, inefficient, repetitive, or long-running workflows, AI should actively consider whether a better tool-based alternative exists.
- When the default tool path is inefficient, the agent should actively look for a more appropriate tool or approach for the task, but it must distinguish between officially integrated capabilities and candidate enhancements.

### 5.5 No Unapproved Feature Additions

- Do not add out-of-scope functionality, interactions, state-machine changes, default-behavior changes, visual redesigns, workflow changes, or 鈥渟mall optimizations鈥?without explicit user approval.
- Better options may be proposed, but they must wait for user confirmation before implementation.

---

## 6. Documentation Precision Rules

### 6.1 Markdown Is Not Auxiliary

- Markdown is not an attachment; it is the runtime map, troubleshooting index, and repair archive of the project.

### 6.2 Prefer Precision

- When time allows, documentation should become more specific, not more abstract.

### 6.3 Physical Location Requirement

- Whenever markdown references a function, method, command, or event, it should also provide a file path by default.
- Best form:
  - `function name` + `file path`
  - and when practical, an approximate line or search anchor

### 6.4 Relationship Chains Matter

- Key functions should not be documented only as isolated points.
- Also document:
  - who calls them
  - what they affect next
  - which document section or chain they belong to

### 6.5 Log Location Must Be Explicit

- Log placement is an architectural fact, not an implementation footnote.
- Whenever log behavior changes, verify and document the physical log location.
- If permissions require a fallback path, record it explicitly; never silently change the default destination.

---

## 7. Packaging vs Runtime Verification Protocol

### 7.1 Default Dual Track

- Track A: unpacked testing artifacts
  - such as `win-unpacked`, runnable directories, debug builds, or uninstalled bundles
- Track B: final installers or release packages
  - such as `.exe`, NSIS, MSI, `.dmg`, `.AppImage`, APK, or AAB

### 7.2 Default Order

- Validate feature logic, interactions, state machines, and communication chains in Track A first.
- Move to Track B only when:
  - the user explicitly asks for the final installer
  - the work has reached QA, acceptance, or delivery stage
  - the issue exists specifically in installation, signing, packaging, permissions, upgrade, or uninstall flows

### 7.3 Confirm Packaging Intent First

- Are we testing an unpacked build or producing the final installer?
- Is the current goal feature validation or formal delivery?
- If the user does not explicitly require the final installer, remain in the unpacked-validation stage by default.

### 7.4 High-Risk Checks After Packaging

- install directory
- working directory
- `app.asar`
- config loading
- stale cache hits
- auto-start entries
- scheduled tasks
- leftover processes
- uninstall metadata
- permissions, signing, and file locks
- shared-directory or user-directory path models

### 7.5 Release Asset Completeness Rule

- When a project reaches the stage of GitHub release publication, formal delivery, stable-version archiving, or milestone-version delivery, the release should not contain only installers or executable artifacts.
- By default, the release must also include the source package that corresponds to the exact version being published.
- The 鈥渟ource package鈥?here means a version-aligned source archive for the current tag or release, not an arbitrary snapshot of the current working directory.
- If a project provides:
  - installers
  - unpacked executable bundles
  - source packages
  then the source package should also be included in the same release whenever possible.
- The reasons include:
  - easier rollback
  - easier version auditing
  - easier offline archiving
  - direct access from the release page to the exact source version that matches the installers
- For everyday small fixes that are not entering a formal release flow, a manually attached source package is not mandatory. But once the work becomes a published release, the source package should be treated as a standard release asset.
- After the source package has been uploaded successfully to the GitHub release, any temporary local source zip created only for that upload must be deleted immediately.
- Do not keep ad hoc local source zip files in the workspace, release folder, or staging folders after upload, because they easily accumulate and create version confusion about which archive is the canonical release asset.

---

## 8. Instance Conflict and Cleanup Rules

### 8.1 Client Instance Conflict Rule

- If the same machine keeps multiple client forms at the same time, for example:
  - portable build
  - installed build
  - old copied directory
  - stale installed state
- it may lead to:
  - unclickable UI
  - playlist delivery appearing to succeed while playback does not start
  - the wrong instance being launched
  - behavior that looks like the code was never updated
- Therefore the client startup chain must include conflict cleanup by default.

### 8.2 Minimum Client Cleanup Scope

- old `AdvertisingScreenClient.exe` processes
- auto-start registry entries
- scheduled tasks
- old installation directories
- old portable directories
- old runtime directories
- control directories and local runtime directories that conflict with the current instance

### 8.3 Server Multi-Instance Protection Rule

- The server must enforce single-instance behavior.
- Default strategy:
  - block the second instance
  - wake or open the existing instance
- Multi-instance protection must not automatically erase user business data.

### 8.4 Cleanup Boundary Rule

- Cleaning instance conflicts is not the same thing as clearing user configuration.
- Safe-to-clean targets:
  - conflicting processes
  - auto-start items
  - scheduled tasks
  - old runtime directories
  - old portable directories
  - installation directories that conflict with the current instance
- Do not auto-delete by default:
  - user config files
  - server storage data
  - playlists
  - approval records
  - media libraries
  - installer repositories
- Only delete config and business data when the user explicitly requests a reset, factory reset, or data wipe.

---

## 9. UI / UX and README Presentation Rules

### 9.1 UI / UX Boundary Rule

- UI changes must not pursue 鈥渕odernization鈥?in isolation; they must match actual product boundaries and interaction reality.
- Any change to state machines, layout structure, or user flow should be treated as a product change, not just a visual change.

### 9.2 README as the Public Landing Page

- A GitHub README is not only documentation; it should also function as the public landing page and first product impression.
- When the task involves the README, repository homepage, release page, or project introduction, do not only increase text density. Also evaluate:
  - first-screen pacing
  - section hierarchy
  - visual impact
  - memorability
- It is acceptable to improve:
  - hero titles and subtitles
  - badges
  - feature matrices
  - version timelines
  - bilingual or multilingual entry points
  - clearer landing-page narrative
- But do not change facts or invent capabilities.
- A README must include a practical 鈥淯sage鈥? 鈥淨uick Start鈥? or equivalent section by default.
- Even if the project is still evolving, the README should not stop at overview and architecture. At minimum, it should tell the reader:
  - how to start using the repository
  - what the main directories are for
  - how to launch or validate the client and server
  - where installer assets or release artifacts are obtained
- If the project is currently more suitable for developer-oriented usage instructions than end-user instructions, the README must still include the minimum executable steps instead of omitting usage entirely.
- When a README needs multilingual support, do not stack full Chinese, English, Japanese, or other full-language content into a single page by default.
- The preferred multilingual README structure is:
  - `README.md` as the primary entry page
  - `README.zh-CN.md` as the Chinese page
  - `README.ja.md` as the Japanese page
  - additional languages following the same independent-file pattern
- Each language page must provide the same language-switch links near the top, for example:
  - `English | 涓枃 | 鏃ユ湰瑾瀈
- The default README should still preserve:
  - title
  - summary
  - badges
  - multilingual entry links
  - the full content of its own language version
- The goal is to support multilingual readers without destroying the landing-page rhythm or readability of the repository homepage.
- When a README is acting as the repository landing page, centered presentation is allowed and recommended for visual coherence, especially for:
  - the main title
  - the subtitle or slogan
  - badges
  - multilingual navigation links
- The purpose of this centered layout is not decoration for its own sake; it is to make the repository homepage feel more like a product landing page than a plain text document.
- If centered presentation is used, the top section should stay structurally consistent when practical:
  - centered title
  - centered subtitle
  - centered badges
  - centered language switch links
- As long as readability and factual clarity are preserved, this top-level Hero-style presentation should be treated as a recommended pattern rather than an optional flourish.

---

## 10. Safety and Validation Protocol

### 10.1 Sensitive Actions Need Rollback Paths

- Deletion, movement, replacement, publishing, cleanup, and overwrite actions must preserve a recovery path or a clearly defined rollback point.

### 10.2 Deep Validation

- Validation must not stop at 鈥渋t opens鈥?
- It should cover:
  - empty data
  - invalid input
  - network interruptions
  - low disk space
  - path mismatches
  - installation leftovers
  - stale cache hits

### 10.3 Delivery Must Include Proof

- Delivery should include as much of the following as practical:
  - validation method
  - key results
  - what was not validated
  - remaining risks

---

## 11. Self-Improvement Loop

- Once the user corrects something, the lesson should be written into the correct document quickly.
- At the start of new sessions, review prior lessons and project documentation first.
- When code and markdown differ in information density, prefer enriching the documentation.

---

## 12. Prohibitions

- Do not define the project architecture before reading the project markdown.
- Do not expand the scope before confirming the current task boundary.
- Do not write project-level rules into the wrong directory.
- Do not upload local private notes, temporary notes, or unrelated artifacts into a repository.
- Do not mechanically copy repository-specific rules from project A into project B.

---

## 13. Recommended Execution Order

1. Read all project markdown files first.
2. Confirm the project documentation entrypoint and the current task layer.
3. Read the relevant code and runtime directories.
4. Form the execution sequence and risk judgment.
5. Modify code or prepare release artifacts.
6. Validate the result.
7. Update the correct markdown files.
8. Deliver the conclusion, paths, risks, and next-step suggestions.

---

## 14. Source-Driven Logic Package Maintenance Protocol

### 14.1 A Logic Package Is Not a Raw Source Backup

- When the task is to organize a project into a logic package, the deliverable should not be a blind copy of the entire repository.
- A logic package should be a structured knowledge package focused on how to understand, enter, execute, validate, and extend the system.
- By default, it should include at least:
  - a master logic file
  - architecture layers
  - the main execution flow
  - a tool integration inventory
  - permissions and safety mechanisms
  - extensibility mechanisms
  - key source mappings

### 14.2 Tools Must Be Integrated as a System View

- When a project contains built-in tools, external tools, MCP tools, skills, sub-agents, or command systems, the logic package must not only list directories.
- It should answer at least:
  - where tools are registered
  - how tools are exposed to the model
  - how tool permissions are evaluated
  - how tools execute
  - how tool results flow back into the conversation
  - which tools are always available
  - which tools are controlled by platform, permissions, environment variables, or feature flags
- The tool integration document should preferentially provide:
  - tool categories
  - enablement conditions
  - risk levels
  - key source paths

### 14.3 Every Logic Package Must Cite Source Evidence

- Every key conclusion in the logic package should be traceable to real source files or project markdown.
- When practical, include:
  - markdown paths
  - source code paths
  - entry files
  - key functions or modules
- If a capability is stubbed, partially implemented, conditionally enabled, platform-limited, or feature-flagged off, this must be stated explicitly.

### 14.4 Recommended Logic Package Structure

- When producing an independent logic package, the default output should be:
  - `00_README.md`
  - `01_MasterLogic.md`
  - `02_Architecture.md`
  - `03_AgenticLoop.md`
  - `04_Tools.md`
  - `05_PermissionsAndSafety.md`
  - `06_Extensibility.md`
  - `07_CommandSurface.md`
  - `08_SourceIndex.md`
  - `manifest.json`
- If a higher-level master logic file already exists, such as `AgentLogic_V6.md`, the package should retain that master logic and layer project-specific structure on top of it instead of replacing its generic engineering value.

### 14.4.1 Layered Packaging Should Be Treated as the Default

- When a project contains substantial tool source code, tool orchestration code, permission code, or command code, the logic package should not stop at the abstract documentation layer.
- By default, it should use at least three layers:
  - the abstract logic layer
  - the raw source layer
  - the index and mapping layer
- The abstract logic layer explains why the system is structured the way it is.
- The raw source layer preserves the real implementation of critical capabilities, especially the tool system.
- The index and mapping layer tells future maintainers:
  - which sources must be read first
  - which sources are support layers
  - which sources are currently stubs, dead branches, or conditionally enabled

### 14.4.2 Tool Source Is Allowed to Be Packaged Directly

- For the tool system, this protocol explicitly allows the tool source directories to be included directly in the logic package.
- But raw tool source alone is insufficient; the package must also include a tool overview document that explains:
  - tool categories
  - tool entrypoints
  - tool registration points
  - tool execution infrastructure
  - tool permission boundaries
  - tool enablement conditions
- When there are many tools, it is acceptable to use a layered approach of 鈥渞aw tool source preserved as-is + overview documentation with system-level explanation鈥?instead of rewriting every tool into one oversized summary.

### 14.4.3 The Master Logic May Explicitly Enforce Packaging Boundaries

- When the package is intended not only for reading but also for ongoing maintenance and reuse, the master logic should explicitly enforce:
  - which directories must be included
  - which directories only need indexed references
  - which directories should be summarized instead of copied wholesale
- Typical enforced rules include:
  - tool directories must be preserved as a package layer
  - core permission directories must be preserved through either raw copies or key implementation slices
  - documentation directories may be selectively extracted rather than fully copied
  - large UI directories may be represented by entrypoint indexes and key execution-flow explanations
- Without explicit enforcement, future maintainers often produce unstable packages that are half-summary and half-loss.

### 14.4.4 Recommended Packaging Priority

- For agentic CLI systems, tool-centric systems, and permission-bound engineering projects, the default packaging priority should be:
  - P0 must be preserved as raw package layers:
    - tool directories
    - tool registration and execution infrastructure
  - P1 must preserve either key implementations or full raw copies:
    - permission systems
    - sub-agent and agent-definition systems
    - MCP core services
    - skill systems
  - P2 may be preserved as indexes and mappings:
    - command surfaces
    - context-building layers
    - state layers
  - P3 should default to entrypoints and explanations only:
    - large UI component layers
    - theme, presentation, and display-oriented components
- If the main value of the project is the UI itself, the project-specific logic may override this priority.

### 14.4.5 Capability Status Must Be Captured

- A logic package should not only answer 鈥渄oes this directory exist鈥? it must also answer 鈥渨hat is the current capability state鈥?
- At minimum, one of the following states should be recorded:
  - implemented
  - enabled conditionally
  - disabled by feature flag
  - stub
  - external-only
- Without a capability-state matrix, future maintainers will incorrectly treat 鈥渃ode exists鈥?as 鈥渃apability is available鈥?

### 14.5 Version Iteration Rules for Logic Packages

- When a project reveals more accurate execution flows, tool boundaries, permission behavior, packaging rules, or extensibility models, those lessons should be written back into the main logic file instead of only updating the exported package.
- The relationship should remain:
  - the master logic defines abstract rules
  - the project logic package defines project-specific mappings
  - when the version increases, the documentation should state what structural value was added instead of only changing the file name

### 14.6 Validation Artifact and Repository Sync Rules

- For UI, layout, rendering, window-behavior, and visual-regression work, screenshot-based visual verification is a required validation tool, not an optional extra.
- The agent must not rely only on code reading or build success when the problem is visibly behavioral.
- When UI verification depends on screenshots, screenshots may be generated as temporary validation artifacts.
- After the screenshot has completed its debugging or confirmation purpose, the temporary screenshot file must be deleted immediately.
- Temporary UI screenshots must not remain in `dist`, release folders, staging folders, or the repository root after verification is complete.
- The main logic must not absorb every useful discovery by default.
- Project-specific discoveries, task-specific notes, and temporary working patterns should stay in project markdown, task notes, or local structure unless the user explicitly asks for main-logic promotion.
- Only when the user explicitly says that a rule should enter the main logic should that rule be written back into `AgentLogic_V6`.
- When the user explicitly asks for a main-logic update, the updated main logic must be synchronized not only to the current project repository but also to the dedicated rules repository: `https://github.com/UIhoshi/AgentLogic`.
- That cross-repository sync applies specifically to main-logic updates, not to every project-layer change by default.
- After the rule has been written back, the repository must be synchronized in the same round unless a concrete blocker exists.
- Routine logic additions do not justify a major-version jump such as `V6 -> V7`.
- Unless the change is a real major logic-generation upgrade, updates should remain within the current logic version line.
- If the repository already contains a release archive for the current logic version, the same-version archive should be replaced instead of creating an arbitrary new major version.
- If no tag, release, or release-archive baseline exists yet, do not fabricate a fake release flow. In that case, keep normal repository synchronization and preserve the current version line.

### 14.6.1 Primary Logic Source Precedence Rule

- If a workspace or project explicitly declares one current primary logic source, that source must take precedence over older local logic notes, stale helper files, or ad hoc workspace reminders when they conflict.
- This precedence rule applies especially when:
  - the workspace has an installed main logic package
  - the project points to a dedicated logic repository
  - older local notes survive from earlier iterations
- In that situation, the agent must treat the declared current primary logic source as the logic truth baseline for future work.
- Older local logic notes may still help as supporting context, but they must not silently override the current main logic.

### 14.6.2 Upload Boundary Rule For Logic Files And Build Byproducts

- Ordinary project repositories must not absorb logic-control files that belong to the logic system itself unless the task is explicitly to update the logic repository.
- By default, the following must not be uploaded into ordinary project repositories:
  - logic-package markdown directly related to the main logic repository
  - private rule bundles
  - local logic-entry control files
  - workspace-only logic notes
  - build byproducts
  - generated intermediates
  - machine-specific runtime artifacts
  - temporary packaging leftovers
- By default, files that are normally acceptable to upload into ordinary project repositories are:
  - project-related markdown
  - project source code
  - release versions or release assets that are actually intended for publication
- If the task is specifically to update the logic repository itself, then logic-related markdown belongs in that logic repository rather than in the ordinary project repository.

### 14.7 Startup Re-Read Loop for Main Logic

- Before every new work round, the agent must re-read the current project's main logic entry before executing.
- "Every new work round" includes returning after interruption, starting a new user request, entering a new module, or resuming after a failed attempt.
- The purpose is not ceremonial reading. The purpose is to refresh the current behavioral constraints, validation rules, packaging rules, and repository-sync rules before action.
- This startup re-read loop must be reflected not only in the logic package itself, but also in the project's own top-level markdown so the project can remind future agents locally.
- If the project already declares its logic entry path, the startup loop should explicitly point back to that path.

### 14.7.0 A Logic Package May Define One Absolute First-Entry File

- A logic package may explicitly define one absolute first-entry file, such as `00_START_HERE.md`.
- If such a file exists, the agent must read that file first before treating any other markdown, checklist, or logic file as the initial entrypoint.
- The purpose of this file is not to become a second README. Its purpose is to force the correct reading order and reduce ambiguity about where formal work may begin.
- This file should define:
  - the mandatory reading chain
  - whether the reading order is fixed
  - the conditions for formal implementation readiness
  - the startup chain for new coding rounds when needed
- If the logic package declares such a file, other entry docs should point back to it instead of competing with it.

### 14.7.0.1 The First-Entry File Is Logic, Not Project Content

- A dedicated first-entry file such as `00_START_HERE.md` must be treated as logic-entry control, not as normal project content.
- The agent must not use that file to record routine project changes, temporary notes, implementation details, or business-facing summaries.
- Unless the user explicitly authorizes a logic update or rule update, the agent must not modify that first-entry file as part of ordinary project work.
- For normal project tasks, the correct behavior is:
  - read the first-entry file
  - complete the mandatory reading chain
  - continue into the project's own files
- This boundary exists to prevent the first-entry file from gradually turning into a mixed document that weakens the logic-entry role.

### 14.7.0.2 A Mandatory Full-Read Chain May Be Declared

- A logic package may explicitly declare a mandatory full-read chain.
- If such a chain is declared, the agent must not replace it with:
  - skimming
  - partial reading
  - keyword-only reading
  - summary-based substitution
  - previous-session memory
- If the chain says files must be fully read from beginning to end, that requirement is mandatory.
- Until the declared full-read chain is completed, the agent must not treat itself as ready for formal planning, implementation, modification, validation, review, or rule synchronization.

### 14.7.1 Highest-Priority Startup Chain For New Coding Rounds

- The startup chain below is a highest-priority mandatory rule, not an optional heuristic.
- Before any new coding round, new feature round, or resumed implementation round, the agent must execute this exact order:
  1. confirm the current logic entry
  2. judge whether the new task is an extension of the previous coding round
  3. if it is not an extension, the agent must ask the user whether to forget/compress context before continuing
- Step 3 has the same priority level as step 1 and step 2.
- This means the agent must not silently carry old context into a new coding track when the new task is not clearly an extension of the previous one.
- If the answer is to forget/compress context, the agent must first externalize the current valid state into structured records before reducing the working context.
- At minimum, the externalized state should include:
  - current task goal
  - current boundary
  - current module or subsystem
  - completed work
  - next action
  - unconfirmed facts
  - remaining risks
- Until this startup chain is satisfied, the agent should not treat itself as ready to enter formal implementation.

### 14.8 Structured External-Brain Rule

- Do not assume that stable execution comes from internal memory alone.
- The preferred working model is an externalized memory model: methods, decisions, exceptions, and learned procedures should be written into structured records and revisited before execution.
- Spreadsheet-like structure is a valid and preferred form of external memory when the user's working style depends on collecting many facts into one navigable structure.
- When the user describes a workflow similar to an Excel habit, the agent should interpret that as a preference for:
  - structured aggregation
  - repeatable lookup
  - reusable execution patterns
  - low-memory-dependence workflows
- Therefore, when the agent encounters uncertainty, difficulty, or a recurring task, the default response should be:
  - look back at the recorded structure first
  - reuse the recorded method if it exists
  - only improvise when the structured record does not already provide a usable path
- This rule applies both to the user's own documented working style and to the agent's collaboration behavior in the repository.

### 14.9 Logic-Project Closed Loop Rule

- Project work must form a closed loop between the main logic and the project's own structure documents.
- The default loop is:
  - read the main logic first
  - read the relevant project markdown and structure files
  - before making the formal update, return once more to the main logic
  - then decide how to implement the project change
- This means the main logic is not only a startup reference. It is also a pre-implementation calibration layer.
- When the task is to update, refactor, or extend the project, the agent must not jump directly from reading project files into implementation.
- The agent must first re-check the change through the main-logic lens before editing code, packaging artifacts, or project documentation.
- The purpose of this loop is:
  - prevent local project drift
  - prevent implementation choices from bypassing collaboration rules
- ensure project updates still obey the same higher-order method
- keep project facts and execution rules continuously aligned
- This closed loop should also be reflected in the project's own top-level markdown so the project locally reminds future agents how updates must be performed.

### 14.10 Real Entry / Starting Source Files Should Carry Logic Reminders

- When a project depends on an external logic package or a dedicated logic-entry workflow, the reminder should not exist only in chat memory or only in top-level markdown.
- The project should also place a short logic-entry reminder at the top of its real entry / starting source files.
- The purpose of these reminders is to increase the chance that the agent sees the logic-entry rule at the exact point where work usually starts, especially in long multi-round sessions.
- These reminders should cover all real source-level starting points where an agent is likely to begin reading, changing, routing, bootstrapping, or controlling execution.
- They should not be mechanically added to every source file in the repository.
- Typical targets include:
  - process entry files
  - main backend control files
  - route entry files
  - preload bridge files
  - major renderer entry files
  - main admin UI entry files
- The reminder text should stay short and low-noise.
- The reminder should point to repository-relative entry documents such as `AGENTS.md` and `README.md`, not to machine-specific absolute paths.
- The preferred chain is:
  - code-file reminder points to repository entry docs
  - repository entry docs point to the main logic package
- This design keeps the code reminder stable across machines while keeping the actual logic path centralized in repository-level documentation.

### 14.10.1 Repository-Level Enforcement Script Should Back The Reminder

- A logic reminder only in markdown and source headers is stronger than chat memory, but it is still not a full engineering enforcement mechanism.
- If the project wants stronger execution guarantees, it should add a repository-level enforcement script that mechanically checks whether:
  - the repository entry docs still point to the current logic entry
  - the real entry / starting source files still retain the logic reminder
  - the reminder text still points to repository-relative docs rather than machine-specific paths
- A recommended command pattern is:
  - `node scripts/check-logic-entry.js`
- This script does not replace the requirement to read the logic package.
- Its role is to prevent silent drift, accidental deletion of reminders, and project-layer desynchronization after multiple implementation rounds.
- Therefore the preferred enforcement stack becomes:
  - logic package defines the rule
  - repository markdown declares the entry path
  - real entry / starting source files carry short reminders
  - repository script checks the reminder chain mechanically

### 14.10.2 Header-Level Mandatory Rules Should Default To English

- When a project writes mandatory workflow rules into file headers, the default language for those header-level rules must be English.
- This applies to header notices in:
  - source files
  - style files
  - markup files
  - project markdown files
- The purpose is to maximize consistency across:
  - different agents
  - different language settings
  - different model providers
  - cross-project reuse
- Local-language explanation is still allowed in normal project markdown body text.
- But the short mandatory rule written into file headers should default to English unless the user explicitly requests a different default.
- Therefore a project should not mix header-level mandatory rules between Chinese, English, and other languages by default.
- The repository-level enforcement script should also validate the English header rule text if the project has standardized on it.

### 14.10.3 A Logic Package May Carry A Default GitHub README Template

- A logic package may include one repository-level default template for GitHub-facing `README.md` work.
- If that template exists, it should be treated as the default baseline when:
  - creating a new repository `README.md`
  - rewriting an incomplete or placeholder README
  - preparing a repository homepage for open-source publication
- In this package, the default file is:
  - `16_GitHubREADMETemplate_V1.md`
- This template should integrate existing README presentation rules rather than compete with them.
- At minimum, the integrated rule set should preserve:
  - README as the public landing page and first product impression
  - practical quick-start or usage content by default
  - multilingual README split across files instead of stacking full languages into one page
  - repository-relative links instead of machine-specific absolute paths
- The template is a structure baseline, not permission to invent facts.
- The agent must not fabricate:
  - screenshots
  - GIF demos
  - release links
  - commands
  - technical claims
  - platform support
- If the project already has a stronger explicit repository-specific README standard, that project-specific standard may override the package default.
- If no stronger README standard exists, the package template should be reused instead of rebuilding the structure from scratch.

### 14.10.4 A Logic Package May Also Carry GitHub README Style Rules

- A content template alone is insufficient when the goal is to keep repository homepages broadly consistent across many projects.
- Therefore a logic package may carry a separate GitHub README style-rules file in addition to the README template.
- In this package, the default style-rules file is:
  - `17_GitHubREADMEStyleRules_V1.md`
- When a future repository uses the GitHub README template, it should also check the style-rules file in the same round.
- The purpose is not to force pixel-identical README pages.
- The purpose is to preserve broad structural consistency across repositories, including:
  - recognizable hero section
  - early value explanation
  - early quick-start or usage path
  - stable preview or proof section treatment
  - technical details in the lower half rather than replacing the landing-page layer
- Project-specific variation is still allowed.
- But a repository should not drift so far that its README structure becomes unrelated to the rest of the project set without a good reason.

### 14.10.5 A Logic Package May Carry README Example Files

- A template and a style-rules file are usually enough for policy, but example files are useful for execution consistency.
- Therefore a logic package may also carry one or more README example files that show:
  - a product-style repository homepage
  - a developer-style repository homepage
- In this package, the default example file is:
  - `18_GitHubREADMEExamples_V1.md`
- Example files are not the source of truth for project facts.
- Their purpose is to reduce ambiguity about final page shape, section rhythm, and visual balance.
- When the agent prepares a new repository README, it should preferably use:
  - the template file for section structure
  - the style-rules file for presentation constraints
  - the examples file for finished-page reference
- This three-layer README system should be treated as the default baseline unless the project explicitly declares a stronger repository-specific standard.

### 14.10.6 A Logic Package May Carry A README Review Checklist

- A README system is more stable when it includes not only generation assets but also a final review layer.
- Therefore a logic package may carry a dedicated GitHub README review checklist.
- In this package, the default review-checklist file is:
  - `19_GitHubREADMEReviewChecklist_V1.md`
- When the agent drafts, rewrites, or significantly restructures a repository README, it should preferably run through the checklist before treating the README as complete.
- The checklist should verify at least:
  - structural completeness
  - style consistency
  - badge sanity
  - truthfulness of links, screenshots, commands, and claims
  - presence of a practical quick-start path
- The default README workflow in this package therefore becomes:
  - template
  - style rules
  - examples
  - review checklist
- This four-layer README system should be treated as the normal baseline unless a repository-specific standard overrides it.

### 14.10.7 GitHub Upload Or Publication Automatically Triggers The README System

- When the task includes uploading a project to GitHub, preparing a repository for first public push, preparing a repository homepage for publication, or restructuring a repository immediately before GitHub publication, the README system must be triggered automatically.
- In this trigger case, README work is not optional polish.
- It is part of publication readiness.
- The agent should automatically invoke the full README workflow in the same round:
  - `16_GitHubREADMETemplate_V1.md`
  - `17_GitHubREADMEStyleRules_V1.md`
  - `18_GitHubREADMEExamples_V1.md`
  - `19_GitHubREADMEReviewChecklist_V1.md`
- The agent must not upload or publish the repository while ignoring an obviously weak, placeholder, structurally inconsistent, or unreviewed README when the repository homepage is part of the public GitHub presentation.
- If the repository already has a strong repository-specific README standard, that standard may override the package defaults.
- But the automatic trigger rule still applies: the agent must consciously pass through the repository's README system rather than skipping README judgment entirely.

### 14.10.8 Product README Quick Start Should Preserve Real Entry Paths

- For product-style repositories, `Quick Start` must describe the real supported user entry paths instead of flattening everything into a single developer-only flow.
- If the project has multiple truthful entry paths, the README should preserve them explicitly when they help the user choose how to start.
- Typical path categories include:
  - release or installer path
  - local source/runtime path
  - browser-only or fallback path
- The default ordering for product-style repositories should be:
  1. normal user path
  2. source or local runtime path
  3. fallback or advanced path
- The agent must not force `npm run dev` or equivalent to become the only visible path when most real users start from Releases or installers.

### 14.10.9 Product README May Use Lightweight Version Evolution

- A product-style repository may include a lightweight `Version Evolution`, `How It Evolved`, or equivalent section when release maturity helps explain the current product state.
- This section should stay in the lower half of the README.
- It should remain brief, usually 3 to 5 bullets, and summarize milestones rather than turning into a full changelog.
- If the repository already has detailed release notes or a changelog, the README section should summarize and point outward rather than duplicate detail.
- The purpose is to add product context without weakening the landing-page rhythm.

### 14.10.10 Product Preview May Fall Back To Product Proof

- Product-style repositories should aim to include an early visual preview section.
- But if screenshots or GIFs do not exist yet, the agent must not fake visual assets just to preserve symmetry.
- In that case, the agent should replace `Product Preview` with a truthful early proof section such as:
  - `Product Proof`
  - `Usage Proof`
  - `Workflow Proof`
- This fallback should still preserve the same top-half structure:
  - hero
  - early proof
  - value
  - quick start
  - compact summary
- The goal is structural consistency without fabricated assets.

### 14.10.11 GitHub README Badge Selection Should Follow A Priority Matrix

- A GitHub README should not choose badges ad hoc.
- If the repository uses badges, badge selection should follow a stable priority matrix based on repository style mode.
- For product-style repositories, the default badge priority should be:
  1. release or version
  2. license
  3. platform
  4. build status
  5. stars
- For developer-style repositories, the default badge priority should be:
  1. package version or release
  2. license
  3. build status
  4. runtime or language
  5. coverage or docs status
- For minimal repositories, the default badge priority should be:
  1. license
  2. version or release
  3. build status
- The agent should prefer omitting weak badges over padding the badge strip with low-value or vanity signals.
- Badge count should normally remain within 3 to 5 and should not exceed 6 without a concrete reason.

### 14.10.12 GitHub README Screenshot Assets Should Follow A Stable Structure

- When a repository uses screenshots or GIFs in its README, the assets should follow a stable repository structure rather than ad hoc export naming.
- The default asset directory should be:
  - `screenshots/`
- The default naming pattern should prefer stable, reusable names such as:
  - `main.png`
  - `demo.gif`
  - `usage.png`
  - `feature-01.png`
  - `feature-02.png`
- The agent should avoid committing noisy export filenames such as timestamped screenshot names, `image (12).png`, or `final-final-demo.gif`.
- Screenshot references should stay repository-relative and stable across machines.
- The top-half preview block should normally contain no more than 3 visual assets by default.
- If a project needs more screenshots than that, the extra assets should move lower in the README or into dedicated docs instead of bloating the first screen.

### 14.10.13 GitHub README Top-Half Section Order Should Be Mostly Locked

- A shared README system loses value if repositories keep the same sections but shuffle the top-half order freely.
- Therefore the top-half order should be treated as mostly locked by default:
  1. hero
  2. preview or proof
  3. value or pain-point section
  4. quick start
  5. compact summary such as `At a Glance`
- For product-style repositories, the agent should not move technical implementation above value or quick start.
- For developer-style repositories, limited adjustment is allowed, but the first runnable path must still remain near the top.
- Lower-half sections may swap more freely as long as the top-half landing-page rhythm remains intact.

### 14.10.14 Multilingual README Files Should Be Structurally Mirrored

- If a repository maintains multiple language README files, they should stay structurally mirrored by default.
- Structural mirroring means:
  - the same major section order
  - the same top-half rhythm
  - the same major proof assets when shared
  - the same core repository links when shared
- The purpose is not to force sentence-level literal translation.
- Natural localization is allowed.
- But accidental structure drift between `README.md`, `README.zh-CN.md`, `README.ja.md`, or other language files should be treated as a documentation inconsistency rather than accepted by default.
- If one language intentionally diverges, that divergence should be conscious and justified by a real audience or platform reason.

### 14.10.15 GitHub README Density Should Scale With Repository Maturity

- Not every repository should carry the same README density.
- The shared structure should stay recognizable, but optional depth should scale with repository maturity.
- For early or newly public repositories:
  - keep the README lean
  - prioritize positioning, value, quick start, core features, basic technical shape, and license
  - omit optional lower-half sections unless they already add real value
- For active or mature repositories:
  - the full normal skeleton may be used
  - FAQ, roadmap, version evolution, and richer quick-start variants are appropriate when truthful
- For maintenance-mode or stable repositories:
  - keep the top half current and useful
  - compress aspirational sections
  - prefer status clarity, compatibility, limitations, and maintenance notes over expansion fluff
- A sparse README is acceptable only when it is intentionally sparse for maturity reasons, not when it is simply incomplete.
- A mature README should not hide important usage or compatibility information just to stay short.

### 14.10.16 The Entry / Starting Source File Logic Gate Is Mandatory, Not Advisory

- The logic notice placed at the top of real entry / starting source files must be treated as a mandatory execution gate, not as a suggestion, reminder, or stylistic comment.
- This requirement exists because repeated testing shows that AI agents often begin practical work from entry files, control files, route files, renderer roots, and other high-frequency starting source files first.
- Therefore the highest-leverage place to reduce entry errors is the exact file where implementation would otherwise begin.

- The mandatory gate must block the following common failure modes:
  - skipping repository entry documents
  - silently treating a new task as a continuation of the previous coding round
  - carrying stale context into a new task without explicit confirmation
  - starting deeper reading, write operations, deletion, or implementation before the startup loop is complete

- For that reason, every real entry / starting source file must carry the standardized Mandatory Logic Gate header.
- This is not optional on real entry / starting source files.
- Repositories should treat absence, weakening, or removal of that gate as a logic-entry integrity failure.

- The Mandatory Logic Gate must enforce all of the following:
  - read repository entry documents first
  - follow the repository-declared logic-entry chain
  - explicitly determine whether the current task extends the previous coding round
  - if it does not, explicitly ask whether to forget/compress context first
  - treat this startup loop as a blocking gate
  - prohibit deeper reading, write actions, deletions, or implementation before the loop is complete

- The gate should be short, English by default, and repository-relative in its path references.
- It must not use machine-specific absolute paths.
- It must not be downgraded into general prose or business-facing explanation.

- Repositories should also provide a mechanical validation path, such as a repository-level checking script, so that the gate can be verified rather than assumed.

---

## 15. Version Note

- This version is `AgentLogic_V6`.
- It is a consolidated version based on `agentlogic.md` and `agentlogic test1.md`.
- It keeps:
  - general engineering rules
  - packaging and documentation rules
  - instance-conflict cleanup rules
  - README presentation rules
- It removes repository-specific appendices that do not belong to the current project.


### 14.7.1.1 Continuous Execution Authorization Must Suppress Repeated Confirmation

- The purpose of the startup chain is to preserve logic continuity, prevent forgotten constraints, and avoid silent context drift.
- It is **not** intended to force repeated confirmation during one continuous implementation track.
- Therefore, if the user explicitly states any equivalent of:
  - "unless I say stop, keep going"
  - "keep following the plan"
  - "do not stop to ask me again"
  - "keep writing until I tell you to stop"
  then the agent must treat that as an active continuous-execution authorization for the current task scope.
- Under that authorization, the agent must default to treating subsequent work as part of the same implementation round unless a real task-boundary break appears.
- This means the agent must not repeatedly re-ask for confirmation at ordinary boundaries such as:
  - moving from reading to editing
  - moving from one planned implementation step to the next
  - running the next validation in the same planned chain
  - fixing follow-up issues discovered during the same execution sequence
- In this mode, the correct behavior is:
  - keep following the planned order
  - keep writing, validating, and progressing
  - only pause when:
    - the user explicitly says to stop
    - the current plan is complete and a new strategic direction is required
    - a true blocker exists that cannot be resolved from local context
    - a high-risk irreversible action is about to be taken

### 14.7.1.2 "Keep Going Until I Say Stop" Also Implies Pre-Test Build-Out Phase

- When the user explicitly says "unless I say stop, keep going" or equivalent, the default interpretation is that the work is still in an implementation / build-out phase.
- It should not be interpreted as formal product testing, acceptance testing, or a test-signoff phase unless the user explicitly says the task has entered testing.
- Therefore the agent should continue building through the planned sequence instead of prematurely switching into a "pause and ask before each stage" testing posture.
- The agent may still run local verification, builds, and sanity checks during continuous execution.
- But those checks are part of continuous implementation progress, not evidence that the work has already entered formal product-test stage.

## END FILE: versions/AgentLogic_V6.md

---

## BEGIN FILE: modules/01_MasterLogic.md

# AgentLogic_V6 Master Logic

鏈枃浠朵笉鏄浛浠?`AgentLogic_V6.md`锛岃€屾槸灏嗗綋鍓嶄富閫昏緫鏄犲皠鍒板綋鍓嶄粨搴擄紝褰㈡垚涓€浠介潰鍚?Claude Code 绫?Agentic CLI 绯荤粺鐨勯」鐩骇涓婚€昏緫鎽樿銆?

## 1. 褰撳墠椤圭洰瀹氫綅

- 璇ラ」鐩槸涓€涓粓绔師鐢熺殑 Agentic Coding System銆?
- 绯荤粺鏍稿績涓嶆槸鈥滆亰澶┾€濓紝鑰屾槸鈥滃杞ā鍨嬫帹鐞?+ 宸ュ叿璋冪敤 + 鏉冮檺鍒ゅ畾 + 涓婁笅鏂囧帇缂?+ 鐘舵€佸洖鍐欌€濄€?
- 鍥犳锛岄€昏緫鏁寸悊蹇呴』鍥寸粫浠ヤ笅浜斾釜瀵硅薄灞曞紑锛?
  - 鍏ュ彛涓庡惎鍔?
  - 浼氳瘽缂栨帓
  - 鍗曡疆鎵ц寰幆
  - 宸ュ叿绯荤粺
  - 鏉冮檺涓庢墿灞曚綋绯?

## 2. 褰撳墠椤圭洰鐨勪笁灞傛槧灏?

### L1锛氭垬鐣ヤ笌鍏ュ彛灞?

- 涓诲叆鍙ｆ枃妗ｏ細
  - `README.md`
  - `AIagent.md`
  - `AGENTS.md`
  - `docs/introduction/architecture-overview.mdx`
- 涓诲叆鍙ｄ唬鐮侊細
  - `src/entrypoints/cli.tsx`
  - `src/main.tsx`
  - `src/entrypoints/init.ts`

### L2锛氶鍩熸灦鏋勫眰

- 鏍稿績浼氳瘽缂栨帓锛?
  - `src/QueryEngine.ts`
  - `src/query.ts`
- 宸ュ叿绯荤粺锛?
  - `src/Tool.ts`
  - `src/tools.ts`
  - `src/services/tools/`
- 鏉冮檺涓庡畨鍏細
  - `src/utils/permissions/`
  - `src/tools/BashTool/`
  - `src/tools/PowerShellTool/`
- 鎵╁睍绯荤粺锛?
  - `src/services/mcp/`
  - `src/skills/`
  - `src/tools/AgentTool/`

### L3锛氬師瀛愭墽琛屽眰

- 宸ュ叿鐩綍锛歚src/tools/*`
- 鍛戒护鐩綍锛歚src/commands/*`
- 鐘舵€佷笌涓婁笅鏂囷細`src/state/`銆乣src/context.ts`
- UI/缁堢娓叉煋锛歚src/screens/`銆乣src/components/`銆乣src/ink/`

## 3. 褰撳墠椤圭洰鐨勬牳蹇冨伐浣滃璞?

- 妯″瀷璇锋眰瀵硅薄
  鐢?`src/query.ts` 鍜?`src/services/api/claude.ts` 鍏卞悓鏋勫缓銆?
- 宸ュ叿闆嗗悎瀵硅薄
  鐢?`src/tools.ts` 鍔ㄦ€佺粍瑁咃紝涓嶆槸闈欐€佸父閲忋€?
- 鏉冮檺涓婁笅鏂囧璞?
  鐢?`ToolPermissionContext` 涓?`src/utils/permissions/` 鍏卞悓缁存姢銆?
- 浼氳瘽鐘舵€佸璞?
  鐢?`src/QueryEngine.ts`銆乣src/state/`銆乣src/bootstrap/state.ts` 鍏卞悓缁存姢銆?

## 4. 褰撳墠椤圭洰鐨勯珮浠峰€肩淮鎶ゅ師鍒?

- 浠讳綍鈥滆兘鍔涘瓨鍦ㄢ€濈殑缁撹锛岄兘蹇呴』鍖哄垎锛?
  - 宸插疄鐜?
  - 鏉′欢鍚敤
  - feature flag 鍏抽棴
  - stub
- 浠讳綍鈥滃伐鍏峰彲鐢ㄢ€濈殑缁撹锛岄兘蹇呴』鍖哄垎锛?
  - 娉ㄥ唽灞傞潰瀛樺湪
  - 杩愯鏃跺彲鍚敤
  - 鏉冮檺灞傞潰鍙斁琛?
  - 褰撳墠澶栭儴鏋勫缓榛樿鍙揪
- 浠讳綍鈥滈€昏緫鍖呭畬鍠勨€濆姩浣滐紝閮藉繀椤绘妸宸ュ叿銆佹潈闄愩€佹墿灞曚綔涓轰竴涓暣浣撶郴缁熸潵鍐欙紝鑰屼笉鏄垎鏁ｈ蹇嗐€?

## 4.1 鍏ㄩ儴 Agent 鐨勭粺涓€鎺ュ叆瑕佹眰

- 褰撳墠椤圭洰鍚庣画鏃犺鐢卞摢涓?Agent 杩涘叆锛岄兘蹇呴』鍏堣蛋涓婚€昏緫鎺ュ叆娴佺▼銆?
- 杩欐潯瑙勫垯閫傜敤浜庯細
  - 涓荤嚎绋?Agent
  - 瀛?Agent
  - review Agent
  - verification Agent
  - planning Agent
  - 妯″潡涓撶敤 Agent
- 鍙鍑虹幇浠ヤ笅浠讳竴鎯呭喌锛屽氨蹇呴』閲嶆柊鎵ц涓婚€昏緫鎺ュ叆锛?
  - 杩涘叆涓€涓柊椤圭洰
  - 鏂板涓€涓柊妯″潡
  - 鎺ユ墜涓€涓箣鍓嶆湭璇婚€忕殑瀛愮郴缁?
  - 浠庡垎鏋愰樁娈靛垏鎹㈠埌瀹炴柦闃舵
- 鐩殑涓嶆槸澧炲姞褰㈠紡鍖栨祦绋嬶紝鑰屾槸鍑忓皯涓嶅悓 Agent 鍥犱负鍏ュ彛涓嶄竴鑷磋€屽甫鏉ョ殑閿欒鐜囥€佽竟鐣屾紓绉诲拰缁撴瀯璇垽銆?

## 4.2 鏂版ā鍧楀繀椤诲厛瑙勫垝

- 濡傛灉宸ヤ綔瀵硅薄鏄竴涓柊妯″潡锛岃€屼笉鏄凡鏈夋ā鍧楃殑灞€閮ㄤ慨澶嶏紝鍒?Agent 鍦ㄨ繘鍏ュ疄鐜板墠蹇呴』鍏堢粰鍑烘ā鍧楃骇瑙勫垝銆?
- 璇ヨ鍒掕嚦灏戝簲鍖呭惈锛?
  - 妯″潡鐩爣
  - 妯″潡杈圭晫
  - 鍏ュ彛涓庤惤鐐?
  - 涓庣幇鏈夌郴缁熺殑鍏崇郴
  - 楠岃瘉鏂瑰紡
- 杩欐槸涓婚€昏緫鍦ㄦ柊澧炴ā鍧楀満鏅笅鐨勫己鍒舵淳鐢熻姹傘€?

## 4.3 V6 鏄柟娉曡剳锛岄」鐩枃妗ｄ笌婧愮爜鏄簨瀹炲眰

- 褰撳墠鐗堟湰蹇呴』鏄庣‘鍖哄垎锛?
  - `AgentLogic_V6` 璐熻矗鏂规硶銆佽涓恒€佽鍒掋€侀獙璇併€佸洖鍐欒鍒?
  - 椤圭洰鑷韩 md 涓庢簮鐮佽礋璐ｄ笟鍔′簨瀹炪€佸疄鐜颁簨瀹炪€佺粨鏋勪簨瀹炰笌褰撳墠鐘舵€?
- 杩欐剰鍛崇潃锛?
  - V6 涓嶈礋璐ｆ弿杩版煇涓叿浣撻」鐩埌搴曞仛浠€涔?
  - V6 涓嶈礋璐ｆ浛浠ｉ」鐩?README銆佹ā鍧楁枃妗ｅ拰婧愮爜闃呰
  - 椤圭洰鑷繁鐨勬枃妗ｄ笌婧愮爜锛屾墠鏄€滄枃浠跺湪鍝噷銆佸嚱鏁板湪鍝噷銆佸叆鍙ｅ湪鍝噷銆佸綋鍓嶅疄鐜板浣曗€濈殑浜嬪疄鏉ユ簮
- 鑻?Agent 鎶?V6 鍜岄」鐩簨瀹炴贩涓轰竴浣擄紝灏变細鎶婃柟娉曞眰閿欒鍦板綋浣滈」鐩鏄庡眰锛岃繖鏄繀椤婚伩鍏嶇殑銆?

## 4.3.1 椤圭洰涓?md 杩樺繀椤绘壙鎷呴€昏緫鍏ュ彛纭鑱岃矗

- 褰撳墠鐗堟湰杩樺簲鏄庣‘锛氶」鐩富 md 涓嶅彧鏄憡璇?Agent鈥滈」鐩槸浠€涔堚€濓紝杩樺簲甯姪 Agent 纭鈥滃綋鍓嶉」鐩簲鎺ュ叆鍝唤 Agent 閫昏緫鏂囦欢鈥濄€?
- 褰?Agent 閲嶆柊杩涘叆涓€涓」鐩椂锛岄粯璁ゅ簲鍏堜粠椤圭洰涓?md 寮€濮嬶紝浣嗕笉鑳芥姝ヤ簬椤圭洰浠嬬粛鏈韩銆?
- 鍦ㄦ寮忓紑宸ュ墠锛岃繕蹇呴』纭锛?
  - 褰撳墠椤圭洰鐩綍涓嬫槸鍚﹀凡鏈夐€昏緫鏂囦欢
  - 鑻ユ病鏈夛紝閫昏緫鏂囦欢瀹為檯瀛樻斁鍦ㄥ摢閲?
  - 褰撳墠椤圭洰鏄惁渚濊禆鐙珛缁存姢鐨勫閮ㄩ€昏緫鍖?
- 杩欓噷涓嶅簲鎶婇€昏緫鐗堟湰鍐欐锛屽洜涓烘湭鏉ュ彲鑳戒粠 `V6` 鍗囩骇涓哄叾浠栫増鏈€?
- 鍥犳锛岃鍒欏簲闈㈠悜鈥滈€昏緫鍏ュ彛鏄惁宸茬‘璁も€濓紝鑰屼笉鏄潰鍚戞煇涓浐瀹氱増鏈彿銆?

## 4.3.2 椤圭洰涓?README 鐨勬渶灏忓繀澶囬」搴斿寘鍚€昏緫鍏ュ彛璇存槑

- 褰撳墠鐗堟湰寤鸿鎶婅繖鏉¤繘涓€姝ュ墠缃埌椤圭洰涓?README / 涓?md 鐨勬渶灏忓繀澶囬」涓€?
- 涔熷氨鏄锛岄」鐩富鏂囨。闄や簡璇存槑椤圭洰鐩爣銆佺洰褰曠粨鏋勩€佷娇鐢ㄦ柟寮忎箣澶栵紝杩樺簲榛樿鍖呭惈锛?
  - 褰撳墠椤圭洰閫昏緫鍏ュ彛鏄惁鍦ㄤ粨搴撳唴
  - 鑻ュ湪浠撳簱鍐咃紝閫昏緫鏂囦欢璺緞
  - 鑻ヤ笉鍦ㄤ粨搴撳唴锛岄€昏緫鏂囦欢搴斾粠鍝噷鎺ュ叆
  - 姝ｅ紡寮€濮嬮」鐩墠鏄惁闇€瑕佸厛鎸傛帴澶栭儴閫昏緫鍖?
- 杩欐牱椤圭洰鏂囨。浼氬弽杩囨潵甯姪 Agent 鏇村揩瀹屾垚涓婚€昏緫鎺ュ叆锛屽舰鎴愭鍚戝惊鐜€?

## 4.4 椤圭洰鎺ュ叆鏃跺繀椤诲缓绔嬮」鐩簨瀹炲湴鍥?

- 褰撳墠椤圭洰杩涗竴姝ヨ瘉鏄庯細鍙涓婚€昏緫杩樹笉澶燂紝Agent 杩樺繀椤诲缓绔嬮」鐩簨瀹炲湴鍥俱€?
- 椤圭洰浜嬪疄鍦板浘鑷冲皯闇€瑕佽鐩栵細
  - 椤圭洰涓荤洰鏍?
  - 涓绘枃妗ｅ叆鍙?
  - 褰撳墠椤圭洰閫昏緫鍏ュ彛鏄惁宸茬‘璁?
  - 褰撳墠浠诲姟鎵€灞炴ā鍧?
  - 鍏抽敭鍏ュ彛鏂囦欢
  - 鍏抽敭鍑芥暟 / 绫?
  - 鏈‘璁や簨瀹炵偣
- 杩欎唤鍦板浘涓嶆槸涓轰簡杈撳嚭婕備寒鎽樿锛岃€屾槸涓轰簡淇濊瘉鍚庣画瀹炵幇銆佷慨鏀广€侀獙璇佹椂涓嶄細鍋忕鐪熷疄椤圭洰缁撴瀯銆?
- 鑻ュ悗缁闀挎湡澶嶇敤锛屽簲灏介噺鎶婇」鐩簨瀹炲湴鍥惧浐瀹氭垚妯℃澘杈撳嚭锛岃€屼笉鏄瘡娆￠噸鏂扮粍缁囧瓧娈甸『搴忋€?
- 鑻ラ€昏緫鍖呭唴宸叉湁鏍囧噯妯℃澘鏂囦欢锛屽垯鍚庣画 Agent 搴斾紭鍏堢洿鎺ヤ娇鐢ㄨ妯℃澘銆?

## 4.4.1 閫昏緫鍏ュ彛妫€鏌ユ竻鍗曞簲鍥哄畾

- 褰撳墠鐗堟湰寤鸿鎶娾€滈€昏緫鍏ュ彛妫€鏌モ€濅篃鍥哄畾鎴愪竴浠界煭娓呭崟銆?
- 姣忔閲嶆柊寮€濮嬮」鐩椂锛岃嚦灏戝簲妫€鏌ワ細
  - 椤圭洰涓绘枃妗ｅ叆鍙ｆ槸鍚﹀凡瀹氫綅
  - 椤圭洰閫昏緫鍏ュ彛鏄惁宸插畾浣?
  - 鑻ラ」鐩洰褰曞唴鏈湅鍒伴€昏緫鏂囦欢锛屾槸鍚﹀凡璇㈤棶鍏朵綅缃?
  - 褰撳墠閫昏緫鍏ュ彛鏄惁涓虹増鏈棤鍏崇‘璁わ紝鑰屼笉鏄嚟鏃х増鏈悕鐚滄祴
  - 鐩綍瀹¤鏄惁宸插畬鎴?
- 杩欐牱鍙互鎶娾€滃紑濮嬮」鐩墠鐨勫姩浣溾€濆浐鍖栨垚绋冲畾鍏ュ彛锛岃€屼笉鏄緷璧栧崟娆′細璇濊蹇嗐€?
- 鑻ラ€昏緫鍖呭唴宸叉湁鏍囧噯娓呭崟鏂囦欢锛屽垯鍚庣画 Agent 搴斾紭鍏堢洿鎺ユ寜娓呭崟鎵ц銆?

## 4.5 涓婚€昏緫涓嶈兘鍙鍓嶅崐娈?

- 褰撳墠鐗堟湰鏄庣‘瑕佹眰锛欰gent 蹇呴』瀹屾暣闃呰涓婚€昏緫锛屼笉鑳藉彧璇诲彇鍓嶉潰鐨勮嫢骞叉潯娆惧悗灏辫繘鍏ユ墽琛屻€?
- 鍚庨儴绔犺妭閫氬父鍖呭惈绂佹浜嬮」銆佹墦鍖呰竟鐣屻€侀闄╄鍒欍€佸悓姝ヨ鍒欏拰鐗堟湰缁存姢瑙勫垯銆?
- 鍥犳锛屸€滃畬鏁撮槄璇讳富閫昏緫鈥濇湰韬氨鏄帴鍏ュ姩浣滅殑涓€閮ㄥ垎锛岃€屼笉鏄彲閫変範鎯€?

## 4.6 榛樿宸ュ叿浣庢晥鏃跺繀椤讳富鍔ㄨ瘎浼?

- 褰撳墠鐗堟湰杩涗竴姝ヨ姹傦細濡傛灉榛樿宸ュ叿銆侀粯璁ゆ祻瑙堝櫒璺緞銆侀粯璁ら槄璇昏矾寰勬垨榛樿鎼滅储璺緞鏄庢樉浣庢晥锛孉gent 涓嶅簲琚姩鍧氭寔鏃ц矾寰勩€?
- Agent 搴斾富鍔ㄨ瘎浼帮細
  - 鏄惁瀛樺湪鏇撮€傚悎褰撳墠浠诲姟鐨勫伐鍏锋垨 skills
  - 鏄惁瀛樺湪鏇存垚鐔熺殑澶栭儴鍊欓€夋柟妗?
  - 鍊欓€夋柟妗堝睘浜庢帹鑽愰」銆佸€欓€夊寮洪」杩樻槸姝ｅ紡闆嗘垚椤?

## 4.7 V6 鍙綔涓哄鎸傞€昏緫鍖咃紝涓嶄綔涓洪」鐩洰褰?

- 褰撳墠椤圭洰宸茬粡璇佹槑锛氫富閫昏緫鍖呬笌涓氬姟椤圭洰鐩綍蹇呴』涓ユ牸鍒嗙銆?
- `AgentLogic_V6` 鐨勮鑹叉槸澶栨寕閫昏緫鑴戯紝涓嶆槸涓氬姟浠撳簱鏈綋锛屼篃涓嶆槸鏂伴」鐩€佹柊妯″潡鐨勮惤鐩樼洰褰曘€?
- 鍚庣画浠讳綍 Agent 杩涘叆鏂伴」鐩椂锛屽厑璁告妸 V6 褰撲綔锛?
  - 涓婚€昏緫鍏ュ彛
  - 瑙勫垯鍙傝€冨寘
  - 鑳藉姏鏄犲皠鍖?
  - 瀹¤涓庤ˉ寮哄熀绾?
- 浣嗕笉鍏佽鎶?V6 褰撲綔锛?
  - 椤圭洰婧愮爜鐩綍
  - 妯″潡鍒涘缓鐩綍
  - 渚濊禆瀹夎鐩綍
  - 鏋勫缓杈撳嚭鐩綍
  - 涓存椂娴嬭瘯涓庢棩蹇楃洰褰?
- 鑻ュ惎鍔ㄦ柊椤圭洰锛屽繀椤诲厛寤虹珛鐙珛椤圭洰鐩綍锛屽啀灏?V6 浣滀负澶栨寕瑙勫垯鎺ュ叆銆?

## 4.8 鍚姩鍓嶇洰褰曞璁″繀椤诲墠缃?

- 褰撳墠鐗堟湰杩樺簲鎶娾€滅洰褰曞璁♀€濇彁鍗囦负鍚姩鍓嶅己鍒跺姩浣溿€?
- Agent 鍦ㄥ紑濮嬩换浣曚細鍒涘缓涓氬姟鏂囦欢鐨勪换鍔″墠锛岄兘蹇呴』鍏堝垽鏂綋鍓嶇洰褰曟槸鍚﹀睘浜?V6 閫昏緫鍖呰寖鍥淬€?
- 濡傛灉褰撳墠鐩綍灞炰簬锛?
  - `AgentLogic_V6`
  - 閫昏緫鍖呯淮鎶ょ洰褰?
  - 閫昏緫鍖呴暅鍍忕洰褰?
  - 閫昏緫鍖呰В鍘嬬洰褰?
  鍒欎笉寰楃洿鎺ョ户缁」鐩垵濮嬪寲鎴栨ā鍧楀垱寤恒€?
- 姝ｇ‘鍔ㄤ綔鏄厛鍒囨崲鍒扮嫭绔嬮」鐩洰褰曪紝鍐嶆妸 V6 浣滀负澶栨寕瑙勫垯鎺ュ叆銆?
- 杩欐潯瑙勫垯鐨勭洰鏍囷紝鏄槻姝?AI 鍙湪宸叉湁宸ュ叿閲屾墦杞紝蹇界暐鏇村ソ鐢ㄧ殑澶栭儴宸ュ叿锛屼粠鑰岄檷浣庢晥鐜囧拰鍒ゆ柇璐ㄩ噺銆?
- 缁熶竴琛ㄨ揪涓猴細榛樿宸ュ叿浣庢晥鏃讹紝Agent 搴斾富鍔ㄥ鎵炬洿閫傚悎褰撳墠浠诲姟鐨勫伐鍏锋垨鏂规锛屼絾蹇呴』鍖哄垎姝ｅ紡鑳藉姏涓庡€欓€夊寮恒€?

## 5. 褰撳墠椤圭洰鐨勬墦鍖呮寚瀹?

瀵逛簬褰撳墠椤圭洰锛屼富閫昏緫搴旀槑纭己鍒舵寚瀹氫互涓嬭竟鐣岋細

- `src/tools/` 蹇呴』浣滀负宸ュ叿鍘熷婧愮爜灞傛暣鍖呬繚鐣欍€?
- `src/Tool.ts`銆乣src/tools.ts`銆乣src/services/tools/` 蹇呴』浣滀负宸ュ叿鍩虹璁炬柦灞備繚鐣欍€?
- `src/utils/permissions/` 涓嶈姹傛暣鐩綍澶嶅埗锛屼絾鑷冲皯瑕佸湪閫昏緫灞備腑鏄庣‘绱㈠紩涓庡叧閿矾寰勩€?
- `docs/` 涓嶈姹傚叏閲忓鍒讹紝浣嗘牳蹇冪珷鑺傚繀椤诲湪绱㈠紩灞備腑鐐瑰悕銆?
- 澶у瀷 UI 鐩綍涓嶈姹傛暣鍖呰繘鍏ラ€昏緫鍖咃紝榛樿浠ュ叆鍙ｇ储寮曞拰涓婚摼璺鏄庝负涓汇€?

## 6. 涓轰粈涔堝厑璁稿伐鍏风洿鎺ユ墦鍖?

褰撳墠椤圭洰鐨勫伐鍏风郴缁熻妯¤緝澶э紝涓斿緢澶氫环鍊兼潵鑷湡瀹炲疄鐜拌€屼笉鏄憳瑕佹枃瀛椼€?

鍥犳閲囩敤浠ヤ笅绛栫暐鏇寸ǔ瀹氾細

- 宸ュ叿婧愮爜鍘熸牱淇濈暀
- 宸ュ叿鎬昏鍗曠嫭瑙ｉ噴
- 宸ュ叿娉ㄥ唽涓庢墽琛屽熀纭€璁炬柦鍗曠嫭瑙ｉ噴
- 瀵?stub銆乫eature flag銆佹潯浠跺惎鐢ㄥ伐鍏峰湪閫昏緫灞傛槑纭爣璁?

## 7. 褰撳墠椤圭洰鐨勬渶缁堝垎灞傝竟鐣?

瀵瑰綋鍓嶉」鐩紝寤鸿褰㈡垚濡備笅鏈€缁堣竟鐣岋細

- P0 鏁村寘淇濈暀
  - `src/tools/`
  - `src/Tool.ts`
  - `src/tools.ts`
  - `src/services/tools/`
- P1 淇濈暀鍏抽敭瀹炵幇灞?
  - `src/utils/permissions/`
  - `src/services/mcp/`
  - `src/skills/`
  - `src/tools/AgentTool/`
- P2 淇濈暀绱㈠紩涓庢槧灏?
  - `src/commands/`
  - `src/context.ts`
  - `src/state/`
- P3 鍏ュ彛鍖栧鐞?
  - 澶у瀷 UI 鐩綍
  - 灞曠ず鎬х粍浠?

褰撳墠鐗堟湰杩涗竴姝ュ姞寮轰负锛?

- `src/commands/` 浣滀负鍛戒护闈㈠師濮嬪眰淇濈暀
- `context.ts` 涓?`state/` 缁х画淇濇寔绱㈠紩浼樺厛

## 8. 瀵逛富閫昏緫鐨勬柊澧炶ˉ寮?

鐩歌緝浜庢洿鏃╃増鏈殑涓婚€昏緫锛屽綋鍓嶉」鐩澶栬瘉鏄庝簡浠ヤ笅鍐呭搴旈暱鏈熻繘鍏ヤ富閫昏緫锛?

- 閫昏緫鍖呭簲鏄€滄簮鐮侀┍鍔ㄧ殑鐭ヨ瘑鍖呪€濓紝涓嶆槸鈥滄簮鐮佸鍒跺寘鈥濄€?
- 宸ュ叿绯荤粺蹇呴』鏁村悎鎴愬畬鏁磋鍥撅紝鑷冲皯娑电洊娉ㄥ唽銆佽繃婊ゃ€佹巿鏉冦€佹墽琛屻€佸洖娴併€?
- 椤圭洰绾ч€昏緫鍖呴渶瑕佷繚鐣欌€滆兘鍔涚姸鎬佲€濈淮搴︼紝閬垮厤鎶?stub 鎴栨浠ｇ爜璇啓鎴愮湡瀹炶兘鍔涖€?
- 鍙戠幇鏇村噯纭殑鏋舵瀯銆佸伐鍏枫€佹潈闄愩€佹墿灞曡竟鐣屾椂锛屽簲鍚屾鍙嶅摵涓婚€昏緫鏂囦欢銆?
- 褰撻」鐩瓨鍦ㄧ湡瀹炲叆鍙?/ 璧锋墜婧愮爜鏂囦欢鏃讹紝杩欎簺鏂囦欢椤堕儴榛樿閮藉簲鏀剧疆鐭皬鐨勯€昏緫鍏ュ彛鎻愰啋銆?- 杩欐潯瑙勫垯鐨勯粯璁よ寖鍥翠笉鏄€滃彧闄愬叧閿叆鍙ｂ€濓紝鑰屾槸瑕嗙洊椤圭洰鍐呮墍鏈夌湡瀹炲叆鍙?/ 璧锋墜婧愮爜鏂囦欢锛涗絾涓嶅簲鏈烘閾烘弧宸ュ叿鍑芥暟銆佸彾瀛愮粍浠跺拰闈炲叆鍙ｅ疄鐜版枃浠躲€?- 鎻愰啋搴旀寚鍚戜粨搴撳唴鐨?`AGENTS.md`銆乣README.md` 绛夌浉瀵瑰叆鍙ｆ枃浠讹紝鑰屼笉鏄啓鍏ユ満鍣ㄧ浉鍏崇殑缁濆璺緞銆?
- 杩欐牱鍙互鎶娾€滀富閫昏緫鍥炶鈥濅粠椤跺眰鏂囨。寤朵几鍒扮湡瀹炲紑宸ョ偣锛岄檷浣庡杞璇濆悗鐨勪富閫昏緫婕傜Щ椋庨櫓銆?
- 濡傛灉椤圭洰瑕佹妸杩欐潯瑙勫垯浠庘€滄枃妗ｈ鑼冣€濆崌绾т负鈥滃伐绋嬬害鏉熲€濓紝鍒欒繕搴旀彁渚涗粨搴撶骇鏍￠獙鑴氭湰锛岀敤浜庢満姊版鏌ユ墍鏈夌湡瀹炲叆鍙?/ 璧锋墜婧愮爜鏂囦欢涓庝富鏂囨。鏄惁浠嶄繚鐣欓€昏緫鍏ュ彛鎻愰啋銆?- 璇ョ被鑴氭湰搴斾紭鍏堟鏌ワ細
  - 浠撳簱绾у叆鍙ｆ枃妗ｆ槸鍚︿粛鎸囧悜涓婚€昏緫鍏ュ彛
  - 鎵€鏈夌湡瀹炲叆鍙?/ 璧锋墜婧愮爜鏂囦欢椤堕儴鏄惁浠嶄繚鐣欑煭鎻愰啋
  - 鎻愰啋鍐呭鏄惁鎸囧洖浠撳簱鐩稿璺緞锛岃€屼笉鏄満鍣ㄧ粷瀵硅矾寰?


## 9. Continuous Execution Interpretation For This Project

- In this project-level logic summary, repeated confirmation is not the goal of the startup chain.
- The goal is to preserve logical continuity and prevent context drift.
- If the user explicitly says any equivalent of:
  - "unless I say stop, keep going"
  - "do not keep asking me for confirmation"
  - "follow the plan and keep writing"
  then that statement must be treated as active continuous-execution authorization within the current task scope.
- Under that authorization:
  - subsequent implementation steps should default to being treated as the same ongoing execution round
  - the agent should continue reading, editing, validating, and fixing in sequence without repeated confirmation at ordinary step boundaries
  - the agent should stop only when:
    - the user explicitly says to stop
    - the current plan is complete and a new strategic direction is required
    - a true blocker cannot be resolved from local context
    - a high-risk irreversible action is about to be taken
- This authorization also implies that the work is still in implementation / build-out mode by default, not yet in formal product-test stage, unless the user explicitly says testing has begun.

## END FILE: modules/01_MasterLogic.md

---

## BEGIN FILE: modules/03_AgenticLoop.md

# Agentic Loop

## 1. 涓婚摼璺?

褰撳墠椤圭洰鐨勪竴娆℃爣鍑嗘墽琛岄摼璺彲浠ュ啓鎴愶細

1. 鐢ㄦ埛杈撳叆杩涘叆 REPL 鎴?pipe 妯″紡
2. `QueryEngine` 鏀堕泦鐘舵€併€佷笂涓嬫枃銆佹秷鎭€佹潈闄愪笂涓嬫枃
3. `query()` 鍙戣捣涓€娆℃ā鍨嬭姹?
4. 妯″瀷杩斿洖鏂囨湰鍧楀拰 `tool_use`
5. 绯荤粺鏍规嵁宸ュ叿绫诲瀷涓庡苟鍙戝畨鍏ㄦ€ф墽琛屽伐鍏?
6. 宸ュ叿缁撴灉杞垚 `tool_result` 鍥炲啓浼氳瘽
7. 濡傛灉闇€瑕佽拷闂紝鍒欒繘鍏ヤ笅涓€杞惊鐜?
8. 濡傛灉浠诲姟缁撴潫锛屽垯杈撳嚭鏈€缁堢粨鏋滃苟璁板綍鐘舵€?

## 2. 鍏抽敭鍑芥暟璐ｄ换

- `src/QueryEngine.ts`
  璐熻矗浼氳瘽绾х紪鎺掋€佹垚鏈€佹憳瑕併€佹枃浠跺巻鍙层€乼urn bookkeeping銆?
- `src/query.ts`
  璐熻矗鍗曡疆鐨勭湡瀹炴墽琛屽惊鐜€?
- `src/services/tools/toolOrchestration.ts`
  璐熻矗浠诲姟鎵规鍒掑垎銆佷覆琛屾垨骞惰鎵ц銆?
- `src/services/tools/toolExecution.ts`
  璐熻矗鍗曚釜宸ュ叿鎵ц缁嗚妭涓庝笂涓嬫枃琛旀帴銆?
- `src/services/tools/toolHooks.ts`
  璐熻矗 pre/post tool use hook 鐩稿叧閫昏緫銆?

## 3. 涓婁笅鏂囬澶勭悊

鍦ㄦā鍨嬭姹備箣鍓嶏紝褰撳墠椤圭洰鍖呭惈杈冮噸鐨勪笂涓嬫枃棰勭畻涓庡帇缂╅€昏緫锛屾牳蹇冪洰鏍囨槸锛?

- 闃叉鍘嗗彶娑堟伅鏃犻檺鑶ㄨ儉
- 淇濇寔宸ュ叿缁撴灉鐨勫彲鍥炴函鎬?
- 鍦?token 瓒呴檺鍓嶄富鍔ㄥ仛 compact

鐩稿叧鍏抽敭璇嶏細

- auto compact
- micro compact
- tool result budget
- prompt cache

## 4. 宸ュ叿缁撴灉鍥炴祦

宸ュ叿鎵ц涓嶆槸缁堢偣锛岀湡姝ｉ噸瑕佺殑鏄粨鏋滃浣曞洖娴侊細

- 缁撴灉浼氳鏄犲皠涓虹粨鏋勫寲 `tool_result`
- 缁撴灉鍙兘琚鍓€佹憳瑕佹垨鎸佷箙鍖栧埌纾佺洏
- 妯″瀷鍦ㄤ笅涓€杞湅鍒扮殑鏄€滃伐鍏风粨鏋滄秷鎭€濓紝鑰屼笉鏄洿鎺ユ搷浣滅郴缁熺姸鎬?

鍥犳锛岄€昏緫鏁寸悊鏃跺繀椤诲悓鏃惰褰曪細

- 宸ュ叿鎵ц鏂瑰紡
- 宸ュ叿缁撴灉鏍煎紡
- 缁撴灉棰勭畻鎺у埗
- 缁撴灉濡備綍褰卞搷涓嬩竴杞帹鐞?

## 5. 缁存姢閫昏緫鍖呮椂鐨勬敞鎰忕偣

- 涓嶈鍙啓鈥渜uery 鏄牳蹇冣€濓紝瑕佽ˉ榻愬畠涓?`QueryEngine`銆佸伐鍏风紪鎺掋€佹潈闄愪笂涓嬫枃涔嬮棿鐨勫叧绯汇€?
- 涓嶈鎶婂苟琛屾墽琛岃兘鍔涙硾鍖栦负鈥滄墍鏈夊伐鍏烽兘骞惰鈥濄€?
- 褰撳墠椤圭洰鏄庣‘鍖哄垎鍙骞跺彂瀹夊叏宸ュ叿涓庢湁鍓綔鐢ㄥ伐鍏凤紝杩欎竴鐐瑰繀椤婚暱鏈熶繚鐣欏湪閫昏緫鍖呬腑銆?

## END FILE: modules/03_AgenticLoop.md

---

## BEGIN FILE: modules/05_PermissionsAndSafety.md

# Permissions And Safety

## 1. 鏉冮檺浣撶郴鐨勫湴浣?

褰撳墠椤圭洰鐨勬潈闄愮郴缁熶笉鏄檮灞為€昏緫锛岃€屾槸宸ュ叿绯荤粺鐨勫疄闄呰竟鐣屽眰銆?

濡傛灉涓嶇悊瑙ｆ潈闄愭ā鍨嬶紝灏辨棤娉曞噯纭悊瑙ｏ細

- 鍝簺宸ュ叿鍙槸鈥滄敞鍐屼簡鈥?
- 鍝簺宸ュ叿鐪熺殑鑳芥墽琛?
- 鍝簺鎵ц浼?ask
- 鍝簺鎵ц浼?deny

## 2. 涓夌鏉冮檺缁撴灉

- allow
- ask
- deny

杩欎笁绉嶈涓哄叡鍚屽喅瀹氱敤鎴蜂綋楠屻€佸畨鍏ㄨ竟鐣屽拰 agentic loop 鐨勫彲鎸佺画鎬с€?

## 3. 褰撳墠椤圭洰鐨勫叧閿潈闄愯矾寰?

- `src/utils/permissions/permissions.ts`
- `src/utils/permissions/PermissionRule.ts`
- `src/utils/permissions/PermissionResult.ts`
- `src/utils/permissions/permissionSetup.ts`
- `src/utils/permissions/denialTracking.ts`

## 4. 璁″垝妯″紡

璁″垝妯″紡鏄綋鍓嶉」鐩潪甯稿叧閿殑涓€灞傛墽琛屽垎娴侊細

- 鎺㈢储闃舵浼樺厛鍙
- 閫€鍑鸿鍒掓ā寮忓悗鍐嶈繘鍏ユ墽琛?
- 鍏佽鍦ㄢ€滃厛鐞嗚В鍐嶄慨鏀光€濈殑宸ョ▼绾緥涓婂舰鎴愮郴缁熷寲绾︽潫

鐩稿叧宸ュ叿锛?

- `src/tools/EnterPlanModeTool/`
- `src/tools/ExitPlanModeTool/`

## 5. 娌欑涓庡懡浠ゅ畨鍏?

鍛戒护鎵ц瀹夊叏閲嶇偣闆嗕腑鍦細

- `src/tools/BashTool/`
- `src/tools/PowerShellTool/`
- `docs/safety/sandbox.mdx`

闇€瑕侀暱鏈熺淮鎶ょ殑鍏抽敭鐐癸細

- 鏄惁璧版矙绠?
- 鏄惁鍏佽 unsandboxed
- 骞冲彴宸紓
- 鍙鍛戒护涓庢湁鍓綔鐢ㄥ懡浠ょ殑鍖哄垎
- 鍛戒护妯″紡鍖归厤鍜屽嵄闄╁懡浠よ瘑鍒?

## 6. Denial Tracking

璇ユ満鍒剁殑宸ョ▼浠峰€煎緢楂橈紝搴旀寔缁啓鍏ヤ富閫昏緫锛?

- 闃叉妯″瀷鍦ㄨ鎷掑悗鏃犻檺閲嶅鍚岀被璇锋眰
- 灏嗘嫆缁濊褰曡浆鍖栦负鎵ц绛栫暐璋冩暣
- 璁╂潈闄愮郴缁熶笉鍙槸鈥滄嫤鎴€濓紝鑰屾槸鈥滄帶鍒惰涓烘敹鏁涒€?

## 7. 楠岃瘉鏍囧噯

涓庡綋鍓嶉」鐩浉鍏崇殑楠岃瘉锛屼笉搴斿彧鍋滅暀鍦ㄥ伐鍏疯兘璋冮€氾紝鑰屽簲鑷冲皯鑰冭檻锛?

- 瑙勫垯鍛戒腑鏄惁绗﹀悎棰勬湡
- 璁″垝妯″紡鍒囨崲鍚庢潈闄愭槸鍚﹀洖婊?
- 娌欑涓?bypass 鏄惁绗﹀悎閰嶇疆
- 鍚屼竴宸ュ叿琚嫆澶氭鍚庣殑琛屼负鏄惁姝ｇ‘
- 楂橀闄╁啓鎿嶄綔鏄惁瀛樺湪鎭㈠璺緞

## END FILE: modules/05_PermissionsAndSafety.md

---

## BEGIN FILE: modules/12_AgentEnforcement.md

# Agent Enforcement

## 1. 鐩殑

鏈枃浠剁敤浜庢槑纭竴浠朵簨锛?

杩欎釜閫昏緫鍖呬笉浠呮槸缁欎汉闃呰鐨勶紝涔熸槸缁欏悗缁繘鍏ラ」鐩殑 Agent 鐢ㄦ潵寮哄埗閬靛惊鐨勪富閫昏緫鍩虹嚎銆?

## 2. 寮哄埗閫傜敤鑼冨洿

浠ヤ笅绫诲瀷鐨?Agent 閮藉繀椤婚伒寰細

- 涓荤嚎绋?Agent
- 瀛?Agent
- 骞惰 Agent
- review Agent
- verification Agent
- planning Agent
- 妯″潡涓撶敤 Agent

## 3. 瑙﹀彂鏉′欢

鍑虹幇浠ヤ笅浠讳竴鏉′欢鏃讹紝蹇呴』閲嶆柊璧颁富閫昏緫鎺ュ叆锛?

- 寮€濮嬩竴涓柊椤圭洰
- 鎺ユ墜涓€涓柊妯″潡
- 鏂板涓€涓柊妯″潡
- 杩涘叆涓€涓箣鍓嶆湭璇婚€忕殑瀛愮郴缁?
- 浠庡垎鏋愰樁娈靛垏鎹㈠埌瀹炴柦闃舵

## 4. 寮哄埗鎵ц鍐呭

Agent 鑷冲皯蹇呴』瀹屾垚锛?

1. 璇嗗埆椤圭洰鏂囨。涓诲叆鍙?
2. 纭椤圭洰鐩綍涓嬫槸鍚﹀瓨鍦ㄥ綋鍓嶉」鐩娇鐢ㄧ殑 Agent 閫昏緫鏂囦欢锛涜嫢涓嶅瓨鍦紝鍏堣闂€昏緫鍏ュ彛浣嶇疆
3. 鍒ゆ柇褰撳墠浠诲姟鏄惁灞炰簬涓婁竴杞?coding 鐨勫欢鐢?
4. 鑻ヤ笉灞炰簬涓婁竴杞欢鐢筹紝鍏堣闂敤鎴锋槸鍚﹂渶瑕?`forget/compress context`
5. 鑻ヨ鏀剁缉涓婁笅鏂囷紝鍏堟妸褰撳墠鏈夋晥鐘舵€佸洖鍐欏埌缁撴瀯鍖栬浇浣?
6. 璇诲彇鐩稿叧 md 涓庡叧閿叆鍙ｆ簮鐮?
7. 鍒ゆ柇褰撳墠浠诲姟浣嶄簬 L1 / L2 / L3 鍝竴灞?
8. 缁欏嚭鎵ц椤哄簭銆佽竟鐣屽拰椋庨櫓鍒ゆ柇
9. 濡傛灉鏄柊澧炴ā鍧楋紝鍒欒ˉ妯″潡绾ц鍒?
10. 寤虹珛鏈€灏忛」鐩簨瀹炲湴鍥撅紝鏄庣‘椤圭洰鐩爣銆佹ā鍧楄惤鐐广€佸叆鍙ｆ枃浠朵笌鍏抽敭鍑芥暟 / 绫?
11. 鎸夐€昏緫鍏ュ彛妫€鏌ユ竻鍗曞畬鎴愬惎鍔ㄥ墠鏍稿

- `AgentLogic_V6` 鍙兘浣滀负澶栨寕閫昏緫鑴戜笌瑙勫垯鍖呭瓨鍦紝涓嶅緱琚綋浣滀笟鍔￠」鐩伐浣滅洰褰曘€?
- Agent 涓嶅緱鍦?V6 鐩綍涓嬪垱寤烘柊椤圭洰婧愮爜銆佹ā鍧楁枃浠躲€佷緷璧栧畨瑁呯粨鏋溿€佹瀯寤轰骇鐗┿€佹棩蹇楁垨娴嬭瘯鏉傞」銆?
- 涓€鏃﹀彂鐜板綋鍓嶈矾寰勮惤鍦?V6 閫昏緫鍖呭唴锛岃€屼换鍔″張瑕佹眰鍒涘缓涓氬姟鏂囦欢锛屽繀椤诲厛鍒囨崲鍒扮嫭绔嬮」鐩洰褰曘€?
- 杩涘叆鎵ц鍓嶅繀椤诲厛鍋氱洰褰曞璁★紝鐩綍瀹¤鏈€氳繃鏃讹紝涓嶅緱寮€濮嬪垵濮嬪寲銆佸啓鏂囦欢銆佽渚濊禆鎴栫敓鎴愭ā鍧椼€?

## 4.1 涓婚€昏緫蹇呴』瀹屾暣闃呰

- Agent 涓嶅緱鎶娾€滆杩囧墠鍑犳潯涓婚€昏緫鈥濊涓哄凡瀹屾垚鎺ュ叆銆?
- 鍙湁鍦ㄥ畬鏁磋瀹屼富閫昏緫鍚庯紝鎵嶅彲瑙嗕负鐪熸瀹屾垚涓婚€昏緫鎺ュ叆銆?
- 灏ゅ叾涓嶅緱鍑虹幇浠ヤ笅閿欒琛屼负锛?
  - 鍙鍓嶉儴绔犺妭
  - 鍙寜鍏抽敭璇嶅懡涓鍙?
  - 鍥犱负鍓嶉潰宸叉湁鑻ュ共瑙勫垯锛屽氨蹇界暐鍚庨儴绔犺妭
- 涓婚€昏緫鍚庨儴寰€寰€鍖呭惈锛?
  - 绂佹浜嬮」
  - 鎵撳寘瑙勫垯
  - 椋庨櫓杈圭晫
  - 鐗堟湰缁存姢瑙勫垯
  - 鍥炲啓涓庡悓姝ヨ姹?
- 杩欎簺鍐呭琚烦杩囧悗锛屽悗鏈熷啀鍥炴潵瀵归綈鐨勬垚鏈€氬父鏇撮珮銆?

## 4.2 宸ュ叿涓?Skills 鐨勪富鍔ㄨ瘎浼拌姹?

- 褰?Agent 鏃犳硶纭畾褰撳墠浠诲姟鏈€閫傚悎浠€涔堝伐鍏锋垨 skills锛屾垨鑰呭彂鐜伴粯璁よ矾寰勬槑鏄句綆鏁堟椂锛屽繀椤讳富鍔ㄨ繘琛屽伐鍏疯瘎浼帮紝鑰屼笉鏄満姊版部鐢ㄦ棫璺緞銆?
- 杩欑璇勪及鑷冲皯搴旇鐩栵細
  - 鐜版湁宸ュ叿鏄惁鍙槸鈥滃媺寮鸿兘鐢ㄢ€?
  - 鏄惁瀛樺湪鏇翠笓涓氥€佹洿楂樻晥銆佹洿绋冲畾鐨勫€欓€夊伐鍏?
  - 鏇夸唬鏂规鏄惁鑳芥樉钁楁彁鍗囬槄璇汇€佹悳绱€佸垎绫绘垨鑷姩鍖栨晥鐜?
- 鍏剁洰鐨勶紝鏄槻姝?Agent 鍥犱负鍙洴鐫€鎵嬪ご宸叉湁宸ュ叿鑰岄棴闂ㄩ€犺溅锛屽拷鐣ュ閮ㄥ凡缁忔洿鎴愮啛銆佹洿鍚堥€傜殑宸ュ叿銆?

## 4.2.1 蹇呴』鍖哄垎鏂规硶灞備笌椤圭洰浜嬪疄灞?

- `AgentLogic_V6` 鏄柟娉曞眰銆佽鍒欏眰銆佽涓哄眰锛屼笉鏄叿浣撻」鐩殑涓氬姟璇存槑涔︺€?
- 椤圭洰鑷韩 md 涓庢簮鐮侊紝鎵嶆槸涓氬姟浜嬪疄灞備笌瀹炵幇浜嬪疄灞傘€?
- 鍥犳 Agent 蹇呴』锛?
  - 鐢?V6 鍐冲畾濡備綍寮€濮嬮」鐩?
  - 鐢ㄩ」鐩枃妗ｅ拰婧愮爜鍒ゆ柇椤圭洰鍒板簳鏄粈涔堛€佹ā鍧楀湪鍝噷銆佸嚱鏁板湪鍝噷
- 涓嶅緱鎶?V6 鐨勬娊璞＄粡楠岀洿鎺ュ綋浣滃叿浣撻」鐩簨瀹炪€?

## 4.2.2 椤圭洰寮€濮嬪墠蹇呴』纭閫昏緫鍏ュ彛

- Agent 閲嶆柊寮€濮嬮」鐩椂锛屼笉鑳藉彧璇婚」鐩富 md 鍚庡氨鐩存帴寮€宸ャ€?
- 鍦ㄦ寮忓紑濮嬪墠锛屽繀椤荤‘璁ゅ綋鍓嶉」鐩娇鐢ㄧ殑 Agent 閫昏緫鏂囦欢鏄惁宸插畾浣嶃€?
- 濡傛灉椤圭洰鐩綍鍐呮病鏈夌洿鎺ョ湅鍒伴€昏緫鏂囦欢锛屼笉寰楁搮鑷烦杩囷紝鑰屽簲鍏堣闂€昏緫鏂囦欢鍦ㄥ摢閲屻€?
- 杩欓噷蹇呴』浣跨敤鐗堟湰鏃犲叧琛ㄨ揪锛屽洜涓洪€昏緫鍏ュ彛鍙兘涓嶆槸 `V6`锛屼篃鍙兘鏄悗缁柊鐗堟湰銆?

## 4.2.3 椤圭洰浜嬪疄鍦板浘涓庨€昏緫鍏ュ彛娓呭崟搴旀ā鏉垮寲

- 椤圭洰浜嬪疄鍦板浘涓嶅簲姣忔浠庨浂缁勭粐锛屽缓璁寜鍥哄畾妯℃澘杈撳嚭銆?
- 閫昏緫鍏ュ彛妫€鏌ヤ篃涓嶅簲闈犺蹇嗘墽琛岋紝寤鸿鎸夊浐瀹氭竻鍗曟牳瀵广€?
- 杩欐牱鍋氱殑鐩殑锛屾槸闄嶄綆涓嶅悓 Agent銆佷笉鍚岃疆娆°€佷笉鍚岄」鐩箣闂寸殑鎺ュ叆婕傜Щ銆?
- 鑻ラ€昏緫鍖呬腑宸叉彁渚涙爣鍑嗘ā鏉夸笌鏍囧噯娓呭崟锛岄粯璁ゅ簲浼樺厛鐩存帴澶嶇敤銆?

## 4.2.4 浠撳簱绾х‖绾︽潫鎺ㄨ崘钀界偣

- 濡傛灉椤圭洰甯屾湜鎶婇€昏緫鍏ュ彛浠庘€滄枃妗ｈ鑼冣€濆崌绾т负鈥滃伐绋嬬骇绾︽潫鈥濓紝鑷冲皯搴旇ˉ浠ヤ笅涓夊眰锛?  - 浠撳簱涓绘枃妗ｅ０鏄庨€昏緫鍏ュ彛涓庢鏌ュ懡浠?  - 鎵€鏈夌湡瀹炲叆鍙?/ 璧锋墜婧愮爜鏂囦欢椤堕儴淇濈暀浣庡櫔澹版彁閱?  - 浠撳簱鎻愪緵鍙墽琛岃剼鏈鏌ヨ繖浜涙彁閱掓槸鍚︿粛瀛樺湪
- 杩欑妫€鏌ヨ剼鏈殑鐩爣涓嶆槸鏇夸唬涓婚€昏緫闃呰锛岃€屾槸闃叉椤圭洰鍦ㄥ杞敼鍔ㄥ悗鎶婇€昏緫鍏ュ彛鎻愰啋鎮勬倓鍒犳帀銆?- 杩欓噷鐨勨€滃叆鍙?/ 璧锋墜婧愮爜鏂囦欢鈥濋粯璁や笉鍐嶅彧鎸囧皯鏁板叧閿叆鍙ｏ紝鑰屾槸鎸?Agent 寰堝彲鑳戒粠閭ｉ噷寮€濮嬮槄璇汇€佷慨鏀规垨瀹炴柦鐨勭湡瀹炰唬鐮佸叆鍙ｏ紱宸ュ叿鍑芥暟銆佸彾瀛愮粍浠跺拰闈炲叆鍙ｅ疄鐜版枃浠朵笉搴旇鏈烘绾冲叆銆?- 鎺ㄨ崘鍛戒护褰㈡€佺ず渚嬶細
  - `node scripts/check-logic-entry.js`
- 鍙湁鍏峰杩欎笁灞傚悗锛岄€昏緫鍏ュ彛绾︽潫鎵嶅紑濮嬩粠鈥滆鑼冪骇鈥濆悜鈥滃伐绋嬬骇鈥濊繃娓°€?

## 4.2.5 Real Entry / Starting Source Files Must Carry the Mandatory Logic Gate

- Every real entry / starting source file in the repository must carry the standardized Mandatory Logic Gate header.
- This is a mandatory enforcement requirement, not a documentation preference.

- The reason is operational:
  - AI agents frequently begin work from entry files, control files, route files, renderer roots, and other high-frequency starting source files
  - therefore these source-level starting points are the most reliable places to block premature implementation
  - repeated testing shows that this significantly reduces context-carryover errors and skipped startup checks

- The Mandatory Logic Gate must not be interpreted as:
  - a reminder
  - optional guidance
  - a local coding style
  - a comment that may be removed during cleanup

- It must instead be interpreted as:
  - a blocking startup gate
  - an implementation precondition
  - a repository-level logic enforcement point

- Before the gate has been satisfied, the agent must not:
  - continue deeper reading
  - edit files
  - delete files
  - execute write operations
  - begin implementation

- The gate must require the agent to:
  1. read `AGENTS.md` and `README.md`
  2. follow the repository-declared logic-entry chain
  3. explicitly determine whether the task extends the previous coding round
  4. if not, explicitly ask whether to forget/compress context first

- The gate must be:
  - English by default
  - short and high-signal
  - repository-relative in path references
  - present on every real entry / starting source file

- Repositories should back this requirement with a mechanical validation script so that real entry / starting source files can be checked for gate presence and integrity.

## 4.2.4.1 鏂囦欢澶村己鍒惰鍒欓粯璁や娇鐢ㄨ嫳鏂?

- 濡傛灉椤圭洰鎶婂己鍒惰鍒欏啓鍏ユ枃浠跺ご閮紝杩欎簺澶撮儴瑙勫垯榛樿蹇呴』浣跨敤鑻辨枃銆?
- 璇ヨ姹傞€傜敤浜庯細
  - 婧愮爜鏂囦欢澶撮儴
  - 鏍峰紡鏂囦欢澶撮儴
  - 鏍囪鏂囦欢澶撮儴
  - 椤圭洰 markdown 鏂囦欢澶撮儴
- 鐩殑涓嶆槸璇█鍋忓ソ锛岃€屾槸淇濊瘉璺?Agent銆佽法璇█鐜銆佽法妯″瀷鎻愪緵鏂规椂鐨勭ǔ瀹氫竴鑷存€с€?
- 椤圭洰姝ｆ枃瑙ｉ噴鍙互缁х画浣跨敤鏈湴璇█锛屼絾鏂囦欢澶撮儴鐨勭煭寮哄埗瑙勫垯榛樿浣跨敤鑻辨枃銆?
- 鑻ラ」鐩凡鎻愪緵浠撳簱绾ф鏌ヨ剼鏈紝鍒欒鑴氭湰涔熷簲鎸夎嫳鏂囨枃鏈繘琛屾牎楠屻€?

## 4.2.5 涓婁笅鏂囬噸缃彁闂睘浜庢渶楂樹紭鍏堝己鍒惰鍒?

- 鈥滃鏋滃綋鍓嶆柊浠诲姟涓嶆槸涓婁竴杞?coding 鐨勫欢鐢筹紝鍒欏繀椤诲厛璇㈤棶鏄惁闇€瑕?`forget/compress context`鈥?杩欐潯瑙勫垯锛屼紭鍏堢骇蹇呴』涓庘€滅‘璁ら€昏緫鍏ュ彛鈥濃€滃垽鏂槸鍚﹀睘浜庝笂涓€杞欢鐢斥€濈浉鍚屻€?
- 瀹冧笉鏄缓璁」锛屼篃涓嶆槸涓婁笅鏂囪繃闀挎椂鎵嶄复鏃惰€冭檻鐨勮ˉ鍏呴」銆?
- 姝ｇ‘椤哄簭蹇呴』鍥哄畾涓猴細
  1. 鍏堢‘璁ら€昏緫鍏ュ彛
  2. 鍐嶅垽鏂槸鍚﹀睘浜庝笂涓€杞欢鐢?
  3. 鑻ヤ笉鏄欢鐢筹紝蹇呴』鍏堣闂槸鍚﹂渶瑕?`forget/compress context`
- 鑻ョ 3 姝ユ湭瀹屾垚锛屼笉寰楃洿鎺ヨ繘鍏ユ寮忓疄鐜般€?
- 鑻ョ敤鎴风‘璁ら渶瑕佹敹缂╀笂涓嬫枃锛孉gent 蹇呴』鍏堝洖鍐欑粨鏋勫寲鐘舵€侊紝鍐嶅噺灏戝伐浣滀笂涓嬫枃銆?

## 4.3 澶栭儴鏇翠紭宸ュ叿鐨勬彁鍑轰箟鍔?

- 褰?Agent 鍦ㄩ」鐩紑濮嬮樁娈点€佹ā鍧楄鍒掗樁娈垫垨娴佺▼璁捐闃舵鍙戠幇澶栭儴宸叉湁鏇村悎閫傜殑宸ュ叿銆乻kills 鎴栬嚜鍔ㄥ寲缁勪欢鏃讹紝搴斾富鍔ㄦ彁鍑恒€?
- 浣嗘彁鍑烘椂蹇呴』鏄庣‘鍖哄垎锛?
  - 鎺ㄨ崘椤?
  - 鍊欓€夊寮洪」
  - 宸叉寮忛泦鎴愰」
- 鏈粡纭锛屼笉寰楁妸鍊欓€夊伐鍏锋弿杩版垚褰撳墠椤圭洰鐨勬寮忚兘鍔涖€?
- 榛樿宸ュ叿浣庢晥鏃讹紝Agent 搴斾富鍔ㄥ鎵炬洿閫傚悎褰撳墠浠诲姟鐨勫伐鍏锋垨鏂规锛屼絾蹇呴』鍖哄垎姝ｅ紡鑳藉姏涓庡€欓€夊寮恒€?

## 5. 涓轰粈涔堣繖鏄己鍒惰姹?

- 涓嶅悓 Agent 杩涘叆椤圭洰鏃舵渶瀹规槗鍑洪敊鐨勫湴鏂癸紝涓嶆槸鑳藉姏涓嶅锛岃€屾槸鍏ュ彛涓嶄竴鑷淬€?
- 涓婚€昏緫鐨勪綔鐢ㄥ氨鏄妸鍏ュ彛缁熶竴銆佸眰绾х粺涓€銆侀獙璇佹柟寮忕粺涓€銆佹枃妗ｅ洖鍐欑粺涓€銆?
- 鍙杩欎釜鍏ュ彛涓€鑷达紝閿欒鐜囥€佽寖鍥存紓绉诲拰灞€閮ㄦ渶浼樹慨澶嶉兘浼氭槑鏄句笅闄嶃€?

## 6. 瀹為檯浣跨敤瑕佹眰

- 姣忔鏂伴」鐩紑濮嬫椂锛屼紭鍏堣 `AgentLogic_V6.md`
- 姣忔椤圭洰绾х淮鎶ゆ椂锛屽啀缁撳悎鏈寘涓殑鍒嗗眰鏂囨。涓庡師濮嬪眰鐩綍
- 濡傛灉鍚庣画鏂板鏇村噯纭殑瑙勫垯锛屽簲鍏堝洖鍐?`AgentLogic_V6.md`锛屽啀鍚屾鏈€昏緫鍖?

## END FILE: modules/12_AgentEnforcement.md

---

## BEGIN FILE: modules/13_MandatoryLogicGateTemplate.md

# Mandatory Logic Gate Template

This file defines the mandatory header template that must be added to every real entry / starting source file.

It is not a suggestion.
It is not a style preference.
It is not a documentation nicety.

It is a blocking execution gate.

The purpose of this template is to reduce AI entry errors at the exact point where implementation usually begins.

Those errors include, but are not limited to:

- skipping repository entry documents
- treating a new task as an automatic continuation of the previous coding round
- silently carrying stale context into a new task
- starting deeper reading, writes, deletions, or implementation before the logic-entry loop is complete
- treating mandatory startup behavior as guidance instead of a hard gate

This template exists because repeated testing shows that AI agents often start from entry files, control files, route files, renderer roots, and other high-frequency starting source files first.
Therefore, the gate must be placed at those real starting points.

---

## 1. Status

This template is mandatory.

It must be treated as:

- a blocking gate
- an execution precondition
- a repository-level enforcement target

It must not be treated as:

- optional guidance
- a reminder only
- a stylistic comment
- a replaceable local habit

---

## 2. Scope

This template must be added to every real entry / starting source file.

Typical required targets include:

- process entry files
- CLI entry files
- main backend control files
- route entry files
- preload bridge files
- major renderer entry files
- main admin UI entry files
- other high-frequency implementation entrypoints

This template should not be mechanically added to every file in the repository.

Do not spread it across:

- utility files
- leaf components
- helper modules
- pure style files
- unrelated test fixtures
- low-level implementation files that are not real entrypoints

The rule is:

- mandatory on all real entry / starting source files
- not universal on all files

---

## 3. Repository Link Rule

The header template must point to repository-relative entry documents first.

Default required repository-relative targets:

- `AGENTS.md`
- `README.md`

The code-file header must not use:

- machine-specific absolute paths
- local-user absolute paths
- temporary working-directory assumptions
- hardcoded host-specific locations

If the repository depends on an external logic package, that external path should be declared in repository-level entry documents, not hardcoded into every source-file header.

The preferred chain is:

1. entry-file header points to `AGENTS.md` and `README.md`
2. repository entry documents point to the current logic-entry chain
3. the logic-entry chain points to the real control files

This preserves portability across machines and repositories.

---

## 4. Required Logic Chain

The mandatory logic gate must force the agent back into the repository-declared logic-entry chain.

That chain should include, when applicable:

- `00_START_HERE.md`
- `modules/01_MasterLogic.md`
- `modules/15_LogicEntryChecklist.md`

If the repository declares a different or extended logic chain, that repository-declared chain takes precedence.

The header template should not attempt to duplicate the full logic package.
Its purpose is to block premature implementation and redirect the agent into the proper chain.

---

## 5. Mandatory Startup Gate Behavior

The template must enforce all of the following behaviors before implementation:

1. read repository entry documents first
2. follow the declared logic-entry chain
3. explicitly determine whether the current task is an extension of the previous coding round
4. if it is not an extension, explicitly ask whether to forget/compress context first
5. treat this startup loop as a blocking gate
6. do not infer continuation automatically
7. do not skip the context-reset question for efficiency
8. do not continue deeper reading, writes, deletions, or implementation before the loop is complete

This behavior is mandatory because the highest-risk failure pattern is not lack of capability.
It is inconsistent entry behavior.

---

## 6. Language Rule

Header-level mandatory rules must default to English.

This applies to:

- source files
- script files
- markup files
- style files
- repository markdown files when using header-level mandatory notices

The purpose is consistency across:

- agents
- models
- environments
- future repository checks

Local-language explanation may still exist in normal document bodies.
But the header-level mandatory gate must default to English unless the repository explicitly declares otherwise.

---

## 7. Noise Rule

The template must stay short and high-signal.

It must not become:

- a project summary
- a module explanation
- a changelog
- a TODO area
- a debugging notebook
- a business description

Its only role is to block premature implementation and redirect the agent into the logic-entry chain.

---

## 8. Standard Long Template

Use the following as the default long-form template.

### Plain text form

```txt
MANDATORY LOGIC GATE

Before making changes here, read `AGENTS.md` and `README.md` first.
Then follow the repository-declared logic entry chain, including `00_START_HERE.md`,
`modules/01_MasterLogic.md`, and `modules/15_LogicEntryChecklist.md` when applicable.

Before every new coding round, explicitly decide whether the current task extends
the previous coding round.
If it does not, explicitly ask whether to forget/compress context before continuing.

Treat this flow as a blocking gate, not as guidance, documentation, or a reminder.
Do not infer continuation by yourself.
Do not skip the context-reset question for efficiency.

Do not continue deeper reading, modify files, delete files, perform write actions,
or begin implementation before the logic-entry loop above has been completed.
```

---

## 9. Standard Short Template

Use the short form only when the file type or entry-file constraints make the long form impractical.

### Plain text form

```txt
MANDATORY LOGIC GATE

Read `AGENTS.md` and `README.md` before making changes here.
Then follow the repository-declared logic entry chain.

Before every new coding round, explicitly decide whether this task extends the previous round.
If not, explicitly ask whether to forget/compress context first.

This is a blocking gate.
Do not infer continuation by yourself.
Do not start deeper reading, writes, or implementation before this loop is completed.
```

The short version is a fallback, not the default.

---

## 10. Language-Specific Header Forms

### 10.1 JS / TS / TSX

```ts
/**
 * MANDATORY LOGIC GATE
 *
 * Before making changes here, read `AGENTS.md` and `README.md` first.
 * Then follow the repository-declared logic entry chain, including `00_START_HERE.md`,
 * `modules/01_MasterLogic.md`, and `modules/15_LogicEntryChecklist.md` when applicable.
 *
 * Before every new coding round, explicitly decide whether the current task extends
 * the previous coding round.
 * If it does not, explicitly ask whether to forget/compress context before continuing.
 *
 * Treat this flow as a blocking gate, not as guidance, documentation, or a reminder.
 * Do not infer continuation by yourself.
 * Do not skip the context-reset question for efficiency.
 *
 * Do not continue deeper reading, modify files, delete files, perform write actions,
 * or begin implementation before the logic-entry loop above has been completed.
 */
```

### 10.2 Python

```py
# MANDATORY LOGIC GATE
#
# Before making changes here, read `AGENTS.md` and `README.md` first.
# Then follow the repository-declared logic entry chain, including `00_START_HERE.md`,
# `modules/01_MasterLogic.md`, and `modules/15_LogicEntryChecklist.md` when applicable.
#
# Before every new coding round, explicitly decide whether the current task extends
# the previous coding round.
# If it does not, explicitly ask whether to forget/compress context before continuing.
#
# Treat this flow as a blocking gate, not as guidance, documentation, or a reminder.
# Do not infer continuation by yourself.
# Do not skip the context-reset question for efficiency.
#
# Do not continue deeper reading, modify files, delete files, perform write actions,
# or begin implementation before the logic-entry loop above has been completed.
```

### 10.3 Markdown

```md
<!--
MANDATORY LOGIC GATE

Before making changes here, read `AGENTS.md` and `README.md` first.
Then follow the repository-declared logic entry chain, including `00_START_HERE.md`,
`modules/01_MasterLogic.md`, and `modules/15_LogicEntryChecklist.md` when applicable.

Before every new coding round, explicitly decide whether the current task extends
the previous coding round.
If it does not, explicitly ask whether to forget/compress context before continuing.

Treat this flow as a blocking gate, not as guidance, documentation, or a reminder.
Do not infer continuation by yourself.
Do not skip the context-reset question for efficiency.

Do not continue deeper reading, modify files, delete files, perform write actions,
or begin implementation before the logic-entry loop above has been completed.
-->
```

### 10.4 PowerShell / Shell

```powershell
# MANDATORY LOGIC GATE
#
# Before making changes here, read `AGENTS.md` and `README.md` first.
# Then follow the repository-declared logic entry chain, including `00_START_HERE.md`,
# `modules/01_MasterLogic.md`, and `modules/15_LogicEntryChecklist.md` when applicable.
#
# Before every new coding round, explicitly decide whether the current task extends
# the previous coding round.
# If it does not, explicitly ask whether to forget/compress context before continuing.
#
# Treat this flow as a blocking gate, not as guidance, documentation, or a reminder.
# Do not infer continuation by yourself.
# Do not skip the context-reset question for efficiency.
#
# Do not continue deeper reading, modify files, delete files, perform write actions,
# or begin implementation before the logic-entry loop above has been completed.
```

---

## 11. Enforcement Intent

This template should be backed by repository-level enforcement when possible.

Recommended repository-level check responsibilities include:

- verify that real entry / starting source files still contain the mandatory gate
- verify that the header remains in English
- verify that `AGENTS.md` and `README.md` are still referenced
- verify that the repository entry docs still point to the current logic-entry chain
- verify that machine-specific absolute paths are not used in the gate

A typical enforcement command may look like:

```bash
node scripts/check-logic-entry.js
```

The script is not a replacement for reading the logic package.
Its job is to prevent silent drift.

---

## 12. Validation Targets

When implementing repository-level checks for this template, the repository should prefer validating the presence of stable anchor phrases such as:

- `MANDATORY LOGIC GATE`
- ``read `AGENTS.md` and `README.md` first``
- `forget/compress context`
- `blocking gate`
- `Do not infer continuation by yourself`

The exact string policy may vary by repository, but the enforcement should remain strict enough to detect deletion, weakening, or accidental rewriting of the gate.

---

## 13. Why This Template Is Mandatory

This template is mandatory because it solves a real execution problem.

Repeated observation shows that AI agents often begin from entry files, control files, route files, renderer roots, and other high-frequency starting source files.
That makes those files the highest-leverage places to stop incorrect execution paths before they become file edits, deletions, or stale-context implementation.

Therefore this template must be treated as:

- a tested execution-control mechanism
- a mandatory repository safeguard
- a structural reduction of agent error rate

It must not be downgraded into a soft recommendation.

---

## 14. Relationship To Other Logic Files

This template does not replace:

- `00_START_HERE.md`
- `versions/AgentLogic_V6.md`
- `modules/01_MasterLogic.md`
- `modules/12_AgentEnforcement.md`
- `modules/15_LogicEntryChecklist.md`

Instead, it forces the agent back into them at the exact moment where implementation would otherwise start too early.

Its role is not to carry the whole logic package.
Its role is to stop premature action.

---

## 15. Recommended Repository Adoption Rule

Repositories using AgentLogic should treat the following as the default adoption stack:

1. repository entry docs declare the logic-entry chain
2. all real entry / starting source files carry the Mandatory Logic Gate header
3. repository enforcement script checks the gate mechanically
4. updates to the gate are synchronized with the main logic when promoted

This stack should be treated as the default engineering baseline, not a special-case hardening step.

## END FILE: modules/13_MandatoryLogicGateTemplate.md

---

## BEGIN FILE: modules/15_LogicEntryChecklist.md

# Logic Entry Checklist

鏈枃浠舵槸閫昏緫鍏ュ彛妫€鏌ユ竻鍗曟爣鍑嗘ā鏉裤€?

鐢ㄩ€旓細

- 鍦ㄦ寮忓紑濮嬮」鐩箣鍓嶏紝鐢ㄥ畠鏍稿鈥滈€昏緫鍏ュ彛鏄惁宸茬粡纭鈥濄€?
- 瀹冪敤浜庨槻姝?Agent 鐩存帴寮€宸ヨ€屾病鏈夌‘璁ら€昏緫鏂囦欢銆侀€昏緫鍖呬綅缃垨鐩綍杈圭晫銆?

浣跨敤瑙勫垯锛?

- 搴斿湪椤圭洰姝ｅ紡鎺ュ叆鍓嶅畬鎴愩€?
- 鑻ヤ换涓€鍏抽敭椤规湭閫氳繃锛屼笉搴旇繘鍏ュ疄鐜扮姸鎬併€?
- 杩欎唤娓呭崟浣跨敤鐗堟湰鏃犲叧琛ㄨ揪锛屼笉渚濊禆鍥哄畾鐗堟湰鍚嶃€?

---

## 1. 涓绘枃妗ｅ畾浣?

- [ ] 宸插畾浣嶉」鐩富 README / 涓?md
- [ ] 宸茬‘璁ら」鐩枃妗ｄ富鍏ュ彛
- [ ] 宸茬‘璁ゅ綋鍓嶆枃妗ｅ叆鍙ｄ笉鏄繃鏈熸垨鏃佹敮鏂囨。

## 2. 閫昏緫鍏ュ彛瀹氫綅

- [ ] 宸叉鏌ュ綋鍓嶉」鐩洰褰曚笅鏄惁瀛樺湪 Agent 閫昏緫鏂囦欢
- [ ] 鑻ラ」鐩洰褰曞唴涓嶅瓨鍦ㄩ€昏緫鏂囦欢锛屽凡璇㈤棶閫昏緫鏂囦欢鍦ㄥ摢閲?
- [ ] 宸茬‘璁ゅ綋鍓嶉」鐩簲鎺ュ叆鍝竴浠介€昏緫鍏ュ彛
- [ ] 娌℃湁鍥犱负鏃х増鏈悕涔犳儻鑰岀洿鎺ュ亣璁鹃€昏緫鏂囦欢鍚?

## 3. 閫昏緫鍏ュ彛褰掑睘鍒ゆ柇

- [ ] 宸茬‘璁ら€昏緫鍏ュ彛灞炰簬浠撳簱鍐呮枃浠惰繕鏄閮ㄩ€昏緫鍖?
- [ ] 鑻ュ睘浜庡閮ㄩ€昏緫鍖咃紝宸茬‘璁ゆ寕鎺ヤ綅缃?
- [ ] 鑻ュ睘浜庝粨搴撳唴鏂囦欢锛屽凡纭鍏蜂綋璺緞

## 4. 鐩綍涓庢墽琛岃竟鐣?

- [ ] 宸插畬鎴愮洰褰曞璁?
- [ ] 宸茬‘璁ゅ綋鍓嶇洰褰曚笉鏄€昏緫鍖呭伐浣滅洰褰?
- [ ] 鑻ヤ换鍔￠渶瑕佸垱寤轰笟鍔℃枃浠讹紝宸插垏鎹㈠埌鐙珛椤圭洰鐩綍

## 5. 涓婁笅鏂囧欢鐢充笌閲嶇疆鍒ゆ柇

- [ ] 宸插垽鏂綋鍓嶆柊浠诲姟鏄惁灞炰簬涓婁竴杞?coding 鐨勫欢鐢?
- [ ] 鑻ヤ笉灞炰簬涓婁竴杞欢鐢筹紝宸插厛璇㈤棶鏄惁闇€瑕?`forget/compress context`
- [ ] 鑻ラ渶瑕佹敹缂╀笂涓嬫枃锛屽凡鍏堝洖鍐欑粨鏋勫寲鐘舵€侊紝鍐嶅噺灏戝伐浣滀笂涓嬫枃

## 6. 寮€濮嬮」鐩墠鐨勬渶缁堢粨璁?

- [ ] 宸插畬鎴愪富閫昏緫鎺ュ叆
- [ ] 宸插畬鎴愰€昏緫鍏ュ彛纭
- [ ] 宸插畬鎴愪笂涓嬫枃寤剁敵鍒ゆ柇涓庡繀瑕佺殑涓婁笅鏂囬噸缃彁闂?
- [ ] 宸插缓绔嬮」鐩簨瀹炲湴鍥?
- [ ] 鑻ラ」鐩凡鎻愪緵浠撳簱绾ч€昏緫鍏ュ彛鏍￠獙鑴氭湰锛屽凡瀹為檯杩愯锛堜緥濡傦細`node scripts/check-logic-entry.js`锛?
- [ ] 褰撳墠鍙互杩涘叆姝ｅ紡瑙勫垝 / 瀹炵幇 / 楠岃瘉闃舵

## 7. 鏈€氳繃鏃剁殑榛樿鍔ㄤ綔

- 鑻ョ 1-5 鑺備换涓€椤规湭閫氳繃锛岄粯璁ゅ姩浣滃簲涓猴細
  - 鍋滄杩涘叆瀹炵幇
  - 鍏堣ˉ閫昏緫鍏ュ彛纭
  - 鍏堣ˉ涓婁笅鏂囧欢鐢冲垽鏂垨涓婁笅鏂囬噸缃彁闂?
  - 鍏堣ˉ鐩綍瀹¤
  - 鍏堣ˉ椤圭洰浜嬪疄鍦板浘


## 8. Continuous Execution Authorization Checks

- [ ] If the user explicitly gave a continuous-execution instruction such as "unless I say stop, keep going", that instruction has been recorded as an active authorization for the current task scope
- [ ] Subsequent planned implementation steps are being treated as part of the same continuous execution round rather than as repeated re-confirmation points
- [ ] The current work is still being treated as implementation / build-out phase by default, not as formal product-test stage, unless the user explicitly said testing has begun

## END FILE: modules/15_LogicEntryChecklist.md

