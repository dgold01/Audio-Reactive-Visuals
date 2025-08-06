uniform vec3 uEmission;
uniform float uAlphaFront;
uniform float uShadowStrength;
uniform vec3 uShadowColor;
uniform vec3 uDiffuseColor;
uniform vec3 uAmbientColor;
uniform vec3 uSpecularColor;
uniform float uShininess;
uniform sampler2D uMusicBands;
uniform highp float uRows;
uniform highp float uCols;


out Vertex
{
	vec4 color;
	vec3 worldSpacePos;
	vec3 worldSpaceNorm;
	flat int cameraIndex;
} oVert;

void main()
{
	gl_PointSize = 1.0;
	vec3 pos = TDPos();
	int id = TDInstanceID();
	vec3 normal = TDNormal();

	//Compute grid cords from intanceID
	int rowsInt = int(uRows);
	int colsInt = int(uCols);
	int row = id / colsInt;
	int col = id % colsInt;

	//Normalize the position to be in the range of -1 to 1
	float xPos = (float(col) / float(uCols - 1)) * 5 - 1.0;
	float zPos = (float(row) / float(uRows - 1)) * 5 - 1.0;

	// Offset original position with grid layout
//	pos.x += xPos;
//	pos.z += zPos;

//	pos.y *= 0.2;
//	pos.x += pos.y * 0.5;

	int bandIndex = id % 9;  // Pick a band for this instance
	float bandValue = texture(uMusicBands, vec2(bandIndex / 9.0, 0.5)).r *100;

//	float yOffset = texture(musicBands, vec2(bandIndex / 9.0, 0.5)).r * 10;
//	vec3 newPos = vec3(TDInstanceMat()[3][0], yOffset, TDInstanceMat()[3][2]);
//	gl_Position = TDWorldToProj(newPos);
	// First deform the vertex and normal
	// TDDeform always returns values in world space


	oVert.color = vec4(bandValue, 1.0 - bandValue, 0.5 + 0.5 * bandValue, 1.0);


	float scaleY = texture(uMusicBands, vec2(bandIndex / 9.0, 0.5)).r * 10.0;
	float baseHeight = 0.8; // height of cube before scaling (adjust as needed)

	// Move vertex relative to base position
	pos.y *= scaleY;
//	pos.x *= scaleY * 0.5;
//	pos.z *= scaleY * 0.0;
	// Push it upward so the base stays at same height
	pos.y += (scaleY - 1.0) * baseHeight * 0.5;

	vec4 worldSpacePos = TDDeform(pos);
	vec3 uvUnwrapCoord = TDInstanceTexCoord(TDUVUnwrapCoord());
	gl_Position = TDWorldToProj(worldSpacePos, uvUnwrapCoord);


	// This is here to ensure we only execute lighting etc. code
	// when we need it. If picking is active we don't need lighting, so
	// this entire block of code will be ommited from the compile.
	// The TD_PICKING_ACTIVE define will be set automatically when
	// picking is active.
#ifndef TD_PICKING_ACTIVE

	int cameraIndex = TDCameraIndex();
	oVert.cameraIndex = cameraIndex;
	oVert.worldSpacePos.xyz = worldSpacePos.xyz;
//	oVert.color = TDInstanceColor(TDColor());
	vec3 worldSpaceNorm = normalize(TDDeformNorm(normal));
	oVert.worldSpaceNorm.xyz = worldSpaceNorm;

#else // TD_PICKING_ACTIVE

	// This will automatically write out the nessessary values
	// for this shader to work with picking.
	// See the documentation if you want to write custom values for picking.
	TDWritePickingValues();

#endif // TD_PICKING_ACTIVE
}
