using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class AnimationMarker : ICloneable {

    [SerializeField]
    public Color markerColor = Color.green;

    [SerializeField]
    public Transform trackedGameObject;

    [HideInInspector]
    [SerializeField]
    public Vector3 trackedPosition = Vector3.zero;

    [HideInInspector]
    [SerializeField]
    public Vector3 originalPosition = Vector3.zero;

    [SerializeField]
    [Range (0f, 0.2f)]
    public float trackerSensibility = 0.175f;

    [HideInInspector]
    public int hBuf = 0;
    [HideInInspector]
    public int vBuf = 0;

    [SerializeField]
    public int markerBufferSize = 10;

    public object Clone () {
        return MemberwiseClone ();
    }
}