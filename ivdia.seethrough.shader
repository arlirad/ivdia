Shader "Ivdia/Seethrough"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
        _ShadeMul("Shade Mul", Range(0.00, 1.00)) = 0.85
        _ShadeDirMul("Shade Directional Mul", Range(0.00, 1.00)) = 0.50
        _ShadeDirMin("Shade Directional Minimum", Range(0.00, 1.00)) = 0.65
        _ShadeMax("Shade Max", Range(0.00, 1.00)) = 0.50
        _ShadeMin("Shade Min", Range(0.00, 1.00)) = 0.45
        _OutlineColor("Outline Color", Color) = (1.00, 1.00, 1.00, 1.00)
        _OutlineThickness("Outline Thickness", float) = 0.01
        _EmissionStrength("Emission Strength", float) = 1.00
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" "LightMode" = "ForwardBase" "VRCFallback" = "Toon" }
        LOD 200

        Pass
        {
            Name "Main"
            Cull Back

            CGPROGRAM
            #define _IVDIA_EMISSION
            #define _IVDIA_SEETHROUGH_OCULAR_OPAQUE_PASS
            #include "./Code/ivdia.glslinc"
            ENDCG
        }

        Pass
        {
            Name "Through Hair"
            Cull Back

            Stencil
            {
                Ref 2137
                Comp always
                Pass replace
            }

            CGPROGRAM
            #define _IVDIA_EMISSION
            #define _IVDIA_SEETHROUGH_OCULAR_OPAQUE_PASS
            #include "./Code/ivdia.glslinc"
            ENDCG
        }

        Pass
        {
            Name "Through Hair Transparent"
            Cull Back
            Blend SrcAlpha OneMinusSrcAlpha

            Stencil
            {
                Ref 2137
                Comp always
                Pass replace
            }

            CGPROGRAM
            #define _IVDIA_EMISSION
            #define _IVDIA_SEETHROUGH_OCULAR_TRANSPARENT_PASS
            #include "./Code/ivdia.glslinc"
            ENDCG
        }
        
        Pass
        {
            Name "ForwardAdd"
            Tags { "LightMode" = "ForwardAdd" }
            Blend One One
            ZWrite Off Blend One One

            CGPROGRAM
            #include "./Code/ivdia.lighting.glslinc"
            ENDCG
        }
    }
    FallBack "Diffuse"
}
