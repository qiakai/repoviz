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

**实时展示** —— 以下图表此刻就在真实渲染（AWS 生产级平台架构与月度云成本归因）：

![repoviz 架构图示例](https://x-cmd.com/draw/arch2?t=shadcn&title=AWS%20%E7%94%9F%E4%BA%A7%E7%BA%A7%20Web%20%E5%B9%B3%E5%8F%B0%E6%9E%B6%E6%9E%84&n=r53;cloud;Route%2053;DNS;r0c0;aws:route53&n=waf;sec;WAF;%E9%98%B2%E6%8A%A4%E8%A7%84%E5%88%99;r0c1&n=cf;cloud;CloudFront;CDN;r0c2;aws:cloudfront&n=s3;db;S3;%E9%9D%99%E6%80%81%E8%B5%84%E6%BA%90;r0c3;aws:s3&n=igw;cloud;Internet%20%E7%BD%91%E5%85%B3;%E5%85%AC%E7%BD%91%E5%85%A5%E5%8F%A3;r1c3;aws:igw&n=alb;cloud;ALB;HTTPS%20443;r1c2;aws:alb&n=api;be;API%20%E6%9C%8D%E5%8A%A1;ECS%20Fargate;r2c0;aws:ecs&n=lam;be;Lambda;%E5%BC%82%E6%AD%A5%E4%BB%BB%E5%8A%A1;r2c1;aws:lambda&n=sqs;bus;SQS;%E6%B6%88%E6%81%AF%E9%98%9F%E5%88%97;r2c2;aws:sqs&n=auth;sec;Cognito;OIDC;r2c3&n=rds;db;RDS;PostgreSQL;r3c0;aws:rds&n=redis;db;ElastiCache;%E4%BC%9A%E8%AF%9D%E7%BC%93%E5%AD%98;r3c1;aws:redis&n=ddb;db;DynamoDB;%E6%95%B0%E6%8D%AE%E9%A1%B9;r3c2;aws:dynamodb&n=os;db;OpenSearch;%E6%A3%80%E7%B4%A2%E7%B4%A2%E5%BC%95;r3c3;aws:opensearch&n=cw;be;CloudWatch;%E7%9B%91%E6%8E%A7%E5%91%8A%E8%AD%A6;r4c1;aws:cloudwatch&n=sns;bus;SNS;%E9%80%9A%E7%9F%A5;r4c2&e=r53;cf;%E5%9F%9F%E5%90%8D%E8%A7%A3%E6%9E%90&e=waf;cf;%E8%BF%87%E6%BB%A4&e=cf;alb;%E8%BD%AC%E5%8F%91;main&e=cf;s3;%E9%9D%99%E6%80%81%E8%B5%84%E6%BA%90&e=igw;alb;%E5%85%AC%E7%BD%91%E6%B5%81%E9%87%8F&e=alb;api;%E8%B7%AF%E7%94%B1;main&e=api;auth;%E9%89%B4%E6%9D%83&e=api;rds;%E6%9F%A5%E8%AF%A2;main&e=api;ddb;%E8%AF%BB%E5%86%99;main&e=api;redis;%E7%BC%93%E5%AD%98&e=api;lam;%E5%85%A5%E9%98%9F&e=lam;sqs;%E6%B6%88%E8%B4%B9&e=sqs;sns;%E9%80%9A%E7%9F%A5&e=lam;os;%E5%BB%BA%E7%B4%A2%E5%BC%95&e=api;cw;OTLP&e=lam;cw;%E6%97%A5%E5%BF%97&b=%E8%BE%B9%E7%BC%98%E5%B1%82;r53%20waf%20cf%20s3%20igw%20alb&b=%E8%AE%A1%E7%AE%97%E5%B1%82;api%20lam%20auth&b=%E6%95%B0%E6%8D%AE%E5%B1%82;rds%20redis%20ddb%20os%20sqs%20sns%20cw)

![repoviz 桑基图示例](https://x-cmd.com/draw?type=sankey&t=fund&labels=%E6%80%BB%E9%A2%84%E7%AE%97,%E8%AE%A1%E7%AE%97,%E5%AD%98%E5%82%A8,%E7%BD%91%E7%BB%9C,%E6%95%B0%E6%8D%AE%E5%B9%B3%E5%8F%B0,%E7%94%9F%E4%BA%A7,ML,%E5%88%86%E6%9E%90,%E5%85%B6%E4%BB%96&links=%E6%80%BB%E9%A2%84%E7%AE%97>%E8%AE%A1%E7%AE%97:42;%E6%80%BB%E9%A2%84%E7%AE%97>%E5%AD%98%E5%82%A8:18;%E6%80%BB%E9%A2%84%E7%AE%97>%E7%BD%91%E7%BB%9C:14;%E6%80%BB%E9%A2%84%E7%AE%97>%E6%95%B0%E6%8D%AE%E5%B9%B3%E5%8F%B0:26;%E8%AE%A1%E7%AE%97>%E7%94%9F%E4%BA%A7:30;%E8%AE%A1%E7%AE%97>ML:12;%E5%AD%98%E5%82%A8>%E7%94%9F%E4%BA%A7:8;%E5%AD%98%E5%82%A8>%E5%85%B6%E4%BB%96:10;%E7%BD%91%E7%BB%9C>%E5%85%B6%E4%BB%96:14;%E6%95%B0%E6%8D%AE%E5%B9%B3%E5%8F%B0>%E5%88%86%E6%9E%90:17;%E6%95%B0%E6%8D%AE%E5%B9%B3%E5%8F%B0>ML:9&title=%E6%9C%88%E5%BA%A6%E4%BA%91%E6%88%90%E6%9C%AC%E5%BD%92%E5%9B%A0&unit=%E5%8D%83%E5%85%83&w=880&h=540)

上图 16 个节点带 AWS 服务图标，shadcn 风格、三层边界——所有方框、图标、连线都只是 URL 里的数据，改一段参数图就重画。

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

![架构图图库示例](https://x-cmd.com/draw/arch2?t=shadcn&title=AWS%20%E7%94%9F%E4%BA%A7%E7%BA%A7%20Web%20%E5%B9%B3%E5%8F%B0%E6%9E%B6%E6%9E%84&n=r53;cloud;Route%2053;DNS;r0c0;aws:route53&n=waf;sec;WAF;%E9%98%B2%E6%8A%A4%E8%A7%84%E5%88%99;r0c1&n=cf;cloud;CloudFront;CDN;r0c2;aws:cloudfront&n=s3;db;S3;%E9%9D%99%E6%80%81%E8%B5%84%E6%BA%90;r0c3;aws:s3&n=igw;cloud;Internet%20%E7%BD%91%E5%85%B3;%E5%85%AC%E7%BD%91%E5%85%A5%E5%8F%A3;r1c3;aws:igw&n=alb;cloud;ALB;HTTPS%20443;r1c2;aws:alb&n=api;be;API%20%E6%9C%8D%E5%8A%A1;ECS%20Fargate;r2c0;aws:ecs&n=lam;be;Lambda;%E5%BC%82%E6%AD%A5%E4%BB%BB%E5%8A%A1;r2c1;aws:lambda&n=sqs;bus;SQS;%E6%B6%88%E6%81%AF%E9%98%9F%E5%88%97;r2c2;aws:sqs&n=auth;sec;Cognito;OIDC;r2c3&n=rds;db;RDS;PostgreSQL;r3c0;aws:rds&n=redis;db;ElastiCache;%E4%BC%9A%E8%AF%9D%E7%BC%93%E5%AD%98;r3c1;aws:redis&n=ddb;db;DynamoDB;%E6%95%B0%E6%8D%AE%E9%A1%B9;r3c2;aws:dynamodb&n=os;db;OpenSearch;%E6%A3%80%E7%B4%A2%E7%B4%A2%E5%BC%95;r3c3;aws:opensearch&n=cw;be;CloudWatch;%E7%9B%91%E6%8E%A7%E5%91%8A%E8%AD%A6;r4c1;aws:cloudwatch&n=sns;bus;SNS;%E9%80%9A%E7%9F%A5;r4c2&e=r53;cf;%E5%9F%9F%E5%90%8D%E8%A7%A3%E6%9E%90&e=waf;cf;%E8%BF%87%E6%BB%A4&e=cf;alb;%E8%BD%AC%E5%8F%91;main&e=cf;s3;%E9%9D%99%E6%80%81%E8%B5%84%E6%BA%90&e=igw;alb;%E5%85%AC%E7%BD%91%E6%B5%81%E9%87%8F&e=alb;api;%E8%B7%AF%E7%94%B1;main&e=api;auth;%E9%89%B4%E6%9D%83&e=api;rds;%E6%9F%A5%E8%AF%A2;main&e=api;ddb;%E8%AF%BB%E5%86%99;main&e=api;redis;%E7%BC%93%E5%AD%98&e=api;lam;%E5%85%A5%E9%98%9F&e=lam;sqs;%E6%B6%88%E8%B4%B9&e=sqs;sns;%E9%80%9A%E7%9F%A5&e=lam;os;%E5%BB%BA%E7%B4%A2%E5%BC%95&e=api;cw;OTLP&e=lam;cw;%E6%97%A5%E5%BF%97&b=%E8%BE%B9%E7%BC%98%E5%B1%82;r53%20waf%20cf%20s3%20igw%20alb&b=%E8%AE%A1%E7%AE%97%E5%B1%82;api%20lam%20auth&b=%E6%95%B0%E6%8D%AE%E5%B1%82;rds%20redis%20ddb%20os%20sqs%20sns%20cw)

**2. 数据与依赖流（桑基图）** —— *"看看上个月的云成本花在了哪里。"*

![桑基图图库示例](https://x-cmd.com/draw?type=sankey&t=fund&labels=%E6%80%BB%E9%A2%84%E7%AE%97,%E8%AE%A1%E7%AE%97,%E5%AD%98%E5%82%A8,%E7%BD%91%E7%BB%9C,%E6%95%B0%E6%8D%AE%E5%B9%B3%E5%8F%B0,%E7%94%9F%E4%BA%A7,ML,%E5%88%86%E6%9E%90,%E5%85%B6%E4%BB%96&links=%E6%80%BB%E9%A2%84%E7%AE%97>%E8%AE%A1%E7%AE%97:42;%E6%80%BB%E9%A2%84%E7%AE%97>%E5%AD%98%E5%82%A8:18;%E6%80%BB%E9%A2%84%E7%AE%97>%E7%BD%91%E7%BB%9C:14;%E6%80%BB%E9%A2%84%E7%AE%97>%E6%95%B0%E6%8D%AE%E5%B9%B3%E5%8F%B0:26;%E8%AE%A1%E7%AE%97>%E7%94%9F%E4%BA%A7:30;%E8%AE%A1%E7%AE%97>ML:12;%E5%AD%98%E5%82%A8>%E7%94%9F%E4%BA%A7:8;%E5%AD%98%E5%82%A8>%E5%85%B6%E4%BB%96:10;%E7%BD%91%E7%BB%9C>%E5%85%B6%E4%BB%96:14;%E6%95%B0%E6%8D%AE%E5%B9%B3%E5%8F%B0>%E5%88%86%E6%9E%90:17;%E6%95%B0%E6%8D%AE%E5%B9%B3%E5%8F%B0>ML:9&title=%E6%9C%88%E5%BA%A6%E4%BA%91%E6%88%90%E6%9C%AC%E5%BD%92%E5%9B%A0&unit=%E5%8D%83%E5%85%83&w=880&h=540)

**3. 执行流程（Agent 循环）** —— *"演示 repoviz 处理一次请求的完整过程。"*

![流程图图库示例](https://x-cmd.com/draw/arch2?t=shadcn&title=repoviz%20%E4%B8%80%E6%AC%A1%E8%AF%B7%E6%B1%82%E7%9A%84%E6%89%A7%E8%A1%8C%E8%BF%87%E7%A8%8B&n=input;fe;%E7%94%A8%E6%88%B7%E8%AF%B7%E6%B1%82;%E4%BB%93%E5%BA%93%E4%B8%8E%E6%84%8F%E5%9B%BE;r0c0&n=scan;be;%E6%89%AB%E6%8F%8F%E4%BB%93%E5%BA%93;%E6%B8%85%E5%8D%95%E4%B8%8E%E5%85%A5%E5%8F%A3;r0c1&n=route;be;%E5%9B%BE%E8%A1%A8%E8%B7%AF%E7%94%B1;%E5%8C%B9%E9%85%8D%E6%84%8F%E5%9B%BE;r0c2&n=build;svc;%E6%9E%84%E9%80%A0%20URL;%E7%BC%96%E7%A0%81%E8%8A%82%E7%82%B9%E4%B8%8E%E8%BE%B9;r0c3&n=guard;sec;%E6%8A%A4%E6%A0%8F%E6%A0%A1%E9%AA%8C;%E9%95%BF%E5%BA%A6%E4%B8%8E%E8%BD%AC%E4%B9%89;r1c3&n=render;svc;%E7%94%9F%E6%88%90%E5%9B%BE%E7%89%87;SVG%20%E8%BE%93%E5%87%BA;r1c2&n=export;svc;%E6%9C%AC%E5%9C%B0%E5%AF%BC%E5%87%BA;SVG%20%C2%B7%20PNG%20%C2%B7%20HTML;r1c1&n=final;fe;%E6%9C%80%E7%BB%88%E7%AD%94%E5%A4%8D;%E5%9B%BE%2B%E9%93%BE%E6%8E%A5%2B%E8%A7%A3%E8%AF%BB;r1c0&n=refs;db;%E8%AF%AD%E6%B3%95%E5%8F%82%E8%80%83;references%2F%2A.md;r2c1&n=notes;svc;%E6%9E%B6%E6%9E%84%E8%A7%A3%E8%AF%BB;%E6%AF%8F%E5%BC%A0%E5%9B%BE%E8%A6%81%E7%82%B9;r2c2&e=input;scan&e=scan;route&e=route;build&e=build;guard&e=guard;render&e=render;export&e=export;final&e=route;refs;%E6%8C%89%E9%9C%80%E5%8A%A0%E8%BD%BD&e=refs;build;%E6%9F%A5%E8%AF%AD%E6%B3%95&e=render;notes&e=notes;final&e=final;input;%E5%8F%8D%E9%A6%88%E8%BF%AD%E4%BB%A3;dash&b=Agent%20%E4%B8%BB%E5%BE%AA%E7%8E%AF;input%20scan%20route%20build%20guard%20render%20export%20final&b=%E7%9F%A5%E8%AF%86%E5%BA%93;refs%20notes)

**4. 时序图** —— *"画出创建订单的接口调用时序。"*

![时序图图库示例](https://x-cmd.com/draw/seq?t=shadcn&title=%E4%B8%8B%E5%8D%95%E9%93%BE%E8%B7%AF%E6%97%B6%E5%BA%8F&n=c;fe;%E5%AE%A2%E6%88%B7%E7%AB%AF;;&n=gw;be;API%20%E7%BD%91%E5%85%B3;;&n=order;be;%E8%AE%A2%E5%8D%95%E6%9C%8D%E5%8A%A1;;&n=pay;be;%E6%94%AF%E4%BB%98%E6%9C%8D%E5%8A%A1;;&n=kafka;bus;%E6%B6%88%E6%81%AF%E9%98%9F%E5%88%97;;&e=c;gw;%E6%8F%90%E4%BA%A4%E8%AE%A2%E5%8D%95&e=gw;order;%E6%A0%A1%E9%AA%8C%E5%BA%93%E5%AD%98&e=order;gw;%E5%BA%93%E5%AD%98%E7%BB%93%E6%9E%9C;dash&e=order;pay;%E5%8F%91%E8%B5%B7%E6%94%AF%E4%BB%98&e=pay;order;%E6%94%AF%E4%BB%98%E6%88%90%E5%8A%9F;dash&e=order;kafka;%E8%AE%A2%E5%8D%95%E5%B7%B2%E5%88%9B%E5%BB%BA)

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
