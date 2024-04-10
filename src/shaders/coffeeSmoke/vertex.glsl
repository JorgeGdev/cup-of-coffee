uniform sampler2D uPerlinTexture;
uniform float uTime;

varying vec2 vUv;

#include ../includes/rotate2D.glsl


void main()
{
    vec3 newPosition = position;

    //TWIST

    float twistPerlin = texture(
        uPerlinTexture, 
        vec2(0.5, uv.y * 0.2 - uTime * 0.008)
        ).r;
    float angle = twistPerlin * 10.0;
    newPosition.xz = rotate2D(newPosition.xz, angle);


    //WIND 
     vec2 windOffSet = vec2(
        texture(uPerlinTexture,vec2(0.25, uTime * 0.05)).r - 0.5, 
        texture(uPerlinTexture,vec2(0.75, uTime * 0.05)).r - 0.5
     );

     windOffSet *= pow(uv.y, 4.0)* 8.0;

     newPosition.xz += windOffSet;

    
    
    
    //FINAL POSITION


    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(newPosition, 1.0);

    vUv = uv;


}