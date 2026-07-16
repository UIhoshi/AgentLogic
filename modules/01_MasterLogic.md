# AgentLogic_V6_8_0 Master Logic

本文件不是替代 `AgentLogic_V6_8_0.md`，而是将当前主逻辑映射到当前仓库，形成一份面向 Claude Code 类 Agentic CLI 系统的项目级主逻辑摘要。

## 1. 当前项目定位

- 该项目是一个终端原生的 Agentic Coding System。
- 系统核心不是“聊天”，而是“多轮模型推理 + 工具调用 + 权限判定 + 上下文压缩 + 状态回写”。
- 因此，逻辑整理必须围绕以下五个对象展开：
  - 入口与启动
  - 会话编排
  - 单轮执行循环
  - 工具系统
  - 权限与扩展体系

## 2. 当前项目联动的四层源码映射

### L1：CLI 与交互外壳层 (Shell & CLI Surface)
- 主入口文档：
  - `README.md`
  - `AGENTS.md`
  - `00_START_HERE.md`
  - `docs/introduction/architecture-overview.mdx`
- 主入口与 REPL 启动：
  - `src/entrypoints/cli.tsx`
  - `src/main.tsx`
  - `src/entrypoints/init.ts`
- 终端与 UI 渲染组件：
  - `src/screens/`
  - `src/components/`
  - `src/ink/`

### L2：会话与执行循环编排层 (Session & Loop Orchestration)
- 多轮会话编排：
  - `src/QueryEngine.ts`
- 单轮 Agentic 循环引擎：
  - `src/query.ts`
- 上下文与会话状态：
  - `src/context.ts`
  - `src/state/`

### L3：服务组件与中介控制层 (Service & Mediation Control)
- 工具注册与动态组装：
  - `src/Tool.ts`
  - `src/tools.ts`
  - `src/services/tools/`
- 权限判定与安全网关：
  - `src/utils/permissions/`
  - 核心特权工具拦截（如 `BashTool`、`PowerShellTool` 内部安全控制）
- 扩展中介与协议驱动：
  - `src/services/mcp/`

### L4：原子执行与底层驱动层 (Atomic Execution & Drivers)
- 具体底层命令实体：
  - `src/commands/`
- 具体原子工具实体：
  - `src/tools/*` (如 `view_file`、`run_command` 等底层实现)
- 领域扩展技能库：
  - `skills/` (如逆向安全路由、Spec 驱动开发工具包、Taste 前端设计规范等)

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

## 4.3 V6 是方法脑，项目文档与源码是事实层

- 当前版本必须明确区分：
  - `AgentLogic_V6` 负责方法、行为、规划、验证、回写规则
  - 项目自身 md 与源码负责业务事实、实现事实、结构事实与当前状态
- 这意味着：
  - V6 不负责描述某个具体项目到底做什么
  - V6 不负责替代项目 README、模块文档和源码阅读
  - 项目自己的文档与源码，才是“文件在哪里、函数在哪里、入口在哪里、当前实现如何”的事实来源
- 若 Agent 把 V6 和项目事实混为一体，就会把方法层错误地当作项目说明层，这是必须避免的。

## 4.3.1 项目主 md 还必须承担逻辑入口确认职责

- 当前版本还应明确：项目主 md 不只是告诉 Agent“项目是什么”，还应帮助 Agent 确认“当前项目应接入哪份 Agent 逻辑文件”。
- 当 Agent 重新进入一个项目时，默认应先从项目主 md 开始，但不能止步于项目介绍本身。
- 在正式开工前，还必须确认：
  - 当前项目目录下是否已有逻辑文件
  - 若没有，逻辑文件实际存放在哪里
  - 当前项目是否依赖独立维护的外部逻辑包
- 这里不应把逻辑版本写死，因为未来可能从 `V6` 升级为其他版本。
- 因此，规则应面向“逻辑入口是否已确认”，而不是面向某个固定版本号。

## 4.3.2 项目主 README 的最小必备项应包含逻辑入口说明

- 当前版本建议把这条进一步前置到项目主 README / 主 md 的最小必备项中。
- 也就是说，项目主文档除了说明项目目标、目录结构、使用方式之外，还应默认包含：
  - 当前项目逻辑入口是否在仓库内
  - 若在仓库内，逻辑文件路径
  - 若不在仓库内，逻辑文件应从哪里接入
  - 正式开始项目前是否需要先挂接外部逻辑包
- 这样项目文档会反过来帮助 Agent 更快完成主逻辑接入，形成正向循环。

## 4.4 项目接入时必须建立项目事实地图

- 当前项目进一步证明：只读主逻辑还不够，Agent 还必须建立项目事实地图。
- 项目事实地图至少需要覆盖：
  - 项目主目标
  - 主文档入口
  - 当前项目逻辑入口是否已确认
  - 当前任务所属模块
  - 关键入口文件
  - 关键函数 / 类
  - 未确认事实点
- 这份地图不是为了输出漂亮摘要，而是为了保证后续实现、修改、验证时不会偏离真实项目结构。
- 若后续要长期复用，应尽量把项目事实地图固定成模板输出，而不是每次重新组织字段顺序。
- 若逻辑包内已有标准模板文件，则后续 Agent 应优先直接使用该模板。

## 4.4.1 逻辑入口检查清单应固定

- 当前版本建议把“逻辑入口检查”也固定成一份短清单。
- 每次重新开始项目时，至少应检查：
  - 项目主文档入口是否已定位
  - 项目逻辑入口是否已定位
  - 若项目目录内未看到逻辑文件，是否已询问其位置
  - 当前逻辑入口是否为版本无关确认，而不是凭旧版本名猜测
  - 目录审计是否已完成
- 这样可以把“开始项目前的动作”固化成稳定入口，而不是依赖单次会话记忆。
- 若逻辑包内已有标准清单文件，则后续 Agent 应优先直接按清单执行。

## 4.5 主逻辑不能只读前半段

- 当前版本明确要求：Agent 必须完整阅读主逻辑，不能只读取前面的若干条款后就进入执行。
- 后部章节通常包含禁止事项、打包边界、风险规则、同步规则和版本维护规则。
- 因此，“完整阅读主逻辑”本身就是接入动作的一部分，而不是可选习惯。

## 4.6 默认工具低效时必须主动评估

- 当前版本进一步要求：如果默认工具、默认浏览器路径、默认阅读路径或默认搜索路径明显低效，Agent 不应被动坚持旧路径。
- Agent 应主动评估：
  - 是否存在更适合当前任务的工具或 skills
  - 是否存在更成熟的外部候选方案
  - 候选方案属于推荐项、候选增强项还是正式集成项

## 4.6.1 Mandatory Tool Verification Summary

- The main logic now treats some verification tool paths as mandatory rather than optional.
- Local repository facts must be verified by local search/listing plus targeted reads.
- Latest/current/remote facts must be verified by authoritative external read-only checks.
- UI / visible behavior must be verified by screenshot or equivalent visual evidence.
- All frontend layout changes that add or change text, fields, columns, badges, buttons, cards, grid/flex children, min-width, white-space, overflow, font size, or spacing must include a parent-child layout-boundary check so no child exceeds, pushes past, or visually breaks its parent container.
- Frontend work is not complete until the visible result has been checked for overflow, truncation, wrapping, misalignment, and one-row-vs-two-row fit under the actual container width.
- Runtime / build / packaging claims must be verified by command, build, or runtime checks.
- Path-sensitive writes, side-effecting commands, and external state changes must include pre-target confirmation and post-result confirmation.
- Permission-sensitive execution must include permission-mode and allowance confirmation before execution.
- If the matching verification tool was not used, the conclusion should not be treated as fully verified.
- `29_MandatoryVerificationMatrix.md` should be treated as the hard mapping layer for conclusion type -> tool family -> minimum pass condition.
- `30_ToolQuestionBoundaryMatrix.md` should be treated as the hard boundary layer for tool family -> allowed question types -> support-only question types -> forbidden-alone question types.
- `31_ToolMisuseAndAntiPatternMatrix.md` should be treated as the anti-pattern layer for common invalid closure paths, their correction recipes, and the safe interim labels that should replace overconfident conclusions.

## 4.7 V6 只作为外挂逻辑包，不作为项目目录

- 当前项目已经证明：主逻辑包与业务项目目录必须严格分离。
- `AgentLogic_V6` 的角色是外挂逻辑脑，不是业务仓库本体，也不是新项目、新模块的落盘目录。
- 后续任何 Agent 进入新项目时，允许把 V6 当作：
  - 主逻辑入口
  - 规则参考包
  - 能力映射包
  - 审计与补强基线
- 但不允许把 V6 当作：
  - 项目源码目录
  - 模块创建目录
  - 依赖安装目录
  - 构建输出目录
  - 临时测试与日志目录
- 若启动新项目，必须先建立独立项目目录，再将 V6 作为外挂规则接入。

## 4.8 启动前目录审计必须前置

- 当前版本还应把“目录审计”提升为启动前强制动作。
- Agent 在开始任何会创建业务文件的任务前，都必须先判断当前目录是否属于 V6 逻辑包范围。
- 如果当前目录属于：
  - `AgentLogic_V6`
  - 逻辑包维护目录
  - 逻辑包镜像目录
  - 逻辑包解压目录
  则不得直接继续项目初始化或模块创建。
- 正确动作是先切换到独立项目目录，再把 V6 作为外挂规则接入。
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
- 当项目存在真实入口 / 起手源码文件时，这些文件顶部默认都应放置短小的逻辑入口提醒。
- 这条规则的默认范围不是“只限关键入口”，而是覆盖项目内所有真实入口 / 起手源码文件；但不应机械铺满工具函数、叶子组件和非入口实现文件。
- 提醒应指向仓库内的 `AGENTS.md`、`README.md` 等相对入口文件，而不是写入机器相关的绝对路径。
- 这样可以把“主逻辑回读”从顶层文档延伸到真实开工点，降低多轮对话后的主逻辑漂移风险。
- 如果项目要把这条规则从“文档规范”升级为“工程约束”，则还应提供仓库级校验脚本，用于机械检查所有真实入口 / 起手源码文件与主文档是否仍保留逻辑入口提醒。
- 该类脚本应优先检查：
  - 仓库级入口文档是否仍指向主逻辑入口
  - 所有真实入口 / 起手源码文件顶部是否仍保留短提醒
  - 提醒内容是否指回仓库相对路径，而不是机器绝对路径


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
