using System;
using UnityEngine;

[ExecuteAlways]
public class SortingRender : MonoBehaviour
{
    private Renderer myRender;

    public string sortingLayerName = "Default"; //方法前的初始化
    public int orderInLayer = 0;

    private void Awake()
    {
        myRender = this.GetComponent<Renderer>();
    }

    void SetSortingLayer()
    {
        if (sortingLayerName != string.Empty)
        {
            myRender.sortingLayerName = sortingLayerName;
            myRender.sortingOrder = orderInLayer;
        }
    }

#if UNITY_EDITOR
    private void Update()
    {
        SetSortingLayer();
    }
#endif
}
