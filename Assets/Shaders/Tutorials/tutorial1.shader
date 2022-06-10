Shader "Custom/tutorial1"
{
    Properties{
        //属性定义
        _MainColor("MainColor", Color) = (1,1,1,1)//主颜色
    }

    SubShader
    {
        Tags{"RenderType"="Opaque"}

        //pass通道
        Pass{
            //CG代码块声明
            CGPROGRAM
            #pragma vertex vert//顶点函数
            #pragma fragment frag//片元函数

            //应用阶段传输给几何阶段的顶点函数的参数
            struct appdata
            {
                float4 vertex :POSITION;//语义：代表顶点位置
            };
            //顶点函数计算后传输给片元函数的参数
            struct v2f
            {
                float4 vertex :SV_POSITION;//语义：代表屏幕空间坐标位置
            };

            //顶点函数
            v2f vert(appdata a)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(a.vertex);//顶点从自身空间转裁剪空间，几何阶段使用
                return o;
            }

            //片元函数
            fixed4 frag(v2f i) :SV_Target
            {
                return fixed4(1,1,1,1);
            }
            ENDCG
        }
    }
}
