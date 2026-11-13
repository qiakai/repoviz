<div align="center">

# repoviz

**Turn any codebase into architecture, flowchart, and Sankey diagrams — zero setup, instant Markdown URLs, optional SVG/PNG/HTML export.**

English | [简体中文](README.zh.md)

![Claude Code](https://img.shields.io/badge/Claude%20Code-native-blue)
![Cursor](https://img.shields.io/badge/Cursor-native-blue)
![Windsurf](https://img.shields.io/badge/Windsurf-native-blue)
![Codex CLI](https://img.shields.io/badge/Codex%20CLI-compatible-blue)
![ClawHub](https://img.shields.io/badge/ClawHub-publishable-green)
![skills.sh](https://img.shields.io/badge/skills.sh-installable-green)

</div>

`repoviz` is an agent skill that scans a repository and answers with the right
visualization — an **architecture map**, **Sankey flow**, **flowchart**,
**sequence diagram**, **mind map**, or **Gantt chart** — rendered as a single
embeddable URL. No local installs, no file writes by default; every diagram is a
Markdown image link you can paste into a README, doc, or chat.

**Live showcase** — these render right now, from real URLs (a sample web service and its data pipeline):

![repoviz architecture sample](https://x-cmd.com/draw/archmap?title=Sample%20web%20service&n=user;ext;User;;r0c0&n=cdn;cloud;CDN;;r0c1&n=gw;be;API%20Gateway;rate%20limit;r0c2&n=auth;sec;Auth;JWT;r1c1&n=svc;be;Core%20Service;logic;r1c2&n=pg;db;Postgres;;r2c1&n=redis;db;Redis;cache;r2c2&e=user;cdn;https&e=cdn;gw&e=gw;auth;verify;main&e=gw;svc;route;main&e=auth;svc;claims&e=svc;pg;sql;main&e=svc;redis;cache&b=Data%20Layer;pg%20redis)

![repoviz sankey sample](https://x-cmd.com/draw?type=sankey&t=pipeline&labels=Events,Collector,Stream,Hot%20Store,Cold%20Store,Dashboard,ML%20Pipeline&links=Events>Collector:100;Collector>Stream:96;Stream>Hot%20Store:40;Stream>Cold%20Store:56;Hot%20Store>Dashboard:32;Hot%20Store>ML%20Pipeline:8;Cold%20Store>ML%20Pipeline:30;Cold%20Store>Dashboard:12&title=Data%20pipeline%20flow&unit=GB%2Fday)

### A real-world architecture, rendered from one URL

An 18-node SaaS platform — clients, edge, six services, four data backends, external
providers — grouped into four boundaries. Every box, label, and edge below is data in
the URL; edit any segment and the diagram re-renders:

![repoviz real-world architecture sample](https://x-cmd.com/draw/archmap?title=SaaS%20platform%20architecture&n=web;fe;Web%20App;React;;r0c0&n=app;fe;Mobile%20App;Flutter;;r0c1&n=open;ext;Open%20API;partners;;r0c2&n=cdn;cloud;CDN;edge%20cache;;r0c3&n=gw;be;API%20Gateway;rate%20limit;;r1c0&n=auth;sec;Auth%20Service;JWT%20%C2%B7%20OIDC;;r1c1&n=order;be;Order%20Service;;r1c2&n=pay;be;Payment%20Service;;r1c3&n=notify;svc;Notification%20Service;;r2c0&n=search;be;Search%20Service;;r2c1&n=rec;be;Recommend%20Service;;r2c2&n=pg1;db;Users%20DB;Postgres;;r2c3&n=pg2;db;Orders%20DB;Postgres;;r3c0&n=redis;db;Redis;cache%20%C2%B7%20queue;;r3c1&n=kafka;bus;Kafka;event%20stream;;r3c2&n=oss;cloud;Object%20Storage;S3;;r3c3&n=stripe;ext;Stripe;payments;;r4c0&n=sms;ext;SMS%20Provider;;r4c1&e=web;cdn&e=app;cdn&e=open;gw&e=cdn;gw;route&e=gw;auth;verify;main&e=gw;order;main&e=gw;search&e=gw;rec&e=auth;pg1;users&e=auth;redis;session&e=order;pg2;SQL;main&e=order;redis;cache&e=order;kafka;OrderCreated&e=kafka;notify;subscribe&e=kafka;search;index&e=order;pay;charge;main&e=pay;stripe;API;main&e=order;oss;files&e=notify;sms;SMS&e=rec;redis&b=Clients;web%20app%20open%20cdn&b=Services;gw%20auth%20order%20pay%20notify%20search%20rec&b=Data;pg1%20pg2%20redis%20kafka%20oss&b=External;stripe%20sms)

## Why repoviz?

| | Raw Mermaid | Frontend-Only Generators | **repoviz** |
|---|---|---|---|
| Diagram variety (Sankey / Arch / Flow / Seq / Mindmap / Gantt) | Flow + Seq only | Usually one fixed type | **All six, auto-routed per intent** |
| Local dependencies | JS runtime or CLI install | Node + browser toolchain | **Zero — URLs render in any Markdown viewer** |
| Token efficiency | Verbose DSL per diagram | Full AST dumps | **Flat, readable URL params; agent reads 1 manifest, not 100 files** |
| Markdown / README readiness | Needs a renderer on the viewer side | Export step required | **Paste the URL — done** |
| Offline export (SVG / PNG / HTML) | CLI only | Often paid/watermarked | **One `sh` script call each, POSIX + curl only** |

## Chart gallery

Copy a prompt, drop it in your agent (with repoviz installed), and it scans + routes + answers with a live diagram:

**1. System architecture** — *"Visualize this repo's architecture."*

![Architecture gallery](https://x-cmd.com/draw/archmap?title=Sample%20web%20service&n=user;ext;User;;r0c0&n=cdn;cloud;CDN;;r0c1&n=gw;be;API%20Gateway;rate%20limit;r0c2&n=auth;sec;Auth;JWT;r1c1&n=svc;be;Core%20Service;logic;r1c2&n=pg;db;Postgres;;r2c1&n=redis;db;Redis;cache;r2c2&e=user;cdn;https&e=cdn;gw&e=gw;auth;verify;main&e=gw;svc;route;main&e=auth;svc;claims&e=svc;pg;sql;main&e=svc;redis;cache&b=Data%20Layer;pg%20redis)

**2. Data & dependency flow (Sankey)** — *"Trace how data flows through this pipeline."*

![Sankey gallery](https://x-cmd.com/draw?type=sankey&t=pipeline&labels=Events,Collector,Stream,Hot%20Store,Cold%20Store,Dashboard,ML%20Pipeline&links=Events>Collector:100;Collector>Stream:96;Stream>Hot%20Store:40;Stream>Cold%20Store:56;Hot%20Store>Dashboard:32;Hot%20Store>ML%20Pipeline:8;Cold%20Store>ML%20Pipeline:30;Cold%20Store>Dashboard:12&title=Data%20pipeline%20flow&unit=GB%2Fday)

**3. Request / execution flowchart** — *"Draw the auth flow as a flowchart."*

![Flowchart gallery](https://x-cmd.com/draw/mermaid?m=graph%20TD%3B%20U%5BLogin%5D--%3EV%7Bvalid%20token%3F%7D%3B%20V--%3EG%5BGrant%20access%5D%3B%20V--%3ED%5BDeny%5D&title=Auth%20flow)

**4. Sequence diagram** — *"Show the API handshake sequence for creating an order."*

![Sequence gallery](https://x-cmd.com/draw/seq?title=API%20handshake&n=c;fe;Client&n=g;be;API%20Gateway&n=a;sec;Auth&n=s;be;Service&e=c;g;POST%20%2Forders&e=g;a;verify%20token&e=a;g;claims;dash&e=g;s;forward&e=s;g;201%20Created;dash)

## Quick installation

```bash
# Install via the skills CLI (works with Claude Code, Cursor, Windsurf, Codex, ...)
npx skills add qiakai/repoviz
```

Manual install — just copy the folder into your agent's skills directory:

```bash
# Claude Code
git clone https://github.com/qiakai/repoviz ~/.claude/skills/repoviz

# Cursor
git clone https://github.com/qiakai/repoviz ~/.cursor/skills/repoviz
```

That's it: no packages, no build step, no API keys. The export scripts need only
POSIX `sh` + `curl` (both already on macOS, Linux, and Windows Git Bash).

## Usage prompts (copy & paste)

**Default — Markdown URL mode (writes nothing locally):**

```
Visualize this repo's architecture as a diagram I can embed in the README.
```

**Multi-chart deep-dive:**

```
Give me a full visual breakdown of this codebase: a system architecture diagram,
a Sankey of the data flow, and a sequence diagram of the main request lifecycle.
```

**Local SVG / PNG export:**

```
Map the architecture and save it locally as an SVG (also a PNG at 2x for the slides).
```

**Standalone HTML report:**

```
Scan this repo and generate a standalone HTML report with the architecture,
data-flow Sankey, and your notes — dark mode aware, for sharing with the team.
```

Under the hood the agent picks the right chart type (routing table in
`SKILL.md`), scans manifests and entry points with a token budget, and emits
flat percent-encoded render URLs — plus, only on request, runs
`scripts/export.sh` or `scripts/build_html.sh`.

## Repository layout

```text
repoviz/
├── SKILL.md               # routing logic, scanning rules, output templates
├── references/            # lazy-loaded per-diagram syntax guides (all URLs live-tested)
│   ├── architecture.md    # archmap / arch2 grammar: n=, e=, b=
│   ├── flowchart.md       # mermaid flowchart, seq, lifecycle
│   ├── sankey.md          # labels=, links=, weights, limits
│   └── general-charts.md  # mindmap, gantt, auxiliary repo-metric charts
├── scripts/
│   ├── export.sh          # URL → local .svg / .png (curl, with CLI fallback)
│   └── build_html.sh      # URLs + notes → standalone dark/light HTML report
└── README.md
```

## License

Apache-2.0 — embed the diagrams anywhere.
