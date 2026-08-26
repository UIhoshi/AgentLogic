# AgentLogic V6.8.7 Master Logic

鏈枃浠舵槸 AgentLogic 浠撳簱鐨勯」鐩骇涓婚€昏緫鎽樿銆傚畠鎻忚堪鏈粨搴撲腑鐨勮鍒欍€侀獙璇併€佸畨瑁呭拰
鎵撳寘璧勪骇锛屼笉鎻忚堪浠讳綍澶栭儴涓氬姟椤圭洰鎴栨煇涓叿浣?Agentic CLI 浜у搧鐨勬簮鐮佷簨瀹炪€?

## 1. 褰撳墠浠撳簱瀹氫綅

- 鏈粨搴撴槸鍙畨瑁呭埌鏈湴 AI coding host 鐨勪富閫昏緫鍩虹璁炬柦锛坢ethod layer锛夈€?
- 浜嬪疄鏉ユ簮鏄粨搴撳唴鐨勫叆鍙ｆ枃妗ｃ€佺増鏈簮鏂囦欢銆佹ā鍧椼€佽剼鏈€乵anifest 鍜岀敓鎴愯緭鍑恒€?
- 澶栭儴椤圭洰銆佹瘮杈冧粨搴撳拰 `reference/` 鍘熷灞傚彧鑳戒綔涓哄弬鑰冭瘉鎹紝涓嶈兘鑷姩鍗囩骇涓哄綋鍓嶄粨搴撲簨瀹炪€?
- 褰撳墠绋冲畾缁戝畾鍏ュ彛鏄?`MAIN.md`锛涘綋鍓嶇増鏈簮鏂囦欢鐢?`manifest.json` 鐨?`main_logic_file` 鎸囧畾銆?

## 2. 褰撳墠浠撳簱鐨勫洓灞傛槧灏?

### L1锛氬叆鍙ｄ笌瀹夸富琛ㄩ潰 (Entry & Host Surface)

- 浜虹被鍏ュ彛锛歚00_START_HERE.md`
- Agent 鍏ュ彛锛歚AGENTS.md`
- 绋冲畾瀹夸富鍏ュ彛锛歚MAIN.md`
- 浠撳簱璇存槑锛歚README.md`
- 瀹夎璇存槑锛歚AGENT_INSTALL.md`銆乣INSTALL.md`
- 瀹夸富閫傞厤鍣細`adapters/`

### L2锛氫細璇濊鍒欎笌寮€鍙戠敓鍛藉懆鏈?(Session & Development Lifecycle)

- 绋冲畾鐗堟湰婧愶細`versions/AgentLogic_V6_8_7.md`
- 涓婚€昏緫鎽樿锛歚modules/01_MasterLogic.md`
- Agent 寮哄埗瑙勫垯锛歚modules/12_AgentEnforcement.md`
- 鍏ュ彛娓呭崟锛歚modules/15_LogicEntryChecklist.md`
- Agentic loop 鍚堝悓锛歚modules/03_AgenticLoop.md`
- SDD 鐢熷懡鍛ㄦ湡锛歚modules/38_V6_6_SpecDrivenDevelopment.md`
- Graphify 浠ｇ爜鍦板浘涓庨瑙堥棬锛歚modules/45_V6_8_GraphifyCodeMapIntegration.md`
- 鍙傝€冨埌鐣岄潰宸ヤ綔娴侊細`modules/47_V6_8_ReferenceToInterfaceWorkflow.md`
- 鎶€鑳戒笌宸ュ叿璺敱锛歚modules/48_V6_8_SkillAndToolRouting.md`
- 澶栭儴鐮旂┒涓庝氦浠樼墿鏁村悎锛歚modules/50_V6_8_ExternalResearchAndArtifactIntegration.md`
- 宸ュ叿鍙緵鎬т紭鍏堣矾鐢憋細`modules/51_V6_8_AffordanceFirstToolUse.md`
- 浜や簰寮?3D 缃戦〉妯″瀷绛栫暐锛歚modules/52_V6_8_Img2ThreeJs3DWebIntegration.md`
- 缂栫▼绾ф妧鑳藉己鍒讹細`modules/53_V6_8_ProgrammingLevelSkillEnforcement.md`銆乣contracts/skill-registry.json`銆乣contracts/skill-enforcement.json`
- 浠诲姟瑙勬牸涓庣姸鎬侊細`.specify/`

### L3锛氬畨鍏ㄣ€佹潈闄愪笌楠岃瘉鎺у埗 (Safety & Verification Control)

- 浠诲姟閫傜敤鎬у叆鍙ｏ細`AGENTS.md`
- 鏉冮檺涓庡畨鍏細`modules/05_PermissionsAndSafety.md`銆乣modules/23_V6_5_PermissionAndOutputPipeline.md`
- 楠岃瘉鐭╅樀锛歚modules/29_MandatoryVerificationMatrix.md`
- 宸ュ叿杈圭晫锛歚modules/30_ToolQuestionBoundaryMatrix.md`
- 鍙嶆ā寮忕籂鍋忥細`modules/31_ToolMisuseAndAntiPatternMatrix.md`
- 鎶€鑳戒笌宸ュ叿璺敱锛歚modules/48_V6_8_SkillAndToolRouting.md`
- 瑙勫垯鍏ュ彛鏍￠獙锛歚scripts/check-logic-entry.js`
- 鍖呮牎楠岋細`scripts/validate-package.ps1`
- 缁存姢鑰呮牎楠岋細`scripts/maintainer-check.ps1`
- 鐜璇婃柇锛歚scripts/doctor.ps1`

### L4锛氳鍒欒祫浜с€佹妧鑳戒笌鐢熸垚杈撳嚭 (Assets & Generated Outputs)

- 鍙Щ妞嶆妧鑳斤細`skills/`
- SDD 宸ュ叿灞傦細`spec-kit/`
- 鍘熷鍙傝€冨眰锛歚reference/`
- 瀹夸富 bundle锛歚dist/`
- bundle 鐢熸垚鍣細`scripts/build-profile.ps1`
- 鐗堟湰涓?profile 娓呭崟锛歚manifest.json`銆乣manifest.schema.json`

## 3. 缁熶竴鍏ュ彛椤哄簭

姝ｅ紡缂栫爜杞蹇呴』鎸変互涓嬮『搴忔墽琛岋細

1. 璇诲彇 `AGENTS.md` 鍜?`README.md`銆?
2. 璇诲彇 `00_START_HERE.md`锛岀‘璁ゅ綋鍓嶇ǔ瀹氬叆鍙ｅ拰閫傜敤杈圭晫銆?
3. 鍒ゆ柇浠诲姟鏄彧璇诲璁°€佹枃妗ｅ彉鏇淬€佸绔嬩慨澶嶃€佸姛鑳?閲嶆瀯銆乁I銆佸畨瑁?鍙戝竷涓殑鍝竴绫汇€?
4. 鍒ゆ柇鏄惁寤剁画涓婁竴杞?coding锛涜嫢涓嶆槸锛屽繀椤昏闂槸鍚?`forget/compress context`锛屼笉寰椾娇鐢?
   Token 闃堝€奸潤榛樿烦杩囥€?
5. 鎸?`00_START_HERE.md` 澹版槑鐨?full-read chain 瀹屾暣璇诲彇鐗堟湰婧愩€佷富閫昏緫鍜屽叆鍙ｆ竻鍗曘€?
6. 寤虹珛鏈€灏忎簨瀹炲湴鍥撅紝鍐嶆墽琛屽尮閰嶇殑 SDD銆佹潈闄愩€侀獙璇佹垨鍙戝竷闂ㄦ銆?

鍙闂涓嶉渶瑕佷吉閫犲疄鐜拌鍒掞紱浣嗕换浣曞啓鍏ャ€佸畨瑁呫€佹墦鍖呮垨瑙勫垯鍚屾閮藉繀椤诲厛瀹屾垚閫傜敤鐨勯棬妲涖€?

## 4. 鑳藉姏鐘舵€佸繀椤诲垎灞傝〃杈?

浠讳綍鑳藉姏缁撹閮藉繀椤诲尯鍒嗭細

- 瑙勫垯鏄惁澹版槑
- 鏂囦欢鎴?profile 鏄惁娉ㄥ唽
- 杩愯鏃舵槸鍚﹀彲鐢?
- 鏉冮檺鏄惁鍏佽鎵ц
- 鏄惁缁忚繃鍖归厤鐨勯獙璇佸伐鍏风‘璁?

鎼滅储缁撴灉銆侀潤鎬佽鍙栥€佹瀯寤烘垚鍔熸垨鍘嗗彶璁板繂閮戒笉鑳藉崟鐙瘉鏄庤繍琛屾椂銆佽瑙夋垨杩滅▼浜嬪疄銆?

## 5. UI 瀹炴柦鍓嶇疆闂ㄦ

浠讳綍姝ｅ紡 UI 瀹炴柦锛堥〉闈€佸睆骞曘€佺粍浠躲€佸竷灞€銆佽瑙夎璁℃垨 UI 鏍峰紡鍙樻洿锛変箣鍓嶏紝蹇呴』锛?

1. 浣跨敤鏂囩敓鍥惧伐鍏风敓鎴愬嵆灏嗗疄鏂界殑 UI 棰勮鍥俱€?
2. 灏嗛瑙堝浘灞曠ず缁欑敤鎴锋煡鐪嬶紙鑻ヨ亰澶╃晫闈㈡垨瀹㈡埛绔幆澧冧笉鏀寔鐩存帴娓叉煋鏄剧ず锛屽簲灏嗗浘鐗囩敓鎴愬悗淇濆瓨鍒伴」鐩枃浠跺す濡?`.specify/mockups/` 涓嬶紝鏄庣‘鎻愮ず缁濆鏂囦欢璺緞浠ヤ緵鐢ㄦ埛鑷鏌ョ湅锛夈€?
3. 绛夊緟鐢ㄦ埛纭锛涚敤鎴峰彲浠ユ壒鍑嗛瑙堬紝涔熷彲浠ユ槑纭涓嶉渶瑕佽姝ラ銆?
4. 鍙湁鎵瑰噯鎴栨槑纭?opt-out 鍚庯紝鎵嶅厑璁稿紑濮?UI 浠ｇ爜瀹炴柦銆?

鐢ㄦ埛娌℃湁鏄庣‘ opt-out 鏃讹紝涓嶅緱鎶娾€滃唴瀹规敼鍔ㄣ€佸搷搴斿紡淇銆佹棤闅滅淇鎴栧皬鏀瑰姩鈥濆綋浣滈粯璁よ眮鍏嶃€?
UI 瀹炴柦瀹屾垚鍚庝粛蹇呴』鎵ц鎴浘銆佺埗瀛愬竷灞€杈圭晫銆佹孩鍑恒€佹崲琛屽拰瀹為檯瀹瑰櫒瀹藉害楠岃瘉銆?

## 6. 椤圭洰鐭ヨ瘑涓庤鍒欏悓姝?

- 涓氬姟椤圭洰鐨勫悓姝ヤ簨瀹炴槸椤圭洰鑷韩 Git 璺熻釜鐨?`AGENTS.md`銆乣PROJECT_MAP.md`銆乣CODE_MAP.md` 鍜?
  `.learnings/ERRORS.md`锛岃€屼笉鏄缃棩蹇椾粨搴撱€?
- 鎺ユ墜椤圭洰鏃跺厛 `git fetch --prune`锛堝彲鐢ㄦ椂锛夊苟妫€鏌ュ垎鏀€佸伐浣滄爲鍜屽樊寮傦紝鍐嶈鍙栬繖涓変唤鏂囦欢锛?
  浠讳綍 pull/checkout/merge 浠嶉渶浣滀负鍗曠嫭鐨勭姸鎬佸彉鏇寸‘璁ゃ€?
- 缁撴瀯鍙樺寲蹇呴』鍚屾彁浜ゆ洿鏂?`PROJECT_MAP.md`锛涘叧閿嚱鏁?鐘舵€?鎺ュ彛瀵艰埅鍙樺寲蹇呴』鍚屾彁浜ゆ洿鏂?`CODE_MAP.md`锛涢噸瑕侀敊璇籂姝ｅ繀椤诲悓鎻愪氦鏇存柊
  `.learnings/ERRORS.md`锛沗.specify/` 鍜?`docs/adr/` 浠呭湪鐩稿簲闂ㄦ瑙﹀彂鏃朵娇鐢ㄣ€?
- `modification_history` 鍙繚鐣欎负璺ㄩ」鐩粡楠屽拰鍘嗗彶褰掓。锛屼絾涓嶉樆鏂櫘閫氫笟鍔￠」鐩殑缂栫爜鎴栧彂甯冦€?
- 涓嶅緱鎶婂瘑閽ャ€佷釜浜鸿矾寰勩€佺鏈夋彁绀鸿瘝銆佸師濮嬫棩蹇楁垨榛樿 Graphify 杈撳嚭鍐欏叆宸茶窡韪煡璇嗘枃浠舵垨 bundle銆?

## 7. 鐩綍杈圭晫涓庢墦鍖呰鍒?

- `AgentLogic` 鐩綍鍙兘淇濆瓨閫昏緫銆佹ā鍧椼€佹妧鑳姐€佽剼鏈€佽鏍煎拰鐢熸垚 bundle銆?
- 涓嶅緱鍦ㄦ湰浠撳簱鍒涘缓鏃犲叧涓氬姟婧愮爜銆佷緷璧栧畨瑁呯粨鏋溿€佷复鏃舵祴璇曟垨涓氬姟鏃ュ織銆?
- `dist/` 鍙兘鐢?`scripts/build-profile.ps1` 鐢熸垚锛岀姝㈡墜宸ョ紪杈戙€?
- `manifest.json` 鏄?profile銆佸涓昏緭鍑哄拰閫傞厤鍣ㄧ殑鏈哄櫒鍙浜嬪疄婧愩€?
- `reference/` 鍜屽巻鍙茬増鏈枃浠朵笉搴旈粯璁ゆ敞鍏ヤ负褰撳墠杩愯瑙勫垯锛岄櫎闈?profile 鏄庣‘鍒楀嚭銆?

## 8. 鍙樻洿鍚庣殑鏈€灏忛獙璇?

- 鏂囨。鎴栬鍒欏彉鏇达細杩愯 `node scripts/check-logic-entry.js` 鍜岄摼鎺ユ鏌ャ€?
- manifest銆乸rofile銆乥undle 鎴栧畨瑁呭彉鏇达細杩愯 `scripts/validate-package.ps1`銆?
- 鐗堟湰銆佸涓绘垨鍙戝竷鍙樻洿锛氳繍琛?`scripts/maintainer-check.ps1`锛屽苟妫€鏌ョ敓鎴愯緭鍑哄拰 git diff銆?
- 鐜涓庡涓诲垽鏂細杩愯 `scripts/doctor.ps1`銆?
- 浠讳綍楂橀闄╂垨澶栭儴鐘舵€佸彉鏇撮兘蹇呴』鍋氱洰鏍囩‘璁ゅ拰缁撴灉纭銆?

## 9. 鎸佺画鎵ц杈圭晫

鐢ㄦ埛鏄庣‘瑕佹眰鎸佺画鎵ц鏃讹紝褰撳墠璁″垝鍐呯殑闃呰銆佷慨鏀广€侀獙璇佸拰淇瑙嗕负鍚屼竴鎵ц杞銆?
鍙湁鐢ㄦ埛瑕佹眰鍋滄銆佽鍒掑畬鎴愰渶瑕佹柊鐨勬垬鐣ユ柟鍚戙€佸嚭鐜版棤娉曚粠鏈湴浜嬪疄瑙ｅ喅鐨勯樆濉烇紝鎴栧嵆灏嗚繘琛?
楂橀闄╀笉鍙€嗘搷浣滄椂锛屾墠鏆傚仠璇锋眰杈撳叆銆?

## 10. 寮哄埗鏂囨湰浠ｇ爜鍦板浘涓庡彲閫夊浘璋遍瑙?

- 姣忎釜瀹屾暣宸ヤ綔娴佷笟鍔￠」鐩繀椤荤淮鎶ゆ牴鐩綍 `CODE_MAP.md`锛岀敤浜庡叆鍙ｃ€佹ā鍧椼€佸叧閿鍙枫€佺姸鎬佸拰鎺ュ彛鐨勬枃鏈鑸紱瀹冧笉鏄繍琛屾椂璇佹槑锛屽繀椤讳互褰撳墠婧愮爜澶嶆牳銆?
- `modules/45_V6_8_GraphifyCodeMapIntegration.md` 鎻愪緵鎸夐渶鍙鍖栦唬鐮佸湴鍥剧瓥鐣ワ紝涓嶆槸榛樿瀹夎鐨勫閮ㄤ緷璧栥€?
- `modules/50_V6_8_ExternalResearchAndArtifactIntegration.md` 瀹氫箟 OfficeCLI銆丳ixelRAG 鍜?
  Firecrawl 鐨勬潵婧愭斂绛栵紱Office 鏂囦欢澶勭悊蹇呴』璧扮粡淇′换鐨?OfficeCLI 璺嚎锛屽叾浠栨潵婧愪粛涓嶅緱浠庤鏀跨瓥鎺ㄦ柇
  宸插畨瑁呫€佸彲淇℃垨鍙皟鐢ㄣ€?
- `modules/51_V6_8_AffordanceFirstToolUse.md` 瑕佹眰浠庝换鍔℃剰鍥惧拰鎵€闇€璇佹嵁鑷劧閫夋嫨宸ュ叿锛?
  榛樿 profile 浠ユ墽琛屼负涓績锛屽畬鏁存不鐞嗗唴瀹瑰湪 `governance-reference` profile 涓寜闇€鍔犺浇銆?
- `modules/52_V6_8_Img2ThreeJs3DWebIntegration.md` 瀹氫箟鍙€夌殑浜や簰寮?3D 缃戦〉妯″瀷璺嚎锛?
  闈欐€?3D 鎰熻瑙夎蛋 UI 璺緞锛岄€氱敤 3D 浜や簰璧板師鐢?Three.js 璺緞锛屽彧鏈夌粡鎵瑰噯鐨勫弬鑰冨浘妯″瀷閲嶅缓
  鎵嶈兘鍊欓€?`img2threejs`锛屼笖涓嶅緱鎺ㄦ柇宸插畨瑁呫€佸彲淇℃垨鍙墽琛屻€?
- 澶氭ā鍧楀姛鑳姐€侀噸澶ч噸鏋勩€佹灦鏋勬垨鍙戝竷宸ヤ綔鍦?Converge/Ship 鏃跺簲璇㈤棶鐢ㄦ埛鏄惁闇€瑕佷唬鐮佽鍥鹃瑙堛€?
- 鐢ㄦ埛鏄庣‘鍚屾剰鍚庯紝鎵嶅彲鍦ㄧ洰鏍囦笟鍔￠」鐩腑鐢熸垚 `graphify-out/`锛涗笉寰楅粯璁ゅ湪 AgentLogic 浠撳簱鍐呯敓鎴愶紝涔熶笉寰楁妸澶栭儴鍥捐氨缁撴灉褰撲綔杩愯鏃朵簨瀹炶瘉鏄庛€?
- `modules/53_V6_8_ProgrammingLevelSkillEnforcement.md` 瑕佹眰姣忎釜鍙惡甯?`SKILL.md` 鍦ㄦ満鍣ㄥ彲璇绘敞鍐岃〃涓湁鐢熷懡鍛ㄦ湡鐘舵€侊紱鍖归厤璺敱蹇呴』缁忚繃鍙墽琛岀殑 preflight銆乮nvocation 涓?closure 璁板綍銆傝宸ヤ綔娴侀棬涓嶇瓑鍚屼簬鏈獙璇佺殑瀹夸富鍘熺敓宸ュ叿鎷︽埅銆?

## 11. 椤圭洰鍐?L1-L4 鍦板浘

- 姣忎釜涓氬姟椤圭洰浣跨敤鏍圭洰褰?`PROJECT_MAP.md` 淇濆瓨鍏剁湡瀹?L1-L4 鏄犲皠锛屼笉澶嶅埗鏈€昏緫鍖呫€?
- 姣忎釜涓氬姟椤圭洰浣跨敤鏍圭洰褰?`CODE_MAP.md` 淇濆瓨鍙氦鎺ョ殑绗﹀彿绾у鑸湴鍥俱€?
- 姝ゅ湴鍥惧拰 `.learnings/ERRORS.md` 蹇呴』涓庨」鐩唬鐮佷竴璧锋彁浜ゅ苟璺ㄨ澶囧悓姝ャ€?
- 鍏蜂綋妯℃澘銆佽劚鏁忚竟鐣屽拰瀹夊叏鍚屾姝ラ鐢?`modules/46_V6_8_ProjectKnowledgeSync.md` 瀹氫箟銆?
