using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioBasedAnimation : MonoBehaviour {

    SkinnedMeshRenderer blendshapesRenderer;
    AudioSource audioSource;

    [Header ("General Settings")]

    [SerializeField]
    int volumeShapeIndex = 0;
    [SerializeField]
    int pitchShapeIndex = 1;
    [SerializeField]
    float volumeScale = 2000; // set how much the scale will vary
    [SerializeField]
    float pitchScale = 2000; // set how much the scale will vary

    [Header ("Internal Settings")]

    [SerializeField]
    int qSamples = 1024; // array size
    [SerializeField]
    float refValue = 0.1f; // RMS value for 0 dB
    [SerializeField]
    float rmsValue; // sound level - RMS
    [SerializeField]
    float dbValue; // sound level - dB
    [SerializeField]
    float threshold = 0.02f;

    float fSample;
    float pitchValue; // sound pitch - Hz
    float[] spectrum; // audio spectrum
    float[] samples; // audio samples
    float volVel;
    float pitVet;

    void Start () {
        samples = new float[qSamples];
        spectrum = new float[qSamples];
        fSample = AudioSettings.outputSampleRate;
        blendshapesRenderer = GetComponent<SkinnedMeshRenderer> ();
        audioSource = GetComponent<AudioSource> ();
        InvokeRepeating ("GetVolume", 0f, 0.1f);
    }

    void Update () {

        float smoothVol = Mathf.SmoothDamp (blendshapesRenderer.GetBlendShapeWeight (volumeShapeIndex), volumeScale * rmsValue, ref volVel, 0.025f);
        float smoothPit = Mathf.SmoothDamp (blendshapesRenderer.GetBlendShapeWeight (pitchShapeIndex), pitchScale * pitchValue, ref pitVet, 0.025f);

        blendshapesRenderer.SetBlendShapeWeight (volumeShapeIndex, smoothVol);
        blendshapesRenderer.SetBlendShapeWeight (pitchShapeIndex, smoothPit);
    }

    void GetVolume () {

        // Volume

        audioSource.GetOutputData (samples, 0); // fill array with samples
        int i;
        float sum = 0.0f;

        for (i = 0; i < qSamples; i++) {
            sum += samples[i] * samples[i]; // sum squared samples
        }

        rmsValue = Mathf.Sqrt (sum / qSamples); // rms = square root of average
        dbValue = 20 * Mathf.Log10 (rmsValue / refValue); // calculate dB
        if (dbValue < -160) dbValue = -160; // clamp it to -160dB min

        // Pitch

        audioSource.GetSpectrumData (spectrum, 0, FFTWindow.BlackmanHarris);
        float maxV = 0f;
        int maxN = 0;
        for (i = 0; i < qSamples; i++) { // find max 
            if (spectrum[i] > maxV && spectrum[i] > threshold) {
                maxV = spectrum[i];
                maxN = i; // maxN is the index of max
            }
        }
        float freqN = maxN; // pass the index to a float variable
        if (maxN > 0 && maxN < qSamples - 1) { // interpolate index using neighbours
            var dL = spectrum[maxN - 1] / spectrum[maxN];
            var dR = spectrum[maxN + 1] / spectrum[maxN];
            freqN += 0.5f * (dR * dR - dL * dL);
        }
        pitchValue = freqN * (fSample / 2) / qSamples; // convert index to frequency
    }

}