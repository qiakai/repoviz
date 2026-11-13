<div align="center">

# repoviz

**把任意代码库变成架构图、流程图和桑基图——零安装，Markdown 链接即出，可选 SVG/PNG/HTML 导出。**

[English](README.md) | 简体中文

![Claude Code](https://img.shields.io/badge/Claude%20Code-native-blue)
![Cursor](https://img.shields.io/badge/Cursor-native-blue)
![Windsurf](https://img.shields.io/badge/Windsurf-native-blue)
![Codex CLI](https://img.shields.io/badge/Codex%20CLI-compatible-blue)
![ClawHub](https://img.shields.io/badge/ClawHub-publishable-green)
![skills.sh](https://img.shields.io/badge/skills.sh-installable-green)

</div>

`repoviz` 是一个 Agent 技能：扫描代码库，自动选出最合适的可视化形式——**架构图、桑基图、流程图、时序图、思维导图或甘特图**——并渲染成一个可直接嵌入的 URL。默认零安装、零本地文件；每张图就是一个 Markdown 图片链接，可粘贴进 README、文档或聊天窗口。

**实时展示** —— 以下图表此刻就在真实渲染（示例电商平台的微服务架构与数据管道）：

![repoviz 架构图示例](https://x-cmd.com/draw/archmap?title=%E7%94%B5%E5%95%86%E5%B9%B3%E5%8F%B0%E5%BE%AE%E6%9C%8D%E5%8A%A1%E6%9E%B6%E6%9E%84&n=web;fe;%E7%BD%91%E9%A1%B5%E7%AB%AF;React;r0c0&n=app;fe;%E7%A7%BB%E5%8A%A8%E7%AB%AF;Flutter;r0c1&n=open;ext;%E5%BC%80%E6%94%BE%E6%8E%A5%E5%8F%A3;%E5%90%88%E4%BD%9C%E4%BC%99%E4%BC%B4;r0c2&n=cdn;cloud;CDN;%E8%BE%B9%E7%BC%98%E7%BC%93%E5%AD%98;r0c3&n=gw;be;API%20%E7%BD%91%E5%85%B3;%E9%99%90%E6%B5%81;r1c0&n=auth;sec;%E8%AE%A4%E8%AF%81%E6%9C%8D%E5%8A%A1;JWT%20%C2%B7%20OIDC;r1c1&n=order;be;%E8%AE%A2%E5%8D%95%E6%9C%8D%E5%8A%A1;;r1c2&n=pay;be;%E6%94%AF%E4%BB%98%E6%9C%8D%E5%8A%A1;;r1c3&n=notify;svc;%E9%80%9A%E7%9F%A5%E6%9C%8D%E5%8A%A1;;r2c0&n=search;be;%E6%90%9C%E7%B4%A2%E6%9C%8D%E5%8A%A1;;r2c1&n=rec;be;%E6%8E%A8%E8%8D%90%E6%9C%8D%E5%8A%A1;;r2c2&n=pg1;db;%E7%94%A8%E6%88%B7%E5%BA%93;Postgres;r2c3&n=pg2;db;%E8%AE%A2%E5%8D%95%E5%BA%93;Postgres;r3c0&n=redis;db;Redis;%E7%BC%93%E5%AD%98%20%C2%B7%20%E9%98%9F%E5%88%97;r3c1&n=kafka;bus;Kafka;%E4%BA%8B%E4%BB%B6%E6%B5%81;r3c2&n=oss;cloud;%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8;S3;r3c3&n=stripe;ext;Stripe;%E6%94%AF%E4%BB%98%E6%B8%A0%E9%81%93;r4c0&n=sms;ext;%E7%9F%AD%E4%BF%A1%E5%B9%B3%E5%8F%B0;;r4c1&e=web;cdn&e=app;cdn&e=open;gw&e=cdn;gw;%E8%B7%AF%E7%94%B1&e=gw;auth;%E9%89%B4%E6%9D%83;main&e=gw;order;;main&e=gw;search&e=gw;rec&e=auth;pg1;%E7%94%A8%E6%88%B7%E6%95%B0%E6%8D%AE&e=auth;redis;%E4%BC%9A%E8%AF%9D&e=order;pg2;SQL;main&e=order;redis;%E7%BC%93%E5%AD%98&e=order;kafka;%E8%AE%A2%E5%8D%95%E4%BA%8B%E4%BB%B6&e=kafka;notify;%E8%AE%A2%E9%98%85&e=kafka;search;%E7%B4%A2%E5%BC%95&e=order;pay;%E6%89%A3%E6%AC%BE;main&e=pay;stripe;API;main&e=order;oss;%E6%96%87%E4%BB%B6&e=notify;sms;SMS&e=rec;redis&b=%E6%8E%A5%E5%85%A5%E5%B1%82;web%20app%20open%20cdn&b=%E6%9C%8D%E5%8A%A1%E5%B1%82;gw%20auth%20order%20pay%20notify%20search%20rec&b=%E6%95%B0%E6%8D%AE%E5%B1%82;pg1%20pg2%20redis%20kafka%20oss&b=%E5%A4%96%E9%83%A8%E4%BE%9D%E8%B5%96;stripe%20sms)

![repoviz 桑基图示例](https://x-cmd.com/draw?type=sankey&t=pipeline&labels=%E4%B8%9A%E5%8A%A1%E6%97%A5%E5%BF%97,%E9%87%87%E9%9B%86%E6%9C%8D%E5%8A%A1,%E6%B6%88%E6%81%AF%E9%98%9F%E5%88%97,%E5%AE%9E%E6%97%B6%E6%95%B0%E4%BD%93,%E7%A6%BB%E7%BA%BF%E6%95%B0%E4%BD%93,BI%20%E6%8A%A5%E8%A1%A8,%E6%8E%A8%E8%8D%90%E6%A8%A1%E5%9E%8B&links=%E4%B8%9A%E5%8A%A1%E6%97%A5%E5%BF%97>%E9%87%87%E9%9B%86%E6%9C%8D%E5%8A%A1:100;%E9%87%87%E9%9B%86%E6%9C%8D%E5%8A%A1>%E6%B6%88%E6%81%AF%E9%98%9F%E5%88%97:96;%E6%B6%88%E6%81%AF%E9%98%9F%E5%88%97>%E5%AE%9E%E6%97%B6%E6%95%B0%E4%BD%93:40;%E6%B6%88%E6%81%AF%E9%98%9F%E5%88%97>%E7%A6%BB%E7%BA%BF%E6%95%B0%E4%BD%93:56;%E5%AE%9E%E6%97%B6%E6%95%B0%E4%BD%93>BI%20%E6%8A%A5%E8%A1%A8:32;%E5%AE%9E%E6%97%B6%E6%95%B0%E4%BD%93>%E6%8E%A8%E8%8D%90%E6%A8%A1%E5%9E%8B:8;%E7%A6%BB%E7%BA%BF%E6%95%B0%E4%BD%93>%E6%8E%A8%E8%8D%90%E6%A8%A1%E5%9E%8B:30;%E7%A6%BB%E7%BA%BF%E6%95%B0%E4%BD%93>BI%20%E6%8A%A5%E8%A1%A8:12&title=%E6%95%B0%E6%8D%AE%E7%AE%A1%E9%81%93%E6%B5%81%E9%87%8F&unit=GB%2F%E5%A4%A9)

上图共 18 个节点、21 条边，分四层边界（接入层 / 服务层 / 数据层 / 外部依赖）——所有方框、文字、连线都只是 URL 里的数据，改一段参数图就重画。

## 为什么选择 repoviz？

| | 裸 Mermaid | 前端私有生成器 | **repoviz** |
|---|---|---|---|
| 图表种类（桑基/架构/流程/时序/思维导图/甘特） | 仅流程图 + 时序图 | 通常只支持单一类型 | **六种全覆盖，按意图自动路由** |
| 本地依赖 | 需 JS 运行时或 CLI | Node + 浏览器工具链 | **零依赖——任意 Markdown 查看器直接渲染** |
| Token 效率 | 每种图冗长 DSL | 需喂完整 AST | **扁平可读的 URL 参数；agent 只读清单，不读上百个文件** |
| Markdown / README 就绪度 | 查看端还需渲染器 | 必须额外导出 | **粘贴 URL 即完成** |
| 离线导出（SVG / PNG / HTML） | 仅 CLI 支持 | 常需付费或带水印 | **各一条 `sh` 命令，仅需 POSIX + curl** |

## 图库

复制提示词发给装好 repoviz 的 agent，它会自动扫描、路由并返回答案：

**1. 系统架构图** —— *"把这个仓库的架构画出来。"*

![架构图图库示例](https://x-cmd.com/draw/archmap?title=%E7%94%B5%E5%95%86%E5%B9%B3%E5%8F%B0%E5%BE%AE%E6%9C%8D%E5%8A%A1%E6%9E%B6%E6%9E%84&n=web;fe;%E7%BD%91%E9%A1%B5%E7%AB%AF;React;r0c0&n=app;fe;%E7%A7%BB%E5%8A%A8%E7%AB%AF;Flutter;r0c1&n=open;ext;%E5%BC%80%E6%94%BE%E6%8E%A5%E5%8F%A3;%E5%90%88%E4%BD%9C%E4%BC%99%E4%BC%B4;r0c2&n=cdn;cloud;CDN;%E8%BE%B9%E7%BC%98%E7%BC%93%E5%AD%98;r0c3&n=gw;be;API%20%E7%BD%91%E5%85%B3;%E9%99%90%E6%B5%81;r1c0&n=auth;sec;%E8%AE%A4%E8%AF%81%E6%9C%8D%E5%8A%A1;JWT%20%C2%B7%20OIDC;r1c1&n=order;be;%E8%AE%A2%E5%8D%95%E6%9C%8D%E5%8A%A1;;r1c2&n=pay;be;%E6%94%AF%E4%BB%98%E6%9C%8D%E5%8A%A1;;r1c3&n=notify;svc;%E9%80%9A%E7%9F%A5%E6%9C%8D%E5%8A%A1;;r2c0&n=search;be;%E6%90%9C%E7%B4%A2%E6%9C%8D%E5%8A%A1;;r2c1&n=rec;be;%E6%8E%A8%E8%8D%90%E6%9C%8D%E5%8A%A1;;r2c2&n=pg1;db;%E7%94%A8%E6%88%B7%E5%BA%93;Postgres;r2c3&n=pg2;db;%E8%AE%A2%E5%8D%95%E5%BA%93;Postgres;r3c0&n=redis;db;Redis;%E7%BC%93%E5%AD%98%20%C2%B7%20%E9%98%9F%E5%88%97;r3c1&n=kafka;bus;Kafka;%E4%BA%8B%E4%BB%B6%E6%B5%81;r3c2&n=oss;cloud;%E5%AF%B9%E8%B1%A1%E5%AD%98%E5%82%A8;S3;r3c3&n=stripe;ext;Stripe;%E6%94%AF%E4%BB%98%E6%B8%A0%E9%81%93;r4c0&n=sms;ext;%E7%9F%AD%E4%BF%A1%E5%B9%B3%E5%8F%B0;;r4c1&e=web;cdn&e=app;cdn&e=open;gw&e=cdn;gw;%E8%B7%AF%E7%94%B1&e=gw;auth;%E9%89%B4%E6%9D%83;main&e=gw;order;;main&e=gw;search&e=gw;rec&e=auth;pg1;%E7%94%A8%E6%88%B7%E6%95%B0%E6%8D%AE&e=auth;redis;%E4%BC%9A%E8%AF%9D&e=order;pg2;SQL;main&e=order;redis;%E7%BC%93%E5%AD%98&e=order;kafka;%E8%AE%A2%E5%8D%95%E4%BA%8B%E4%BB%B6&e=kafka;notify;%E8%AE%A2%E9%98%85&e=kafka;search;%E7%B4%A2%E5%BC%95&e=order;pay;%E6%89%A3%E6%AC%BE;main&e=pay;stripe;API;main&e=order;oss;%E6%96%87%E4%BB%B6&e=notify;sms;SMS&e=rec;redis&b=%E6%8E%A5%E5%85%A5%E5%B1%82;web%20app%20open%20cdn&b=%E6%9C%8D%E5%8A%A1%E5%B1%82;gw%20auth%20order%20pay%20notify%20search%20rec&b=%E6%95%B0%E6%8D%AE%E5%B1%82;pg1%20pg2%20redis%20kafka%20oss&b=%E5%A4%96%E9%83%A8%E4%BE%9D%E8%B5%96;stripe%20sms)

**2. 数据与依赖流（桑基图）** —— *"梳理这个数据管道的流量走向。"*

![桑基图图库示例](https://x-cmd.com/draw?type=sankey&t=pipeline&labels=%E4%B8%9A%E5%8A%A1%E6%97%A5%E5%BF%97,%E9%87%87%E9%9B%86%E6%9C%8D%E5%8A%A1,%E6%B6%88%E6%81%AF%E9%98%9F%E5%88%97,%E5%AE%9E%E6%97%B6%E6%95%B0%E4%BD%93,%E7%A6%BB%E7%BA%BF%E6%95%B0%E4%BD%93,BI%20%E6%8A%A5%E8%A1%A8,%E6%8E%A8%E8%8D%90%E6%A8%A1%E5%9E%8B&links=%E4%B8%9A%E5%8A%A1%E6%97%A5%E5%BF%97>%E9%87%87%E9%9B%86%E6%9C%8D%E5%8A%A1:100;%E9%87%87%E9%9B%86%E6%9C%8D%E5%8A%A1>%E6%B6%88%E6%81%AF%E9%98%9F%E5%88%97:96;%E6%B6%88%E6%81%AF%E9%98%9F%E5%88%97>%E5%AE%9E%E6%97%B6%E6%95%B0%E4%BD%93:40;%E6%B6%88%E6%81%AF%E9%98%9F%E5%88%97>%E7%A6%BB%E7%BA%BF%E6%95%B0%E4%BD%93:56;%E5%AE%9E%E6%97%B6%E6%95%B0%E4%BD%93>BI%20%E6%8A%A5%E8%A1%A8:32;%E5%AE%9E%E6%97%B6%E6%95%B0%E4%BD%93>%E6%8E%A8%E8%8D%90%E6%A8%A1%E5%9E%8B:8;%E7%A6%BB%E7%BA%BF%E6%95%B0%E4%BD%93>%E6%8E%A8%E8%8D%90%E6%A8%A1%E5%9E%8B:30;%E7%A6%BB%E7%BA%BF%E6%95%B0%E4%BD%93>BI%20%E6%8A%A5%E8%A1%A8:12&title=%E6%95%B0%E6%8D%AE%E7%AE%A1%E9%81%93%E6%B5%81%E9%87%8F&unit=GB%2F%E5%A4%A9)

**3. 请求 / 执行流程图** —— *"把订单流程画成流程图。"*

![流程图图库示例](https://x-cmd.com/draw/mermaid?m=graph%20TD%3B%20A%5B%E6%8F%90%E4%BA%A4%E8%AE%A2%E5%8D%95%5D--%3EB%7B%E5%BA%93%E5%AD%98%E5%85%85%E8%B6%B3%3F%7D%3B%20B--%3EC%5B%E6%89%A3%E5%87%8F%E5%BA%93%E5%AD%98%5D%3B%20B--%3ED%5B%E6%8F%90%E7%A4%BA%E7%BC%BA%E8%B4%A7%5D%3B%20C--%3EE%5B%E5%88%9B%E5%BB%BA%E8%AE%A2%E5%8D%95%5D%3B%20E--%3EF%5B%E5%8F%91%E8%B5%B7%E6%94%AF%E4%BB%98%5D&title=%E8%AE%A2%E5%8D%95%E6%B5%81%E7%A8%8B)

**4. 时序图** —— *"画出创建订单的接口调用时序。"*

![时序图图库示例](https://x-cmd.com/draw/seq?title=%E4%B8%8B%E5%8D%95%E9%93%BE%E8%B7%AF%E6%97%B6%E5%BA%8F&n=c;fe;%E5%AE%A2%E6%88%B7%E7%AB%AF;;&n=gw;be;API%20%E7%BD%91%E5%85%B3;;&n=order;be;%E8%AE%A2%E5%8D%95%E6%9C%8D%E5%8A%A1;;&n=pay;be;%E6%94%AF%E4%BB%98%E6%9C%8D%E5%8A%A1;;&n=kafka;bus;%E6%B6%88%E6%81%AF%E9%98%9F%E5%88%97;;&e=c;gw;%E6%8F%90%E4%BA%A4%E8%AE%A2%E5%8D%95&e=gw;order;%E6%A0%A1%E9%AA%8C%E5%BA%93%E5%AD%98&e=order;gw;%E5%BA%93%E5%AD%98%E7%BB%93%E6%9E%9C;dash&e=order;pay;%E5%8F%91%E8%B5%B7%E6%94%AF%E4%BB%98&e=pay;order;%E6%94%AF%E4%BB%98%E6%88%90%E5%8A%9F;dash&e=order;kafka;%E8%AE%A2%E5%8D%95%E5%B7%B2%E5%88%9B%E5%BB%BA)

**5. 思维导图** —— *"把 repoviz 的功能结构画成思维导图。"*

![思维导图图库示例](https://x-cmd.com/draw/mindmap?style=tree&title=repoviz%20%E5%8A%9F%E8%83%BD%E5%85%A8%E6%99%AF&n=repoviz%2F%E5%9B%BE%E8%A1%A8%2F%E6%9E%B6%E6%9E%84%E5%9B%BE&n=repoviz%2F%E5%9B%BE%E8%A1%A8%2F%E6%97%B6%E5%BA%8F%E5%9B%BE&n=repoviz%2F%E5%9B%BE%E8%A1%A8%2F%E6%A1%91%E5%9F%BA%E5%9B%BE&n=repoviz%2F%E5%9B%BE%E8%A1%A8%2F%E6%B5%81%E7%A8%8%E5%9B%BE&n=repoviz%2F%E5%9B%BE%E8%A1%A8%2F%E6%80%9D%E7%BB%B4%E5%AF%BC%E5%9B%BE&n=repoviz%2F%E5%9B%BE%E8%A1%A8%2F%E7%94%98%E7%89%B9%E5%9B%BE&n=repoviz%2F%E5%AF%BC%E5%87%BA%2FSVG&n=repoviz%2F%E5%AF%BC%E5%87%BA%2FPNG&n=repoviz%2F%E5%AF%BC%E5%87%BA%2FHTML%20%E6%8A%A5%E5%91%8A&n=repoviz%2F%E8%BE%93%E5%87%BA%2FMarkdown%20%E9%93%BE%E6%8E%A5)

> 甘特图同样支持中文任务名：把 Mermaid 甘特 DSL 放进 `m=` 参数即可（见 `references/general-charts.md`）。

## 快速安装

```bash
# 通过 skills CLI 安装（适用 Claude Code、Cursor、Windsurf、Codex 等）
npx skills add qiakai/repoviz
```

手动安装——把整个目录拷进对应技能的 skills 目录即可：

```bash
# Claude Code
git clone https://github.com/qiakai/repoviz ~/.claude/skills/repoviz

# Cursor
git clone https://github.com/qiakai/repoviz ~/.cursor/skills/repoviz
```

就这么多：无依赖包、无构建步骤、无需 API Key。导出脚本仅需 POSIX `sh` + `curl`（macOS、Linux、Windows Git Bash 均已内置）。

## 使用提示词（复制即用）

**默认模式——Markdown 链接（不在本地写任何文件）：**

```
把这个仓库的架构画成一张可以嵌进 README 的图。
```

**多图深潜模式：**

```
给这个代码库一份完整的可视化拆解：一张系统架构图、一张数据流桑基图、
以及核心请求链路的时序图。
```

**本地 SVG / PNG 导出：**

```
把架构图画出来，并在本地存成 SVG（再导出一张 2 倍分辨率的 PNG 放幻灯片里）。
```

**独立 HTML 报告：**

```
扫描这个仓库，生成一份独立 HTML 报告，包含架构图、数据流桑基图和你的分析备注，
要支持暗色模式，方便分享给团队。
```

工作原理：agent 依据 `SKILL.md` 的路由表选图，带 token 预算地扫描清单与入口文件，
输出扁平百分号编码的渲染 URL；仅在明确要求时调用 `scripts/export.sh` 或
`scripts/build_html.sh` 做本地导出。

## 仓库结构

```text
repoviz/
├── SKILL.md               # 路由逻辑、扫描规则、输出模板
├── references/            # 按需加载的图表语法指南（示例 URL 全部实测可用）
│   ├── architecture.md    # archmap / arch2 语法：n=、e=、b=
│   ├── flowchart.md       # mermaid 流程图、seq 时序图、lifecycle 状态机
│   ├── sankey.md          # labels=、links=、权重与限制
│   └── general-charts.md  # mindmap、gantt 及仓库度量辅助图
├── scripts/
│   ├── export.sh          # URL → 本地 .svg / .png（curl，支持 CLI 回退）
│   └── build_html.sh      # URL + 备注 → 自包含暗/亮响应式 HTML 报告
└── README.md
```

## 许可证

Apache-2.0——图表可任意嵌入。
