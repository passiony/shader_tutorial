// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Ice"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_FrozenTex("FrozenTex", 2D) = "white" {}
		_FrostTint("FrostTint", Color) = (1,1,1,0)
		_IceSlider("IceSlider", Range( 0 , 1)) = 0
		_IcicleMask("IcicleMask", 2D) = "white" {}
		_IceMaskTile("IceMaskTile", Range( 0 , 1)) = 0
		_BaseNormals("BaseNormals", 2D) = "bump" {}
		_FrostNormal("FrostNormal", 2D) = "bump" {}
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 18.2
		_TessMin( "Tess Min Distance", Float ) = 10
		_TessMax( "Tess Max Distance", Float ) = 25
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "Tessellation.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _IcicleMask;
		uniform float _IceMaskTile;
		uniform float _IceSlider;
		uniform sampler2D _BaseNormals;
		uniform float4 _BaseNormals_ST;
		uniform sampler2D _FrostNormal;
		uniform float4 _FrostNormal_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform sampler2D _FrozenTex;
		uniform float4 _FrozenTex_ST;
		uniform float4 _FrostTint;
		uniform float _TessValue;
		uniform float _TessMin;
		uniform float _TessMax;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityDistanceBasedTess( v0.vertex, v1.vertex, v2.vertex, _TessMin, _TessMax, _TessValue );
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 ase_vertexNormal = v.normal.xyz;
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float2 appendResult25 = (float2(ase_worldNormal.x , ase_worldNormal.z));
			float4 OffsetMask29 = tex2Dlod( _IcicleMask, float4( (( _IceMaskTile * appendResult25 )*1.0 + 0.5), 0, 0.0) );
			float IceSlider11 = _IceSlider;
			float y_Mask15 = saturate( ( IceSlider11 * ( ase_worldNormal.y * -0.3 ) ) );
			float yMaskTop36 = saturate( ( ase_worldNormal.y * 1.0 ) );
			float4 VertexOffset20 = ( float4( ase_vertexNormal , 0.0 ) * ( ( OffsetMask29 * y_Mask15 ) + ( yMaskTop36 * (0.0 + (IceSlider11 - 0.0) * (0.01 - 0.0) / (1.0 - 0.0)) ) ) );
			v.vertex.xyz += VertexOffset20.rgb;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BaseNormals = i.uv_texcoord * _BaseNormals_ST.xy + _BaseNormals_ST.zw;
			float2 uv_FrostNormal = i.uv_texcoord * _FrostNormal_ST.xy + _FrostNormal_ST.zw;
			float IceSlider11 = _IceSlider;
			float3 lerpResult65 = lerp( UnpackNormal( tex2D( _BaseNormals, uv_BaseNormals ) ) , UnpackNormal( tex2D( _FrostNormal, uv_FrostNormal ) ) , IceSlider11);
			float3 Normalize67 = lerpResult65;
			o.Normal = Normalize67;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 uv_FrozenTex = i.uv_texcoord * _FrozenTex_ST.xy + _FrozenTex_ST.zw;
			float4 tex2DNode3 = tex2D( _FrozenTex, uv_FrozenTex );
			float4 lerpResult4 = lerp( tex2D( _MainTex, uv_MainTex ) , tex2DNode3 , saturate( ( IceSlider11 * 8.0 ) ));
			float4 Albedo6 = lerpResult4;
			o.Albedo = Albedo6.rgb;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV48 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode48 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV48, 5.0 ) );
			float4 Emission53 = ( ( ( tex2D( _FrozenTex, uv_FrozenTex ) * fresnelNode48 ) * IceSlider11 ) * _FrostTint );
			o.Emission = Emission53.rgb;
			o.Smoothness = IceSlider11;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18909
0;73;1920;928;2688.412;1509.291;3.680129;True;False
Node;AmplifyShaderEditor.CommentaryNode;39;-707.8324,-280.5728;Inherit;False;563.4693;168.838;Comment;2;11;5;Ice Slider;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-657.5089,-201.8094;Inherit;False;Property;_IceSlider;IceSlider;3;0;Create;True;0;0;0;False;0;False;0;0.76;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;9;-972.2647,356.3984;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;33;-694.7502,-17.23943;Inherit;False;1265.615;354.4906;Comment;6;31;27;25;28;26;29;Offset Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-644.7502,58.92627;Inherit;False;Property;_IceMaskTile;IceMaskTile;5;0;Create;True;0;0;0;False;0;False;0;0.6;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;16;-661.0292,422.4743;Inherit;False;734.1053;508.0932;Comment;8;15;36;34;10;35;13;12;14;YMask;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-355.8839,-224.8182;Inherit;False;IceSlider;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-489.4203,202.2512;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-582.6414,585.7308;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-342.421,115.2512;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;13;-608.9291,481.5159;Inherit;False;11;IceSlider;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-417.6395,515.8426;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-581.8999,727.3443;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;31;-190.5809,118.1548;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;28;35.8676,32.76057;Inherit;True;Property;_IcicleMask;IcicleMask;4;0;Create;True;0;0;0;False;0;False;-1;None;3a5a96df060a5cf4a9cc0c59e13486b7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;14;-289.5529,515.9755;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;23;853.0914,-965.4806;Inherit;False;948.9276;568.6053;Comment;11;20;18;17;69;40;41;30;70;19;43;42;VertexOffset;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;35;-420.8999,750.3443;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;858.1917,-549.4068;Inherit;False;11;IceSlider;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;7;-682.3674,-1040.013;Inherit;False;1069.035;654.1647;Comment;9;60;61;6;4;59;3;2;58;57;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;36;-197.8999,693.3443;Inherit;True;yMaskTop;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;62;731.021,-231.5464;Inherit;False;1143;439.9999;Comment;8;51;49;52;50;53;47;46;48;Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;29;346.8647,56.68919;Inherit;False;OffsetMask;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-141.7314,466.6362;Inherit;True;y_Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;57;-618.9552,-511.6002;Inherit;False;11;IceSlider;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;879.1917,-709.4066;Inherit;False;36;yMaskTop;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;19;880.2479,-829.7975;Inherit;False;15;y_Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;70;1047.79,-593.2677;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;46;781.0209,-181.5463;Inherit;True;Property;_FrostTex;FrostTex;1;0;Create;True;0;0;0;False;0;False;-1;None;a897a8e7c562f9c48b7efae0b86680e7;True;0;False;white;Auto;False;Instance;3;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;48;845.0209,27.4539;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;30;886.5372,-920.155;Inherit;False;29;OffsetMask;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-423.5163,-548.6493;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;8;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;1092.02,30.4539;Inherit;False;11;IceSlider;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;71;367.3585,411.9086;Inherit;False;877.364;552.5239;Comment;5;67;65;64;66;63;Normalize;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;1076.192,-858.4064;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;1120.02,-92.54623;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;1266.995,-637.7336;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;556.38,881.4323;Inherit;False;11;IceSlider;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;69;1239.672,-742.7524;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;64;417.3586,674.7436;Inherit;True;Property;_FrostNormal;FrostNormal;7;0;Create;True;0;0;0;False;0;False;-1;395af38f32379e146b840470032d01e8;f5453dca2ac649e4182c56a3966ad395;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;52;1294.02,29.4539;Inherit;False;Property;_FrostTint;FrostTint;2;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;1327.02,-83.54623;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;63;429.6614,461.9088;Inherit;True;Property;_BaseNormals;BaseNormals;6;0;Create;True;0;0;0;False;0;False;-1;395af38f32379e146b840470032d01e8;395af38f32379e146b840470032d01e8;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;17;1235.911,-921.507;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-632.3671,-990.0126;Inherit;True;Property;_MainTex;MainTex;0;0;Create;True;0;0;0;False;0;False;-1;None;31f83ccc3181cfa4db2fbde67cc33f66;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-629.3671,-791.0126;Inherit;True;Property;_FrozenTex;FrozenTex;1;0;Create;True;0;0;0;False;0;False;-1;None;0c13bdfc1ad5def4aa6650ca8a1568e5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;59;-303.0892,-654.4698;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;1521.02,-76.54621;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;65;862.7197,643.9874;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;1422.586,-806.7246;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;4;-148.4678,-884.3124;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;6;154.131,-880.0126;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;67;1049.722,661.2115;Inherit;False;Normalize;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;1680.02,-80.54623;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;20;1575.401,-810.9896;Inherit;False;VertexOffset;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;56;1414.311,616.2603;Inherit;False;11;IceSlider;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;21;1416.21,765.4087;Inherit;False;20;VertexOffset;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;1408.311,457.2603;Inherit;False;67;Normalize;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;-143.1277,-701.5926;Inherit;False;11;IceSlider;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;60;60.97173,-801.6926;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;55;1413.311,533.2603;Inherit;False;53;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;8;1411.189,385.4802;Inherit;False;6;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;1;1687.796,411.9567;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Ice;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;16;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;0;18.2;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;8;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;11;0;5;0
WireConnection;25;0;9;1
WireConnection;25;1;9;3
WireConnection;10;0;9;2
WireConnection;26;0;27;0
WireConnection;26;1;25;0
WireConnection;12;0;13;0
WireConnection;12;1;10;0
WireConnection;34;0;9;2
WireConnection;31;0;26;0
WireConnection;28;1;31;0
WireConnection;14;0;12;0
WireConnection;35;0;34;0
WireConnection;36;0;35;0
WireConnection;29;0;28;0
WireConnection;15;0;14;0
WireConnection;70;0;42;0
WireConnection;58;0;57;0
WireConnection;40;0;30;0
WireConnection;40;1;19;0
WireConnection;47;0;46;0
WireConnection;47;1;48;0
WireConnection;41;0;43;0
WireConnection;41;1;70;0
WireConnection;69;0;40;0
WireConnection;69;1;41;0
WireConnection;49;0;47;0
WireConnection;49;1;50;0
WireConnection;59;0;58;0
WireConnection;51;0;49;0
WireConnection;51;1;52;0
WireConnection;65;0;63;0
WireConnection;65;1;64;0
WireConnection;65;2;66;0
WireConnection;18;0;17;0
WireConnection;18;1;69;0
WireConnection;4;0;2;0
WireConnection;4;1;3;0
WireConnection;4;2;59;0
WireConnection;6;0;4;0
WireConnection;67;0;65;0
WireConnection;53;0;51;0
WireConnection;20;0;18;0
WireConnection;60;0;4;0
WireConnection;60;1;3;0
WireConnection;60;2;61;0
WireConnection;1;0;8;0
WireConnection;1;1;54;0
WireConnection;1;2;55;0
WireConnection;1;4;56;0
WireConnection;1;11;21;0
ASEEND*/
//CHKSM=6C7C029B73F35D1E026254175CC5DE08A7D35FB6