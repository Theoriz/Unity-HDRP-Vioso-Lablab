Shader "Hidden/Shader/TextureBlitPostProcess"
{
    HLSLINCLUDE

    #pragma target 4.5
    #pragma only_renderers d3d11 playstation xboxone vulkan metal switch

    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/PostProcessing/Shaders/FXAA.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/PostProcessing/Shaders/RTUpscale.hlsl"

    struct Attributes
    {
        uint vertexID : SV_VertexID;
        UNITY_VERTEX_INPUT_INSTANCE_ID
    };

    struct Varyings
    {
        float4 positionCS : SV_POSITION;
        float2 texcoord   : TEXCOORD0;
        UNITY_VERTEX_OUTPUT_STEREO
    };

    Varyings Vert(Attributes input)
    {
        Varyings output;
        UNITY_SETUP_INSTANCE_ID(input);
        UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);
        output.positionCS = GetFullScreenTriangleVertexPosition(input.vertexID);
        output.texcoord = GetFullScreenTriangleTexCoord(input.vertexID);
        return output;
    }

    // List of properties to control your post process effect
    float2 _InputResolution;
    sampler2D _TextureToBlit1;
    sampler2D _TextureToBlit2;
    sampler2D _TextureToBlit3;
    sampler2D _TextureToBlit4;

    float4 CustomPostProcess(Varyings input) : SV_Target
    {
        UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

        //Coordinates in input uv space
        float2 scaledCoord = input.texcoord * _ScreenSize.xy / _InputResolution;

        float3 outColor = float3(0, 0, 0);
        float2 offset = float2(0, 1);

        if (scaledCoord.x > 1 && scaledCoord.y <= 1) {
            //Bottom Right
            outColor = tex2D(_TextureToBlit4, scaledCoord - offset.yx);
        } 
        else if (scaledCoord.x > 1 && scaledCoord.y > 1) {
            //Top Right
            outColor = tex2D(_TextureToBlit2, scaledCoord - offset.yy);
        }
        else if (scaledCoord.x <= 1 && scaledCoord.y > 1) {
            //Top Left
            outColor = tex2D(_TextureToBlit1, scaledCoord - offset.xy);
        }
        else {
            //Bottom Left
            outColor = tex2D(_TextureToBlit3, scaledCoord);
        }

        return float4(outColor, 1);
    }

    ENDHLSL

    SubShader
    {
        Pass
        {
            Name "TextureBlitPostProcess"

            ZWrite Off
            ZTest Always
            Blend Off
            Cull Off

            HLSLPROGRAM
                #pragma fragment CustomPostProcess
                #pragma vertex Vert
            ENDHLSL
        }
    }
    Fallback Off
}
