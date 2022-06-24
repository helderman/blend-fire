// Simple but effective 2D fire effect:
// sum two noise patterns moving at different speeds, then do color mapping.
// Copyright 2022 Ruud Helderman
// MIT License

const vec2 grain = vec2(9, 6);
const float oven = 3.2;
const vec2 rise = vec2(0, 8);
const vec2 slide = vec2(0.5);
const vec4 color = vec4(-1, -2, -3, 0);

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord / iResolution.xy;
    vec2 pos = grain * fragCoord / iResolution.y - iTime * rise;
    float octave1 = 0.2 * (snoise(pos + iTime * slide) + snoise(pos - iTime * slide));
    float octave2 = 0.9 * snoise(pos * 0.45);
    float obstacles = 7.0 * texture(iChannel0, uv).r;
    fragColor = octave1 + length(vec2(oven * (1.0 - uv.y) + octave2, obstacles)) + color;
}
