precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 color = texture2D(tex, v_texcoord);

    // Simulate ~4500K temperature shift
    color.r *= 1.05;   // slight warm boost
    color.g *= 0.95;   // reduce green slightly
    color.b *= 0.75;   // reduce blue significantly

    // Optional gamma correction for smoothness
    color.rgb = pow(color.rgb, vec3(1.0/1.05));

    gl_FragColor = color;
}