using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScaleAnimate : MonoBehaviour
{
    public int MinScale = 1;

    public int MaxScale = 5;

    // Start is called before the first frame update
    void Start()
    {
        Time.timeScale = 2;
    }

    // Update is called once per frame
    void Update()
    {
        var scale = Mathf.PingPong(Time.time, MaxScale) + MinScale;
        transform.localScale = Vector3.one * scale;
    }
}