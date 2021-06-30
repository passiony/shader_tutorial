 Shader "Lighting/Specular Phong" {
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
      _Spec ("Spec", Range(1,200) ) = 48
    }
    SubShader {
      Tags { "RenderType" = "Opaque" }
      CGPROGRAM
      #pragma surface surf SpecularPhong

      fixed _Spec;
	  fixed4 LightingSpecularPhong(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
	  {
		  //漫反射
		  half diff = dot(s.Normal, lightDir)*0.5 + 0.5;

		  //高光
		  fixed3 reflectDir = normalize(reflect(-lightDir, s.Normal));
		  float spec = max(0, dot(reflectDir, viewDir));

		  fixed4 c;
		  c.rgb = s.Albedo.rgb*_LightColor0*diff + _LightColor0.rgb* pow(spec, _Spec) *atten;
		  c.a = s.Alpha;
		  return c;
	  }

	  struct Input {
          float2 uv_MainTex;
      };
      sampler2D _MainTex;
      
      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
      }
      ENDCG
    }
    Fallback "Diffuse"
  }