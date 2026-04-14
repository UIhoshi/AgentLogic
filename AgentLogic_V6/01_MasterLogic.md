# AgentLogic_V6 Master Logic

本文件不是替代 `AgentLogic_V6.md`，而是将当前主逻辑映射到当前仓库，形成一份面向 Claude Code 类 Agentic CLI 系统的项目级主逻辑摘要。

## 1. 当前项目定位

- 该项目是一个终端原生的 Agentic Coding System。
- 系统核心不是“聊天”，而是“多轮模型推理 + 工具调用 + 权限判定 + 上下文压缩 + 状态回写”。
- 因此，逻辑整理必须围绕以下五个对象展开：
  - 入口与启动
  - 会话编排
  - 单轮执行循环
  - 工具系统
  - 权限与扩展体系

## 2. 当前项目的三层映射

### L1：战略与入口层

- 主入口文档：
  - `README.md`
  - `CLAUDE.md`
  - `docs/introduction/architecture-overview.mdx`
- 主入口代码：
  - `src/entrypoints/cli.tsx`
  - `src/main.tsx`
  - `src/entrypoints/init.ts`

### L2：领域架构层

- 核心会话编排：
  - `src/QueryEngine.ts`
  - `src/query.ts`
- 工具系统：
  - `src/Tool.ts`
  - `src/tools.ts`
  - `src/services/tools/`
- 权限与安全：
  - `src/utils/permissions/`
  - `src/tools/BashTool/`
  - `src/tools/PowerShellTool/`
- 扩展系统：
  - `src/services/mcp/`
  - `src/skills/`
  - `src/tools/AgentTool/`

### L3：原子执行层

- 工具目录：`src/tools/*`
- 命令目录：`src/commands/*`
- 状态与上下文：`src/state/`、`src/context.ts`
- UI/终端渲染：`src/screens/`、`src/components/`、`src/ink/`

## 3. 当前项目的核心工作对象

- 模型请求对象
  由 `src/query.ts` 和 `src/services/api/claude.ts` 共同构建。
- 工具集合对象
  由 `src/tools.ts` 动态组装，不是静态常量。
- 权限上下文对象
  由 `ToolPermissionContext` 与 `src/utils/permissions/` 共同维护。
- 会话状态对象
  由 `src/QueryEngine.ts`、`src/state/`、`src/bootstrap/state.ts` 共同维护。

## 4. 当前项目的高价值维护原则

- 任何“能力存在”的结论，都必须区分：
  - 已实现
  - 条件启用
  - feature flag 关闭
  - stub
- 任何“工具可用”的结论，都必须区分：
  - 注册层面存在
  - 运行时可启用
  - 权限层面可放行
  - 当前外部构建默认可达
- 任何“逻辑包完善”动作，都必须把工具、权限、扩展作为一个整体系统来写，而不是分散记忆。

## 4.1 全部 Agent 的统一接入要求

- 当前项目后续无论由哪个 Agent 进入，都必须先走主逻辑接入流程。
- 这条规则适用于：
  - 主线程 Agent
  - 子 Agent
  - review Agent
  - verification Agent
  - planning Agent
  - 模块专用 Agent
- 只要出现以下任一情况，就必须重新执行主逻辑接入：
  - 进入一个新项目
  - 新增一个新模块
  - 接手一个之前未读透的子系统
  - 从分析阶段切换到实施阶段
- 目的不是增加形式化流程，而是减少不同 Agent 因为入口不一致而带来的错误率、边界漂移和结构误判。

## 4.2 新模块必须先规划

- 如果工作对象是一个新模块，而不是已有模块的局部修复，则 Agent 在进入实现前必须先给出模块级规划。
- 该规划至少应包含：
  - 模块目标
  - 模块边界
  - 入口与落点
  - 与现有系统的关系
  - 验证方式
- 这是主逻辑在新增模块场景下的强制派生要求。

## 4.3 主逻辑不能只读前半段

- 当前版本明确要求：Agent 必须完整阅读主逻辑，不能只读取前面的若干条款后就进入执行。
- 后部章节通常包含禁止事项、打包边界、风险规则、同步规则和版本维护规则。
- 因此，“完整阅读主逻辑”本身就是接入动作的一部分，而不是可选习惯。

## 4.4 默认工具低效时必须主动评估

- 当前版本进一步要求：如果默认工具、默认浏览器路径、默认阅读路径或默认搜索路径明显低效，Agent 不应被动坚持旧路径。
- Agent 应主动评估：
  - 是否存在更适合当前任务的工具或 skills
  - 是否存在更成熟的外部候选方案
  - 候选方案属于推荐项、候选增强项还是正式集成项
- 这条规则的目标，是防止 AI 只在已有工具里打转，忽略更好用的外部工具，从而降低效率和判断质量。
- 统一表达为：默认工具低效时，Agent 应主动寻找更适合当前任务的工具或方案，但必须区分正式能力与候选增强。

## 5. 当前项目的打包指定

对于当前项目，主逻辑应明确强制指定以下边界：

- `src/tools/` 必须作为工具原始源码层整包保留。
- `src/Tool.ts`、`src/tools.ts`、`src/services/tools/` 必须作为工具基础设施层保留。
- `src/utils/permissions/` 不要求整目录复制，但至少要在逻辑层中明确索引与关键路径。
- `docs/` 不要求全量复制，但核心章节必须在索引层中点名。
- 大型 UI 目录不要求整包进入逻辑包，默认以入口索引和主链路说明为主。

## 6. 为什么允许工具直接打包

当前项目的工具系统规模较大，且很多价值来自真实实现而不是摘要文字。

因此采用以下策略更稳定：

- 工具源码原样保留
- 工具总览单独解释
- 工具注册与执行基础设施单独解释
- 对 stub、feature flag、条件启用工具在逻辑层明确标记

## 7. 当前项目的最终分层边界

对当前项目，建议形成如下最终边界：

- P0 整包保留
  - `src/tools/`
  - `src/Tool.ts`
  - `src/tools.ts`
  - `src/services/tools/`
- P1 保留关键实现层
  - `src/utils/permissions/`
  - `src/services/mcp/`
  - `src/skills/`
  - `src/tools/AgentTool/`
- P2 保留索引与映射
  - `src/commands/`
  - `src/context.ts`
  - `src/state/`
- P3 入口化处理
  - 大型 UI 目录
  - 展示性组件

当前版本进一步加强为：

- `src/commands/` 作为命令面原始层保留
- `context.ts` 与 `state/` 继续保持索引优先

## 8. 对主逻辑的新增补强

相较于更早版本的主逻辑，当前项目额外证明了以下内容应长期进入主逻辑：

- 逻辑包应是“源码驱动的知识包”，不是“源码复制包”。
- 工具系统必须整合成完整视图，至少涵盖注册、过滤、授权、执行、回流。
- 项目级逻辑包需要保留“能力状态”维度，避免把 stub 或死代码误写成真实能力。
- 发现更准确的架构、工具、权限、扩展边界时，应同步反哺主逻辑文件。
