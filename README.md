# Acoustics
Basic processing for acoustics.

## Reverb Time

Simple algorithm for calculating T20 and T30 (or any dB difference) of an impulse response. A third octave filtering is NOT applied to the signal but can be done to obtain different times for each band. The medthod used for its calculation is the following:
- First the enevelope is obtained by taking the module of the signals Hilbert transform.
- Then the response is smoothed by filtering it with a moving average *movmean*.
- E(t) its calculated with the Schroeder "integral method" for some more smoothing.
- A line is adjusted to the time difference (with an optional top margin) and the 60dB fall is estimated with the evaluated fall.
