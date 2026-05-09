shader_type canvas_item;

uniform vec4 border_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float border_thickness : hint_range(0.0, 10.0) = 2.0;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    vec2 size = TEXTURE_PIXEL_SIZE * border_thickness;
    
    // Check neighbors to detect edge
    float alpha = color.a;
    alpha += texture(TEXTURE, UV + vec2(size.x, 0.0)).a;
    alpha += texture(TEXTURE, UV - vec2(size.x, 0.0)).a;
    alpha += texture(TEXTURE, UV + vec2(0.0, size.y)).a;
    alpha += texture(TEXTURE, UV - vec2(0.0, size.y)).a;
    
    // Clamp to prevent over-coloring
    vec4 final_color = mix(color, border_color, clamp(alpha, 0.0, 1.0) - color.a);
    COLOR = vec4(final_color.rgb, clamp(alpha, 0.0, 1.0));
}