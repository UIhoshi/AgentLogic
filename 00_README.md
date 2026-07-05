# AgentLogic_V6

本仓库如果用于本地安装，请优先查看：

- AI 安装入口：`AGENT_INSTALL.md`
- 人类安装入口：`INSTALL.md`
- 首选诊断命令：`powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\doctor.ps1`

本目录是基于当前仓库 `C:\Users\XU RONG\Downloads\claude-code-main\claude-code-main` 提炼出来的分层逻辑包，不是无边界源码镜像。

它的目标是把当前项目中和 Agent、工具、权限、安全、扩展、命令面、源码映射相关的关键信息整理成一套可持续维护的规则包，便于你后续继续升级主逻辑和逻辑包。

## 包内结构

本包采用三层结构：

- 抽象逻辑层
  负责解释系统结构、边界、主链路与维护规则。
- 原始源码层
  直接保留关键工具源码与关键工具基础设施源码。
- 索引映射层
  告诉后续维护者应该先读什么、哪些是条件能力、哪些只是支撑层。

- `AgentLogic_V6_65.md`
  当前逻辑包内的主逻辑正式版本。
- `01_MasterLogic.md`
  当前主逻辑的增强摘要，承接 `AgentLogic_V6_65.md` 的方法论。
- `02_Architecture.md`
  系统分层、主要入口、核心调用关系。
- `03_AgenticLoop.md`
  单轮执行链路，从用户输入到模型响应、工具执行、结果回流。
- `04_Tools.md`
  工具系统整合清单，包含分类、启用条件、关键路径。
- `05_PermissionsAndSafety.md`
  权限、计划模式、沙箱、安全判定与验证要求。
- `06_Extensibility.md`
  MCP、Skill、Custom Agent、工作树与插件相关的扩展入口。
- `07_CommandSurface.md`
  斜杠命令与工具/模块的关联视图。
- `08_SourceIndex.md`
  关键文档与关键源码索引，方便后续继续维护。
- `09_CapabilityMatrix.md`
  能力状态矩阵，区分实现、条件启用、stub、flag 关闭等状态。
- `10_PackagingPolicy.md`
  当前逻辑包的分层打包边界和强制保留规则。
- `13_MandatoryLogicGateTemplate.md`
  真实入口 / 起手源码文件强制头部模板。该模板必须加入每个真实入口 / 起手源码文件，
  用于在实现开始前阻断错误的上下文延续、跳过逻辑入口、以及未完成入口循环的执行行为。
- `14_ProjectFactMapTemplate.md`
  项目事实地图标准模板，可直接复制用于新项目接入。
- `15_LogicEntryChecklist.md`
  逻辑入口检查清单标准模板，可直接复制用于启动前核对。
- `16_GitHubREADMETemplate_V1.md` / `17_GitHubREADMEStyleRules_V1.md` / `18_GitHubREADMEExamples_V1.md` / `19_GitHubREADMEReviewChecklist_V1.md`
  GitHub README 编写规范与评审工具包。
- `20_V6_5_RuntimeModes.md`
  当前系统运行模式（REPL、Headless、SDK、Daemon 等）的认知与环境差异适配。
- `21_V6_5_ToolUsageAndSelection.md`
  通用工具选择的基本原则与防误用规约。
- `22_V6_5_HookLifecycle.md`
  工具执行的前置（Pre-execute）与后置（Post-execute）Hook 生命周期钩子。
- `23_V6_5_PermissionAndOutputPipeline.md`
  权限拦截与多模式输出管道的实现路径。
- `24_V6_5_ToolUsageMatrix.md`
  基于任务类型、阶段与风险等级的工具首选矩阵决策表。
- `25_V6_5_ToolCapabilityMapping.md`
  工具大类与具体提问类型之间的强弱能力映射表。
- `26_V6_5_INDEX.md`
  V6.5 治理与结构模块索引。
- `27_V6_5_ToolPermissionRiskMatrix.md`
  工具的安全授权姿态与风险拦截分级网关。
- `28_V6_5_TerminologyAndModuleBoundaries.md`
  标准专业词汇表与各个规则模块之间的边界权责界定。
- `29_MandatoryVerificationMatrix.md`
  结论类型到强制校验工具与证据要求的硬性映射矩阵。
- `30_ToolQuestionBoundaryMatrix.md`
  限制单一工具凭证闭环的强度边界矩阵，防止越权推论。
- `31_ToolMisuseAndAntiPatternMatrix.md`
  识别并纠正模型在工具使用中“强行闭环”等反模式的校验失败与标签降级机制。
- `32_V6_5_ContextAssemblyAndInstructionStacking.md`
  上下文指令优先级分层堆叠与记忆加载。
- `33_V6_5_BackgroundConsolidationAndIdleLifecycle.md`
  多轮对话结束后的“梦境期”后台数据巩固与闲置清理。
- `34_V6_5_ProjectFactMap_V2.md`
  结构化 4-Tier 事实地图在多轮会话中的演进机制。
- `35_V6_5_SkillGovernanceAndMandatoryUse.md`
  本地技能去重、审计与特定场景下强制使用技能的分配。
- `36_V6_5_SkillZoneSeparation.md`
  明确划分宿主本地私有技能与便携式仓库逻辑技能的隔离规则。
- `37_V6_6_CybersecuritySkillsRouter.md`
  逆向安全、Kali 辅助脚本、CTF 渗透分析与漏洞 Field Journal 的集成路由。
- `38_V6_6_SpecDrivenDevelopment.md`
  规格说明驱动开发（SDD）的六个 mandatory 生命周期执行阶段。
- `39_V6_6_TasteFrontendDesign.md`
  拒绝 UI Slop（粗制滥造前端）的设计参数 dials 微调、 spring 弹簧动画与溢出审计标准。
- `40_AgentLogicSystemMap.md`
  受 Linux 内核地图启发的 Agentic CLI 架构网格与单轮执行流 Mermaid 地图。
- `raw_tools/`
  直接保留的工具源码层。
- `raw_tooling/`
  工具注册、工具接口、工具编排等关键基础设施源码层。
- `raw_permissions/`
  权限与安全核心源码层。
- `raw_extensions/`
  MCP、skills、agent 扩展核心源码层。
- `raw_commands/`
  命令面原始源码层。
- `11_CrossDirectoryMap.md`
  tools、permissions、mcp、skills、commands 的跨目录关系图。
- `manifest.json`
  当前逻辑包的元信息。

## 维护原则

- 逻辑包优先描述“系统如何工作”，不是机械罗列文件名。
- 工具本体允许直接打包，但必须配套总览和索引。
- 所有关键结论尽量都能回溯到源码或文档。
- 发现更准确的链路、边界、限制时，应优先回写主逻辑文件 `AgentLogic_V6_65.md`，再同步逻辑包。
- 当前逻辑包是外挂规则包，不是业务项目目录；后续新项目或新模块不得直接在 `AgentLogic_V6` 目录下创建文件。
- 当前逻辑包同样不是具体项目事实本身；项目自己的 `README`、模块文档、接口文档与源码，才是项目事实来源。
- 当 Agent 重新进入项目时，项目主 md 除了承担项目说明职责，还应帮助确认“当前项目逻辑入口是否已定位”；若逻辑文件不在项目目录内，则必须先询问其位置。
- 因此，项目主 README / 主 md 的最小必备项，默认也应包含“当前项目逻辑入口说明”。
- 若项目依赖外部逻辑包，项目内所有真实入口 / 起手源码文件顶部都应放置短小逻辑提醒，且项目仓库应提供可执行校验脚本，例如 `node scripts/check-logic-entry.js`，用于检查这些入口提醒是否仍存在。
- `13_MandatoryLogicGateTemplate.md` 不是建议性注释模板，而是强制执行门模板；它必须加入每个真实入口 / 起手源码文件。
- 该模板来源于 AI 阅读真实入口 / 起手源码文件时的真实行为模式与多轮测试结果，其目标是阻断错误的上下文延续判断、阻断跳过逻辑入口、并降低实现前误操作率。

## 参考与借鉴的开源项目

本仓库在从早期版本演进到最新的 `V6.65` 阶段中，借鉴与参考了以下优秀的 GitHub 开源项目，以强化系统的设计、安全审计及可视化展示：

1. **Linux Kernel Map** (架构与地图设计借鉴)
   - 仓库地址: [makelinux/linux_kernel_map](https://github.com/makelinux/linux_kernel_map)
   - 借鉴点: 启发了 `V6.65` 将复杂的 Agent 规则与源码关系，重构为“横向子系统（Columns）与纵向抽象层（Rows）”的 4层矩阵式地图结构 ([40_AgentLogicSystemMap.md](file:///REPO_ROOT_PLACEHOLDER/modules/40_AgentLogicSystemMap.md))。
2. **Cybersecurity Skills Router** (逆向与安全分析能力对齐)
   - 仓库地址: [zhaoxuya520/reverse-skill](https://github.com/zhaoxuya520/reverse-skill)
   - 借鉴点: 整合了针对二进制逆向分析、CTF 渗透以及恶意软件检测等特定安全领域工具的路由控制规则。
3. **Spec Kit** (规格驱动开发规范)
   - 仓库地址: [github/spec-kit](https://github.com/github/spec-kit)
   - 借鉴点: 引入了 Spec-Driven Development 规格化开发契约校验，规范了 Agentic Loop 编程规范。
4. **Taste Skill** (前端界面艺术标准)
   - 仓库地址: [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill)
   - 借鉴点: 借鉴了其高标准的设计美学和反粗制滥造（Anti-Slop）的优质 UI 审计与页面渲染指标。
5. **Claude Code Base** (宿主 CLI 基础架构参考)
   - 仓库地址: [claude-code-best/claude-code](https://github.com/claude-code-best/claude-code)
   - 借鉴点: 作为系统底层与能力对齐的基线参考，用以映射和规范 CLI QueryEngine 循环、REPL 引导和权限沙箱的源码设计。
6. **Agent Browser** (智能体无头浏览器控制)
   - 仓库地址: [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser)
   - 借鉴点: 整合了针对大模型智能体优化的无头浏览器操作，采用 AOM 辅助功能树减少 Token 损耗并实现网页控制。
7. **Nano Banana Pro** (多模态图片生成原型)
   - 仓库地址: [google-gemini/imagen](https://ai.google.dev/)
   - 借鉴点: 支持高逼真的 UI 草图与网页视觉效果生成，提供先确认设计图再进行前端代码开发的前置确认工作流。
8. **Self-Improvement Agent** (智能体自纠错与自学习)
   - 仓库地址: [peterskoett/self-improving-agent](https://github.com/peterskoett/self-improving-agent)
   - 借鉴点: 提供了结构化的日志归档、缺陷纠偏记录以及针对频发问题的自适应总结和沉淀，用以提升智能体持续迭代能力。


## 当前输出来源

- 主逻辑基线：`AgentLogic_V6_65.md`
- 项目说明：`README.md`、`CLAUDE.md`
- 文档目录：`docs/`
- 核心源码目录：`src/`
