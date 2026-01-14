shader_type canvas_item;

uniform float turn_progress = 0.0;  // 0.0 = flat, 1.0 = page half-turned

void fragment() {
    vec2 uv = UV;
    
    // Create page curl effect from left to right
    float curl_edge = turn_progress * 1.5;  // Edge of curl moving across page
    
    // Calculate distance from left edge
    float dist_from_left = uv.x;
    
    // Create shadow/shading for curled part
    float curl_amount = smoothstep(curl_edge - 0.3, curl_edge, dist_from_left);
    
    // Get base texture color
    vec4 color = texture(TEXTURE, uv);
    
    // Apply shadow to curled portion (darker)
    float shadow = 1.0 - curl_amount * 0.5;
    color.rgb *= shadow;
    
    // Add highlight at curl edge
    float edge = smoothstep(curl_edge - 0.02, curl_edge, dist_from_left) - 
                 smoothstep(curl_edge, curl_edge + 0.02, dist_from_left);
    color.rgb += vec3(0.2, 0.2, 0.2) * edge;
    
    COLOR = color;
}

void vertex() {
    // Subtle vertex displacement for paper movement
    vec2 vert = VERTEX;
    
    // Very gentle wave as page turns
    float wave = sin(vert.y * 0.02 + TIME * 3.0) * sin(turn_progress * 3.14159) * 0.5;
    vert.x += wave;
    
    VERTEX = vert;
}
