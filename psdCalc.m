path_nwb = ['C:\Users\mahdi\Desktop\documents\university\courses\C286\project\Illusion_project\' ...
    'sub-619296\sub-619296_ses-1187930705_probe-1_ecephys.nwb'];
nwb = nwbRead(path_nwb);


dataLFP = nwb.acquisition.get('probe_1_lfp');
runningSpeedData = nwb.acquisition.get('X');  % We couldn't locate the corresponding parameter to running speed in the NWB file

%%% sampling freq
fs = 1000; 
nfft = 2^nextpow2(size(dataLFP, 1));
f = fs/2*linspace(0,1,nfft/2+1);

numSegments = 10;
segmentIndices = cell(numSegments, 1);
for j = 1:numSegments
    segmentIndices{j} = randi([1, length(runningSpeedData)], 100, 1);
end

% for each LFP channel
for i = 1:size(dataLFP, 2)
    % fft calc
    for j = 1:numSegments
        lfpSegment = dataLFP(segmentIndices{j}, i); 
        speedSegment = runningSpeedData(segmentIndices{j}); 
        
        % fft func
        Y = fft(lfpSegment, nfft);
        
        % ps func
        P = abs(Y/nfft).^2;
        
        % plotting script
        plot(f, 10*log10(P(1:nfft/2+1)), 'LineWidth', 1.5); % Plot only the positive frequencies
        xlabel('Frequency (Hz)');
        ylabel('Power/Frequency (dB/Hz)');
        title('Power Spectral Density');
        xlim([0, fs/2]);
        grid on;
        hold on;
    end
end
