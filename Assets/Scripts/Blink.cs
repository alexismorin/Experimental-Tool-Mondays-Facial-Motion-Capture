using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Blink : MonoBehaviour {

    [SerializeField]
    Transform[] upperEyelids;
    [SerializeField]
    Transform[] lowerEyelids;

    float originalUpper;
    float originalLower;

    void Start () {
        originalUpper = upperEyelids[0].localEulerAngles.x;
        originalLower = lowerEyelids[0].localEulerAngles.x;
        InvokeRepeating ("BlinkEye", 1f, 1.236f);
    }

    void BlinkEye () {

        foreach (Transform eye in upperEyelids) {
            eye.localEulerAngles = Vector3.zero;
        }
        foreach (Transform eye in lowerEyelids) {
            eye.localEulerAngles = Vector3.zero;
        }

        Invoke ("OpenEye", 0.1f);
    }

    void OpenEye () {
        foreach (Transform eye in upperEyelids) {
            eye.localEulerAngles = Vector3.right * originalUpper;
        }
        foreach (Transform eye in lowerEyelids) {
            eye.localEulerAngles = Vector3.right * originalLower;
        }
    }
}