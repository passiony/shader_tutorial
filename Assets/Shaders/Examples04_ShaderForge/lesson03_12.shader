// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:Legacy Shaders/Diffuse,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:6,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:False,qofs:0,qpre:3,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33209,y:32712,varname:node_9361,prsc:2|custl-2060-OUT;n:type:ShaderForge.SFN_ScreenPos,id:288,x:32522,y:32646,varname:node_288,prsc:2,sctp:2;n:type:ShaderForge.SFN_SceneDepth,id:8183,x:32701,y:32646,varname:node_8183,prsc:2|UV-288-UVOUT;n:type:ShaderForge.SFN_Depth,id:6016,x:32701,y:32767,varname:node_6016,prsc:2;n:type:ShaderForge.SFN_If,id:2060,x:33032,y:32953,varname:node_2060,prsc:2|A-8183-OUT,B-6016-OUT,GT-9906-RGB,EQ-9906-RGB,LT-9548-OUT;n:type:ShaderForge.SFN_Tex2d,id:9906,x:32250,y:32793,ptovrint:False,ptlb:node_9906,ptin:_node_9906,varname:node_9906,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:31f83ccc3181cfa4db2fbde67cc33f66,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Fresnel,id:2141,x:32541,y:33123,varname:node_2141,prsc:2;n:type:ShaderForge.SFN_Color,id:1866,x:32530,y:33289,ptovrint:False,ptlb:RimColor,ptin:_RimColor,varname:node_1866,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.08347746,c2:0.4264706,c3:0.01881487,c4:1;n:type:ShaderForge.SFN_Multiply,id:9548,x:32712,y:33123,varname:node_9548,prsc:2|A-2141-OUT,B-1866-RGB,C-6476-OUT;n:type:ShaderForge.SFN_Slider,id:6476,x:32373,y:33479,ptovrint:False,ptlb:RimValue,ptin:_RimValue,varname:node_6476,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:1,max:10;proporder:9906-1866-6476;pass:END;sub:END;*/

Shader "Shader Forge/CullMask" {
    Properties {
        _node_9906 ("node_9906", 2D) = "white" {}
        [HDR]_RimColor ("RimColor", Color) = (0.08347746,0.4264706,0.01881487,1)
        _RimValue ("RimValue", Range(1, 10)) = 1
    }
    SubShader {
        Tags {
            "Queue"="Transparent"
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            ZTest Always
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _CameraDepthTexture;
            uniform sampler2D _node_9906; uniform float4 _node_9906_ST;
            uniform float4 _RimColor;
            uniform float _RimValue;
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
                float4 projPos : TEXCOORD3;
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
////// Lighting:
                float node_2060_if_leA = step(max(0, LinearEyeDepth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, sceneUVs.rg)) - _ProjectionParams.g),partZ);
                float node_2060_if_leB = step(partZ,max(0, LinearEyeDepth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, sceneUVs.rg)) - _ProjectionParams.g));
                float4 _node_9906_var = tex2D(_node_9906,TRANSFORM_TEX(i.uv0, _node_9906));
                float3 finalColor = lerp((node_2060_if_leA*((1.0-max(0,dot(normalDirection, viewDirection)))*_RimColor.rgb*_RimValue))+(node_2060_if_leB*_node_9906_var.rgb),_node_9906_var.rgb,node_2060_if_leA*node_2060_if_leB);
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Legacy Shaders/Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
