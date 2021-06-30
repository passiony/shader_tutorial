// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33209,y:32712,varname:node_9361,prsc:2|custl-7100-RGB,voffset-5395-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:5331,x:32187,y:32515,varname:node_5331,prsc:2;n:type:ShaderForge.SFN_ObjectPosition,id:6418,x:32187,y:32648,varname:node_6418,prsc:2;n:type:ShaderForge.SFN_Subtract,id:65,x:32364,y:32591,varname:node_65,prsc:2|A-5331-XYZ,B-6418-XYZ;n:type:ShaderForge.SFN_Set,id:9080,x:32535,y:32591,varname:LocalPosition,prsc:2|IN-65-OUT;n:type:ShaderForge.SFN_Get,id:928,x:32144,y:32931,varname:node_928,prsc:2|IN-9080-OUT;n:type:ShaderForge.SFN_ComponentMask,id:2517,x:32338,y:32931,varname:node_2517,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-928-OUT;n:type:ShaderForge.SFN_Add,id:6588,x:32524,y:32931,varname:node_6588,prsc:2|A-2517-R,B-2517-B,C-8579-T;n:type:ShaderForge.SFN_Time,id:8579,x:32338,y:33094,varname:node_8579,prsc:2;n:type:ShaderForge.SFN_Sin,id:7426,x:32683,y:32931,varname:node_7426,prsc:2|IN-6588-OUT;n:type:ShaderForge.SFN_Vector3,id:6618,x:32683,y:33067,varname:node_6618,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_Multiply,id:5395,x:32851,y:32987,varname:node_5395,prsc:2|A-7426-OUT,B-6618-OUT,C-8457-U,D-528-OUT;n:type:ShaderForge.SFN_Tex2d,id:7100,x:32999,y:32640,ptovrint:False,ptlb:node_7100,ptin:_node_7100,varname:node_7100,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:41a4db52e439bd74490add92075101ff,ntxv:0,isnm:False;n:type:ShaderForge.SFN_TexCoord,id:8457,x:32683,y:33175,varname:node_8457,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ValueProperty,id:528,x:32683,y:33342,ptovrint:False,ptlb:node_528,ptin:_node_528,varname:node_528,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;proporder:7100-528;pass:END;sub:END;*/

Shader "Shader Forge/lesson03_11" {
    Properties {
        _node_7100 ("node_7100", 2D) = "white" {}
        _node_528 ("node_528", Float ) = 1
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _node_7100; uniform float4 _node_7100_ST;
            uniform float _node_528;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float3 LocalPosition = (mul(unity_ObjectToWorld, v.vertex).rgb-objPos.rgb);
                float3 node_2517 = LocalPosition.rgb;
                float4 node_8579 = _Time;
                v.vertex.xyz += (sin((node_2517.r+node_2517.b+node_8579.g))*float3(0,1,0)*o.uv0.r*_node_528);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
////// Lighting:
                float4 _node_7100_var = tex2D(_node_7100,TRANSFORM_TEX(i.uv0, _node_7100));
                float3 finalColor = _node_7100_var.rgb;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float _node_528;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float3 LocalPosition = (mul(unity_ObjectToWorld, v.vertex).rgb-objPos.rgb);
                float3 node_2517 = LocalPosition.rgb;
                float4 node_8579 = _Time;
                v.vertex.xyz += (sin((node_2517.r+node_2517.b+node_8579.g))*float3(0,1,0)*o.uv0.r*_node_528);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
