Shader "Custom/CustomDiffuse"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            Tags {"LightMode"="ForwardBase"}
        
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc" // for UnityObjectToWorldNormal
            #include "UnityLightingCommon.cginc" // for _LightColor0

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                fixed4 diff : COLOR0; // diffuse lighting color
            };

            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);//顶点从自身坐标系转裁剪坐标系
                half3 worldNormal = UnityObjectToWorldNormal(v.normal);//法线从自身坐标系转世界坐标系
                o.uv = v.texcoord;
               
                //自定义 漫反射Lambert 光照模型
                half nl = dot(worldNormal, _WorldSpaceLightPos0.xyz);
                nl=nl*0.5+0.5;//漫反射遮蔽，半lambert
                o.diff = nl * _LightColor0;
                return o;
            }
            
            sampler2D _MainTex;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                col *= i.diff;
                return col;
            }
            ENDCG
        }
    }
}