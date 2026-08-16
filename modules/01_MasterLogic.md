# AgentLogic V6.8.5 Master Logic

本文件是 AgentLogic 仓库的项目级主逻辑摘要。它描述本仓库中的规则、验证、安装和
打包资产，不描述任何外部业务项目或某个具体 Agentic CLI 产品的源码事实。

## 1. 当前仓库定位

- 本仓库是可安装到本地 AI coding host 的主逻辑基础设施（method layer）。
- 事实来源是仓库内的入口文档、版本源文件、模块、脚本、manifest 和生成输出。
- 外部项目、比较仓库和 `reference/` 原始层只能作为参考证据，不能自动升级为当前仓库事实。
- 当前稳定绑定入口是 `MAIN.md`；当前版本源文件由 `manifest.json` 的 `main_logic_file` 指定。

## 2. 当前仓库的四层映射

### L1：入口与宿主表面 (Entry & Host Surface)

- 人类入口：`00_START_HERE.md`
- Agent 入口：`AGENTS.md`
- 稳定宿主入口：`MAIN.md`
- 仓库说明：`README.md`
- 安装说明：`AGENT_INSTALL.md`、`INSTALL.md`
- 宿主适配器：`adapters/`

### L2：会话规则与开发生命周期 (Session & Development Lifecycle)

- 稳定版本源：`versions/AgentLogic_V6_8_5.md`
- 主逻辑摘要：`modules/01_MasterLogic.md`
- Agent 强制规则：`modules/12_AgentEnforcement.md`
- 入口清单：`modules/15_LogicEntryChecklist.md`
- Agentic loop 合同：`modules/03_AgenticLoop.md`
- SDD 生命周期：`modules/38_V6_6_SpecDrivenDevelopment.md`
- Graphify 代码地图与预览门：`modules/45_V6_8_GraphifyCodeMapIntegration.md`
- 参考到界面工作流：`modules/47_V6_8_ReferenceToInterfaceWorkflow.md`
- 技能与工具路由：`modules/48_V6_8_SkillAndToolRouting.md`
- 外部研究与交付物整合：`modules/50_V6_8_ExternalResearchAndArtifactIntegration.md`
- 工具可供性优先路由：`modules/51_V6_8_AffordanceFirstToolUse.md`
- 交互式 3D 网页模型策略：`modules/52_V6_8_Img2ThreeJs3DWebIntegration.md`
- 任务规格与状态：`.specify/`

### L3：安全、权限与验证控制 (Safety & Verification Control)

- 任务适用性入口：`AGENTS.md`
- 权限与安全：`modules/05_PermissionsAndSafety.md`、`modules/23_V6_5_PermissionAndOutputPipeline.md`
- 验证矩阵：`modules/29_MandatoryVerificationMatrix.md`
- 工具边界：`modules/30_ToolQuestionBoundaryMatrix.md`
- 反模式纠偏：`modules/31_ToolMisuseAndAntiPatternMatrix.md`
- 技能与工具路由：`modules/48_V6_8_SkillAndToolRouting.md`
- 规则入口校验：`scripts/check-logic-entry.js`
- 包校验：`scripts/validate-package.ps1`
- 维护者校验：`scripts/maintainer-check.ps1`
- 环境诊断：`scripts/doctor.ps1`

### L4：规则资产、技能与生成输出 (Assets & Generated Outputs)

- 可移植技能：`skills/`
- SDD 工具层：`spec-kit/`
- 原始参考层：`reference/`
- 宿主 bundle：`dist/`
- bundle 生成器：`scripts/build-profile.ps1`
- 版本与 profile 清单：`manifest.json`、`manifest.schema.json`

## 3. 统一入口顺序

正式编码轮次必须按以下顺序执行：

1. 读取 `AGENTS.md` 和 `README.md`。
2. 读取 `00_START_HERE.md`，确认当前稳定入口和适用边界。
3. 判断任务是只读审计、文档变更、孤立修复、功能/重构、UI、安装/发布中的哪一类。
4. 判断是否延续上一轮 coding；若不是，必须询问是否 `forget/compress context`，不得使用
   Token 阈值静默跳过。
5. 按 `00_START_HERE.md` 声明的 full-read chain 完整读取版本源、主逻辑和入口清单。
6. 建立最小事实地图，再执行匹配的 SDD、权限、验证或发布门槛。

只读问题不需要伪造实现计划；但任何写入、安装、打包或规则同步都必须先完成适用的门槛。

## 4. 能力状态必须分层表达

任何能力结论都必须区分：

- 规则是否声明
- 文件或 profile 是否注册
- 运行时是否可用
- 权限是否允许执行
- 是否经过匹配的验证工具确认

搜索结果、静态读取、构建成功或历史记忆都不能单独证明运行时、视觉或远程事实。

## 5. UI 实施前置门槛

任何正式 UI 实施（页面、屏幕、组件、布局、视觉设计或 UI 样式变更）之前，必须：

1. 使用文生图工具生成即将实施的 UI 预览图。
2. 将预览图展示给用户查看（若聊天界面或客户端环境不支持直接渲染显示，应将图片生成后保存到项目文件夹如 `.specify/mockups/` 下，明确提示绝对文件路径以供用户自行查看）。
3. 等待用户确认；用户可以批准预览，也可以明确说不需要该步骤。
4. 只有批准或明确 opt-out 后，才允许开始 UI 代码实施。

用户没有明确 opt-out 时，不得把“内容改动、响应式修复、无障碍修复或小改动”当作默认豁免。
UI 实施完成后仍必须执行截图、父子布局边界、溢出、换行和实际容器宽度验证。

## 6. 项目知识与规则同步

- 业务项目的同步事实是项目自身 Git 跟踪的 `AGENTS.md`、`PROJECT_MAP.md`、`CODE_MAP.md` 和
  `.learnings/ERRORS.md`，而不是外置日志仓库。
- 接手项目时先 `git fetch --prune`（可用时）并检查分支、工作树和差异，再读取这三份文件；
  任何 pull/checkout/merge 仍需作为单独的状态变更确认。
- 结构变化必须同提交更新 `PROJECT_MAP.md`；关键函数/状态/接口导航变化必须同提交更新 `CODE_MAP.md`；重要错误纠正必须同提交更新
  `.learnings/ERRORS.md`；`.specify/` 和 `docs/adr/` 仅在相应门槛触发时使用。
- `modification_history` 可保留为跨项目经验和历史归档，但不阻断普通业务项目的编码或发布。
- 不得把密钥、个人路径、私有提示词、原始日志或默认 Graphify 输出写入已跟踪知识文件或 bundle。

## 7. 目录边界与打包规则

- `AgentLogic` 目录只能保存逻辑、模块、技能、脚本、规格和生成 bundle。
- 不得在本仓库创建无关业务源码、依赖安装结果、临时测试或业务日志。
- `dist/` 只能由 `scripts/build-profile.ps1` 生成，禁止手工编辑。
- `manifest.json` 是 profile、宿主输出和适配器的机器可读事实源。
- `reference/` 和历史版本文件不应默认注入为当前运行规则，除非 profile 明确列出。

## 8. 变更后的最小验证

- 文档或规则变更：运行 `node scripts/check-logic-entry.js` 和链接检查。
- manifest、profile、bundle 或安装变更：运行 `scripts/validate-package.ps1`。
- 版本、宿主或发布变更：运行 `scripts/maintainer-check.ps1`，并检查生成输出和 git diff。
- 环境与宿主判断：运行 `scripts/doctor.ps1`。
- 任何高风险或外部状态变更都必须做目标确认和结果确认。

## 9. 持续执行边界

用户明确要求持续执行时，当前计划内的阅读、修改、验证和修复视为同一执行轮次。
只有用户要求停止、计划完成需要新的战略方向、出现无法从本地事实解决的阻塞，或即将进行
高风险不可逆操作时，才暂停请求输入。

## 10. 强制文本代码地图与可选图谱预览

- 每个完整工作流业务项目必须维护根目录 `CODE_MAP.md`，用于入口、模块、关键符号、状态和接口的文本导航；它不是运行时证明，必须以当前源码复核。
- `modules/45_V6_8_GraphifyCodeMapIntegration.md` 提供按需可视化代码地图策略，不是默认安装的外部依赖。
- `modules/50_V6_8_ExternalResearchAndArtifactIntegration.md` 定义 OfficeCLI、PixelRAG 和
  Firecrawl 的来源政策；Office 文件处理必须走经信任的 OfficeCLI 路线，其他来源仍不得从该政策推断
  已安装、可信或可调用。
- `modules/51_V6_8_AffordanceFirstToolUse.md` 要求从任务意图和所需证据自然选择工具；
  默认 profile 以执行为中心，完整治理内容在 `governance-reference` profile 中按需加载。
- `modules/52_V6_8_Img2ThreeJs3DWebIntegration.md` 定义可选的交互式 3D 网页模型路线：
  静态 3D 感视觉走 UI 路径，通用 3D 交互走原生 Three.js 路径，只有经批准的参考图模型重建
  才能候选 `img2threejs`，且不得推断已安装、可信或可执行。
- 多模块功能、重大重构、架构或发布工作在 Converge/Ship 时应询问用户是否需要代码视图预览。
- 用户明确同意后，才可在目标业务项目中生成 `graphify-out/`；不得默认在 AgentLogic 仓库内生成，也不得把外部图谱结果当作运行时事实证明。

## 11. 项目内 L1-L4 地图

- 每个业务项目使用根目录 `PROJECT_MAP.md` 保存其真实 L1-L4 映射，不复制本逻辑包。
- 每个业务项目使用根目录 `CODE_MAP.md` 保存可交接的符号级导航地图。
- 此地图和 `.learnings/ERRORS.md` 必须与项目代码一起提交并跨设备同步。
- 具体模板、脱敏边界和安全同步步骤由 `modules/46_V6_8_ProjectKnowledgeSync.md` 定义。
