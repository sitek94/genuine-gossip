// app.jsx — renders the design canvas with all 5 direction artboards.
// DCArtboard MUST be a direct child of DCSection (the canvas walks
// children synchronously and only registers ab.type === DCArtboard).
// So we render all 4 artboards inline per direction rather than via a
// Board helper component.

const DIRECTIONS = [
  {
    id: 'd1', name: 'Editorial',
    subtitle: 'Literary quarterly · cream paper · oxblood accent · Fraunces',
    Gate: D1Gate, Picker: D1Picker, Card: D1Card, End: D1End,
  },
  {
    id: 'd2', name: 'Nocturnal',
    subtitle: 'Candlelit · amber glow · handwritten accents · Instrument Serif',
    Gate: D2Gate, Picker: D2Picker, Card: D2Card, End: D2End,
  },
  {
    id: 'd3', name: 'Tactile Paper',
    subtitle: 'Physical card metaphor · color per deck · Crimson Pro',
    Gate: D3Gate, Picker: D3Picker, Card: D3Card, End: D3End,
  },
  {
    id: 'd4', name: 'Typographic',
    subtitle: 'Radical minimal · giant display type · text is the product · Cormorant',
    Gate: D4Gate, Picker: D4Picker, Card: D4Card, End: D4End,
  },
  {
    id: 'd5', name: 'Atmospheric',
    subtitle: 'Gradient dusk · soft glass · color varies with deck · Newsreader',
    Gate: D5Gate, Picker: D5Picker, Card: D5Card, End: D5End,
  },
];

const AB_W = 360 * 2 + 32 + 48 * 2;   // 848
const AB_H = 780 + 48 * 2;             // 876

function PhonePairArtboardBody({ Screen }) {
  return (
    <div style={{ width: '100%', height: '100%', background: '#ebe8e1', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 32, padding: 48 }}>
      <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 14 }}>
        <Screen dark={false} />
        <div style={{ fontFamily: 'ui-monospace, JetBrains Mono, monospace', fontSize: 10, letterSpacing: 2, color: '#6a5c4a', textTransform: 'uppercase' }}>Light</div>
      </div>
      <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 14 }}>
        <Screen dark={true} />
        <div style={{ fontFamily: 'ui-monospace, JetBrains Mono, monospace', fontSize: 10, letterSpacing: 2, color: '#6a5c4a', textTransform: 'uppercase' }}>Dark</div>
      </div>
    </div>
  );
}

function Intro() {
  return (
    <DCSection id="intro" title="Between Us · visual directions" subtitle="A conversation-starter app for couples — five fresh takes on mood, type, and chrome">
      <DCArtboard id="brief" label="Brief" width={900} height={540}>
        <div style={{
          width: '100%', height: '100%', padding: '56px 60px',
          background: 'linear-gradient(135deg, #f5f0e8 0%, #ede5d8 100%)',
          display: 'flex', flexDirection: 'column', gap: 20,
          fontFamily: 'Inter Tight, system-ui, sans-serif', color: '#2a241c',
        }}>
          <div style={{ fontFamily: 'ui-monospace, monospace', fontSize: 11, letterSpacing: 2.4, textTransform: 'uppercase', color: '#756a58' }}>A fresh visual pass · v0</div>
          <div style={{ fontFamily: 'Fraunces, serif', fontSize: 54, fontWeight: 300, fontStyle: 'italic', lineHeight: 1, letterSpacing: -1 }}>Five directions<br/>for a quiet app.</div>
          <div style={{ fontFamily: 'Newsreader, Georgia, serif', fontSize: 19, lineHeight: 1.5, fontWeight: 300, maxWidth: 700, color: '#3d342a' }}>
            The product is a single card held between two people. The content does the work; the interface stays out of the way. Below, five mood boards rendered as real screens — each covers the gate, deck picker, active card and end-of-deck, in light and dark.
          </div>
          <div style={{ marginTop: 'auto', display: 'grid', gridTemplateColumns: 'repeat(5, 1fr)', gap: 18, fontSize: 11, color: '#6a5c4a', letterSpacing: 0.2 }}>
            {DIRECTIONS.map((d, i) => (
              <div key={d.id}>
                <div style={{ fontFamily: 'ui-monospace, monospace', fontSize: 10, letterSpacing: 2, color: '#9a8d78' }}>0{i + 1}</div>
                <div style={{ fontFamily: 'Fraunces, serif', fontSize: 20, fontStyle: 'italic', fontWeight: 400, marginTop: 4, color: '#2a241c' }}>{d.name}</div>
                <div style={{ marginTop: 4, lineHeight: 1.4 }}>{d.subtitle.split(' · ').slice(0, 2).join(' · ')}</div>
              </div>
            ))}
          </div>
        </div>
      </DCArtboard>
    </DCSection>
  );
}

function App() {
  return (
    <DesignCanvas>
      <Intro />
      {DIRECTIONS.map(dir => (
        <DCSection key={dir.id} id={dir.id} title={dir.name} subtitle={dir.subtitle}>
          <DCArtboard id={`${dir.id}-gate`} label="01 · Access gate" width={AB_W} height={AB_H}>
            <PhonePairArtboardBody Screen={dir.Gate} />
          </DCArtboard>
          <DCArtboard id={`${dir.id}-picker`} label="02 · Deck picker" width={AB_W} height={AB_H}>
            <PhonePairArtboardBody Screen={dir.Picker} />
          </DCArtboard>
          <DCArtboard id={`${dir.id}-card`} label="03 · Card (active)" width={AB_W} height={AB_H}>
            <PhonePairArtboardBody Screen={dir.Card} />
          </DCArtboard>
          <DCArtboard id={`${dir.id}-end`} label="04 · End of deck" width={AB_W} height={AB_H}>
            <PhonePairArtboardBody Screen={dir.End} />
          </DCArtboard>
        </DCSection>
      ))}
    </DesignCanvas>
  );
}

ReactDOM.createRoot(document.getElementById('root')).render(<App />);
