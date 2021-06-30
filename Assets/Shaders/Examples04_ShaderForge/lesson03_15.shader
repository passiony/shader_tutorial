// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:33236,y:32985,varname:node_4013,prsc:2|custl-3859-OUT,clip-6982-OUT;n:type:ShaderForge.SFN_TexCoord,id:4738,x:31452,y:32924,varname:node_4738,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:8345,x:32135,y:32943,varname:node_8345,prsc:2,spu:0,spv:2|UVIN-4738-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:4376,x:32326,y:32943,ptovrint:False,ptlb:node_4376,ptin:_node_4376,varname:node_4376,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:f1323a39ff483f64a985c7a5dd3acf97,ntxv:3,isnm:False|UVIN-8345-UVOUT;n:type:ShaderForge.SFN_Color,id:8355,x:32310,y:32711,ptovrint:False,ptlb:node_8355,ptin:_node_8355,varname:node_8355,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.9862069,c2:1,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:739,x:32534,y:32889,varname:node_739,prsc:2|A-8355-RGB,B-4376-RGB;n:type:ShaderForge.SFN_Tex2d,id:3420,x:32166,y:33338,ptovrint:False,ptlb:node_3420,ptin:_node_3420,varname:node_3420,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:f1323a39ff483f64a985c7a5dd3acf97,ntxv:3,isnm:False|UVIN-8345-UVOUT;n:type:ShaderForge.SFN_Vector1,id:1588,x:32166,y:33237,varname:node_1588,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Step,id:992,x:32488,y:33183,varname:node_992,prsc:2|A-1588-OUT,B-5175-OUT;n:type:ShaderForge.SFN_Multiply,id:5175,x:32325,y:33458,varname:node_5175,prsc:2|A-3420-R,B-3638-OUT;n:type:ShaderForge.SFN_Vector1,id:8926,x:32307,y:33647,varname:node_8926,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Subtract,id:1564,x:32534,y:33539,varname:node_1564,prsc:2|A-1588-OUT,B-8926-OUT;n:type:ShaderForge.SFN_Step,id:6982,x:32637,y:33399,varname:node_6982,prsc:2|A-1564-OUT,B-5175-OUT;n:type:ShaderForge.SFN_Subtract,id:4673,x:32691,y:33215,varname:node_4673,prsc:2|A-6982-OUT,B-992-OUT;n:type:ShaderForge.SFN_Add,id:3859,x:33058,y:32985,varname:node_3859,prsc:2|A-739-OUT,B-9007-OUT;n:type:ShaderForge.SFN_Color,id:4395,x:32691,y:33062,ptovrint:False,ptlb:node_4395,ptin:_node_4395,varname:node_4395,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:9007,x:32890,y:33129,varname:node_9007,prsc:2|A-4395-RGB,B-4673-OUT;n:type:ShaderForge.SFN_Distance,id:8519,x:31581,y:33231,varname:node_8519,prsc:2|A-4738-UVOUT,B-6612-OUT;n:type:ShaderForge.SFN_Vector2,id:6612,x:31382,y:33265,varname:node_6612,prsc:2,v1:0.5,v2:0.8;n:type:ShaderForge.SFN_OneMinus,id:8306,x:31678,y:33378,varname:node_8306,prsc:2|IN-8519-OUT;n:type:ShaderForge.SFN_Power,id:3638,x:31897,y:33437,varname:node_3638,prsc:2|VAL-8306-OUT,EXP-2513-OUT;n:type:ShaderForge.SFN_Slider,id:2513,x:31550,y:33574,ptovrint:False,ptlb:node_2513,ptin:_node_2513,varname:node_2513,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1.995823,max:10;proporder:4376-8355-3420-4395-2513;pass:END;sub:END;*/

Shader "Shader Forge/lesson03_15" {
    Properties {
        _node_4376 ("node_4376", 2D) = "bump" {}
        [HDR]_node_8355 ("node_8355", Color) = (0.9862069,1,0,1)
        _node_3420 ("node_3420", 2D) = "bump" {}
        [HDR]_node_4395 ("node_4395", Color) = (1,0,0,1)
        _node_2513 ("node_2513", Range(0, 10)) = 1.995823
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
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
            uniform sampler2D _node_4376; uniform float4 _node_4376_ST;
            uniform float4 _node_8355;
            uniform sampler2D _node_3420; uniform float4 _node_3420_ST;
            uniform float4 _node_4395;
            uniform float _node_2513;
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
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float node_1588 = 0.5;
                float4 node_2661 = _Time;
                float2 node_8345 = (i.uv0+node_2661.g*float2(0,2));
                float4 _node_3420_var = tex2D(_node_3420,TRANSFORM_TEX(node_8345, _node_3420));
                float node_5175 = (_node_3420_var.r*pow((1.0 - distance(i.uv0,float2(0.5,0.8))),_node_2513));
                float node_6982 = step((node_1588-0.1),node_5175);
                clip(node_6982 - 0.5);
////// Lighting:
                float4 _node_4376_var = tex2D(_node_4376,TRANSFORM_TEX(node_8345, _node_4376));
                float3 finalColor = ((_node_8355.rgb*_node_4376_var.rgb)+(_node_4395.rgb*(node_6982-step(node_1588,node_5175))));
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
            uniform sampler2D _node_3420; uniform float4 _node_3420_ST;
            uniform float _node_2513;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float node_1588 = 0.5;
                float4 node_8432 = _Time;
                float2 node_8345 = (i.uv0+node_8432.g*float2(0,2));
                float4 _node_3420_var = tex2D(_node_3420,TRANSFORM_TEX(node_8345, _node_3420));
                float node_5175 = (_node_3420_var.r*pow((1.0 - distance(i.uv0,float2(0.5,0.8))),_node_2513));
                float node_6982 = step((node_1588-0.1),node_5175);
                clip(node_6982 - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
