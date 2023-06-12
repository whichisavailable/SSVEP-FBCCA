function Hd = filter4
%FILTER4 返回离散时间滤波器对象。

% MATLAB Code
% Generated by MATLAB(R) 9.12 and Signal Processing Toolbox 9.0.
% Generated on: 10-Jun-2023 19:30:44

% Chebyshev Type I Highpass filter designed using FDESIGN.HIGHPASS.

% All frequency values are in Hz.
Fs = 1000;  % Sampling Frequency

Fstop1 = 30;           % First Stopband Frequency
Fpass1 = 32;           % First Passband Frequency
Fpass2 = 80;          % Second Passband Frequency
Fstop2 = 100;         % Second Stopband Frequency
Astop1 = 80;          % First Stopband Attenuation (dB)
Apass  = 1;           % Passband Ripple (dB)
Astop2 = 80;          % Second Stopband Attenuation (dB)
match  = 'passband';  % Band to match exactly

% Construct an FDESIGN object and call its CHEBY1 method.
h  = fdesign.bandpass(Fstop1, Fpass1, Fpass2, Fstop2, Astop1, Apass, ...
                      Astop2, Fs);
Hd = design(h, 'cheby1', 'MatchExactly', match);
% [EOF]
