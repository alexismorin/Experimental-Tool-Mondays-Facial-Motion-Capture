using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MarkerBasedAnimation : MonoBehaviour {

    WebCamTexture webcamTexture;
    int width = 0;
    int height = 0;

    public RawImage debugImage;
    public Image outputImage;

    public AnimationMarker[] markers;

    [Space (10f)]

    public float captureScale = 0.01f;

    void Start () {

        foreach (AnimationMarker marker in markers) {
            marker.originalPosition = marker.trackedGameObject.localPosition;
        }

        // We initialize webcam texture data
        webcamTexture = new WebCamTexture ();
        webcamTexture.Play ();

        width = webcamTexture.width;
        height = webcamTexture.height;

        debugImage.texture = webcamTexture;
        debugImage.material.mainTexture = webcamTexture;

    }

    void Calibrate () {
        foreach (AnimationMarker marker in markers) {
            Vector3 calibratedPosition = marker.trackedGameObject.localPosition - marker.originalPosition;
            marker.originalPosition -= calibratedPosition;
        }
    }

    void Update () {

        if (Input.GetKeyDown (KeyCode.Space)) {
            Calibrate ();
        }

        Texture2D modifiableTexture = new Texture2D (width, height, TextureFormat.ARGB32, false);

        if (webcamTexture.isPlaying) {

            for (int y = 0; y < height - 1; y++) {
                for (int x = 0; x < width - 1; x++) {

                    foreach (AnimationMarker marker in markers) {

                        // We check if a marker is present
                        Color pixelColor = webcamTexture.GetPixel (x, y);
                        if (pixelColor.r <= marker.markerColor.r + marker.trackerSensibility && pixelColor.r >= marker.markerColor.r - marker.trackerSensibility &&
                            pixelColor.g <= marker.markerColor.g + marker.trackerSensibility && pixelColor.g >= marker.markerColor.g - marker.trackerSensibility &&
                            pixelColor.b <= marker.markerColor.b + marker.trackerSensibility && pixelColor.b >= marker.markerColor.b - marker.trackerSensibility
                        ) {

                            modifiableTexture.SetPixel (x, y, pixelColor);
                            marker.hBuf++;

                            // Only chunks of color are recognized as markers, set by markerBufferSize
                            if (marker.hBuf > marker.markerBufferSize) {
                                marker.trackedGameObject.localPosition = marker.originalPosition + new Vector3 (x * captureScale, y * captureScale, 0f);
                                marker.hBuf = 0;
                            }
                        }
                    }
                }
            }

            modifiableTexture.Apply ();
            Sprite outputSprite = Sprite.Create (modifiableTexture, new Rect (0.0f, 0.0f, width, height), new Vector2 (0.5f, 0.5f), 100.0f);
            outputImage.sprite = outputSprite;

        }
    }
}