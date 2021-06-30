// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:9361,x:32554,y:32646,varname:node_9361,prsc:2|custl-9357-OUT;n:type:ShaderForge.SFN_Tex2d,id:8164,x:31876,y:32357,ptovrint:False,ptlb:node_8164,ptin:_node_8164,varname:node_8164,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:c23aa7dd1aa73bd41854935f98a5f4a2,ntxv:0,isnm:False|UVIN-5084-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:9475,x:31503,y:32477,varname:node_9475,prsc:2,uv:0;n:type:ShaderForge.SFN_Panner,id:5084,x:31703,y:32357,varname:node_5084,prsc:2,spu:0.2,spv:0|UVIN-9475-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:4413,x:31869,y:32617,ptovrint:False,ptlb:node_8164_copy,ptin:_node_8164_copy,varname:_node_8164_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:7c6e91970f7e1da46aa2e85a700dbc77,ntxv:0,isnm:False|UVIN-4926-UVOUT;n:type:ShaderForge.SFN_Panner,id:4926,x:31697,y:32617,varname:node_4926,prsc:2,spu:0,spv:0.3|UVIN-9475-UVOUT;n:type:ShaderForge.SFN_Add,id:7720,x:32051,y:32475,varname:node_7720,prsc:2|A-8164-RGB,B-4413-RGB;n:type:ShaderForge.SFN_Color,id:4636,x:32063,y:32767,ptovrint:False,ptlb:node_4636,ptin:_node_4636,varname:node_4636,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:9357,x:32210,y:32585,varname:node_9357,prsc:2|A-7720-OUT,B-4636-RGB;proporder:8164-4413-4636;pass:END;sub:END;*/

Shader "Shader Forge/UVEmission" {
    Properties {
        _node_8164 ("node_8164", 2D) = "white" {}
        _node_8164_copy ("node_8164_copy", 2D) = "white" {}
        [HDR]_node_4636 ("node_4636", Color) = (0.5,0.5,0.5,1)
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform sampler2D _node_8164; uniform float4 _node_8164_ST;
            uniform sampler2D _node_8164_copy; uniform float4 _node_8164_copy_ST;
            uniform float4 _node_4636;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos(v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
                float4 node_3474 = _Time + _TimeEditor;
                float2 node_5084 = (i.uv0+node_3474.g*float2(0.2,0));
                float4 _node_8164_var = tex2D(_node_8164,TRANSFORM_TEX(node_5084, _node_8164));
                float2 node_4926 = (i.uv0+node_3474.g*float2(0,0.3));
                float4 _node_8164_copy_var = tex2D(_node_8164_copy,TRANSFORM_TEX(node_4926, _node_8164_copy));
                float3 finalColor = ((_node_8164_var.rgb+_node_8164_copy_var.rgb)*_node_4636.rgb);
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
