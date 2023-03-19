using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

public class LoopPinpangValue : MonoBehaviour
{
    public int MinValue = 0;

    public int MaxValue = 2;

    public float Duration = 2;

    public string PropertyName = "_Power";

    private Renderer render;

    // Start is called before the first frame update
    void Start()
    {
        render = this.GetComponent<Renderer>();
    }

    // Update is called once per frame
    void Update()
    {
        var scale = Mathf.PingPong(Time.time, MaxValue) + MinValue;
        var t = scale / Duration;
        render.material.SetFloat(PropertyName, t);
    }
}