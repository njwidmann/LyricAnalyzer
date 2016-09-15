"""
This script scrapes songs from genius.com using RoboBrowser. It saves all the lyrics to one big txt file for each genre.
Author: NICK WIDMANN
Last Edited: 2/14/16
"""

from robobrowser import RoboBrowser


browser = RoboBrowser(history=True, parser='html.parser')
genres = ["rock", "country", "pop", "r&b", "hiphop"]
num_songs = {}

artists = {}

#Create dictionary of arists' names lists with the genres as the keys
for genre in genres:
    artists[genre] = []
    num_songs[genre] = 0
    fin = open("artists/artists_%s.txt"%genre, "r") #open artists file for given genre
    for line in fin:
        artist_name = line[:-1]#chop off carriage return
        if(artist_name.find(",") >= 0): #Flip the name from 'last, first' to 'first last'
            comma_index = artist_name.index(",")
            artist_name = artist_name[comma_index+2:] + " " + artist_name[:comma_index]
        #replace spaces and slashes with hyphens to meet code for genius.com urls
        artist_name = artist_name.replace(" ", "-")
        artist_name = artist_name.replace("/", "-")

        artists[genre].append(artist_name)
    fin.close() #close artists file
print artists

#This function drops all characters that are not letters, digits, spaces, or carriage returns
def simplify_unicode(in_str):
    out_str = ""
    for char in in_str:
        if char.isalpha() or char.isdigit() or char.isspace() or char == "\n":
            out_str += char
    return out_str

#Loop through artists and create lyrics file sorted by genre
for genre in artists:
    fout = open("lyrics2/lyrics_%s.txt"%genre, "w") #open a text file for the genre to write the songs to
    for artist_name in artists[genre]:

        print "\n"+artist_name
        print "Song Count:", num_songs #print total number of songs collected. num_songs is dictionary with genres as keys
        print "Artists Left in %s: %d" %(genre,len(artists[genre]))

        url = 'http://www.genius.com/artists/' + artist_name #Create url for artist on genius.com
        browser.open(url) #open url

        artists[genre].remove(artist_name) #Remove artist from list (for counting purposes)

        songs = browser.select('.song_name') #Create a list of song links (These all have the html class name song_name)

        for i in range(0,len(songs)): #loop through all the song links
            browser.follow_link(songs[i]) #follow the link for the ith song

            lyrics = browser.select('.lyrics') #Collect all song lyrics on the page (These have html class lyrics)
            if(len(lyrics) > 0): #If there are lyrics on the page
                output = simplify_unicode(lyrics[0].text) #Simplify unicode so that it can be written to txt file

                try:
                    fout.write(output) #Try to write to txt file
                    num_songs[genre] += 1
                except Exception as e: #Catch minor encoding errors
                    print e

            browser.back() #Go back to the songs page to follow the next link


    fout.close() #Close this genre's text file
