uniform sampler2D uAmplitudeTex;
uniform float uTime;
uniform sampler2D uVideo;

out vec2 vUV;

void main() {
    vec3 basePos = TDPos();
    mat4 instanceMat = TDInstanceMat();

    int instanceID = TDInstanceID();
    int col = instanceID % 100; // 100 columns
    int band = col / 10;        // 10 bands
    float bandIndex = float(band) / 9;
    float amplitude = texture(uAmplitudeTex, vec2(bandIndex, 0.5)).r;

//    float c = abs(sin(uTime * 1) * amplitude * 200);
    vec3 pos = (instanceMat * vec4(basePos, 1)).xyz;

    // Compute UV for texture sample (example: map instance ID to X)
//    int instanceID = TDInstanceID();
//    int col = instanceID % 100; // 100 columns
//    int band = col / 10;        // 10 bands
//    float bandIndex = float(band) / 100.0; // Normalize for sampler2D

//    // Burst upward
//    float t = uTime * 5.0 + float(TDInstanceID()) * 0.5;
//    float burst = max(0.0, sin(t)) * amplitude * 10;
//
//    // Fake "falling" using exponential decay
//    float fall = exp(-mod(t, 3.14));  // dampens over time

//    pos.y += burst * 200.0 * fall;
    // Example: vibrate in Y axis based on amplitude
    float shake = sin(uTime * 10.0 + float(TDInstanceID()) * 0.5) * amplitude * 200;
//    pos.y += shake;

    float t = sin(uTime * 2.0); // oscillates between -1 and 1
    float explosionAmount = t * amplitude * 200.0; // scale this
    vec3 direction = normalize(pos); // from origin
    pos += direction * explosionAmount;


    vUV = (pos.zx + vec2(50.0)) / 100.0;

    gl_Position = TDWorldToProj(TDDeform(pos));
}