function bestMatch = fuzzyMatch(query, allText)
    import java.util.Locale
    import org.apache.commons.text.similarity.FuzzyScore

    matcher = FuzzyScore(Locale.ENGLISH);
    score = zeros(numel(allText, 1));
    for iItem = 1:numel(allText)
        score(iItem) = matcher.fuzzyScore(...
            java.lang.String(allText{iItem}), ...
            java.lang.String(query));
    end
    matchLength = cellfun(@numel, allText);
    matchLength = -matchLength;
    score = score';
    results = table(score, allText, matchLength);
    bestMatch = sortrows(results, {'score', 'matchLength'}, 'descend');
end
