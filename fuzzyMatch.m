function bestMatch = fuzzyMatch(query, allText)
    import java.util.Locale
    import org.apache.commons.text.similarity.FuzzyScore

    matcher = FuzzyScore(Locale.ENGLISH);
    score = zeros(numel(allText, 1));
    for iItem = 1:numel(allText)
        score(iItem) = matcher.fuzzyScore(...
            java.lang.String(allText{iItem}), java.lang.String(query));
    end
    results = table(score', allText);
    [val, idx] = max(score)
    bestResults = results(results.Var1 == val,:)
    if height(bestResults) > 1
        matchLength = cellfun(@numel, bestResults.allText);
        [~, idx] = min(matchLength);
        bestMatch = bestResults.allText{idx};
    else
        bestMatch = bestResults.allText{1};
    end
end
