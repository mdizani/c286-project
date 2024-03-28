path_nwb = ['C:\Users\mahdi\Desktop\documents\university\courses\C286\project\Illusion_project\' ...
    'sub-619296\sub-619296_ses-1187930705_probe-1_ecephys.nwb'];

%%% to read "malfunctioned files" alternatively %%%
% path_nwb = ['C:\Users\mahdi\Desktop\documents\university\courses\C286\project\' ...
%     'sub-411400_ses-759666166_behavior+image+ophys.nwb']; 
nwb = nwbRead(path_nwb);

nwbFile = path_nwb;
info = h5info(nwbFile);

for i = 1:length(info.Groups)
    fprintf('Group %d: %s\n', i, info.Groups(i).Name);
end

for i = 1:length(info.Datasets)
    fprintf('Dataset %d: %s\n', i, info.Datasets(i).Name);
end

nwb
nwb.acquisition
nwb.acquisition.get('probe_1_lfp')
nwb.acquisition.get('probe_1_lfp_data')

lfpData = nwb.acquisition.get('probe_1_lfp');
matrixLFP = cell2mat(lfpData);

matrx = lfpData.electricalseries;
cell2mat(matrx)
