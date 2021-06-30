using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AutoDisolve : MonoBehaviour {

    List<Material> mats;
	void Start () {
        mats = new List<Material>();
        var meshs = this.GetComponentsInChildren<MeshRenderer>();
        for (int i = 0; i < meshs.Length; i++)
        {
            mats.Add(meshs[i].material);
        }
    }
	void Update () {
		if(Input.GetMouseButtonDown(0))
        {
            StartCoroutine(Disolve());
        }
	}
    IEnumerator Disolve()
    {
        //直接更换shader
        //mat.shader = Shader.Find("Shader Forge/lesson03_01");
        float value = 0.3f;
        while (value < 0.7)
        {
            yield return 0;
            value += Time.deltaTime*0.2f;
            foreach (var mat in mats)
            {
                //修改shader的属性
                mat.SetFloat("_DisValue", value);
            }
        }
    }
}
