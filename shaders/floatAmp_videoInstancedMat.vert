uniform float uAmplitude;
uniform float uTime;
uniform sampler2D uVideo;

out vec2 vUV;

void main() {
    vec3 basePos = TDPos();
    mat4 instanceMat = TDInstanceMat();
    vec3 pos = (instanceMat * vec4(basePos, 1.0)).xyz;

    vUV = (pos.zx + vec2(50.0)) / 100.0;

    // Vibration effect on Z axis
    float shake = sin(uTime * 10.0 + float(TDInstanceID()) * 0.5) * uAmplitude * 0.9;
    pos.y += shake;

    gl_Position = TDWorldToProj(TDDeform(pos));
}