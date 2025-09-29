//
// Sets the RGB to 1 and just retains the alpha, making the sprite look white
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float light;
vec4 baseColor;

void main()
{
	vec4 baseColor = texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor = vec4(vec3(light)+baseColor.rgb,baseColor.a);
}
