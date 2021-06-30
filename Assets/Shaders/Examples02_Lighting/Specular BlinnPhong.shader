Shader "Custom/Specular BlinnPhong"
{
    Properties{
        _MainTex("Main",2D) = "white"{}
		_Spec("高光强度",Float) = 10
    }
    SubShader
    {
        Tags {"RenderType"="Opaque"}
        CGPROGRAM
        #pragma surface surf SpecularBlinnPhong
        struct Input
        {
            float2 uv_MainTex;
        };
        float _Spec;
        sampler2D _MainTex;

        void surf(Input IN,inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
        }
        fixed4 LightingSpecularBlinnPhong(SurfaceOutput s,half3 lightDir, half3 viewDir,half atten)
        {
            //漫反射
            half diff = dot(s.Normal,lightDir)*0.5+0.5;

			//Blinn-phong：半角向量.发线向量
			//1.半角向量：求（点到光源+点到摄像机）的单位向量，他们的中间平均值
            fixed3 h = normalize(lightDir + viewDir);
			//2.高光底数【半角向量与法线向量的余弦值】
			float nh = max(0, dot(s.Normal, h));
			//3.高光系数：根据高光低数和高光指数求得
			float spec = pow(nh, _Spec);

            fixed4 c;
            c.rgb = s.Albedo.rgb*_LightColor0*diff + _LightColor0.rgb* spec *atten;
            c.a = s.Alpha;
            return c;
        }
        ENDCG
    }
}


