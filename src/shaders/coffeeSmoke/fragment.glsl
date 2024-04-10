
uniform sampler2D uPerlinTexture;
uniform float uTime;
varying vec2 vUv;



void main()
{

    //scale and animate

    vec2 smokeUv = vUv;
    smokeUv.x *= 0.5;
    smokeUv.y *= 0.3;
    smokeUv.y -= uTime * 0.1;



    //SMOKE

    float smoke = texture(uPerlinTexture, smokeUv).r;

    //remap  - transicion mas suave del smoke

    smoke = smoothstep(0.5, 1.0, smoke);

    //EDGES quitar bordes 
    
    smoke *= smoothstep(0.0, 0.1, vUv.x);
    smoke *= smoothstep(1.0, 0.9, vUv.x);
    smoke *= smoothstep(0.0, 0.1, vUv.y);
    smoke *= smoothstep(1.0, 0.4, vUv.y);


    //FINAL COLOR
    gl_FragColor = vec4(0.6, 0.3, 0.2, smoke);
    
    #include <tonemapping_fragment>
    #include <colorspace_fragment>

}