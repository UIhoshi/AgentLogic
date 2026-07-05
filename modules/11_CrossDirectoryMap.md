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

# Cross Directory Code Map (代码跨目录地图)

本文件是针对本系统源码目录设计的 **4层代码架构与跨目录调用地图**。它将三层扁平结构重构为受 Linux 内核启发的 **L1 ➔ L2 ➔ L3 ➔ L4** 四层渐进体系，清晰界定了从用户终端界面到底层执行驱动的代码分布与数据流转关系。

---

## 1. 源码四层映射矩阵 (4-Layer Code Architecture)

| 代码层级 | 核心职责 | 关联的关键目录与文件 |
| :--- | :--- | :--- |
| **L1: Shell & CLI Surface**<br>(CLI 与交互外壳层) | 负责 REPL 启动、用户输入解析、命令分发、终端 UI 渲染。类似于 Linux 的 TTY 终端与系统调用接口。 | - [cli.tsx](file:///REPO_ROOT_PLACEHOLDER/src/entrypoints/cli.tsx)<br>- [main.tsx](file:///REPO_ROOT_PLACEHOLDER/src/main.tsx)<br>- `src/screens/` 与 `src/components/` (终端 React 组件)<br>- `src/ink/` (终端渲染引擎) |
| **L2: Session & Loop Orchestration**<br>(会话与循环编排层) | 负责协调多轮会话状态、管理当前会话上下文以及单轮推理循环。类似于 Linux 内核的进程调度与页表映射。 | - [QueryEngine.ts](file:///REPO_ROOT_PLACEHOLDER/src/QueryEngine.ts) (会话编排)<br>- [query.ts](file:///REPO_ROOT_PLACEHOLDER/src/query.ts) (单轮思考/推理引擎)<br>- [context.ts](file:///REPO_ROOT_PLACEHOLDER/src/context.ts) (上下文封装)<br>- `src/state/` (会话状态状态机) |
| **L3: Service & Mediation Control**<br>(服务组件与中介控制层) | 提供统一的抽象接口，负责工具的动态组装、执行拦截、权限判定和扩展协议。类似于 Linux 的 VFS (虚拟文件系统) 和 Sockets 层。 | - [Tool.ts](file:///REPO_ROOT_PLACEHOLDER/src/Tool.ts) & [tools.ts](file:///REPO_ROOT_PLACEHOLDER/src/tools.ts) (工具中介与注册)<br>- `src/services/tools/` (工具执行与 Hook 生命周期编排)<br>- `src/utils/permissions/` (权限拦截网关)<br>- `src/services/mcp/` (Model Context Protocol 客户端/服务端) |
| **L4: Atomic Execution & Drivers**<br>(原子执行与底层驱动层) | 负责具体业务命令与工具的实际执行，与本地环境、文件系统、网络交互。类似于 Linux 的具体设备驱动与文件系统实现。 | - `src/commands/` (底层 CLI 命令实现)<br>- `src/tools/` (原子工具代码，如 `view_file`、`run_command` 等的实际 TypeScript 实现)<br>- `skills/` (领域技能包，例如 `taste-skill` UI 审计、`reverse-skill` 逆向分析、`spec-kit` SDD 控制) |

---

## 2. 关键跨目录交互与数据流向

当用户输入指令或大模型产生工具调用时，代码将按以下路径跨目录流转：

```
L1: Surface (cli.tsx / React UI)
       │ (1) 提交用户指令 / 输入
       ▼
L2: Loop (QueryEngine.ts ➔ query.ts) ◄───┐
       │ (2) 发起模型推理，生成工具调用请求  │ (7) 回传执行结果
       ▼                                  │
L3: Service (tools.ts ➔ toolExecution.ts) ┘
       │ (3) 触发 Pre-Hook 并请求权限校验
       ├────────➔ src/utils/permissions/ (权限判定)
       │ (4) 权限放行，开始派发工具
       ▼
L4: Drivers (src/tools/* or skills/*)
       │ (5) 实际执行系统/网络/文件操作
       ▼
L3: Service (toolResultStorage.ts ➔ Hook Lifecycle)
         (6) 触发 Post-Hook & 强制验证矩阵验证 (modules/29)
```

---

## 3. 维护与阅读顺序建议

对于接手或参与系统开发的开发者，推荐按照如下的系统化路径进行代码阅读：

1. **核心逻辑入口**:
   - `modules/01_MasterLogic.md` (主架构纲领)
   - `modules/40_AgentLogicSystemMap.md` (架构网格与执行流地图)
2. **第一步：看外壳交互 (L1)**:
   - 从 `src/main.tsx` 了解 REPL 启动，然后看 `src/entrypoints/cli.tsx` 如何处理首帧渲染与组件挂载。
3. **第二步：理会话循环 (L2)**:
   - 深入阅读 `src/QueryEngine.ts` 掌握多轮对话的挂起与激活，再看 `src/query.ts` 理解单轮 Agentic Loop 中的模型调用策略。
4. **第三步：看工具服务与安全 (L3)**:
   - 阅读 `src/Tool.ts` 抽象类，接着看 `src/services/tools/toolExecution.ts` 如何管理生命周期 Hook 以及如何接入 `src/utils/permissions/` 进行安全拦截。
5. **第四步：看驱动与落地 (L4)**:
   - 查看 `src/tools/` 目录下的底层执行逻辑，然后看外部扩展技能包 `skills/` 如何反哺核心引擎。
