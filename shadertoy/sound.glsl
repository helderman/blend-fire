// Procedural fire sound
// - Rumble/roar: low frequency noise with random overdrive (clipping)
// - Sparks: random 10 ms noise bursts, with decay
// Inspired by Andy Farnell's work on procedural audio.
// Copyright 2022 Ruud Helderman
// MIT License

const float volume = 0.2;
const float overdrive = 3.0;
const mat2 mix_stereo = mat2(0.8, 0.2, 0.2, 0.8);

const float f1 = 1.0;      // overdrive rate
const float f2 = 100.0;    // rumble noise
const float f3 = 100.0;    // spark rate
const float f4 = 4000.0;   // spark noise

float square(float a) { return a * a; }
float decay(float t) { return min(1.5 * exp(-1.5 * t), 1.0); }
float mono(float a) { return snoise(vec2(a, 0.0)); }
vec2 stereo(float a) { return vec2(snoise(vec2(a, 1.0)), snoise(vec2(a, 2.0))); }

vec2 mainSound( int samp, float time )
{
    return volume * mix_stereo * (
        (0.5 + square(mono(f1*time))) * clamp(stereo(f2*time) * overdrive, -1.0, 1.0) +
        decay(fract(f3*time)) * max(vec2(0), stereo(floor(f3*time))) * stereo(f4*time)
    );
}
