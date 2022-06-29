// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/Fire"
{
	Properties
	{
		_FireNoise("FireNoise", 2D) = "white" {}
		_FireMask("FireMask", 2D) = "white" {}
		_fire2scale("fire2scale", Float) = 0.2
		_fire2speed("fire2speed", Float) = -1
		_fire1scale("fire1scale", Float) = 0.5
		_fire1speed("fire1speed", Float) = -1.2
		_FireInner("FireInner", Range( 0 , 1)) = 0.4475331
		_FireOuter("FireOuter", Range( 0 , 1)) = 0.04529411
		_FireInnerColor("FireInnerColor", Color) = (1,0.9490197,0.4235294,1)
		_GradiantValue("GradiantValue", Range( 0 , 1)) = 0
		_FireOuter1("FireOuter1", Color) = (1,0.7306895,0,0)
		_FireOuter2("FireOuter2", Color) = (1,0.7333333,0,1)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend One One
		AlphaToMask Off
		Cull Off
		ColorMask RGBA
		ZWrite Off
		ZTest LEqual
		
		
		
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

			uniform float4 _FireInnerColor;
			uniform float _FireInner;
			uniform sampler2D _FireMask;
			uniform float4 _FireMask_ST;
			uniform sampler2D _FireNoise;
			uniform float _fire1speed;
			uniform float _fire1scale;
			uniform float _fire2speed;
			uniform float _fire2scale;
			uniform float _FireOuter;
			uniform float4 _FireOuter2;
			uniform float _GradiantValue;
			uniform float4 _FireOuter1;

			
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
				float2 uv_FireMask = i.ase_texcoord1.xy * _FireMask_ST.xy + _FireMask_ST.zw;
				float2 appendResult4 = (float2(0.0 , _fire1speed));
				float2 texCoord9 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner2 = ( 1.0 * _Time.y * appendResult4 + ( _fire1scale * texCoord9 ));
				float2 appendResult12 = (float2(0.0 , _fire2speed));
				float2 panner14 = ( 1.0 * _Time.y * appendResult12 + ( texCoord9 * _fire2scale ));
				float temp_output_31_0 = step( _FireInner , ( tex2D( _FireMask, uv_FireMask ) * ( tex2D( _FireNoise, panner2 ).r * tex2D( _FireNoise, panner14 ).r ) ).g );
				float2 texCoord69 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float smoothstepResult67 = smoothstep( 0.0 , _GradiantValue , texCoord69.y);
				
				
				finalColor = ( ( _FireInnerColor * temp_output_31_0 ) + ( ( step( _FireOuter , ( tex2D( _FireMask, uv_FireMask ) * ( tex2D( _FireNoise, panner2 ).r * tex2D( _FireNoise, panner14 ).r ) ).g ) - temp_output_31_0 ) * ( ( _FireOuter2 * ( 1.0 - smoothstepResult67 ) ) + ( smoothstepResult67 * _FireOuter1 ) ) ) );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18909
1920;6;1920;1013;1137.355;775.6057;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;51;-1301.557,-124.2676;Inherit;False;1369.927;678.1226;Comment;15;3;9;7;11;13;8;4;10;12;6;2;14;1;15;17;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1207.927,-70.04498;Inherit;False;Property;_fire1speed;fire1speed;5;0;Create;True;0;0;0;False;0;False;-1.2;-1.19;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1197.557,63.82056;Inherit;False;Property;_fire1scale;fire1scale;4;0;Create;True;0;0;0;False;0;False;0.5;0.56;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1216.639,316.855;Inherit;False;Property;_fire2scale;fire2scale;2;0;Create;True;0;0;0;False;0;False;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1227.639,437.855;Inherit;False;Property;_fire2speed;fire2speed;3;0;Create;True;0;0;0;False;0;False;-1;-0.77;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1251.557,166.8206;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-1008.557,45.82057;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-993.6393,276.855;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;12;-992.6393,395.855;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;4;-1008.927,-68.04498;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;2;-836.7043,-74.26757;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;14;-807.6393,327.855;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;6;-832.9268,107.955;Inherit;True;Property;_FireNoise;FireNoise;0;0;Create;True;0;0;0;False;0;False;8336292a663889e4eadff2471dc5114f;e28dc97a9541e3642a48c0e3886688c5;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;1;-520.3999,-51.99998;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;8336292a663889e4eadff2471dc5114f;8336292a663889e4eadff2471dc5114f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;-510.6394,257.855;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-166.6301,103.1064;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-251.73,-390.7936;Inherit;True;Property;_FireMask;FireMask;1;0;Create;True;0;0;0;False;0;False;-1;None;d5917b144327edc43b7236ac204a81ab;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;73;556.5513,294.1119;Inherit;False;1157;572;Comment;9;37;66;65;72;71;68;70;67;69;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;66;610.5513,582.112;Inherit;False;Property;_GradiantValue;GradiantValue;9;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;69;659.5513,450.1119;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;154.347,-192.5174;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;52;546.6032,-462.971;Inherit;False;1432.402;713.8223;Comment;10;34;29;32;31;33;35;38;39;36;40;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;44;364.6387,-190.0392;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SmoothstepOpNode;67;952.5519,536.1121;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;70;1160.553,530.112;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;745.6947,-255.1376;Inherit;False;Property;_FireInner;FireInner;6;0;Create;True;0;0;0;False;0;False;0.4475331;0.279;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;37;1112.15,343.4767;Inherit;False;Property;_FireOuter2;FireOuter2;11;0;Create;True;0;0;0;False;0;False;1,0.7333333,0,1;1,0.7599123,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;65;675.5513,678.1119;Inherit;False;Property;_FireOuter1;FireOuter1;10;0;Create;True;0;0;0;False;0;False;1,0.7306895,0,0;1,0,0.2626143,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;32;737.8947,-54.58773;Inherit;False;Property;_FireOuter;FireOuter;7;0;Create;True;0;0;0;False;0;False;0.04529411;0.08;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;34;754.7947,-157.6376;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;1370.553,424.1119;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;1171.553,632.1119;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;33;1096.595,-83.48734;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;31;1090.895,-254.5378;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;38;1281.67,-412.971;Inherit;False;Property;_FireInnerColor;FireInnerColor;8;0;Create;True;0;0;0;False;0;False;1,0.9490197,0.4235294,1;0.9917833,1,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;35;1319.573,-109.6043;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;72;1529.553,531.112;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;59;-959.7579,632.6436;Inherit;False;1002.546;511.5218;Comment;5;53;55;57;54;56;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;1535.673,-113.5042;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;1531.339,-334.3265;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;57;-492.3696,692.7458;Inherit;True;Property;_TextureSample3;Texture Sample 3;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;55;-896.1228,803.6357;Inherit;False;Constant;_Float6;Float 6;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;40;1805.004,-218.1487;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;54;-697.246,715.6512;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;53;-909.7578,714.3787;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;56;-894.4874,914.1655;Inherit;True;Property;_Texture1;Texture 1;12;0;Create;True;0;0;0;False;0;False;None;9c32b10524e4da84c8019db9fcef4052;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;2120.199,-199.3;Float;False;True;-1;2;ASEMaterialInspector;100;1;Custom/Fire;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;4;1;False;-1;1;False;-1;0;5;False;-1;10;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;2;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;True;2;False;-1;True;3;False;-1;True;False;0;False;-1;0;False;-1;True;1;RenderType=Transparent=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;8;0;7;0
WireConnection;8;1;9;0
WireConnection;10;0;9;0
WireConnection;10;1;11;0
WireConnection;12;1;13;0
WireConnection;4;1;3;0
WireConnection;2;0;8;0
WireConnection;2;2;4;0
WireConnection;14;0;10;0
WireConnection;14;2;12;0
WireConnection;1;0;6;0
WireConnection;1;1;2;0
WireConnection;15;0;6;0
WireConnection;15;1;14;0
WireConnection;17;0;1;1
WireConnection;17;1;15;1
WireConnection;19;0;18;0
WireConnection;19;1;17;0
WireConnection;44;0;19;0
WireConnection;67;0;69;2
WireConnection;67;2;66;0
WireConnection;70;0;67;0
WireConnection;34;0;44;1
WireConnection;71;0;37;0
WireConnection;71;1;70;0
WireConnection;68;0;67;0
WireConnection;68;1;65;0
WireConnection;33;0;32;0
WireConnection;33;1;34;0
WireConnection;31;0;29;0
WireConnection;31;1;34;0
WireConnection;35;0;33;0
WireConnection;35;1;31;0
WireConnection;72;0;71;0
WireConnection;72;1;68;0
WireConnection;36;0;35;0
WireConnection;36;1;72;0
WireConnection;39;0;38;0
WireConnection;39;1;31;0
WireConnection;57;0;56;0
WireConnection;57;1;54;0
WireConnection;40;0;39;0
WireConnection;40;1;36;0
WireConnection;54;0;53;0
WireConnection;54;1;55;0
WireConnection;0;0;40;0
ASEEND*/
//CHKSM=86510E7B0DFBA806C017984D209A3A60276B591B