# Logic Entry Checklist

本文件是逻辑入口检查清单标准模板。

用途：

- 在正式开始项目之前，用它核对“逻辑入口是否已经确认”。
- 它用于防止 Agent 直接开工而没有确认逻辑文件、逻辑包位置或目录边界。

使用规则：

- 应在项目正式接入前完成。
- 若任一关键项未通过，不应进入实现状态。
- 这份清单使用版本无关表达，不依赖固定版本名。

---

## 1. 主文档定位

- [ ] 已定位项目主 README / 主 md
- [ ] 已确认项目文档主入口
- [ ] 已确认当前文档入口不是过期或旁支文档

## 2. 逻辑入口定位

- [ ] 已检查当前项目目录下是否存在 Agent 逻辑文件
- [ ] 若项目目录内不存在逻辑文件，已询问逻辑文件在哪里
- [ ] 已确认当前项目应接入哪一份逻辑入口
- [ ] 没有因为旧版本名习惯而直接假设逻辑文件名

## 3. 逻辑入口归属判断

- [ ] 已确认逻辑入口属于仓库内文件还是外部逻辑包
- [ ] 若属于外部逻辑包，已确认挂接位置
- [ ] 若属于仓库内文件，已确认具体路径

## 4. 目录与执行边界

- [ ] 已完成目录审计
- [ ] 已确认当前目录不是逻辑包工作目录
- [ ] 若任务需要创建业务文件，已切换到独立项目目录
- [ ] 确认执行命令时的 Cwd 是否正确处于工作区根目录，以防止误删除/误覆盖

## 5. 上下文延申与重置判断

- [ ] Current task is explicitly classified as an extension of the previous implementation round or as a new coding round.
- [ ] If it is not an extension, the user was explicitly asked whether to `forget/compress context` before continuing.
- [ ] If the user explicitly authorizes continuous execution, that authorization is recorded for the current task scope.
- [ ] 若需要收缩上下文，已先回写结构化状态，再减少工作上下文

## 6. 开始项目前的最终结论

- [ ] 已完成主逻辑接入
- [ ] 已完成逻辑入口确认
- [ ] 若检测到本地主逻辑文件有变更，已运行 scripts/validate-package.ps1 进行一致性验证
- [ ] 已完成上下文延申判断与必要的上下文重置提问（或满足静默忽略条件）
- [ ] 已建立项目事实地图
- [ ] 若项目已提供仓库级逻辑入口校验脚本，已实际运行（例如：`node scripts/check-logic-entry.js`）
- [ ] 当前可以进入正式规划 / 实现 / 验证阶段

## 7. 未通过时的默认动作

- 若第 1-5 节任一项未通过，默认动作应为：
  - 停止进入实现
  - 先补逻辑入口确认
  - 先补上下文延申判断或上下文重置提问
  - 先补目录审计
  - 先补项目事实地图


## 8. Continuous Execution Authorization Checks

- [ ] If the user explicitly gave a continuous-execution instruction such as "unless I say stop, keep going", that instruction has been recorded as an active authorization for the current task scope
- [ ] Subsequent planned implementation steps are being treated as part of the same continuous execution round rather than as repeated re-confirmation points
- [ ] The current work is still being treated as implementation / build-out phase by default, not as formal product-test stage, unless the user explicitly said testing has begun

## 9. UI Preview Gate

- [ ] If the task includes formal UI implementation, a text-to-image preview has been generated and shown to the user before UI code is written
- [ ] The user has either reviewed/approved the preview or explicitly opted out of the preview step
- [ ] No UI implementation began before one of those two conditions was satisfied
