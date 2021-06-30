// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:32719,y:32712,varname:node_4013,prsc:2|diff-4712-OUT,spec-8261-OUT,normal-2156-RGB,emission-6192-OUT,transm-3128-OUT,lwrap-3128-OUT,voffset-6992-OUT;n:type:ShaderForge.SFN_Color,id:1304,x:32256,y:32495,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_1304,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_TexCoord,id:1446,x:31196,y:32249,varname:node_1446,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ComponentMask,id:3094,x:31542,y:32249,varname:node_3094,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-4830-UVOUT;n:type:ShaderForge.SFN_Panner,id:4830,x:31377,y:32249,varname:node_4830,prsc:2,spu:0.1,spv:0|UVIN-1446-UVOUT;n:type:ShaderForge.SFN_Frac,id:3240,x:31704,y:32249,varname:node_3240,prsc:2|IN-3094-OUT;n:type:ShaderForge.SFN_Subtract,id:5948,x:31873,y:32249,varname:node_5948,prsc:2|A-3240-OUT,B-4836-OUT;n:type:ShaderForge.SFN_Vector1,id:4836,x:31704,y:32399,varname:node_4836,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Abs,id:1606,x:32025,y:32249,varname:node_1606,prsc:2|IN-5948-OUT;n:type:ShaderForge.SFN_Multiply,id:2525,x:32211,y:32249,varname:node_2525,prsc:2|A-1606-OUT,B-50-OUT;n:type:ShaderForge.SFN_Vector1,id:50,x:32025,y:32393,varname:node_50,prsc:2,v1:2;n:type:ShaderForge.SFN_Power,id:4092,x:32393,y:32249,varname:node_4092,prsc:2|VAL-2525-OUT,EXP-6354-OUT;n:type:ShaderForge.SFN_Vector1,id:6354,x:32211,y:32403,varname:node_6354,prsc:2,v1:5;n:type:ShaderForge.SFN_Set,id:342,x:32565,y:32249,varname:highligt,prsc:2|IN-4092-OUT;n:type:ShaderForge.SFN_Tex2d,id:3746,x:32516,y:32395,ptovrint:False,ptlb:node_3746,ptin:_node_3746,varname:node_3746,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:b66bceaf0cc0ace4e9bdc92f14bba709,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Lerp,id:4712,x:32496,y:32574,varname:node_4712,prsc:2|A-3746-RGB,B-1304-RGB,T-630-OUT;n:type:ShaderForge.SFN_Get,id:630,x:32248,y:32706,varname:node_630,prsc:2|IN-342-OUT;n:type:ShaderForge.SFN_Color,id:6381,x:31999,y:32899,ptovrint:False,ptlb:node_6381,ptin:_node_6381,varname:node_6381,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:6192,x:32309,y:32902,varname:node_6192,prsc:2|A-6381-RGB,B-3128-OUT;n:type:ShaderForge.SFN_Get,id:3128,x:32119,y:33048,varname:node_3128,prsc:2|IN-342-OUT;n:type:ShaderForge.SFN_NormalVector,id:5863,x:32123,y:33173,prsc:2,pt:False;n:type:ShaderForge.SFN_Multiply,id:6992,x:32359,y:33077,varname:node_6992,prsc:2|A-3128-OUT,B-1-OUT,C-5863-OUT;n:type:ShaderForge.SFN_Vector1,id:1,x:32124,y:33111,varname:node_1,prsc:2,v1:0.2;n:type:ShaderForge.SFN_Tex2d,id:2156,x:32065,y:32723,ptovrint:False,ptlb:node_2156,ptin:_node_2156,varname:node_2156,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:bbab0a6f7bae9cf42bf057d8ee2755f6,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Vector1,id:8261,x:32550,y:32736,varname:node_8261,prsc:2,v1:1;proporder:1304-6381-3746-2156;pass:END;sub:END;*/

Shader "Shader Forge/lesson03_10" {
    Properties {
        _Color ("Color", Color) = (0,0,0,1)
        _node_6381 ("node_6381", Color) = (1,0,0,1)
        _node_3746 ("node_3746", 2D) = "white" {}
        _node_2156 ("node_2156", 2D) = "bump" {}
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _Color;
            uniform sampler2D _node_3746; uniform float4 _node_3746_ST;
            uniform float4 _node_6381;
            uniform sampler2D _node_2156; uniform float4 _node_2156_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                UNITY_FOG_COORDS(7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 node_1531 = _Time;
                float highligt = pow((abs((frac((o.uv0+node_1531.g*float2(0.1,0)).r)-0.5))*2.0),5.0);
                float node_3128 = highligt;
                v.vertex.xyz += (node_3128*0.2*v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _node_2156_var = UnpackNormal(tex2D(_node_2156,TRANSFORM_TEX(i.uv0, _node_2156)));
                float3 normalLocal = _node_2156_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = 0.5;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float node_8261 = 1.0;
                float3 specularColor = float3(node_8261,node_8261,node_8261);
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = dot( normalDirection, lightDirection );
                float4 node_1531 = _Time;
                float highligt = pow((abs((frac((i.uv0+node_1531.g*float2(0.1,0)).r)-0.5))*2.0),5.0);
                float node_3128 = highligt;
                float3 w = float3(node_3128,node_3128,node_3128)*0.5; // Light wrapping
                float3 NdotLWrap = NdotL * ( 1.0 - w );
                float3 forwardLight = max(float3(0.0,0.0,0.0), NdotLWrap + w );
                float3 backLight = max(float3(0.0,0.0,0.0), -NdotLWrap + w ) * float3(node_3128,node_3128,node_3128);
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = (forwardLight+backLight) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                float4 _node_3746_var = tex2D(_node_3746,TRANSFORM_TEX(i.uv0, _node_3746));
                float3 diffuseColor = lerp(_node_3746_var.rgb,_Color.rgb,highligt);
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float3 emissive = (_node_6381.rgb*node_3128);
/// Final Color:
                float3 finalColor = diffuse + specular + emissive;
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
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _Color;
            uniform sampler2D _node_3746; uniform float4 _node_3746_ST;
            uniform float4 _node_6381;
            uniform sampler2D _node_2156; uniform float4 _node_2156_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                UNITY_FOG_COORDS(7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 node_4266 = _Time;
                float highligt = pow((abs((frac((o.uv0+node_4266.g*float2(0.1,0)).r)-0.5))*2.0),5.0);
                float node_3128 = highligt;
                v.vertex.xyz += (node_3128*0.2*v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _node_2156_var = UnpackNormal(tex2D(_node_2156,TRANSFORM_TEX(i.uv0, _node_2156)));
                float3 normalLocal = _node_2156_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = 0.5;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float node_8261 = 1.0;
                float3 specularColor = float3(node_8261,node_8261,node_8261);
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = dot( normalDirection, lightDirection );
                float4 node_4266 = _Time;
                float highligt = pow((abs((frac((i.uv0+node_4266.g*float2(0.1,0)).r)-0.5))*2.0),5.0);
                float node_3128 = highligt;
                float3 w = float3(node_3128,node_3128,node_3128)*0.5; // Light wrapping
                float3 NdotLWrap = NdotL * ( 1.0 - w );
                float3 forwardLight = max(float3(0.0,0.0,0.0), NdotLWrap + w );
                float3 backLight = max(float3(0.0,0.0,0.0), -NdotLWrap + w ) * float3(node_3128,node_3128,node_3128);
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = (forwardLight+backLight) * attenColor;
                float4 _node_3746_var = tex2D(_node_3746,TRANSFORM_TEX(i.uv0, _node_3746));
                float3 diffuseColor = lerp(_node_3746_var.rgb,_Color.rgb,highligt);
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
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
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 node_1063 = _Time;
                float highligt = pow((abs((frac((o.uv0+node_1063.g*float2(0.1,0)).r)-0.5))*2.0),5.0);
                float node_3128 = highligt;
                v.vertex.xyz += (node_3128*0.2*v.normal);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
