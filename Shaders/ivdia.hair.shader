/*
 * SPDX-License-Identifier: LGPL-3.0-or-later
 *
 * Copyright (c) 2025 Arlirad
 * Licensed under the GNU Lesser General Public License v3.0 or later
 * See the LICENSE file in the top-level directory for details.
 */

Shader "Ivdia/Hair"
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
        _SeethroughAlpha("Seethrough Alpha", Range(0.00, 1.00)) = 0.25
        _HighlightTex ("Highlight Texture", 2D) = "white" {}
        _HighlightColor("Highlight Color", Color) = (1.00, 1.00, 1.00, 1.00)
        _HighlightDotUpper("Highlight Dot Upper", Range(0.00, 2.00)) = 0.75
        _HighlightDotLower("Highlight Dot Lower", Range(0.00, 1.00)) = 0.1
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" "LightMode" = "ForwardBase" "VRCFallback" = "Toon" }
        LOD 200

        Pass
        {
            Name "Main"
            Cull Back

            Stencil
            {
                Ref 2137
                Comp notequal
                Pass keep
            }

            CGPROGRAM
            #define _IVDIA_HAIR_HIGHLIGHT
            #include "../Code/ivdia.glslinc"
            ENDCG
        }

        Pass
        {
            Name "Main Seethrough"
            Cull Back
            Blend SrcAlpha OneMinusSrcAlpha

            Stencil
            {
                Ref 2137
                Comp equal
                Pass keep
            }

            CGPROGRAM
            #define _IVDIA_SEETHROUGH_HAIR_ALPHA_PASS
            #define _IVDIA_HAIR_HIGHLIGHT
            #include "../Code/ivdia.glslinc"
            ENDCG
        }
        
        Pass
        {
            Name "Outline"
            Cull Front

            CGPROGRAM
            #include "../Code/ivdia.outline.glslinc"
            ENDCG
        }
        
        Pass
        {
            Name "ForwardAdd"
            Tags { "LightMode" = "ForwardAdd" }
            Blend One One
            ZWrite Off Blend One One

            CGPROGRAM
            #include "../Code/ivdia.lighting.glslinc"
            ENDCG
        }
    }
    FallBack "Diffuse"
}
