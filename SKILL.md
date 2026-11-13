---
name: repoviz
description: >
  Scan any codebase or logic and instantly generate rich visual diagrams—including
  architecture diagrams, flowcharts, Sankey diagrams, sequence diagrams, and mind maps—via
  zero-dependency cloud rendering URLs. Outputs ready-to-embed Markdown links by default,
  with on-demand export to local SVG, PNG, or standalone interactive HTML reports.
  Use when the user asks to visualize a repo, map architecture, trace data flows,
  draw a flowchart/Sankey/sequence diagram, or document system design.
---

# repoviz

Turn a codebase into render-ready diagram URLs. Every diagram is a single
`https://x-cmd.com/draw` URL (flat, percent-encoded parameters) that renders SVG in
browsers, GitHub READMEs, and any Markdown viewer. Default mode writes **no local
files**; local export happens only on explicit request via `scripts/`.

## Step 1 — Intent Analysis & Chart Routing

Pick diagram type(s) from intent + repo shape. Read **only** the matching
`references/` file before constructing that diagram.

| User intent | Diagram | Reference |
|---|---|---|
| System overview, folder hierarchy, microservices, tech stack | Architecture map (`/draw/archmap`) | `references/architecture.md` |
| Request lifecycle, function call chains, API handshakes | Sequence diagram (`/draw/seq`) | `references/flowchart.md` |
| Branching logic, algorithms, auth/pipeline stages | Flowchart (`/draw/mermaid`) | `references/flowchart.md` |
| State machines, statuses, retry/rollback | Lifecycle (`/draw/lifecycle`) | `references/flowchart.md` |
| Data pipelines, dependency/bundle weights, traffic routing | Sankey (`?type=sankey`) | `references/sankey.md` |
| Feature trees, module taxonomy | Mind map (`/draw/mindmap`) | `references/general-charts.md` |
| Roadmaps, schedules, release plans | Gantt (`/draw/gantt`) | `references/general-charts.md` |
| Quantitative repo metrics (language split, coverage, growth) | Data charts (`?type=pie|hbar|gauge|combo|...`) | `references/general-charts.md` |
| Broad "visualize this repo" | **Multi-diagram suite**: 1 `archmap` overview + 1 Sankey (data/dependency flow) or `seq` (core request flow) | the two matching references |

Other node/edge endpoints with the same grammar as `archmap` (see
`references/architecture.md`): `arch2` (alt architecture skin), `uc` (use case:
`actor`/`uc`), `dataflow` (`process`/`store`/`source`/`sink`), `erd` (`table`/`view`),
`class` (`class`/`iface`/`enum`). Long-tail charts (treemap, funnel, graph, ...):
`/draw/echarts?d=<url-encoded echarts option JSON>`.

## Step 2 — Token-Disciplined Codebase Scanning

1. Read root manifests first: `package.json`, `go.mod`, `Cargo.toml`,
   `pyproject.toml`, `docker-compose.yml`, plus a directory tree to depth 3 and the
   declared entry points.
2. Never read every source file. Sample entry-point files and route tables; summarize
   components into high-signal nodes and edges.
3. Derive Sankey weights from real quantities where possible: file sizes (`du -sh`),
   import/reference counts, or traffic/cost figures the user supplies.
4. **URL length guardrail**: keep one diagram to ~15–20 nodes (~60 links for Sankey)
   so URLs stay readable and inside CDN limits. For large repos, emit a high-level
   overview diagram + one diagram per subsystem, never a single dense mega-diagram.

## Step 3 — Construct the URL

- Grammar (nodes/edges/boundaries), encoding table, worked examples, and per-type
  limits live in the reference files. Follow them exactly; every example there is
  live-tested.
- Encoding essentials: space `%20`, `+` `%2B`, `&` `%26`, `#` `%23`, `<`/`>` `%3C`/`%3E`,
  newline `%0A`; separators `;` `=` `,` `:` `/` `@` stay literal. No Base64.
- Common modifiers: `title=`, `scheme=dark|light`, `t=<style>` (per-type families in
  references — arch2/seq look best with `t=shadcn`; arch2 nodes take an optional 6th
  `icon` field, e.g. `n=api;be;API;ECS;r2c0;aws:ecs`), `w=`/`h=`, `v=N` to pin a cached
  version, `num=all|peak|none` (charts).
- PNG output embeds a GB2312 level-1 CJK subset: rare characters (e.g. `渲`) become
  tofu in PNG. SVG has no such limit — prefer common synonyms for Chinese PNG labels.
- On a 4xx, the response body is plain text with a correction example — read it,
  fix the offending parameter, retry. Never guess twice.

## Step 4 — Output Delivery

**Default mode — no file writes.** Reply with, per diagram:

```markdown
### <Diagram title>
![<title>](<draw-url>)
*[Interactive preview](<draw-url>)* · [Open in editor](<explore-url>)

- <bullet: what the diagram shows — tiers, critical path, heaviest flows>
- <bullet: notable coupling / single points of failure / ownership boundaries>
```

- `<explore-url>` rewrites the render URL for interactive editing: path
  `/draw?type=X&q` → `/draw/explore?type=X&q`; `/draw/<name>?q` → `/draw/explore/<name>?q`.
- 2–5 tight bullets per diagram. The image is the deliverable; bullets add judgment.

**Export mode — only when the user explicitly says** "save locally", "download
SVG/PNG", "export image", or "generate HTML report":

```sh
bash scripts/export.sh "<draw-url>" "<out.svg|png>"   # downloads rendered file
bash scripts/build_html.sh "<title>" "<out.html>" '<json>'  # standalone report
```

- `export.sh` appends `format=png` automatically for `.png` targets (add `&scale=2`
  or `3` to the URL for higher resolution; pass `scheme=dark` explicitly for PNG,
  whose scheme defaults to light).
- `build_html.sh` takes a JSON array of `{"title","url","note"}` objects and emits a
  self-contained dark/light responsive report with sidebar nav, zoom, fullscreen, and
  copy-URL buttons. Example payload:
  `[{"title":"Architecture","url":"https://x-cmd.com/draw/archmap?...","note":"3 tiers; gateway is the single entry"}]`
- After exporting, print the saved path(s) and continue to output the Markdown block
  for the chat so the user gets both.

## Rules

- Brand-neutral: present results as repoviz diagrams; never rename or wrap the
  render URLs.
- One scan, many diagrams: reuse the node inventory across the suite instead of
  re-reading the repo per diagram.
- Prefer fewer, well-chosen nodes over completeness; collapse details into `sub`
  captions and boundary boxes.
