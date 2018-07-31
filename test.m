import java.util.Locale
javaaddpath('commons-text-1.4/commons-text-1.4.jar');
import org.apache.commons.text.similarity.FuzzyScore

matcher = FuzzyScore(Locale.ENGLISH);
query = 'sub';
files = dir('~');
allText = {files.name};
score = zeros(numel(allText, 1));
tic
for iItem = 1:numel(allText)
    score(iItem) = matcher.fuzzyScore(...
        java.lang.String(allText{iItem}), java.lang.String(query));
end
toc

[val, idx] = max(score)
disp(allText{idx})