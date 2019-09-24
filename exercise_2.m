fs_2 =  300e3; % this is the sample rate
fc_2 = 107.9e6; % this is the center frequency

x_2 = zeros(3e6,1); % empty vector to store data

% create object for RTL-SDR receiver
rx_2 = comm.SDRRTLReceiver('CenterFrequency',fc_2, 'EnableTunerAGC', false, 'TunerGain', 45,  'SampleRate', fs_2);

counter = 1; % initialize a counter
while(counter < length(x_2)) % while the buffer for data is not full
    rxdata = rx_2();   % read from the RTL-SDR
    x_2(counter:counter + length(rxdata)-1) = rxdata; % save the samples returned
    counter = counter + length(rxdata); % increment counter
end
% the data are returned as complex numbers
% separate real and imaginary part, and remove any DC offset
y_I_2 = real(x_2)-mean(real(x_2));
y_Q_2 = imag(x_2)-mean(imag(x_2));
