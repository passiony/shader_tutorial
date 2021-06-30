// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:9361,x:33519,y:32804,varname:node_9361,prsc:2|emission-1856-OUT;n:type:ShaderForge.SFN_Tex2d,id:7576,x:32321,y:32579,ptovrint:False,ptlb:Main1,ptin:_Main1,varname:node_7576,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:f5dfd00af58c3a3439aca5429b1aa5e4,ntxv:0,isnm:False|UVIN-98-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:8398,x:31857,y:32880,varname:node_8398,prsc:2,uv:0;n:type:ShaderForge.SFN_Panner,id:98,x:32156,y:32579,varname:node_98,prsc:2,spu:0,spv:0.1|UVIN-8398-UVOUT;n:type:ShaderForge.SFN_Slider,id:7071,x:32560,y:32485,ptovrint:False,ptlb:node_7071,ptin:_node_7071,varname:node_7071,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.8051361,max:10;n:type:ShaderForge.SFN_Multiply,id:6847,x:32727,y:32691,varname:node_6847,prsc:2|A-7071-OUT,B-5381-OUT;n:type:ShaderForge.SFN_Tex2d,id:1888,x:33107,y:32823,ptovrint:False,ptlb:Niuqu,ptin:_Niuqu,varname:node_1888,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:7c6e91970f7e1da46aa2e85a700dbc77,ntxv:0,isnm:False|UVIN-564-OUT;n:type:ShaderForge.SFN_Add,id:564,x:32891,y:33095,varname:node_564,prsc:2|A-6847-OUT,B-1431-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:6374,x:32318,y:32872,ptovrint:False,ptlb:Main2,ptin:_Main2,varname:_node_7576_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:5a656486bc1ce3e438384eca1850e411,ntxv:0,isnm:False|UVIN-5869-UVOUT;n:type:ShaderForge.SFN_Panner,id:5869,x:32153,y:32872,varname:node_5869,prsc:2,spu:0,spv:0.1|UVIN-8398-UVOUT;n:type:ShaderForge.SFN_Add,id:5381,x:32549,y:32711,varname:node_5381,prsc:2|A-7576-R,B-6374-R;n:type:ShaderForge.SFN_Panner,id:1431,x:32167,y:33115,varname:node_1431,prsc:2,spu:0,spv:0.3|UVIN-8398-UVOUT;n:type:ShaderForge.SFN_Color,id:3013,x:33085,y:32589,ptovrint:False,ptlb:node_3013,ptin:_node_3013,varname:node_3013,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:1856,x:33316,y:32603,varname:node_1856,prsc:2|A-3013-RGB,B-1888-RGB;proporder:7576-6374-1888-7071-3013;pass:END;sub:END;*/

Shader "Shader Forge/floor" {
    Properties {
        _Main1 ("Main1", 2D) = "white" {}
        _Main2 ("Main2", 2D) = "white" {}
        _Niuqu ("Niuqu", 2D) = "white" {}
        _node_7071 ("node_7071", Range(0, 10)) = 0.8051361
        [HDR]_node_3013 ("node_3013", Color) = (0.5,0.5,0.5,1)
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
            uniform sampler2D _Main1; uniform float4 _Main1_ST;
            uniform float _node_7071;
            uniform sampler2D _Niuqu; uniform float4 _Niuqu_ST;
            uniform sampler2D _Main2; uniform float4 _Main2_ST;
            uniform float4 _node_3013;
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
////// Emissive:
                float4 node_8487 = _Time + _TimeEditor;
                float2 node_98 = (i.uv0+node_8487.g*float2(0,0.1));
                float4 _Main1_var = tex2D(_Main1,TRANSFORM_TEX(node_98, _Main1));
                float2 node_5869 = (i.uv0+node_8487.g*float2(0,0.1));
                float4 _Main2_var = tex2D(_Main2,TRANSFORM_TEX(node_5869, _Main2));
                float2 node_564 = ((_node_7071*(_Main1_var.r+_Main2_var.r))+(i.uv0+node_8487.g*float2(0,0.3)));
                float4 _Niuqu_var = tex2D(_Niuqu,TRANSFORM_TEX(node_564, _Niuqu));
                float3 emissive = (_node_3013.rgb*_Niuqu_var.rgb);
                float3 finalColor = emissive;
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
