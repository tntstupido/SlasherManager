shader_type canvas_item;

uniform float speed = 0.5;
uniform float strength = 0.0002;

float random(vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void fragment() {
    vec2 uv = UV;
    float time_step = floor(TIME * speed * 4.0);
    uv.x += random(vec2(time_step, 0.0)) * strength;
    uv.y += random(vec2(0.0, time_step)) * strength;
    
    COLOR = texture(TEXTURE, uv);
}
