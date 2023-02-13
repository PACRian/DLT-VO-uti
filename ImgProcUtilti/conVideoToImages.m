function [s] = conVideoToImages(filename,varargin)
%conVideoToImages 将视频转换为图像
%   参数�?
%   1. range �?个向量组，为[start end]格式，默认视频全部进行转换，nan则由程序指定为视频头或尾
%   2. percent 以比例指定的range, 同样为[start end]格式，取值在0~1之间，当同时指定range �?
%   percent时，以percent为准
%   2. resize 缩放大小，默认为1
%   3. savepath 保存路径，默认是同级下以名称起始的文件夹
%   4. ext 保存图片格式，默认是`jpg`
%   5. fmt 图片名的格式，可以是�?个句柄，接受变量次序�? (k, numFrames, range, name)
    paras = update_struct(struct('range', [nan nan], 'resize', 1, ...
        'savepath', '', ...
        'ext', 'jpg', ...
        'fmt', nan), struct(varargin{:}));

    vid = VideoReader(filename);
    numFrames = vid.NumFrames;
    if isfield(paras, 'percent')
        range = paras.percent.*numFrames;
    else
        range = paras.range;
    end    
    range = round(range);
    range(1) = max(range(1), 1);
    range(2) = min(range(2), numFrames);
    disp(range)
    
    [filepath, vidname, ~] = fileparts(filename);
    if isempty(paras.savepath)
        savepath = fullfile(filepath, vidname);
    else
        savepath = paras.savepath;
    end
    mkdir(savepath);

    if isnan(paras.fmt)
        fmt = sprintf('%%0%dd', numel(num2str(numFrames)));
        % 默认的图片命名格�?
        % %0{}d
    else
        fmt = paras.fmt;
    end

    for k=range(1):range(2)
        if ishandle(fmt)
            name = paras.fmt(k, numFrames, range, vidname);
        else
            name = sprintf(fmt, k);
        end
        name = strcat(name, '.', paras.ext);
        
        fr = read(vid, k);
        if paras.resize ~= 1
            fr = imresize(fr, paras.resize);
        end
        imwrite(fr, fullfile(savepath, name), paras.ext);
    end

    s=1;
end