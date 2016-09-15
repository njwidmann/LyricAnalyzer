%This script reads lyrics .dat files for each of genres and creates a list of 
%all of the unique_words as well as a percent_mat that hold the percentages
%of the each of unique_words occurences in each genre's lyrics.
%Execution time is 33 minutes

genres = {'country', 'hiphop', 'pop', 'r&b', 'rock'};

[lyrics, all_words] = lyric_importer(genres);

unique_words = create_unique_words_list(all_words);

percent_mat = word_percent_by_genre(unique_words, lyrics, genres);