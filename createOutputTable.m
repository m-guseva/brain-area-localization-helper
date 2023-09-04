function tbl = createOutputTable(pathToTabDat, contrastName)

load(pathToTabDat);

% Extract relevant columns from TabDat:

% P-VALUES
p_FWE_corr = TabDat.dat(:,3);
idx_empty = cellfun('isempty',p_FWE_corr);
p_FWE_corr(idx_empty) = {NaN};
p_FWE_corr = cell2mat(p_FWE_corr);

% T-VALUES
t_val = cell2mat(TabDat.dat(:,9));

% CLUSTER SIZE k
k = cell2mat(TabDat.dat(:,5));

% CONTRAST NAME
contrast = repmat(contrastName,sum(~idx_empty),1);

% COORDINATES 
coordinates = TabDat.dat(:,12);

% HEMISPHERE
for i = 1:length(coordinates)
    
    x(i) = coordinates{i}(1);
    y(i) = coordinates{i}(2);
    z(i) = coordinates{i}(3);
    
    if x(i) < 0
        hemisphere(i) = 'l';
    else
        hemisphere(i) = 'r';
    end
    
end

% apply mni2atlas on each coordinate
coordinates = coordinates(~idx_empty); % only clusterwise
for coord = 1:length(coordinates)
    location = mni2atlas(coordinates{coord});
    
    loc = struct2table(location);
    expandedData = struct('name', {}, 'label', {});
    for i = 1:size(loc, 1)
        name = loc.name(i);
        label = loc.label{i};
        if iscell(label)
            numLabels = numel(label);
            for j = 1:numLabels
                expandedData(end+1, :) = struct('name', name, 'label', label{j});
            end
        else
            expandedData(end+1, :) = struct('name', name, 'label', label);
        end
    end
    expanded_loc = struct2table(expandedData);
    
    
    L{coord} = expanded_loc;
end

%% Create table
varNames = ["contrast","locations","hemisphere", "t", "k", "p_FWE_corr", "x","y","z"];
tbl = table(string(contrast), L', string(hemisphere(~idx_empty)'), t_val(~idx_empty),k, p_FWE_corr(~idx_empty), x(~idx_empty)', y(~idx_empty)', z(~idx_empty)', 'VariableNames', varNames);


end