Shader "Ivdia/Wings"
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
        _RootColor("Root Color", Color) = (1.00, 1.00, 1.00, 1.00)
        _EndColor("End Color", Color) = (1.00, 1.00, 1.00, 1.00)
        _StreakColor("Streak Color", Color) = (1.00, 1.00, 1.00, 1.00)
        _StreakMul("Streak Multiplier", float) = 1.00
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
            #include "./Code/ivdia.wings.glslinc"
            ENDCG
        }
        
        Pass
        {
            Name "Outline"
            Cull Front

            CGPROGRAM
            #include "./Code/ivdia.outline.glslinc"
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
