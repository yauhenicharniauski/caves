extern number time01;
extern number dawn;
extern number dusk;
extern vec3  colDay;
extern vec3  colDusk;
extern vec3  colNight;

float luma(vec3 c){ return dot(c, vec3(0.2126,0.7152,0.0722)); }

vec4 effect(vec4 vcolor, Image tex, vec2 uv, vec2 px) {
    vec4 src = Texel(tex, uv) * vcolor;
    vec3 c = src.rgb;

    float t = time01;

    float dayAmt;
    if (t < dawn) {
        dayAmt = smoothstep(dawn - 0.05, dawn, t);
    } else if (t < dusk) {
        dayAmt = 1.0;
    } else {
        dayAmt = 1.0 - smoothstep(dusk, dusk + 0.05, t);
    }

    vec3 tone;
    if (dayAmt < 0.2) {
        tone = mix(colNight, colDusk, dayAmt * 5.0);
    } else if (dayAmt < 1.0) {
        tone = mix(colDusk, colDay, (dayAmt - 0.2) / 0.8);
    } else {
        tone = colDay;
    }

    float exposure = mix(0.45, 1.1, dayAmt);
    float sat = mix(0.7, 1.0, dayAmt);

    float Y = luma(c);
    c = mix(vec3(Y), c, sat);
    c *= tone * exposure;
    c = pow(c, vec3(0.95));

    return vec4(c, src.a);
}
