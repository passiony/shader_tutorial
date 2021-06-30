// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33859,y:32692,varname:node_9361,prsc:2|custl-7614-OUT,clip-1691-OUT;n:type:ShaderForge.SFN_TexCoord,id:8508,x:31774,y:32675,varname:node_8508,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Tex2d,id:6660,x:32693,y:32674,varname:node_6660,prsc:2,tex:53c82e68c12a8894dae421be21da895d,ntxv:3,isnm:False|UVIN-8902-OUT,TEX-6995-TEX;n:type:ShaderForge.SFN_Color,id:1387,x:33089,y:32440,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_1387,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:1223,x:33106,y:32612,varname:node_1223,prsc:2|A-1387-RGB,B-6660-RGB;n:type:ShaderForge.SFN_Tex2d,id:1454,x:32671,y:33053,varname:_node_6660_copy,prsc:2,tex:53c82e68c12a8894dae421be21da895d,ntxv:2,isnm:False|UVIN-8902-OUT,TEX-6995-TEX;n:type:ShaderForge.SFN_Vector1,id:743,x:33070,y:33168,varname:node_743,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Step,id:8439,x:33070,y:33244,varname:node_8439,prsc:2|A-743-OUT,B-3406-OUT;n:type:ShaderForge.SFN_Multiply,id:3406,x:32858,y:33168,varname:node_3406,prsc:2|A-1454-R,B-6890-OUT;n:type:ShaderForge.SFN_Vector1,id:7341,x:33048,y:32898,varname:node_7341,prsc:2,v1:0.4;n:type:ShaderForge.SFN_Step,id:1691,x:33058,y:32972,varname:node_1691,prsc:2|A-7341-OUT,B-3406-OUT;n:type:ShaderForge.SFN_Subtract,id:8559,x:33292,y:33098,cmnt:Outline,varname:node_8559,prsc:2|A-1691-OUT,B-8439-OUT;n:type:ShaderForge.SFN_Add,id:7614,x:33653,y:32777,varname:node_7614,prsc:2|A-1223-OUT,B-4974-OUT;n:type:ShaderForge.SFN_Color,id:5247,x:33292,y:32836,ptovrint:False,ptlb:Edge,ptin:_Edge,varname:node_5247,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:4974,x:33492,y:32860,varname:node_4974,prsc:2|A-5247-RGB,B-8559-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:6995,x:32359,y:32895,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_6995,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:53c82e68c12a8894dae421be21da895d,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Vector2,id:7165,x:32018,y:33177,varname:node_7165,prsc:2,v1:0.5,v2:0.2;n:type:ShaderForge.SFN_Distance,id:6807,x:32189,y:33159,varname:node_6807,prsc:2|A-8508-UVOUT,B-7165-OUT;n:type:ShaderForge.SFN_OneMinus,id:426,x:32350,y:33159,varname:node_426,prsc:2|IN-6807-OUT;n:type:ShaderForge.SFN_Power,id:6890,x:32600,y:33257,cmnt:PositionShape,varname:node_6890,prsc:2|VAL-426-OUT,EXP-5566-OUT;n:type:ShaderForge.SFN_Slider,id:5566,x:32286,y:33355,ptovrint:False,ptlb:Strenth,ptin:_Strenth,varname:node_5566,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1.34188,max:5;n:type:ShaderForge.SFN_Append,id:8902,x:32312,y:32527,varname:node_8902,prsc:2|A-8508-U,B-9767-OUT;n:type:ShaderForge.SFN_Time,id:8413,x:31821,y:32852,varname:node_8413,prsc:2;n:type:ShaderForge.SFN_Add,id:9767,x:32218,y:32785,cmnt:Speed,varname:node_9767,prsc:2|A-4662-OUT,B-5657-OUT;n:type:ShaderForge.SFN_OneMinus,id:4662,x:32053,y:32685,varname:node_4662,prsc:2|IN-8508-V;n:type:ShaderForge.SFN_Slider,id:6042,x:31703,y:33007,ptovrint:False,ptlb:Speed,ptin:_Speed,varname:node_6042,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:20;n:type:ShaderForge.SFN_Multiply,id:5657,x:32053,y:32835,varname:node_5657,prsc:2|A-8413-TSL,B-6042-OUT;proporder:1387-5247-6995-5566-6042;pass:END;sub:END;*/

Shader "Shader Forge/lesson03_16" {
    Properties {
        [HDR]_Color ("Color", Color) = (1,0,0,1)
        [HDR]_Edge ("Edge", Color) = (1,1,0,1)
        _MainTex ("MainTex", 2D) = "white" {}
        _Strenth ("Strenth", Range(0, 5)) = 1.34188
        _Speed ("Speed", Range(0, 20)) = 1
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
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _Color;
            uniform float4 _Edge;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Strenth;
            uniform float _Speed;
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
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 node_8413 = _Time;
                float2 node_8902 = float2(i.uv0.r,((1.0 - i.uv0.g)+(node_8413.r*_Speed)));
                float4 _node_6660_copy = tex2D(_MainTex,TRANSFORM_TEX(node_8902, _MainTex));
                float node_3406 = (_node_6660_copy.r*pow((1.0 - distance(i.uv0,float2(0.5,0.2))),_Strenth));
                float node_1691 = step(0.4,node_3406);
                clip(node_1691 - 0.5);
////// Lighting:
                float4 node_6660 = tex2D(_MainTex,TRANSFORM_TEX(node_8902, _MainTex));
                float3 finalColor = ((_Color.rgb*node_6660.rgb)+(_Edge.rgb*(node_1691-step(0.5,node_3406))));
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
            Cull Off
            
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
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Strenth;
            uniform float _Speed;
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
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 node_8413 = _Time;
                float2 node_8902 = float2(i.uv0.r,((1.0 - i.uv0.g)+(node_8413.r*_Speed)));
                float4 _node_6660_copy = tex2D(_MainTex,TRANSFORM_TEX(node_8902, _MainTex));
                float node_3406 = (_node_6660_copy.r*pow((1.0 - distance(i.uv0,float2(0.5,0.2))),_Strenth));
                float node_1691 = step(0.4,node_3406);
                clip(node_1691 - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
