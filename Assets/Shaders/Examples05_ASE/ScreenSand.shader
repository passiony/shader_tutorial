// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/ScreenSand"
{
	Properties
	{
		_WindTex("WindTex", 2D) = "white" {}
		_WindTint("WindTint", Color) = (1,0.9864793,0,0.1019608)
		_WindRepeat("WindRepeat", Float) = 3
		_WindSpeedX("WindSpeedX", Range( -2 , 2)) = 0.02709646
		_WindSpeedY("WindSpeedY", Range( -2 , 2)) = 0.02734135
		_StomTex("StomTex", 2D) = "white" {}
		_StormTint("StormTint", Color) = (1,0.9864793,0,0.1019608)
		_StormRepeat("StormRepeat", Float) = 6
		_StormSpeedX("StormSpeedX", Range( -1 , 1)) = -0.5
		_StormSpeedY("StormSpeedY", Range( -1 , 1)) = 0.5
		_StormNoiseTex("StormNoiseTex", 2D) = "white" {}
		_StormNoiseX("StormNoiseX", Range( -1 , 1)) = -0.3964329
		_StormNoiseY("StormNoiseY", Range( -1 , 1)) = 0.521459
		_SandTex("SandTex", 2D) = "white" {}
		_SandRepeat("SandRepeat", Float) = 10
		_SandTint("SandTint", Color) = (1,0.9864793,0,0.1019608)
		_SandSpeedX("SandSpeedX", Range( -1 , 1)) = -0.5
		_SandSpeedY("SandSpeedY", Range( -1 , 1)) = 0.5
		_SandNoiseTex("SandNoiseTex", 2D) = "white" {}
		_SandNoiseX("SandNoiseX", Range( -1 , 1)) = -0.3964329
		_SandNoiseY("SandNoiseY", Range( -1 , 1)) = 0.521459

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

			uniform float4 _WindTint;
			uniform sampler2D _WindTex;
			uniform float _WindSpeedX;
			uniform float _WindSpeedY;
			uniform float _WindRepeat;
			uniform float4 _StormTint;
			uniform sampler2D _StomTex;
			uniform float _StormSpeedX;
			uniform float _StormSpeedY;
			uniform float _StormRepeat;
			uniform sampler2D _StormNoiseTex;
			uniform float _StormNoiseX;
			uniform float _StormNoiseY;
			uniform sampler2D _SandTex;
			uniform float _SandSpeedX;
			uniform float _SandSpeedY;
			uniform float _SandRepeat;
			uniform sampler2D _SandNoiseTex;
			uniform float _SandNoiseX;
			uniform float _SandNoiseY;
			uniform float4 _SandTint;

			
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
				float2 appendResult53 = (float2(_WindSpeedX , _WindSpeedY));
				float2 temp_cast_0 = (_WindRepeat).xx;
				float2 texCoord52 = i.ase_texcoord1.xy * temp_cast_0 + float2( 0,0 );
				float2 panner54 = ( 1.0 * _Time.y * appendResult53 + texCoord52);
				float2 appendResult10 = (float2(_StormSpeedX , _StormSpeedY));
				float2 temp_cast_1 = (_StormRepeat).xx;
				float2 texCoord7 = i.ase_texcoord1.xy * temp_cast_1 + float2( 0,0 );
				float2 panner8 = ( 1.0 * _Time.y * appendResult10 + texCoord7);
				float4 tex2DNode1 = tex2D( _StomTex, panner8 );
				float2 appendResult26 = (float2(_StormNoiseX , _StormNoiseY));
				float2 texCoord25 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner27 = ( 1.0 * _Time.y * appendResult26 + texCoord25);
				float4 appendResult37 = (float4((tex2DNode1).rgb , ( tex2DNode1.a * tex2D( _StormNoiseTex, panner27 ).r )));
				float2 appendResult62 = (float2(_SandSpeedX , _SandSpeedY));
				float2 temp_cast_3 = (_SandRepeat).xx;
				float2 texCoord63 = i.ase_texcoord1.xy * temp_cast_3 + float2( 0,0 );
				float2 panner67 = ( 1.0 * _Time.y * appendResult62 + texCoord63);
				float4 tex2DNode68 = tex2D( _SandTex, panner67 );
				float2 appendResult64 = (float2(_SandNoiseX , _SandNoiseY));
				float2 texCoord65 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner66 = ( 1.0 * _Time.y * appendResult64 + texCoord65);
				float4 appendResult72 = (float4((tex2DNode68).rgb , ( tex2DNode68.a * tex2D( _SandNoiseTex, panner66 ).r )));
				
				
				finalColor = ( ( _WindTint * tex2D( _WindTex, panner54 ) ) + ( _StormTint * appendResult37 ) + ( appendResult72 * _SandTint ) );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18909
1913;7;1920;1007;1908.709;1147.411;1.380027;True;True
Node;AmplifyShaderEditor.CommentaryNode;56;-1424.487,200.9984;Inherit;False;1326.398;491.1716;Sand;14;72;70;71;69;68;67;66;65;63;62;60;57;58;59;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;45;-1431.609,-330.0359;Inherit;False;1330.198;510.1715;Storm;16;37;44;43;1;30;8;27;25;26;10;7;23;24;11;74;12;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1419.209,-105.0359;Inherit;False;Property;_StormSpeedY;StormSpeedY;9;0;Create;True;0;0;0;False;0;False;0.5;0.5;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-1408.051,534.2697;Inherit;False;Property;_SandNoiseX;SandNoiseX;19;0;Create;True;0;0;0;False;0;False;-0.3964329;-1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-1411.916,631.4048;Inherit;False;Property;_SandNoiseY;SandNoiseY;20;0;Create;True;0;0;0;False;0;False;0.521459;0.2;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-1413.087,409.9982;Inherit;False;Property;_SandSpeedY;SandSpeedY;17;0;Create;True;0;0;0;False;0;False;0.5;0.5;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-1310.861,-267.7764;Inherit;False;Property;_StormRepeat;StormRepeat;7;0;Create;True;0;0;0;False;0;False;6;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1419.209,-176.0359;Inherit;False;Property;_StormSpeedX;StormSpeedX;8;0;Create;True;0;0;0;False;0;False;-0.5;-0.8;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-1416.087,334.9982;Inherit;False;Property;_SandSpeedX;SandSpeedX;16;0;Create;True;0;0;0;False;0;False;-0.5;-1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-1319.289,251.9962;Inherit;False;Property;_SandRepeat;SandRepeat;14;0;Create;True;0;0;0;False;0;False;10;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-1419.038,100.3707;Inherit;False;Property;_StormNoiseY;StormNoiseY;12;0;Create;True;0;0;0;False;0;False;0.521459;0.5;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1415.173,3.235612;Inherit;False;Property;_StormNoiseX;StormNoiseX;11;0;Create;True;0;0;0;False;0;False;-0.3964329;-0.3;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;63;-1125.087,250.9984;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;62;-1122.087,378.9982;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;55;-1348.381,-696.4326;Inherit;False;1226.759;332.7789;Wind;7;48;54;52;53;50;51;49;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;64;-1109.68,613.2696;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;26;-1116.802,82.23558;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-1126.019,-46.05257;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;10;-1129.209,-152.0359;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1132.209,-280.036;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;65;-1118.897,484.9815;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;67;-900.2849,315.7982;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;27;-902.4463,5.612204;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-1149.425,-626.9771;Inherit;False;Property;_WindRepeat;WindRepeat;2;0;Create;True;0;0;0;False;0;False;3;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;8;-907.4075,-215.236;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;66;-895.3236,536.6463;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-1297.381,-526.4327;Inherit;False;Property;_WindSpeedX;WindSpeedX;3;0;Create;True;0;0;0;False;0;False;0.02709646;-0.8;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-1298.381,-450.4327;Inherit;False;Property;_WindSpeedY;WindSpeedY;4;0;Create;True;0;0;0;False;0;False;0.02734135;0.8;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;30;-719.6308,-24.03643;Inherit;True;Property;_StormNoiseTex;StormNoiseTex;10;0;Create;True;0;0;0;False;0;False;-1;280d77075c2960e43b9d3cff6d0a4a8f;092910d9ed6218a4689afb78cb43b4ca;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;53;-892.3777,-504.4327;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;69;-712.5081,506.9977;Inherit;True;Property;_SandNoiseTex;SandNoiseTex;18;0;Create;True;0;0;0;False;0;False;-1;280d77075c2960e43b9d3cff6d0a4a8f;092910d9ed6218a4689afb78cb43b4ca;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;52;-973.3777,-646.4326;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-727.1918,-243.7844;Inherit;True;Property;_StomTex;StomTex;5;0;Create;True;0;0;0;False;0;False;-1;b9da43182f1cb1344b1796c02f891513;b9da43182f1cb1344b1796c02f891513;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;68;-720.0692,287.2498;Inherit;True;Property;_SandTex;SandTex;13;0;Create;True;0;0;0;False;0;False;-1;b9da43182f1cb1344b1796c02f891513;c3d65c1fa34a1044d9249f641e939d26;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;70;-428.0793,287.6826;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-383.2794,388.8825;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;43;-435.2017,-243.3516;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PannerNode;54;-721.3777,-586.4326;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-390.4017,-142.1517;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;48;-522.1403,-616.2523;Inherit;True;Property;_WindTex;WindTex;0;0;Create;True;0;0;0;False;0;False;-1;36be8d528a4fa024faa4680d7658642c;df479b14a4b0fdb468fe0ea02b6dc621;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;37;-238.8088,-236.638;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;21;-61.25993,326.1991;Inherit;False;Property;_SandTint;SandTint;15;0;Create;True;0;0;0;False;0;False;1,0.9864793,0,0.1019608;0.6901961,0.4,0.2117647,0.2705882;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;85;-67.69809,-417.5932;Inherit;False;Property;_StormTint;StormTint;6;0;Create;True;0;0;0;False;0;False;1,0.9864793,0,0.1019608;0.6901961,0.4,0.2117647,0.3176471;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;72;-231.6866,279.0068;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;84;-30.542,-836.824;Inherit;False;Property;_WindTint;WindTint;1;0;Create;True;0;0;0;False;0;False;1,0.9864793,0,0.1019608;0.6901961,0.4,0.2117647,0.07058824;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;223.101,-4.934783;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;214.7923,-256.9614;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;164.9404,-585.1486;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;92;488.9128,-287.8251;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;703.2314,-286.7909;Float;False;True;-1;2;ASEMaterialInspector;100;1;Custom/ScreenSand;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;True;2;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;63;0;59;0
WireConnection;62;0;57;0
WireConnection;62;1;58;0
WireConnection;64;0;60;0
WireConnection;64;1;61;0
WireConnection;26;0;23;0
WireConnection;26;1;24;0
WireConnection;10;0;11;0
WireConnection;10;1;12;0
WireConnection;7;0;74;0
WireConnection;67;0;63;0
WireConnection;67;2;62;0
WireConnection;27;0;25;0
WireConnection;27;2;26;0
WireConnection;8;0;7;0
WireConnection;8;2;10;0
WireConnection;66;0;65;0
WireConnection;66;2;64;0
WireConnection;30;1;27;0
WireConnection;53;0;49;0
WireConnection;53;1;51;0
WireConnection;69;1;66;0
WireConnection;52;0;50;0
WireConnection;1;1;8;0
WireConnection;68;1;67;0
WireConnection;70;0;68;0
WireConnection;71;0;68;4
WireConnection;71;1;69;1
WireConnection;43;0;1;0
WireConnection;54;0;52;0
WireConnection;54;2;53;0
WireConnection;44;0;1;4
WireConnection;44;1;30;1
WireConnection;48;1;54;0
WireConnection;37;0;43;0
WireConnection;37;3;44;0
WireConnection;72;0;70;0
WireConnection;72;3;71;0
WireConnection;87;0;72;0
WireConnection;87;1;21;0
WireConnection;86;0;85;0
WireConnection;86;1;37;0
WireConnection;83;0;84;0
WireConnection;83;1;48;0
WireConnection;92;0;83;0
WireConnection;92;1;86;0
WireConnection;92;2;87;0
WireConnection;0;0;92;0
ASEEND*/
//CHKSM=EC473BF93330EAC64C36433C0E62309EB3964A5F