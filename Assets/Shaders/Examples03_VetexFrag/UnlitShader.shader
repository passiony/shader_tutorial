Shader "Custom/UnlitShader"
{
    Properties{
        _MainTex("贴图",2D)="white"{}
    }

    SubShader
    {
        Tags{"RenderType"="Opaque"}
        LOD 200
        Pass{
            CGPROGRAM

            //渲染管线：应用阶段->几何阶段（顶点函数计算->片元函数计算）->光栅化
            #pragma vertex vert//顶点函数
            #pragma fragment frag//片元函数

            //应用阶段传输给几何阶段的顶点函数的参数
            struct appdata
            {
                float4 vertex :POSITION;//语义：代表顶点位置
                float2 uv:TEXCOORD0;//语义：贴图的UV
            };
            //顶点函数计算后传输给片元函数的参数
            struct v2f
            {
                float4 vertex :SV_POSITION;
                float2 uv:TEXCOORD0;
            };

            v2f vert(appdata a)
            {
                v2f o;
                //应用层顶点无法直接给几何阶段，需要从自身转屏幕
                o.vertex = UnityObjectToClipPos(a.vertex);
                o.uv = a.uv;
                return o;
            }

            sampler2D _MainTex;
            float4 _MainTex_ST;

            fixed4 frag(v2f i) :SV_Target
            {
                fixed4 c = tex2D(_MainTex, i.uv);
                return c;
            }

            ENDCG
        }
    }
}