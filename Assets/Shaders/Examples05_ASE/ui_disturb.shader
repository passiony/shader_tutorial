// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "uv_disturb"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Noise("Noise", 2D) = "white" {}
		_Intensity("Intensity", Range( 0 , 1)) = 0.5
		_SpeedY("SpeedY", Range( 0 , 1)) = 0.02734135
		_SpeedX("SpeedX", Range( 0 , 1)) = 0.02709646

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Back
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

			uniform sampler2D _TextureSample0;
			uniform sampler2D _Noise;
			uniform float _SpeedX;
			uniform float _SpeedY;
			uniform float _Intensity;

			
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
				float2 texCoord2 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float4 appendResult10 = (float4(_SpeedX , _SpeedY , 0.0 , 0.0));
				float2 texCoord7 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner8 = ( 1.0 * _Time.y * appendResult10.xy + texCoord7);
				float2 temp_cast_1 = (tex2D( _Noise, panner8 ).r).xx;
				float2 lerpResult4 = lerp( texCoord2 , temp_cast_1 , _Intensity);
				
				
				finalColor = tex2D( _TextureSample0, lerpResult4 );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18909
0;0;1920;1019;2002.189;565.2378;1.09593;True;True
Node;AmplifyShaderEditor.RangedFloatNode;12;-1749.137,90.7583;Inherit;False;Property;_SpeedY;SpeedY;3;0;Create;True;0;0;0;False;0;False;0.02734135;0.293;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1748.137,14.7583;Inherit;False;Property;_SpeedX;SpeedX;4;0;Create;True;0;0;0;False;0;False;0.02709646;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;10;-1343.137,36.7583;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1424.137,-105.2417;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;8;-1172.137,-45.2417;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-931.4219,-195.2903;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-1001.722,-72.89042;Inherit;True;Property;_Noise;Noise;1;0;Create;True;0;0;0;False;0;False;-1;e28dc97a9541e3642a48c0e3886688c5;e28dc97a9541e3642a48c0e3886688c5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-982.2213,122.6095;Inherit;False;Property;_Intensity;Intensity;2;0;Create;True;0;0;0;False;0;False;0.5;0.225;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;4;-669.6217,-67.9904;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-521.9218,-95.5901;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;36be8d528a4fa024faa4680d7658642c;36be8d528a4fa024faa4680d7658642c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-235.7001,-90.7;Float;False;True;-1;2;ASEMaterialInspector;100;1;uv_disturb;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;10;0;11;0
WireConnection;10;1;12;0
WireConnection;8;0;7;0
WireConnection;8;2;10;0
WireConnection;5;1;8;0
WireConnection;4;0;2;0
WireConnection;4;1;5;1
WireConnection;4;2;6;0
WireConnection;1;1;4;0
WireConnection;0;0;1;0
ASEEND*/
//CHKSM=C9D73ED44BABCEE76E8125E7EC7A97753E87A838