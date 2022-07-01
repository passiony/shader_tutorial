// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/Disturb"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_Repeat("Repeat", Float) = 3
		_Speed1Y("Speed1Y", Range( -2 , 2)) = 0.02734135
		_Speed1X("Speed1X", Range( -2 , 2)) = 0.02709646
		_Noise("Noise", 2D) = "white" {}
		_Speed2X("Speed2X", Range( -2 , 2)) = 0.02709646
		_Speed2Y("Speed2Y", Range( -2 , 2)) = 0.02734135
		_Intensity("Intensity", Range( 0 , 1)) = 0.5
		_Tint("Tint", Color) = (1,1,1,0.2784314)

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
			uniform float _Speed1X;
			uniform float _Speed1Y;
			uniform float _Repeat;
			uniform sampler2D _Noise;
			uniform float _Speed2X;
			uniform float _Speed2Y;
			uniform float _Intensity;
			uniform float4 _Tint;

			
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
				float4 appendResult26 = (float4(_Speed1X , _Speed1Y , 0.0 , 0.0));
				float2 temp_cast_1 = (_Repeat).xx;
				float2 texCoord25 = i.ase_texcoord1.xy * temp_cast_1 + float2( 0,0 );
				float2 panner27 = ( 1.0 * _Time.y * appendResult26.xy + texCoord25);
				float4 appendResult10 = (float4(_Speed2X , _Speed2Y , 0.0 , 0.0));
				float2 texCoord7 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner8 = ( 1.0 * _Time.y * appendResult10.xy + texCoord7);
				float2 temp_cast_3 = (tex2D( _Noise, panner8 ).r).xx;
				float2 lerpResult4 = lerp( panner27 , temp_cast_3 , _Intensity);
				
				
				finalColor = ( tex2D( _MainTex, lerpResult4 ) * _Tint );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18909
1920;0;1920;1019;2146.118;1003.574;1.648641;True;True
Node;AmplifyShaderEditor.CommentaryNode;31;-1841.579,-29.43262;Inherit;False;1117.415;393.8512;NoisePanner;7;11;12;7;10;8;6;5;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;30;-1494.254,-494.903;Inherit;False;832;375;MainTexPanner;6;23;29;24;26;25;27;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1791.579,216.5675;Inherit;False;Property;_Speed2Y;Speed2Y;6;0;Create;True;0;0;0;False;0;False;0.02734135;0.2;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1790.579,140.5674;Inherit;False;Property;_Speed2X;Speed2X;5;0;Create;True;0;0;0;False;0;False;0.02709646;-0.2;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;10;-1385.579,162.5674;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1466.579,20.56741;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-1443.254,-324.903;Inherit;False;Property;_Speed1X;Speed1X;3;0;Create;True;0;0;0;False;0;False;0.02709646;-1;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1295.299,-425.4475;Inherit;False;Property;_Repeat;Repeat;1;0;Create;True;0;0;0;False;0;False;3;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-1444.254,-248.903;Inherit;False;Property;_Speed1Y;Speed1Y;2;0;Create;True;0;0;0;False;0;False;0.02734135;1;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;8;-1214.579,80.56741;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-1119.254,-444.903;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;26;-1038.254,-302.903;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PannerNode;27;-867.254,-384.903;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1024.663,248.4187;Inherit;False;Property;_Intensity;Intensity;7;0;Create;True;0;0;0;False;0;False;0.5;0.4470588;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-1044.164,52.91869;Inherit;True;Property;_Noise;Noise;4;0;Create;True;0;0;0;False;0;False;-1;e28dc97a9541e3642a48c0e3886688c5;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;4;-669.6217,-67.9904;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;21;-470.1322,145.9726;Inherit;False;Property;_Tint;Tint;8;0;Create;True;0;0;0;False;0;False;1,1,1,0.2784314;1,0.8434348,0.5707547,0.2;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-521.9218,-95.5901;Inherit;True;Property;_MainTex;MainTex;0;0;Create;True;0;0;0;False;0;False;-1;36be8d528a4fa024faa4680d7658642c;df479b14a4b0fdb468fe0ea02b6dc621;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-142.8798,37.4884;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;17.2999,36.3;Float;False;True;-1;2;ASEMaterialInspector;100;1;Custom/Disturb;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;True;2;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;10;0;11;0
WireConnection;10;1;12;0
WireConnection;8;0;7;0
WireConnection;8;2;10;0
WireConnection;25;0;29;0
WireConnection;26;0;23;0
WireConnection;26;1;24;0
WireConnection;27;0;25;0
WireConnection;27;2;26;0
WireConnection;5;1;8;0
WireConnection;4;0;27;0
WireConnection;4;1;5;1
WireConnection;4;2;6;0
WireConnection;1;1;4;0
WireConnection;22;0;1;0
WireConnection;22;1;21;0
WireConnection;0;0;22;0
ASEEND*/
//CHKSM=03D910A99189B0E778019C2FDCE530536DA9D9A0