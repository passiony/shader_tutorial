Shader "Lighting/Custom Lambert" {
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
    }
     SubShader {
      Tags { "RenderType" = "Opaque" }
      CGPROGRAM
      #pragma surface surf CustomLambert

      half4 LightingCustomLambert(SurfaceOutput s, half3 lightDir, half atten) {
          fixed diff = max (0, dot (s.Normal, lightDir));
          fixed4 c;
          c.rgb = s.Albedo * _LightColor0.rgb * (diff * atten);
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