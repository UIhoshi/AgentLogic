# Source Index

## 1. 主文档入口

- `README.md`
- `CLAUDE.md`
- `docs/introduction/architecture-overview.mdx`
- `docs/tools/what-are-tools.mdx`
- `docs/safety/permission-model.mdx`
- `docs/extensibility/custom-agents.mdx`

## 2. 关键源码入口

- `src/entrypoints/cli.tsx`
- `src/main.tsx`
- `src/QueryEngine.ts`
- `src/query.ts`
- `src/context.ts`
- `src/Tool.ts`
- `src/tools.ts`

## 3. 工具系统

- `src/tools/`
- `src/services/tools/toolOrchestration.ts`
- `src/services/tools/toolExecution.ts`
- `src/services/tools/toolHooks.ts`
- `src/utils/toolResultStorage.ts`
- `src/Tool.ts`
- `src/tools.ts`

## 4. 权限与安全

- `src/utils/permissions/`
- `src/tools/BashTool/`
- `src/tools/PowerShellTool/`
- `docs/safety/sandbox.mdx`
- `docs/safety/plan-mode.mdx`
- `docs/safety/permission-model.mdx`

## 5. 扩展

- `src/services/mcp/`
- `src/skills/`
- `src/tools/AgentTool/`
- `docs/extensibility/mcp-protocol.mdx`
- `docs/extensibility/skills.mdx`
- `docs/extensibility/custom-agents.mdx`

## 6. 命令面

- `src/commands/`

## 6.1 当前逻辑包中的原始层位置

- `raw_tools/`
- `raw_tooling/`
- `raw_permissions/`
- `raw_extensions/`
- `raw_commands/`

## 7. 当前整理结论

- 当前项目并不适合被简单理解为“一个 CLI 仓库”。
- 它更准确的定义是“一个带工具系统、权限系统、扩展系统和多轮执行循环的 Agentic CLI 平台”。
- 因此，后续任何逻辑包升级，都应围绕平台级边界维护，而不是围绕单个文件维护。
- 对当前项目，工具源码层应长期保留在逻辑包中，而不是只保留摘要。


## 8. 对照参考源码

- V6.5 对照参考源码仓库
  - `https://github.com/claude-code-best/claude-code`
- 本地比对目录
  - `D:\workspace\claude-code`
- 比对说明
  - 核心逻辑基于 V6.5 及 V6.6 的结构性设计，与 claude-code 进行能力对齐。

## 9. 外部参考源注册规范

- 任何未来的逻辑线升级，若参考了外部开源或私有项目，必须在此显式注册。
- 注册项包含：
  - 外部参考源 URL
  - 本地集成/对比路径
  - 明确标记为 stable line 还是 draft line
  - 关联的具体版本 tag 或 commit 散列值
- 杜绝脱离实际项目架构设计的空想，确保规则与真实执行引擎能力匹配。

