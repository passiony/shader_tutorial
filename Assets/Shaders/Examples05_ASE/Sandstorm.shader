// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/Sandstorm"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_SpeedX("SpeedX", Range( -1 , 1)) = -0.5
		_SpeedY("SpeedY", Range( -1 , 1)) = 0.5
		_Noise("Noise", 2D) = "white" {}
		_NoiseX("NoiseX", Range( -1 , 1)) = -0.3964329
		_NoiseY("NoiseY", Range( -1 , 1)) = 0.521459
		_Tint("Tint", Color) = (1,0.9864793,0,0.1019608)

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite Off
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


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform sampler2D _MainTex;
			uniform float _SpeedX;
			uniform float _SpeedY;
			uniform float4 _Tint;
			uniform sampler2D _Noise;
			uniform float _NoiseX;
			uniform float _NoiseY;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
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
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				float4 appendResult10 = (float4(_SpeedX , _SpeedY , 0.0 , 0.0));
				float2 temp_cast_1 = (6.0).xx;
				float2 texCoord7 = i.ase_texcoord1.xy * temp_cast_1 + float2( 0,0 );
				float2 panner8 = ( 1.0 * _Time.y * appendResult10.xy + texCoord7);
				float4 appendResult26 = (float4(_NoiseX , _NoiseY , 0.0 , 0.0));
				float2 texCoord25 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner27 = ( 1.0 * _Time.y * appendResult26.xy + texCoord25);
				
				
				finalColor = ( tex2D( _MainTex, panner8 ) * _Tint * tex2D( _Noise, panner27 ).r );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18909
1920;18;1920;1001;1480.339;316.2437;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;11;-1326.137,-10.2417;Inherit;False;Property;_SpeedX;SpeedX;1;0;Create;True;0;0;0;False;0;False;-0.5;-1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1327.137,65.7583;Inherit;False;Property;_SpeedY;SpeedY;2;0;Create;True;0;0;0;False;0;False;0.5;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1190.628,-110.2123;Inherit;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1282.623,395.4991;Inherit;False;Property;_NoiseX;NoiseX;4;0;Create;True;0;0;0;False;0;False;-0.3964329;-0.3;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-1283.623,471.4991;Inherit;False;Property;_NoiseY;NoiseY;5;0;Create;True;0;0;0;False;0;False;0.521459;0.5;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;10;-921.137,11.7583;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1002.137,-130.2417;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;26;-877.6226,417.4991;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-958.6226,275.4991;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;8;-750.137,-70.2417;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;27;-706.6226,335.4991;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;21;-452.8798,111.4884;Inherit;False;Property;_Tint;Tint;6;0;Create;True;0;0;0;False;0;False;1,0.9864793,0,0.1019608;1,0.854003,0.259434,0.1019608;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;30;-527.2076,304.8504;Inherit;True;Property;_Noise;Noise;3;0;Create;True;0;0;0;False;0;False;-1;280d77075c2960e43b9d3cff6d0a4a8f;e28dc97a9541e3642a48c0e3886688c5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-521.9218,-95.5901;Inherit;True;Property;_MainTex;MainTex;0;0;Create;True;0;0;0;False;0;False;-1;b9da43182f1cb1344b1796c02f891513;b9da43182f1cb1344b1796c02f891513;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-142.8798,37.4884;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;13.2999,33.3;Float;False;True;-1;2;ASEMaterialInspector;100;1;Custom/Sandstorm;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;True;2;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;10;0;11;0
WireConnection;10;1;12;0
WireConnection;7;0;31;0
WireConnection;26;0;23;0
WireConnection;26;1;24;0
WireConnection;8;0;7;0
WireConnection;8;2;10;0
WireConnection;27;0;25;0
WireConnection;27;2;26;0
WireConnection;30;1;27;0
WireConnection;1;1;8;0
WireConnection;22;0;1;0
WireConnection;22;1;21;0
WireConnection;22;2;30;1
WireConnection;0;0;22;0
ASEEND*/
//CHKSM=586590410E9A8E5A5FD28E38A24A27574C17814E