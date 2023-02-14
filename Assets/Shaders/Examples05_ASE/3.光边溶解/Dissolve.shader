// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/Dissolve"
{
	Properties
	{
		_MainTexture("MainTexture", 2D) = "white" {}
		_NoiseTexture("NoiseTexture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( 0 , 1)) = 0.32
		[HDR]_EdgeColor("EdgeColor", Color) = (0,0,0,0)
		_EdgeWidth("EdgeWidth", Range( 0 , 1)) = 0.02
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" "Queue"="Transparent" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha
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

			uniform sampler2D _MainTexture;
			uniform float4 _MainTexture_ST;
			uniform float _Dissolve;
			uniform sampler2D _NoiseTexture;
			uniform float4 _NoiseTexture_ST;
			uniform float _EdgeWidth;
			uniform float4 _EdgeColor;

			
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
				float2 uv_MainTexture = i.ase_texcoord1.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
				float4 tex2DNode1 = tex2D( _MainTexture, uv_MainTexture );
				float2 uv_NoiseTexture = i.ase_texcoord1.xy * _NoiseTexture_ST.xy + _NoiseTexture_ST.zw;
				float4 tex2DNode2 = tex2D( _NoiseTexture, uv_NoiseTexture );
				float temp_output_19_0 = step( _Dissolve , ( tex2DNode2.r + _EdgeWidth ) );
				float4 appendResult27 = (float4(( tex2DNode1 + ( ( temp_output_19_0 - step( _Dissolve , tex2DNode2.r ) ) * _EdgeColor ) ).rgb , ( tex2DNode1.a * temp_output_19_0 )));
				
				
				finalColor = appendResult27;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18909
7;18;1906;1001;2305.07;1219.749;2.543172;True;False
Node;AmplifyShaderEditor.RangedFloatNode;16;-992.089,418.0332;Inherit;False;Property;_EdgeWidth;EdgeWidth;4;0;Create;True;0;0;0;False;0;False;0.02;0.02;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-1006.759,211.5999;Inherit;True;Property;_NoiseTexture;NoiseTexture;1;0;Create;True;0;0;0;False;0;False;-1;None;28c7aad1372ff114b90d330f8a2dd938;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-684.774,337.5887;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-993.0073,74.58793;Inherit;False;Property;_Dissolve;Dissolve;2;0;Create;True;0;0;0;False;0;False;0.32;0.41;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;6;-558.2415,77.81057;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;19;-547.6055,267.4401;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;20;-316.2973,158.3326;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;24;-314.2268,372.2936;Inherit;False;Property;_EdgeColor;EdgeColor;3;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;7.999999,7.790575,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-687.6746,-325.765;Inherit;True;Property;_MainTexture;MainTexture;0;0;Create;True;0;0;0;False;0;False;-1;None;0a0e8af2869fa45f78e25460db578482;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-84.25098,159.5561;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-354.3203,-64.09814;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;32;118.5018,-310.4588;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;27;334.0845,-82.24866;Inherit;True;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;31;565.1517,-81.28642;Float;False;True;-1;2;ASEMaterialInspector;100;1;Custom/Dissolve;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;2;5;False;-1;10;False;-1;0;5;False;-1;10;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;2;RenderType=Opaque=RenderType;Queue=Transparent=Queue=0;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;17;0;2;1
WireConnection;17;1;16;0
WireConnection;6;0;8;0
WireConnection;6;1;2;1
WireConnection;19;0;8;0
WireConnection;19;1;17;0
WireConnection;20;0;19;0
WireConnection;20;1;6;0
WireConnection;22;0;20;0
WireConnection;22;1;24;0
WireConnection;28;0;1;4
WireConnection;28;1;19;0
WireConnection;32;0;1;0
WireConnection;32;1;22;0
WireConnection;27;0;32;0
WireConnection;27;3;28;0
WireConnection;31;0;27;0
ASEEND*/
//CHKSM=4565776E54F524B8B98DBA2CD0B1F37CA608CE63