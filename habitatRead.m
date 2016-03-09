% Fred Henry
% Creates habitat ranking information for the inputed file data

function [num,txt] = habitatRead(num, txt)

txt = txt(2:end, 2);

% Create a numerial classification of differnet habitats
habs = unique(txt);
for i = 1:numel(txt)
    for j = 1:numel(habs)
        if strcmp(txt(i), habs(j))
            num(i,2) = j;
        end;
    end;
end;