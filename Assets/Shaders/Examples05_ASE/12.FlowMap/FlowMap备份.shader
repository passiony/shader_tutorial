// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/FlowMap"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_FlowMap("FlowMap", 2D) = "white" {}
		_FlowPower("FlowPower", Range( 0 , 1)) = 0.5988402
		_DissolveTex("DissolveTex", 2D) = "white" {}
		_SolfDissolve("SolfDissolve", Range( 0.5 , 1)) = 1
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
			uniform sampler2D _FlowMap;
			uniform float4 _FlowMap_ST;
			uniform float _FlowPower;
			uniform float _SolfDissolve;
			uniform sampler2D _DissolveTex;

			
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
				float2 texCoord8 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv_FlowMap = i.ase_texcoord1.xy * _FlowMap_ST.xy + _FlowMap_ST.zw;
				float4 tex2DNode10 = tex2D( _FlowMap, uv_FlowMap );
				float2 appendResult12 = (float2(tex2DNode10.r , tex2DNode10.g));
				float2 lerpResult9 = lerp( texCoord8 , appendResult12 , _FlowPower);
				float4 tex2DNode1 = tex2D( _MainTex, lerpResult9 );
				float smoothstepResult20 = smoothstep( ( 1.0 - _SolfDissolve ) , _SolfDissolve , ( 1.0 + tex2D( _DissolveTex, lerpResult9 ).r + ( _FlowPower * -2.0 ) ));
				float4 appendResult6 = (float4((tex2DNode1).rgb , ( tex2DNode1.a * smoothstepResult20 )));
				
				
				finalColor = appendResult6;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18909
0;73;830;926;743.9152;1081.015;3.140697;True;False
Node;AmplifyShaderEditor.SamplerNode;10;-1227.583,-257.8592;Inherit;True;Property;_FlowMap;FlowMap;1;0;Create;True;0;0;0;False;0;False;-1;6c3c8685d9c71ec4c9a0fc7b8a4e2f4a;6c3c8685d9c71ec4c9a0fc7b8a4e2f4a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;12;-906.153,-236.1771;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-974.5043,-16.59375;Inherit;False;Property;_FlowPower;FlowPower;2;0;Create;True;0;0;0;False;0;False;0.5988402;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-918.875,-366.9371;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;9;-627.8306,-268.1476;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-434.0628,266.5824;Inherit;False;Constant;_Float2;Float 2;5;0;Create;True;0;0;0;False;0;False;-2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-202.8955,219.5748;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-353.5559,3.806466;Inherit;True;Property;_DissolveTex;DissolveTex;3;0;Create;True;0;0;0;False;0;False;-1;9d8e85550edca804eae190a912aaf4ce;9d8e85550edca804eae190a912aaf4ce;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;22;42.40529,279.0319;Inherit;False;Property;_SolfDissolve;SolfDissolve;4;0;Create;True;0;0;0;False;0;False;1;0.7442442;0.5;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-57.30362,-8.187012;Inherit;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;83.91119,41.06591;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;21;325.6618,119.5448;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;20;541.9275,56.03065;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-363.8888,-290.4394;Inherit;True;Property;_MainTex;MainTex;0;0;Create;True;0;0;0;False;0;False;-1;441925e4ced0e5546afecb6df5049dfc;97087822e95c9b04dafb2eec954a095e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;50;-833.5344,994.2535;Inherit;False;1485.099;480.4929;让效果边缘过渡更平滑;9;43;46;44;37;40;45;39;42;41;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;31;-1582.098,1018.516;Inherit;False;601.516;426.3172;用于粒子特效;3;27;28;29;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;842.8055,-145.1903;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;5;652.2792,-276.7888;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-336.0481,1341.837;Inherit;False;Property;_MaskPower;MaskPower;6;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-1457.381,1063.953;Inherit;False;0;-1;3;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;28;-1142.889,1101.693;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;6;1020.29,-266.6624;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1389.938,1231.777;Inherit;False;Property;_Float1;Float 1;5;1;[Enum];Create;True;0;2;Off;0;On;1;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;46;486.5643,1143.788;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;253.5646,1137.788;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;37;-783.5344,1044.254;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;40;-734.6774,1310.746;Inherit;False;Constant;_Vector0;Vector 0;6;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;45;61.56461,1347.788;Inherit;False;Property;_MaskScale;MaskScale;7;0;Create;True;0;0;0;False;0;False;1.21;2;1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;39;-531.4761,1116.428;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;41;-293.8534,1115.318;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;42;-18.47747,1127.532;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;1182.237,-268.8473;Float;False;True;-1;2;ASEMaterialInspector;100;1;Custom/FlowMap;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;True;2;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;2;RenderType=Opaque=RenderType;Queue=Transparent=Queue=0;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;12;0;10;1
WireConnection;12;1;10;2
WireConnection;9;0;8;0
WireConnection;9;1;12;0
WireConnection;9;2;13;0
WireConnection;17;0;13;0
WireConnection;17;1;19;0
WireConnection;14;1;9;0
WireConnection;15;0;16;0
WireConnection;15;1;14;1
WireConnection;15;2;17;0
WireConnection;21;0;22;0
WireConnection;20;0;15;0
WireConnection;20;1;21;0
WireConnection;20;2;22;0
WireConnection;1;1;9;0
WireConnection;7;0;1;4
WireConnection;7;1;20;0
WireConnection;5;0;1;0
WireConnection;28;1;29;3
WireConnection;28;2;27;0
WireConnection;6;0;5;0
WireConnection;6;3;7;0
WireConnection;46;0;44;0
WireConnection;44;0;42;0
WireConnection;44;1;45;0
WireConnection;39;0;37;0
WireConnection;39;1;40;0
WireConnection;41;0;39;0
WireConnection;42;0;41;0
WireConnection;42;1;43;0
WireConnection;0;0;6;0
ASEEND*/
//CHKSM=BE2BC54AD9F44EE95169E35FF4C4EB373EC2BF47