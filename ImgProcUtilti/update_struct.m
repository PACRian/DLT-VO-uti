function mstruct = update_struct(base, update_struct)
% 基于基础struct(`base`)，更新出新的结构体
%% ARGUMENT
% base: 基础结构体，可以认为是缺省值
% update_struct: 更新填充阵列
%% RETURN
% mstruct: 更新合并后的结构体
    mstruct = struct();
    fields = fieldnames(base);
    for k = 1:length(fields)
        field = fields{k};
        if isfield(update_struct, field)
            value = getfield(update_struct, field);
        else
            value = getfield(base, field);
        end

        mstruct=setfield(mstruct, field, value);
    end

end