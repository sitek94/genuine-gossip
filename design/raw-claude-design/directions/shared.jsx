// Shared primitives for all direction artboards.
// Phone frame sized 360×780. Each direction renders its own screen
// contents inside. We keep this pragmatic — no system chrome bar.

const PHONE_W = 360;
const PHONE_H = 780;

// Sample content used across all directions so comparisons are apples-to-apples.
const SAMPLE_CARDS = {
  'Warm & Light': "What's a small thing I do that you secretly love?",
  'Deep Talk': "When do you feel most yourself with me — and when do you feel farthest away?",
  'Playful Energy': "If our relationship were a sandwich, what would be in it and why?",
  'Relationship Check-in': "What's one thing I could do more of this month that would make you feel seen?",
  'Intimate': "Describe the moment you first wanted me — not with words, but with a single image.",
  'Shuffle Everything': "What's a memory of us you return to when you can't sleep?",
};

const DECKS = [
  { id: 'shuffle',  name: 'Shuffle Everything',    tag: 'All cards · randomized',            count: 84 },
  { id: 'warm',     name: 'Warm & Light',          tag: 'Reflective · playful',              count: 22 },
  { id: 'deep',     name: 'Deep Talk',             tag: 'Vulnerable · meaningful',           count: 18 },
  { id: 'playful',  name: 'Playful Energy',        tag: 'Fun · weird · low-stakes',          count: 14 },
  { id: 'checkin',  name: 'Relationship Check-in', tag: 'Connection · values · future',      count: 16 },
  { id: 'intimate', name: 'Intimate',              tag: 'Suggestive → sexual',               count: 14 },
];

// Compact phone-shaped chrome. No notch — want to keep the reading surface pure.
// Rounded soft corners like a modern handset.
function Phone({ bg, children, frameColor = '#1a1a1a', style, innerStyle }) {
  return (
    <div style={{
      width: PHONE_W, height: PHONE_H, borderRadius: 46,
      background: frameColor, padding: 8,
      boxShadow: '0 30px 60px -20px rgba(0,0,0,0.25), 0 0 0 1px rgba(0,0,0,0.08)',
      position: 'relative', overflow: 'hidden',
      ...style,
    }}>
      <div style={{
        width: '100%', height: '100%', borderRadius: 38, overflow: 'hidden',
        background: bg, position: 'relative',
        ...innerStyle,
      }}>
        {children}
      </div>
    </div>
  );
}

// A thin top bar with a faux time + battery. Kept very understated so
// it doesn't compete with the reading experience.
function StatusBar({ fg = 'rgba(0,0,0,0.6)', time = '9:41' }) {
  return (
    <div style={{
      position: 'absolute', top: 0, left: 0, right: 0, height: 36,
      display: 'flex', alignItems: 'center', justifyContent: 'space-between',
      padding: '0 22px', fontSize: 12, fontWeight: 500, color: fg,
      fontFeatureSettings: '"tnum"',
      fontFamily: 'system-ui, -apple-system, sans-serif',
      letterSpacing: 0.1, zIndex: 5,
    }}>
      <span>{time}</span>
      <span style={{ display: 'flex', gap: 4, alignItems: 'center', opacity: 0.85 }}>
        <svg width="16" height="10" viewBox="0 0 16 10" fill="none"><path d="M1 9 L1 7 M4 9 L4 5 M7 9 L7 3 M10 9 L10 1" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/></svg>
        <svg width="22" height="10" viewBox="0 0 22 10" fill="none"><rect x="0.5" y="0.5" width="18" height="9" rx="2.2" stroke="currentColor" opacity="0.5"/><rect x="2" y="2" width="14" height="6" rx="1" fill="currentColor"/><rect x="19.5" y="3.5" width="1.5" height="3" rx="0.5" fill="currentColor" opacity="0.5"/></svg>
      </span>
    </div>
  );
}

// Bottom home indicator bar — super subtle.
function HomeIndicator({ color = 'rgba(0,0,0,0.4)' }) {
  return (
    <div style={{
      position: 'absolute', bottom: 8, left: '50%', transform: 'translateX(-50%)',
      width: 110, height: 4, borderRadius: 2, background: color, opacity: 0.55,
    }} />
  );
}

// Small helper — a labeled phone pair (light + dark) side by side.
// Each direction uses this to show both modes in a single artboard.
function PhonePair({ children, gap = 32 }) {
  return (
    <div style={{
      display: 'flex', gap, alignItems: 'flex-start', justifyContent: 'center',
      padding: '24px 0',
    }}>
      {children}
    </div>
  );
}

// Exports
Object.assign(window, {
  PHONE_W, PHONE_H,
  SAMPLE_CARDS, DECKS,
  Phone, StatusBar, HomeIndicator, PhonePair,
});
