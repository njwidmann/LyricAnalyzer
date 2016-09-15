
function percent_mat = word_percent_by_genre(unique_words, lyrics, genres)
%This function creates a matrix full of percentages of the unique_words
%occurences in each of genres. Each row corresponds to a genre and cols
%correspond to the word's index in unique_words. e.g. percent_mat(1,4) =
%the percentage of the fourth word ( unique_words{4} )in the first genre ( genres{1} ).
%
%   Inputs:
%   unique_words = the cell array of all unique words in lyrics as strings
%   lyrics = nested cell array with lyrics{1} corresponding to the cell
%       array of lyrics for the first genre
%   genres = cell array of genres as strings. genres{1} corresponds to
%       lyrics{1}

    percent_mat = zeros(length(genres), length(unique_words));
    for i = 1:length(genres)
        lyrics_copy = lyrics{i};
        for j = 1:length(unique_words)
            word = unique_words{j};
            word_bools = strcmp(word, lyrics_copy); %find and delete each of unique_words from the genre's lyrics
            indeces = find(word_bools);
            percent_mat(i,j) = length(indeces) / length( lyrics{i} ); %create percentage and place in matrix
            lyrics_copy(indeces) = []; %remove all word occurences from lyrics_copy to speed up execution
            %fprintf('Creating Percent Mat... Genre: %s \t Words Completed: %d / %d\n', genres{i}, j, length(unique_words)); %print status
        end
    end
end