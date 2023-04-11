// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/DoubleSide"
{
	Properties
	{
		_FrontTex("FrontTex", 2D) = "white" {}
		[HDR]_FrontColor("FrontColor", Color) = (1,0.9544128,0,1)
		_FresnelPower("FresnelPower", Vector) = (0,1,5,0)
		_BackTex("BackTex", 2D) = "white" {}
		_BackSpeed("BackSpeed", Vector) = (3,3,0.2,0.2)
		_NoiseTex("NoiseTex", 2D) = "white" {}
		_NoiseSpeed("NoiseSpeed", Vector) = (1,1,0.2,0.2)
		_NoisePower("NoisePower", Range( 0 , 1)) = 0
		[HDR]_NoiseColor("NoiseColor", Color) = (1,0.8885648,0,1)
		_AddTex("AddTex", 2D) = "white" {}
		_AddSpeed("AddSpeed", Vector) = (1,1,0.86,0.2)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha
		AlphaToMask Off
		Cull Off
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float3 ase_normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform sampler2D _FrontTex;
			uniform float4 _FrontTex_ST;
			uniform float3 _FresnelPower;
			uniform float4 _FrontColor;
			uniform sampler2D _BackTex;
			uniform float4 _BackSpeed;
			uniform float4 _NoiseColor;
			uniform sampler2D _AddTex;
			uniform float4 _AddSpeed;
			uniform sampler2D _NoiseTex;
			uniform float4 _NoiseSpeed;
			uniform float _NoisePower;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float3 ase_worldNormal = UnityObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord2.xyz = ase_worldNormal;
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord3 = screenPos;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				o.ase_texcoord2.w = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i , half ase_vface : VFACE) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				float2 uv_FrontTex = i.ase_texcoord1.xy * _FrontTex_ST.xy + _FrontTex_ST.zw;
				float3 ase_worldViewDir = UnityWorldSpaceViewDir(WorldPosition);
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_worldNormal = i.ase_texcoord2.xyz;
				float fresnelNdotV4 = dot( ase_worldNormal, ase_worldViewDir );
				float fresnelNode4 = ( _FresnelPower.x + _FresnelPower.y * pow( 1.0 - fresnelNdotV4, _FresnelPower.z ) );
				float2 appendResult16 = (float2(_BackSpeed.z , _BackSpeed.w));
				float4 screenPos = i.ase_texcoord3;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float4 temp_output_11_0 = (ase_screenPosNorm).xyzw;
				float2 appendResult15 = (float2(_BackSpeed.x , _BackSpeed.y));
				float2 panner17 = ( 1.0 * _Time.y * appendResult16 + ( temp_output_11_0 * float4( appendResult15, 0.0 , 0.0 ) ).xy);
				float2 appendResult22 = (float2(_AddSpeed.z , _AddSpeed.w));
				float2 appendResult20 = (float2(_AddSpeed.x , _AddSpeed.y));
				float2 panner19 = ( 1.0 * _Time.y * appendResult22 + ( temp_output_11_0 * float4( appendResult20, 0.0 , 0.0 ) ).xy);
				float2 appendResult27 = (float2(_NoiseSpeed.z , _NoiseSpeed.w));
				float2 appendResult25 = (float2(_NoiseSpeed.x , _NoiseSpeed.y));
				float2 panner24 = ( 1.0 * _Time.y * appendResult27 + ( temp_output_11_0 * float4( appendResult25, 0.0 , 0.0 ) ).xy);
				float4 lerpResult33 = lerp( float4( panner19, 0.0 , 0.0 ) , tex2D( _NoiseTex, panner24 ) , _NoisePower);
				float4 switchResult1 = (((ase_vface>0)?(( tex2D( _FrontTex, uv_FrontTex ) + ( saturate( fresnelNode4 ) * _FrontColor ) )):(( tex2D( _BackTex, panner17 ) + ( _NoiseColor * tex2D( _AddTex, lerpResult33.rg ) ) ))));
				
				
				finalColor = switchResult1;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18909
0;73;830;926;932.7589;-161.3519;1.301857;True;False
Node;AmplifyShaderEditor.CommentaryNode;53;-1440.758,484.2463;Inherit;False;2107.111;995.6694;Comment;31;39;18;57;56;17;42;12;16;35;15;29;37;13;33;32;41;34;24;19;27;23;22;28;20;30;31;25;26;21;11;10;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;10;-1416.497,869.1945;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;11;-1242.505,868.7195;Inherit;False;True;True;True;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector4Node;21;-1040.125,983.4242;Inherit;False;Property;_AddSpeed;AddSpeed;10;0;Create;True;0;0;0;False;0;False;1,1,0.86,0.2;2,2,0.5,0.5;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;26;-1035.895,1268.988;Inherit;False;Property;_NoiseSpeed;NoiseSpeed;6;0;Create;True;0;0;0;False;0;False;1,1,0.2,0.2;1,1,0.2,0.2;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;25;-820.6746,1296.8;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;31;-1074.161,1174.317;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;30;-1061.578,904.1588;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;20;-824.9041,1011.237;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;27;-642.033,1344.24;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-650.6728,887.5095;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-651.2491,1157.055;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;22;-644.6605,1026.641;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;19;-498.4971,946.4429;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;24;-494.268,1232.006;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-296.5383,1392.252;Inherit;False;Property;_NoisePower;NoisePower;7;0;Create;True;0;0;0;False;0;False;0;0.42;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;41;-47.75339,1048.255;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;32;-314.3664,1204.621;Inherit;True;Property;_NoiseTex;NoiseTex;5;0;Create;True;0;0;0;False;0;False;-1;None;095ad711c9803a846b03edfe465c7da1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;33;-10.83168,1184.36;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;9;-371.8211,-14.56248;Inherit;False;1038.209;486.7547;Comment;7;3;6;2;7;5;4;8;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector4Node;13;-1055.086,684.4654;Inherit;False;Property;_BackSpeed;BackSpeed;4;0;Create;True;0;0;0;False;0;False;3,3,0.2,0.2;2,2,0.2,0.2;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;15;-839.8658,712.2788;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;8;-354.8211,223.5011;Inherit;False;Property;_FresnelPower;FresnelPower;2;0;Create;True;0;0;0;False;0;False;0,1,5;0.01,1,5;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;35;141.4301,1154.762;Inherit;True;Property;_AddTex;AddTex;9;0;Create;True;0;0;0;False;0;False;-1;None;f14221021a0ce0f4294a0c2a48712378;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;29;-1086.768,627.1802;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;37;224.2345,958.0142;Inherit;False;Property;_NoiseColor;NoiseColor;8;1;[HDR];Create;True;0;0;0;False;0;False;1,0.8885648,0,1;0,0.04867458,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;4;-183.8213,221.5011;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;16;-661.2242,759.7189;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-670.4402,572.5316;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;457.6223,1056.113;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;17;-513.4587,647.4835;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;56;575.9537,857.4157;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;7;96.1787,298.5009;Inherit;False;Property;_FrontColor;FrontColor;1;1;[HDR];Create;True;0;0;0;False;0;False;1,0.9544128,0,1;4,0,3.424671,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;5;131.1787,230.5011;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;57;379.9141,821.5154;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;18;-67.55982,623.8589;Inherit;True;Property;_BackTex;BackTex;3;0;Create;True;0;0;0;False;0;False;-1;None;9b4269b3e7cd7de4293de532ee4a9104;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;319.1787,240.5011;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;125.9538,32.43752;Inherit;True;Property;_FrontTex;FrontTex;0;0;Create;True;0;0;0;False;0;False;-1;None;afedfdb04e349444f9e41cadb80d44d3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;39;415.2823,636.002;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;3;465.3789,160.2011;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;59;722.0654,255.4542;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;58;723.4063,591.8881;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwitchByFaceNode;1;736.1293,367.2356;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;910.3923,367.1957;Float;False;True;-1;2;ASEMaterialInspector;100;1;Custom/DoubleSide;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;2;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;2;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;11;0;10;0
WireConnection;25;0;26;1
WireConnection;25;1;26;2
WireConnection;31;0;11;0
WireConnection;30;0;11;0
WireConnection;20;0;21;1
WireConnection;20;1;21;2
WireConnection;27;0;26;3
WireConnection;27;1;26;4
WireConnection;23;0;30;0
WireConnection;23;1;20;0
WireConnection;28;0;31;0
WireConnection;28;1;25;0
WireConnection;22;0;21;3
WireConnection;22;1;21;4
WireConnection;19;0;23;0
WireConnection;19;2;22;0
WireConnection;24;0;28;0
WireConnection;24;2;27;0
WireConnection;41;0;19;0
WireConnection;32;1;24;0
WireConnection;33;0;41;0
WireConnection;33;1;32;0
WireConnection;33;2;34;0
WireConnection;15;0;13;1
WireConnection;15;1;13;2
WireConnection;35;1;33;0
WireConnection;29;0;11;0
WireConnection;4;1;8;1
WireConnection;4;2;8;2
WireConnection;4;3;8;3
WireConnection;16;0;13;3
WireConnection;16;1;13;4
WireConnection;12;0;29;0
WireConnection;12;1;15;0
WireConnection;42;0;37;0
WireConnection;42;1;35;0
WireConnection;17;0;12;0
WireConnection;17;2;16;0
WireConnection;56;0;42;0
WireConnection;5;0;4;0
WireConnection;57;0;56;0
WireConnection;18;1;17;0
WireConnection;6;0;5;0
WireConnection;6;1;7;0
WireConnection;39;0;18;0
WireConnection;39;1;57;0
WireConnection;3;0;2;0
WireConnection;3;1;6;0
WireConnection;59;0;3;0
WireConnection;58;0;39;0
WireConnection;1;0;59;0
WireConnection;1;1;58;0
WireConnection;0;0;1;0
ASEEND*/
//CHKSM=D22A27F8291E8CD3BBC541CF41574051B2924EDD