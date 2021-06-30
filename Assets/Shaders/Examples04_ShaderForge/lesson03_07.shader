// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33174,y:32763,varname:node_9361,prsc:2|custl-1545-OUT;n:type:ShaderForge.SFN_Dot,id:9138,x:32283,y:32734,cmnt:Lambert,varname:node_9138,prsc:2,dt:0|A-2771-OUT,B-7165-OUT;n:type:ShaderForge.SFN_LightVector,id:2771,x:32065,y:32652,varname:node_2771,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:7165,x:32065,y:32880,prsc:2,pt:True;n:type:ShaderForge.SFN_Dot,id:7126,x:32279,y:32953,cmnt:BlinnPhong,varname:node_7126,prsc:2,dt:1|A-7165-OUT,B-640-OUT;n:type:ShaderForge.SFN_HalfVector,id:640,x:32065,y:33120,varname:node_640,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:4408,x:32444,y:32472,ptovrint:False,ptlb:node_4408,ptin:_node_4408,varname:node_4408,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:b66bceaf0cc0ace4e9bdc92f14bba709,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:4392,x:32773,y:32566,varname:node_4392,prsc:2|A-4408-RGB,B-887-OUT;n:type:ShaderForge.SFN_LightColor,id:1660,x:32763,y:33006,varname:node_1660,prsc:2;n:type:ShaderForge.SFN_LightAttenuation,id:9667,x:32763,y:33131,varname:node_9667,prsc:2;n:type:ShaderForge.SFN_Vector1,id:8009,x:32283,y:32633,varname:node_8009,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:5969,x:32444,y:32693,varname:node_5969,prsc:2|A-8009-OUT,B-9138-OUT;n:type:ShaderForge.SFN_Add,id:887,x:32586,y:32633,varname:node_887,prsc:2|A-8009-OUT,B-5969-OUT;n:type:ShaderForge.SFN_Multiply,id:1545,x:32992,y:33006,varname:node_1545,prsc:2|A-6594-OUT,B-1660-RGB,C-9667-OUT;n:type:ShaderForge.SFN_Slider,id:8943,x:32279,y:33172,ptovrint:False,ptlb:node_8943,ptin:_node_8943,varname:node_8943,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:3.173411,max:10;n:type:ShaderForge.SFN_Power,id:4906,x:32573,y:32926,varname:node_4906,prsc:2|VAL-7126-OUT,EXP-8943-OUT;n:type:ShaderForge.SFN_Add,id:6594,x:32763,y:32839,varname:node_6594,prsc:2|A-4392-OUT,B-4906-OUT;proporder:4408-8943;pass:END;sub:END;*/

Shader "Shader Forge/lesson03_07" {
    Properties {
        _node_4408 ("node_4408", 2D) = "white" {}
        _node_8943 ("node_8943", Range(0, 10)) = 3.173411
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
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _node_4408; uniform float4 _node_4408_ST;
            uniform float _node_8943;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
                UNITY_FOG_COORDS(5)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float4 _node_4408_var = tex2D(_node_4408,TRANSFORM_TEX(i.uv0, _node_4408));
                float node_8009 = 0.5;
                float3 finalColor = (((_node_4408_var.rgb*(node_8009+(node_8009*dot(lightDirection,normalDirection))))+pow(max(0,dot(normalDirection,halfDirection)),_node_8943))*_LightColor0.rgb*attenuation);
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _node_4408; uniform float4 _node_4408_ST;
            uniform float _node_8943;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
                UNITY_FOG_COORDS(5)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float4 _node_4408_var = tex2D(_node_4408,TRANSFORM_TEX(i.uv0, _node_4408));
                float node_8009 = 0.5;
                float3 finalColor = (((_node_4408_var.rgb*(node_8009+(node_8009*dot(lightDirection,normalDirection))))+pow(max(0,dot(normalDirection,halfDirection)),_node_8943))*_LightColor0.rgb*attenuation);
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
