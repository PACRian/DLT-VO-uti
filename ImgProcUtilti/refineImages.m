function refineImages(PATH, varargin)
%UNTITLED 此处提供此函数的摘要
%   此处提供详细说明
    paras = update_struct(struct('range', [nan nan], 'resize', 1, ...
        'readInfo', nan, ...
        'IncludeSubfolder', false, ...
        'savepath', '', ...
        'fmt', nan, ...
        'ext', 'jpg', ...
        'percent', nan), struct(varargin{:}));

    if isnan(paras.readInfo)
        readInfo = @(filename) ...
        struct('id', str2double(filename), 'name', filename, 'len', length(filename));
    elseif ishandle(paras.readInfo)
        readInfo = paras.readInfo;
    else
        error('readInfo property prompted wrong, should be a handler.')
    end

    if isnan(paras.fmt)
        fmt = @(fileobj) sprintf('%%0%dd', fileobj.len);
    elseif ishandle(paras.fmt)
        fmt = paras.fmt;
    else
        error('fmt must be a handle')
    end

    imds = imageDatastore(PATH, "IncludeSubfolders", paras.IncludeSubfolder, ...
        "LabelSource","none");
    
    BIG_LEN = numel(imds.Files);
    if ~isnan(paras.percent)
        range = paras.percent*BIG_LEN;
    else
        range = paras.range;
    end
    range = round(range);
    range(1) = max(range(1), 1);
    range(2) = min(range(2), BIG_LEN);
    
    Filenames = imds.Files{range(1):range(2)};
    for filename=Filenames
        [filepath, name, ~] = fileparts(filename{1});
        fileobj = readInfo(name);
        fileobj.len = BIG_LEN;

        img = imread(filename);
        if paras.resize ~= 1
            img = imresize(img, paras.resize);
        end

        savename = fmt(fileobj);
        if isempty(paras.savepath)
            savepath = filepath;
        else
            savepath = paras.savepath;
        end

        save_to = fullfile(savepath, strcat(savename, '.', paras.ext));
        imwrite(img, save_to, paras.ext);
    end

end