// Procedural die-shot visual — used for the homepage banner and as a dim
// background inside each timeline item. All instances share one global
// pointer so the whole page feels like a single tilted wafer.

// ---- Shared pointer / render scheduler ----
const pointer = { x: 0, y: 0, tx: 0, ty: 0 };
const dies = [];
let easing = false;
let visibleDies = new Set();

function easeLoop() {
  pointer.x += (pointer.tx - pointer.x) * 0.2;
  pointer.y += (pointer.ty - pointer.y) * 0.2;
  for (const d of dies) {
    if (d.reactive && visibleDies.has(d)) d.render();
  }
  if (Math.abs(pointer.tx - pointer.x) > 0.4 ||
      Math.abs(pointer.ty - pointer.y) > 0.4) {
    requestAnimationFrame(easeLoop);
  } else {
    easing = false;
  }
}

function kickEase() {
  if (!easing) {
    easing = true;
    requestAnimationFrame(easeLoop);
  }
}

function onPointer(e) {
  pointer.tx = e.clientX;
  pointer.ty = e.clientY;
  kickEase();
}

// ---- PRNG ----
function mulberry32(a) {
  return function () {
    a = (a + 0x6D2B79F5) | 0;
    let t = a;
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

function getTheme() {
  const cs = getComputedStyle(document.body);
  const read = (v, f) => (cs.getPropertyValue(v).trim() || f);
  return {
    bg: read('--bg-color', '#fdfefa'),
    bgVar: read('--bg-variant', '#e8e5ea'),
    primary: read('--primary', '#3C5100'),
    primaryVar: read('--primary-variant', '#3C5100'),
    secondary: read('--secondary', '#704C8F'),
    dark: document.body.classList.contains('dark'),
  };
}

// ---- Shader (iridescent or flat theme colors) ----
function makeShade(mouse, theme, iridescent) {
  if (!iridescent) {
    return function (x, y, role) {
      if (role === 'primary') return theme.primary;
      if (role === 'bright') return theme.primaryVar;
      return theme.secondary;
    };
  }
  const dark = theme.dark;
  return function (x, y, role) {
    const dx = x - mouse.x;
    const dy = y - mouse.y;
    const angle = Math.atan2(dy, dx);
    const dist = Math.hypot(dx, dy);
    let hue = (angle * 180 / Math.PI + dist * 0.45 + 360) % 360;
    const falloff = Math.max(0, 1 - dist / 450);
    let sat, light;
    if (role === 'primary') {
      hue = (hue + 18) % 360;
      sat = dark ? 42 : 32;
      light = (dark ? 55 : 42) + falloff * 6;
    } else if (role === 'bright') {
      sat = dark ? 50 : 38;
      light = (dark ? 65 : 50) + falloff * 8;
    } else {
      hue = (hue + 60) % 360;
      sat = dark ? 30 : 22;
      light = (dark ? 52 : 40) + falloff * 5;
    }
    return `hsl(${hue.toFixed(1)},${sat.toFixed(0)}%,${light.toFixed(0)}%)`;
  };
}

// ---- Floorplan BSP ----
// maxArea caps any single leaf's footprint — oversized rects are forced to
// keep splitting (ignoring the early-stop roll and depth budget) until they
// either fit the cap or hit the minSize floor.
function splitRect(rect, depth, minSize, rng, out, maxArea = Infinity) {
  const area = rect.w * rect.h;
  const canW = rect.w >= minSize * 2;
  const canH = rect.h >= minSize * 2;
  const tooBig = area > maxArea;
  const stopChance = Math.min(0.55, 0.04 + (6 - depth) * 0.09);
  if (!canW && !canH) {
    // No room to split further — accept even if too big.
    out.push(rect);
    return;
  }
  if (!tooBig && (depth <= 0 || rng() < stopChance)) {
    out.push(rect);
    return;
  }
  let horiz;
  if (canW && !canH) horiz = true;
  else if (!canW && canH) horiz = false;
  else horiz = rect.w > rect.h ? (rng() < 0.78) : (rng() < 0.22);
  const t = 0.28 + rng() * 0.44;
  if (horiz) {
    const cut = Math.round(rect.w * t);
    splitRect({ x: rect.x, y: rect.y, w: cut, h: rect.h }, depth - 1, minSize, rng, out, maxArea);
    splitRect({ x: rect.x + cut, y: rect.y, w: rect.w - cut, h: rect.h }, depth - 1, minSize, rng, out, maxArea);
  } else {
    const cut = Math.round(rect.h * t);
    splitRect({ x: rect.x, y: rect.y, w: rect.w, h: cut }, depth - 1, minSize, rng, out, maxArea);
    splitRect({ x: rect.x, y: rect.y + cut, w: rect.w, h: rect.h - cut }, depth - 1, minSize, rng, out, maxArea);
  }
}

// ---- Interior patterns ----
function pSMArray(ctx, b, rng, shade) {
  const tile = 14 + Math.floor(rng() * 12);
  const cols = Math.max(1, Math.floor(b.iw / tile));
  const rows = Math.max(1, Math.floor(b.ih / tile));
  const tw = b.iw / cols;
  const th = b.ih / rows;
  for (let i = 0; i < cols; i++) {
    for (let j = 0; j < rows; j++) {
      const x = b.ix + i * tw;
      const y = b.iy + j * th;
      const cx = x + tw / 2, cy = y + th / 2;
      ctx.lineWidth = 0.6;
      ctx.strokeStyle = shade(cx, cy, 'secondary');
      ctx.strokeRect(x + 1.5, y + 1.5, tw - 3, th - 3);
      ctx.strokeStyle = shade(cx + 3, cy + 3, 'secondary');
      ctx.strokeRect(x + 3.5, y + 3.5, tw - 7, th - 7);
      const cs = Math.max(2, Math.min(tw, th) * 0.28);
      ctx.fillStyle = shade(cx, cy, 'bright');
      ctx.fillRect(cx - cs / 2, cy - cs / 2, cs, cs);
      const d = 1.3;
      ctx.fillStyle = shade(x + 3, y + 3, 'primary');
      ctx.fillRect(x + 3, y + 3, d, d);
      ctx.fillStyle = shade(x + tw - 4, y + 3, 'primary');
      ctx.fillRect(x + tw - 3 - d, y + 3, d, d);
      ctx.fillStyle = shade(x + 3, y + th - 4, 'primary');
      ctx.fillRect(x + 3, y + th - 3 - d, d, d);
      ctx.fillStyle = shade(x + tw - 4, y + th - 4, 'primary');
      ctx.fillRect(x + tw - 3 - d, y + th - 3 - d, d, d);
      if (tw > 12 && th > 12) {
        ctx.lineWidth = 0.4;
        for (let yy = y + 6; yy < y + th - 6; yy += 2) {
          ctx.strokeStyle = shade(cx, yy, 'secondary');
          ctx.beginPath();
          ctx.moveTo(x + 6, yy + 0.5);
          ctx.lineTo(x + tw - 6, yy + 0.5);
          ctx.stroke();
        }
      }
    }
  }
}

function pMetalH(ctx, b, rng, shade) {
  const gap = 2 + Math.floor(rng() * 2);
  ctx.lineWidth = 0.6;
  for (let y = b.iy + 2; y < b.iy + b.ih - 2; y += gap) {
    ctx.strokeStyle = shade(b.ix + b.iw / 2, y, 'secondary');
    ctx.beginPath();
    ctx.moveTo(b.ix + 1, y + 0.5);
    ctx.lineTo(b.ix + b.iw - 1, y + 0.5);
    ctx.stroke();
  }
  const cols = Math.max(2, Math.floor(b.iw / 10));
  for (let i = 1; i < cols; i++) {
    const x = b.ix + i * (b.iw / cols);
    ctx.fillStyle = shade(x, b.iy + b.ih / 2, 'primary');
    ctx.fillRect(x - 0.5, b.iy + 2, 1.2, b.ih - 4);
  }
}

function pMetalV(ctx, b, rng, shade) {
  const gap = 2 + Math.floor(rng() * 2);
  ctx.lineWidth = 0.6;
  for (let x = b.ix + 2; x < b.ix + b.iw - 2; x += gap) {
    ctx.strokeStyle = shade(x, b.iy + b.ih / 2, 'secondary');
    ctx.beginPath();
    ctx.moveTo(x + 0.5, b.iy + 1);
    ctx.lineTo(x + 0.5, b.iy + b.ih - 1);
    ctx.stroke();
  }
  const rows = Math.max(2, Math.floor(b.ih / 10));
  for (let i = 1; i < rows; i++) {
    const y = b.iy + i * (b.ih / rows);
    ctx.fillStyle = shade(b.ix + b.iw / 2, y, 'primary');
    ctx.fillRect(b.ix + 2, y - 0.5, b.iw - 4, 1.2);
  }
}

function pSRAM(ctx, b, rng, shade) {
  const cw = 4 + Math.floor(rng() * 2);
  const ch = 3 + Math.floor(rng() * 2);
  ctx.lineWidth = 0.45;
  for (let y = b.iy + 3; y < b.iy + b.ih - 2; y += ch) {
    const rowColor = shade(b.ix + b.iw / 2, y + ch / 2, 'secondary');
    ctx.strokeStyle = rowColor;
    for (let x = b.ix + 3; x < b.ix + b.iw - 2; x += cw) {
      ctx.strokeRect(x + 0.5, y + 0.5, cw - 1, ch - 1);
    }
  }
  ctx.fillStyle = shade(b.ix + 2, b.iy + b.ih / 2, 'bright');
  ctx.fillRect(b.ix + 1, b.iy + 2, 2, b.ih - 4);
}

function pNested(ctx, b, rng, shade) {
  ctx.lineWidth = 0.6;
  const layers = 2 + Math.floor(rng() * 3);
  for (let i = 1; i <= layers; i++) {
    const off = 1 + i * 3;
    if (b.iw - off * 2 < 4 || b.ih - off * 2 < 4) break;
    ctx.strokeStyle = shade(b.ix + b.iw / 2, b.iy + b.ih / 2, 'secondary');
    ctx.strokeRect(b.ix + off + 0.5, b.iy + off + 0.5, b.iw - off * 2 - 1, b.ih - off * 2 - 1);
  }
  const innerX = b.ix + 8;
  const innerY = b.iy + 8;
  const innerW = b.iw - 16;
  const innerH = b.ih - 16;
  if (innerW > 6 && innerH > 6) {
    const step = 4;
    for (let y = innerY; y < innerY + innerH; y += step) {
      for (let x = innerX; x < innerX + innerW; x += step) {
        ctx.fillStyle = shade(x, y, 'primary');
        ctx.fillRect(x, y, 1.5, 1.5);
      }
    }
  }
}

function pDecap(ctx, b, rng, shade) {
  const step = 3 + Math.floor(rng() * 2);
  for (let y = b.iy + 3; y < b.iy + b.ih - 2; y += step) {
    const rowColor = shade(b.ix + b.iw / 2, y, 'secondary');
    ctx.fillStyle = rowColor;
    for (let x = b.ix + 3; x < b.ix + b.iw - 2; x += step) {
      ctx.fillRect(x, y, 1.5, 1.5);
    }
  }
}

function pPads(ctx, b, rng, shade) {
  const horiz = b.iw > b.ih;
  const minor = horiz ? b.ih : b.iw;
  const major = horiz ? b.iw : b.ih;
  // Fill the minor axis — pads should look like a strip of IO cells, not
  // small squares floating in empty margin.
  const size = Math.max(3, minor - 3);
  const padLen = size * (1.1 + rng() * 0.4);
  const gap = 1 + Math.floor(rng() * 2);
  const step = padLen + gap;
  const count = Math.max(1, Math.floor((major - 2) / step));
  const usedLen = count * padLen + (count - 1) * gap;
  const majorStart = (horiz ? b.ix : b.iy) + (major - usedLen) / 2;
  const minorOff = (minor - size) / 2;
  for (let i = 0; i < count; i++) {
    const pos = majorStart + i * step;
    const x = horiz ? pos : b.ix + minorOff;
    const y = horiz ? b.iy + minorOff : pos;
    const w = horiz ? padLen : size;
    const h = horiz ? size : padLen;
    const cx = x + w / 2, cy = y + h / 2;
    ctx.fillStyle = shade(cx, cy, 'primary');
    ctx.fillRect(x, y, w, h);
    ctx.strokeStyle = shade(cx, cy, 'bright');
    ctx.lineWidth = 0.5;
    ctx.strokeRect(x + 0.5, y + 0.5, w - 1, h - 1);
  }
}

function pDecoder(ctx, b, rng, shade) {
  let y = b.iy + 2;
  let thick = rng() < 0.5;
  while (y < b.iy + b.ih - 2) {
    const h = thick ? 2 + Math.floor(rng() * 2) : 1;
    ctx.fillStyle = shade(b.ix + b.iw / 2, y + h / 2, 'secondary');
    ctx.fillRect(b.ix + 2, y, b.iw - 4, h);
    y += h + 1;
    thick = !thick;
  }
  const step = 5 + Math.floor(rng() * 3);
  for (let x = b.ix + 4; x < b.ix + b.iw - 2; x += step) {
    ctx.fillStyle = shade(x, b.iy + b.ih / 2, 'primary');
    ctx.fillRect(x, b.iy + 2, 1, b.ih - 4);
  }
}

function pMixed(ctx, b, rng, shade, minSize) {
  const subs = [];
  splitRect({ x: b.ix, y: b.iy, w: b.iw, h: b.ih }, 3, Math.max(8, minSize * 0.6), rng, subs);
  for (const s of subs) {
    const sub = {
      ix: s.x + 1, iy: s.y + 1,
      iw: Math.max(4, s.w - 2), ih: Math.max(4, s.h - 2),
    };
    const kind = pickPattern(sub, rng, true);
    ctx.save();
    ctx.beginPath();
    ctx.rect(sub.ix, sub.iy, sub.iw, sub.ih);
    ctx.clip();
    ctx.strokeStyle = shade(sub.ix + sub.iw / 2, sub.iy + sub.ih / 2, 'secondary');
    ctx.lineWidth = 0.5;
    ctx.strokeRect(sub.ix + 0.5, sub.iy + 0.5, sub.iw - 1, sub.ih - 1);
    drawPattern(ctx, sub, rng, shade, kind, minSize);
    ctx.restore();
  }
}

const PATTERNS = {
  sm: pSMArray, mh: pMetalH, mv: pMetalV, sram: pSRAM,
  nested: pNested, decap: pDecap, pads: pPads, decoder: pDecoder,
};

const BLOCK_LABELS = [
  'ALU', 'L1$', 'L2$', 'SRAM', 'REGS', 'CTRL', 'FPU', 'MMU',
  'DMA', 'FIFO', 'ROB', 'TLB', 'SM', 'PCIE', 'DECODE', 'FETCH',
  'ISSUE', 'VEC', 'XBAR', 'NoC', 'LSU', 'SFU', 'TENSOR', 'RT',
];

function drawPattern(ctx, b, rng, shade, kind, minSize) {
  if (kind === 'mixed') return pMixed(ctx, b, rng, shade, minSize);
  const fn = PATTERNS[kind];
  if (fn) fn(ctx, b, rng, shade);
}

function pickPattern(b, rng, noMixed) {
  const aspect = b.iw / Math.max(1, b.ih);
  const area = b.iw * b.ih;
  // Extreme horizontal strip — pads fit here and read like IO cells.
  if (aspect > 5) {
    const r = rng();
    if (r < 0.4) return 'pads';
    if (r < 0.7) return 'mh';
    return 'decoder';
  }
  if (aspect < 0.2) {
    const r = rng();
    if (r < 0.4) return 'pads';
    if (r < 0.7) return 'mv';
    return 'sram';
  }
  // Moderately long strip — stripes only, no pads.
  if (aspect > 3.2) {
    const r = rng();
    if (r < 0.55) return 'mh';
    return 'decoder';
  }
  if (aspect < 0.32) {
    const r = rng();
    if (r < 0.55) return 'mv';
    return 'sram';
  }
  if (area > 9000 && !noMixed) {
    return rng() < 0.6 ? 'sm' : 'mixed';
  }
  const r = rng();
  if (r < 0.28) return 'nested';
  if (r < 0.55) return 'sram';
  if (r < 0.72) return 'decap';
  if (r < 0.86) return 'sm';
  return 'decoder';
}

// Splits `outer` into up to 4 strips that tile around `reserved`, leaving
// the reserved region as a hole in the layout.
function carveAround(outer, r) {
  if (!r) return [outer];
  const oR = outer.x + outer.w;
  const oB = outer.y + outer.h;
  const cx = Math.max(outer.x, r.x);
  const cy = Math.max(outer.y, r.y);
  const cR = Math.min(oR, r.x + r.w);
  const cB = Math.min(oB, r.y + r.h);
  if (cx >= cR || cy >= cB) return [outer];
  const strips = [];
  if (cy > outer.y)
    strips.push({ x: outer.x, y: outer.y, w: outer.w, h: cy - outer.y });
  if (cB < oB)
    strips.push({ x: outer.x, y: cB, w: outer.w, h: oB - cB });
  if (cx > outer.x)
    strips.push({ x: outer.x, y: cy, w: cx - outer.x, h: cB - cy });
  if (cR < oR)
    strips.push({ x: cR, y: cy, w: oR - cR, h: cB - cy });
  return strips;
}

// ---- Pins + wires ----
// evenSpacing: if true, pins are distributed at a fixed pitch (PCB-style
// equally-spaced), ignoring the random density roll.
function placePins(b, rng, density = 1, evenSpacing = false) {
  const GRID = 6;
  const PITCH = 11; // evenly-spaced pin pitch in px
  const pins = [];
  for (const side of ['t', 'b', 'l', 'r']) {
    const axis = (side === 't' || side === 'b') ? b.iw : b.ih;
    if (axis < GRID * 2 + 4) {
      const p = { side };
      if (side === 't') { p.x = b.ix + b.iw / 2; p.y = b.iy; }
      else if (side === 'b') { p.x = b.ix + b.iw / 2; p.y = b.iy + b.ih; }
      else if (side === 'l') { p.x = b.ix; p.y = b.iy + b.ih / 2; }
      else { p.x = b.ix + b.iw; p.y = b.iy + b.ih / 2; }
      pins.push(p);
      continue;
    }
    let positions = [];
    if (evenSpacing) {
      // Bus-style cluster: tight pitch, centered on the side, capped
      // count so the pins read as a bundled multi-lane bus.
      const BUS_PITCH = 5;
      const MAX_LANES = 14;
      const usable = Math.max(0, axis - GRID * 2);
      const maxFit = Math.floor(usable / BUS_PITCH) + 1;
      const n = Math.max(2, Math.min(MAX_LANES, maxFit));
      const clusterLen = (n - 1) * BUS_PITCH;
      const start = GRID + (usable - clusterLen) / 2;
      for (let i = 0; i < n; i++) positions.push(start + i * BUS_PITCH);
    } else {
      const base = 1 + Math.floor(rng() * 3);
      const n = Math.max(1, Math.min(6, Math.floor(base * density)));
      for (let i = 0; i < n; i++) {
        positions.push(GRID + rng() * (axis - GRID * 2));
      }
    }
    for (const t of positions) {
      const p = { side };
      if (side === 't') { p.x = b.ix + t; p.y = b.iy; }
      else if (side === 'b') { p.x = b.ix + t; p.y = b.iy + b.ih; }
      else if (side === 'l') { p.x = b.ix; p.y = b.iy + t; }
      else { p.x = b.ix + b.iw; p.y = b.iy + t; }
      p.x = Math.round(p.x);
      p.y = Math.round(p.y);
      pins.push(p);
    }
  }
  return pins;
}

function extendPin(p, len) {
  if (p.side === 't') return { x: p.x, y: p.y - len };
  if (p.side === 'b') return { x: p.x, y: p.y + len };
  if (p.side === 'l') return { x: p.x - len, y: p.y };
  return { x: p.x + len, y: p.y };
}

function routeManhattan(p1, p2, e1len, e2len, hFirst) {
  const e1 = extendPin(p1, e1len);
  const e2 = extendPin(p2, e2len);
  const mid = hFirst ? { x: e2.x, y: e1.y } : { x: e1.x, y: e2.y };
  return [p1, e1, mid, e2, p2];
}

// Does the axis-aligned segment (a,b) cross the interior of `block`?
// A 0.5px inset lets segments graze block edges (channel routing) without
// counting as a crossing.
function segmentHitsBlock(a, b, block) {
  const pad = 0.5;
  const bx1 = block.ix + pad;
  const by1 = block.iy + pad;
  const bx2 = block.ix + block.iw - pad;
  const by2 = block.iy + block.ih - pad;
  if (a.y === b.y) {
    const y = a.y;
    if (y <= by1 || y >= by2) return false;
    const xmin = Math.min(a.x, b.x);
    const xmax = Math.max(a.x, b.x);
    return xmax > bx1 && xmin < bx2;
  }
  if (a.x === b.x) {
    const x = a.x;
    if (x <= bx1 || x >= bx2) return false;
    const ymin = Math.min(a.y, b.y);
    const ymax = Math.max(a.y, b.y);
    return ymax > by1 && ymin < by2;
  }
  return false;
}

function pointInsideAnyBlock(pt, blocks) {
  const pad = 0.5;
  for (const blk of blocks) {
    if (pt.x > blk.ix + pad && pt.x < blk.ix + blk.iw - pad &&
        pt.y > blk.iy + pad && pt.y < blk.iy + blk.ih - pad) {
      return true;
    }
  }
  return false;
}

// Validates every segment against every block. Pins sit exactly on block
// edges, which the pad=0.5 interior inset already exempts — no need to
// ignore source/dest blocks (that was masking wires re-entering them).
function pathIsClear(path, blocks) {
  for (let i = 1; i < path.length; i++) {
    for (const blk of blocks) {
      if (segmentHitsBlock(path[i - 1], path[i], blk)) return false;
    }
  }
  return true;
}

function buildWires(blocks, rng) {
  const wires = [];
  const seen = new Set();
  const DEFAULT_ATTEMPTS = 14;

  // Normal pass — skip anything involving the title block.
  for (const b of blocks) {
    if (b.isTitle) continue;
    const near = blocks
      .filter(o => o !== b && !o.isTitle)
      .map(o => ({
        o,
        d: Math.hypot((o.x + o.w / 2) - (b.x + b.w / 2),
                      (o.y + o.h / 2) - (b.y + b.h / 2))
      }))
      .sort((a, c) => a.d - c.d)
      .slice(0, 4 + Math.floor(rng() * 2));
    for (const { o } of near) {
      const key = b.id < o.id ? `${b.id}-${o.id}` : `${o.id}-${b.id}`;
      if (seen.has(key)) continue;
      if (!b.pins.length || !o.pins.length) continue;
      let chosen = null;
      for (let i = 0; i < DEFAULT_ATTEMPTS; i++) {
        const p1 = b.pins[Math.floor(rng() * b.pins.length)];
        const p2 = o.pins[Math.floor(rng() * o.pins.length)];
        const e1len = 3 + rng() * 4;
        const e2len = 3 + rng() * 4;
        const hFirst = rng() < 0.5;
        const path = routeManhattan(p1, p2, e1len, e2len, hFirst);
        if (pointInsideAnyBlock(path[1], blocks)) continue;
        if (pointInsideAnyBlock(path[3], blocks)) continue;
        if (pathIsClear(path, blocks)) {
          chosen = { path, thick: rng() < 0.12 };
          break;
        }
      }
      if (!chosen) continue;
      seen.add(key);
      wires.push(chosen);
    }
  }

  // Dedicated title pass — densely connects the title block, allowing
  // multiple wires per target (via different pins) for a hub feel.
  const title = blocks.find(b => b.isTitle);
  if (title && title.pins.length) {
    const targets = blocks
      .filter(o => !o.isTitle && o.pins.length)
      .map(o => ({
        o,
        d: Math.hypot((o.x + o.w / 2) - (title.x + title.w / 2),
                      (o.y + o.h / 2) - (title.y + title.h / 2))
      }))
      .sort((a, c) => a.d - c.d)
      .map(x => x.o);
    if (targets.length) {
      const TITLE_TARGET_WIRES = 32 + Math.floor(rng() * 8); // 32–39
      const MAX_ITERS = 800;
      const TITLE_PATH_ATTEMPTS = 6;
      // Shuffle title pins for round-robin usage — every pin is attempted
      // before any is reused, so the wires visually spread across the hub.
      const shuffledPins = title.pins.slice();
      for (let i = shuffledPins.length - 1; i > 0; i--) {
        const j = Math.floor(rng() * (i + 1));
        [shuffledPins[i], shuffledPins[j]] = [shuffledPins[j], shuffledPins[i]];
      }
      let pinCursor = 0;
      let made = 0;
      for (let iter = 0; iter < MAX_ITERS && made < TITLE_TARGET_WIRES; iter++) {
        const u = rng();
        const idx = Math.min(targets.length - 1, Math.floor(u * u * targets.length));
        const o = targets[idx];
        let chosen = null;
        for (let i = 0; i < TITLE_PATH_ATTEMPTS; i++) {
          // First attempt uses the next pin in round-robin order; subsequent
          // attempts may pick randomly in case the chosen pin can't route.
          const p1 = i === 0
            ? shuffledPins[pinCursor % shuffledPins.length]
            : title.pins[Math.floor(rng() * title.pins.length)];
          const p2 = o.pins[Math.floor(rng() * o.pins.length)];
          const e1len = 3 + rng() * 4;
          const e2len = 3 + rng() * 4;
          const hFirst = rng() < 0.5;
          const path = routeManhattan(p1, p2, e1len, e2len, hFirst);
          if (pointInsideAnyBlock(path[1], blocks)) continue;
          if (pointInsideAnyBlock(path[3], blocks)) continue;
          if (pathIsClear(path, blocks)) {
            chosen = { path, thick: rng() < 0.18 };
            break;
          }
        }
        if (chosen) {
          wires.push(chosen);
          made++;
          pinCursor++;
        }
      }
    }
  }
  return wires;
}

function drawWires(ctx, wires, theme, shade) {
  ctx.save();
  ctx.strokeStyle = theme.bg;
  ctx.globalAlpha = 0.4;
  for (const w of wires) {
    ctx.lineWidth = w.thick ? 2.2 : 1.4;
    ctx.beginPath();
    ctx.moveTo(w.path[0].x, w.path[0].y);
    for (let i = 1; i < w.path.length; i++) ctx.lineTo(w.path[i].x, w.path[i].y);
    ctx.stroke();
  }
  ctx.globalAlpha = 1;
  for (const w of wires) {
    ctx.lineWidth = w.thick ? 1.2 : 0.7;
    for (let i = 1; i < w.path.length; i++) {
      const a = w.path[i - 1];
      const b = w.path[i];
      ctx.strokeStyle = shade((a.x + b.x) / 2, (a.y + b.y) / 2,
                              w.thick ? 'bright' : 'secondary');
      ctx.beginPath();
      ctx.moveTo(a.x, a.y);
      ctx.lineTo(b.x, b.y);
      ctx.stroke();
    }
  }
  for (const w of wires) {
    const a = w.path[0], b = w.path[w.path.length - 1];
    ctx.fillStyle = shade(a.x, a.y, 'primary');
    ctx.fillRect(a.x - 1, a.y - 1, 2.2, 2.2);
    ctx.fillStyle = shade(b.x, b.y, 'primary');
    ctx.fillRect(b.x - 1, b.y - 1, 2.2, 2.2);
  }
  ctx.restore();
}

function drawLabel(ctx, b, theme, shade, text) {
  if (b.iw < 38 || b.ih < 16) return;
  ctx.save();
  ctx.font = '9px "Red Hat Mono", monospace';
  const tw = ctx.measureText(text).width;
  const chipW = tw + 6, chipH = 11;
  const x = b.ix + 2, y = b.iy + 2;
  ctx.fillStyle = theme.bg;
  ctx.globalAlpha = 0.88;
  ctx.fillRect(x, y, chipW, chipH);
  ctx.globalAlpha = 1;
  ctx.strokeStyle = shade(x + chipW / 2, y + chipH / 2, 'secondary');
  ctx.lineWidth = 0.5;
  ctx.strokeRect(x + 0.5, y + 0.5, chipW - 1, chipH - 1);
  ctx.fillStyle = shade(x + chipW / 2, y + chipH / 2, 'bright');
  ctx.fillText(text, x + 3, y + 9);
  ctx.restore();
}

function drawBackground(ctx, w, h, theme) {
  ctx.save();
  ctx.fillStyle = theme.bgVar;
  ctx.globalAlpha = 0.35;
  ctx.fillRect(0, 0, w, h);
  ctx.globalAlpha = 0.08;
  ctx.strokeStyle = theme.bgVar;
  ctx.lineWidth = 0.5;
  for (let x = 0; x < w; x += 6) {
    ctx.beginPath();
    ctx.moveTo(x + 0.5, 0);
    ctx.lineTo(x + 0.5, h);
    ctx.stroke();
  }
  for (let y = 0; y < h; y += 6) {
    ctx.beginPath();
    ctx.moveTo(0, y + 0.5);
    ctx.lineTo(w, y + 0.5);
    ctx.stroke();
  }
  ctx.restore();
}

function drawSealRing(ctx, w, h, shade) {
  ctx.save();
  ctx.lineWidth = 1;
  ctx.strokeStyle = shade(w / 2, h / 2, 'secondary');
  ctx.strokeRect(2.5, 2.5, w - 5, h - 5);
  ctx.strokeStyle = shade(w / 2, h / 2, 'primary');
  ctx.strokeRect(4.5, 4.5, w - 9, h - 9);
  ctx.restore();
}

function drawBlock(ctx, b, theme, rng, shade, minSize) {
  if (b.kind === 'title') {
    ctx.save();
    // Clean solid backdrop so the HTML title text reads cleanly.
    ctx.fillStyle = theme.bg;
    ctx.fillRect(b.ix, b.iy, b.iw, b.ih);
    // Double frame — marks this as a prominent macro.
    const cx = b.ix + b.iw / 2, cy = b.iy + b.ih / 2;
    ctx.lineWidth = 1;
    ctx.strokeStyle = shade(cx, cy, 'bright');
    ctx.strokeRect(b.ix + 0.5, b.iy + 0.5, b.iw - 1, b.ih - 1);
    ctx.lineWidth = 0.5;
    ctx.strokeStyle = shade(cx, cy, 'secondary');
    ctx.strokeRect(b.ix + 3.5, b.iy + 3.5, b.iw - 7, b.ih - 7);
    // Visible pin dots so it reads as a heavily-connected hub.
    for (const p of b.pins) {
      ctx.fillStyle = shade(p.x, p.y, 'primary');
      ctx.fillRect(p.x - 1.5, p.y - 1.5, 3, 3);
    }
    ctx.restore();
    return;
  }

  ctx.save();
  ctx.fillStyle = theme.bgVar;
  ctx.globalAlpha = 0.3 + rng() * 0.25;
  ctx.fillRect(b.ix, b.iy, b.iw, b.ih);
  ctx.globalAlpha = 1;

  ctx.strokeStyle = shade(b.ix + b.iw / 2, b.iy + b.ih / 2, 'secondary');
  ctx.lineWidth = 0.8;
  ctx.strokeRect(b.ix + 0.5, b.iy + 0.5, b.iw - 1, b.ih - 1);

  ctx.save();
  ctx.beginPath();
  ctx.rect(b.ix + 1, b.iy + 1, b.iw - 2, b.ih - 2);
  ctx.clip();
  drawPattern(ctx, b, rng, shade, b.kind, minSize);
  ctx.restore();
  ctx.restore();
}

// ---- Die instance factory ----
function createDie(canvas, opts = {}) {
  const options = {
    labels: true,
    sealRing: true,
    wires: true,
    minBlockSize: 26,
    maxAreaFraction: 0.25,
    iridescent: true,
    reactive: true,
    titleElement: null,
    ...opts,
  };
  const ctx = canvas.getContext('2d');
  const scene = { w: 0, h: 0, seed: 0, blocks: [], wires: [], labelled: [] };

  function build(w, h, seed) {
    scene.w = w;
    scene.h = h;
    scene.seed = seed;
    const rng = mulberry32(seed);
    const pad = Math.max(3, Math.min(6, Math.floor(Math.min(w, h) / 30)));
    const root = { x: pad, y: pad, w: w - pad * 2, h: h - pad * 2 };

    // Optional reserved region — measured from a live DOM element so the
    // floorplan tiles around it instead of underneath.
    let reserved = null;
    if (options.titleElement) {
      const cRect = canvas.getBoundingClientRect();
      const tRect = options.titleElement.getBoundingClientRect();
      if (tRect.width > 4 && tRect.height > 4) {
        const rx = Math.max(root.x, Math.floor(tRect.left - cRect.left));
        const ry = Math.max(root.y, Math.floor(tRect.top - cRect.top));
        const rR = Math.min(root.x + root.w, Math.ceil(tRect.right - cRect.left));
        const rB = Math.min(root.y + root.h, Math.ceil(tRect.bottom - cRect.top));
        const rw = rR - rx, rh = rB - ry;
        if (rw > 0 && rh > 0 && rw * rh < root.w * root.h * 0.5) {
          reserved = { x: rx, y: ry, w: rw, h: rh };
        }
      }
    }

    const blocks = [];
    const maxArea = root.w * root.h * options.maxAreaFraction;
    const strips = reserved ? carveAround(root, reserved) : [root];
    for (const strip of strips) {
      splitRect(strip, 7, options.minBlockSize, rng, blocks, maxArea);
    }
    if (reserved) {
      blocks.push({
        x: reserved.x, y: reserved.y, w: reserved.w, h: reserved.h,
        isTitle: true,
      });
    }

    blocks.forEach((b, i) => {
      const margin = b.isTitle ? 0 : 2;
      b.ix = b.x + margin;
      b.iy = b.y + margin;
      b.iw = Math.max(6, b.w - margin * 2);
      b.ih = Math.max(6, b.h - margin * 2);
      b.id = i;
      b.kind = b.isTitle ? 'title' : pickPattern(b, rng, false);
      b.pins = placePins(b, rng, b.isTitle ? 2 : 1, b.isTitle);
    });
    scene.blocks = blocks;
    scene.wires = options.wires ? buildWires(blocks, rng) : [];
    scene.labelled = options.labels
      ? blocks.filter(b => !b.isTitle && b.iw >= 42 && b.ih >= 18)
              .filter(() => rng() < 0.32)
              .map(b => ({ block: b, text: BLOCK_LABELS[Math.floor(rng() * BLOCK_LABELS.length)] }))
      : [];
  }

  function render() {
    if (!scene.w || !scene.h) return;
    // Viewport pointer → canvas-local coords.
    const rect = canvas.getBoundingClientRect();
    const mouse = {
      x: pointer.x - rect.left,
      y: pointer.y - rect.top,
    };
    const theme = getTheme();
    const shade = makeShade(mouse, theme, options.iridescent !== false);
    ctx.clearRect(0, 0, scene.w, scene.h);
    drawBackground(ctx, scene.w, scene.h, theme);
    const rng = mulberry32(scene.seed ^ 0xC0FFEE);
    for (const b of scene.blocks) drawBlock(ctx, b, theme, rng, shade, options.minBlockSize);
    if (options.wires) drawWires(ctx, scene.wires, theme, shade);
    if (options.labels) {
      for (const { block, text } of scene.labelled) drawLabel(ctx, block, theme, shade, text);
    }
    if (options.sealRing) drawSealRing(ctx, scene.w, scene.h, shade);
  }

  let resizePending = 0;
  function resize() {
    const dpr = window.devicePixelRatio || 1;
    const rect = canvas.getBoundingClientRect();
    const w = Math.max(40, Math.floor(rect.width));
    const h = Math.max(30, Math.floor(rect.height));
    if (w === scene.w && h === scene.h && scene.seed !== 0) return;
    canvas.width = Math.round(w * dpr);
    canvas.height = Math.round(h * dpr);
    ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    const seed = (Math.floor(Math.random() * 0xFFFFFFFF)) >>> 0;
    build(w, h, seed);
    render();
  }

  function scheduleResize() {
    if (resizePending) cancelAnimationFrame(resizePending);
    resizePending = requestAnimationFrame(() => { resizePending = 0; resize(); });
  }

  if (typeof ResizeObserver !== 'undefined') {
    new ResizeObserver(scheduleResize).observe(canvas);
  } else {
    window.addEventListener('resize', scheduleResize);
  }
  resize();

  return { render, resize, canvas, el: canvas, reactive: options.reactive };
}

// ---- Initialization ----
function init() {
  // Homepage top hero — fills the blank space above the menu/title.
  // Uses the same block scale as the timeline boxes for visual consistency.
  const heroCanvas = document.getElementById('page-hero');
  if (heroCanvas) {
    const heroTitleSpan = document.querySelector('.page-hero-title span');
    dies.push(createDie(heroCanvas, {
      labels: true, sealRing: true, wires: true,
      minBlockSize: 12, maxAreaFraction: 0.05,
      titleElement: heroTitleSpan,
    }));
  }

  // Align the PCIe edge-contact strip to sit above the hero, directly under
  // the menu breadcrumbs — matches their exact horizontal extent.
  const heroPcie = document.querySelector('.page-hero-pcie');
  const heroWrap = document.querySelector('.page-hero-wrap');
  if (heroPcie && heroWrap) {
    function alignHeroPcie() {
      const menu = heroWrap.parentElement && heroWrap.parentElement.querySelector('.breadcrumb');
      if (!menu) { heroPcie.style.display = 'none'; return; }
      const wRect = heroWrap.getBoundingClientRect();
      const mRect = menu.getBoundingClientRect();
      const gap = wRect.top - mRect.bottom;
      const TOP_OFFSET = 5; // clear the menu underlines
      const MIN_STRIP = 5;
      if (mRect.width === 0 || gap < TOP_OFFSET + MIN_STRIP) {
        heroPcie.style.display = 'none';
        return;
      }
      const stripH = gap - TOP_OFFSET;
      heroPcie.style.display = '';
      // Span the full wrap so the bottom hook reaches both die corners.
      heroPcie.style.left = '0px';
      heroPcie.style.width = wRect.width + 'px';
      heroPcie.style.top = (mRect.bottom - wRect.top + TOP_OFFSET) + 'px';
      heroPcie.style.height = stripH + 'px';
      // The substrate + finger features are masked to the menu's horizontal
      // range only; the bottom hook line spans full width.
      heroPcie.style.setProperty('--menu-offset-x',
        (mRect.left - wRect.left) + 'px');
      heroPcie.style.setProperty('--menu-width', mRect.width + 'px');
    }
    alignHeroPcie();
    window.addEventListener('resize', alignHeroPcie);
    // Re-align after fonts load (menu width can shift).
    if (document.fonts && document.fonts.ready) {
      document.fonts.ready.then(alignHeroPcie);
    }
  }

  // Timeline boxes — inject a canvas as first child of each item.
  document.querySelectorAll('.timeline-item').forEach(item => {
    const cv = document.createElement('canvas');
    cv.className = 'timeline-bg';
    cv.setAttribute('aria-hidden', 'true');
    item.insertBefore(cv, item.firstChild);
    dies.push(createDie(cv, {
      labels: false, sealRing: false, wires: true, minBlockSize: 12,
    }));
  });

  if (!dies.length) return;

  // Visibility culling — only render dies that are on-screen.
  const io = new IntersectionObserver(entries => {
    let wake = false;
    for (const e of entries) {
      const d = dies.find(x => x.el === e.target);
      if (!d) continue;
      if (e.isIntersecting) {
        if (!visibleDies.has(d)) { visibleDies.add(d); wake = true; }
      } else {
        visibleDies.delete(d);
      }
    }
    if (wake) {
      for (const d of dies) {
        if (visibleDies.has(d)) d.render();
      }
    }
  }, { rootMargin: '50px' });
  for (const d of dies) io.observe(d.el);

  // Default pointer to viewport center (before any mouse input).
  pointer.x = pointer.tx = window.innerWidth / 2;
  pointer.y = pointer.ty = window.innerHeight / 2;

  window.addEventListener('pointermove', onPointer, { passive: true });

  // Scroll shifts dies relative to the viewport pointer → re-render visible.
  let scrollPending = false;
  window.addEventListener('scroll', () => {
    if (scrollPending) return;
    scrollPending = true;
    requestAnimationFrame(() => {
      scrollPending = false;
      for (const d of dies) {
        if (d.reactive && visibleDies.has(d)) d.render();
      }
    });
  }, { passive: true });

  // Theme flip re-renders everything.
  const mo = new MutationObserver(() => {
    for (const d of dies) d.render();
  });
  mo.observe(document.body, { attributes: true, attributeFilter: ['class'] });

  // Touch devices: gentle drift so the shimmer feels alive without a mouse.
  if (window.matchMedia && window.matchMedia('(hover: none)').matches) {
    let t = 0;
    (function drift() {
      t += 0.005;
      pointer.tx = window.innerWidth * (0.5 + Math.cos(t) * 0.4);
      pointer.ty = window.innerHeight * (0.5 + Math.sin(t * 1.3) * 0.4);
      kickEase();
      requestAnimationFrame(drift);
    })();
  }
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', init, { once: true });
} else {
  init();
}
