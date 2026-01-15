shader_type canvas_item;

uniform float turn_progress = 0.0;  // 0.0 = flat, 1.0 = page almost fully turned

void fragment() {
    vec2 uv = UV;

    // Curl front edge moves from right to left.
    float edge = mix(1.2, -0.2, turn_progress);
    float curl_width = 0.25;
    float curl_start = edge;

    // Compute how far into the curl we are (0..1) on the right side of the edge.
    float t = clamp((curl_start - uv.x) / curl_width, 0.0, 1.0);

    // Bend UVs to simulate a page fold.
    float bend = sin(t * 3.14159);
    uv.x -= bend * 0.08 * t;
    uv.y += (1.0 - t) * 0.02 * sin(uv.x * 20.0);

    vec4 color = texture(TEXTURE, uv);

    // Darken curled area to simulate shadow under the page.
    float shadow = mix(1.0, 0.65, t);
    color.rgb *= shadow;

    // Add a bright highlight at the curling edge.
    float highlight = smoothstep(edge - 0.01, edge, UV.x) * (1.0 - smoothstep(edge, edge + 0.01, UV.x));
    color.rgb += vec3(0.35) * highlight;

    // Slight fade after the edge to mimic page thickness.
    float clip = smoothstep(edge + 0.02, edge + 0.08, UV.x);
    color.a *= 1.0 - clip;

    COLOR = color;
}

void vertex() {
    vec2 vert = VERTEX;

    // Subtle overall wobble while turning.
    float wave = sin(vert.y * 0.015 + TIME * 2.0) * sin(turn_progress * 3.14159) * 0.6;
    vert.x += wave;

    VERTEX = vert;
}
