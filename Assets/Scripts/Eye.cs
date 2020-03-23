using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Eye : MonoBehaviour {
    Transform cameraPos;
    void Start () {
        cameraPos = Camera.main.transform;
    }

    // Update is called once per frame
    void Update () {
        transform.LookAt (cameraPos.position);
    }
}