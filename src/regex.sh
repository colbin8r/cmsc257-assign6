#!/usr/bin/bash

# 1. read file
filepath=$1
echo $filepath
text="`cat $filepath`"
# echo "$text"

# 2. regular expressions

# a. count lines
# lines=`echo $text | grep -c ^`
# lines=`echo $text | grep -o ^` | wc -l
lines="`echo "$text" | grep $ | wc -l`"

# b. count words
# includes alphanumeric words
words="`echo "$text" | grep -o '[a-zA-Z0-9]*\b' | wc -l`"

# c. find (first) most repetitive word
# does not include alphanumeric words, only alphabetic words
most_word="`echo "$text" | grep -o '[a-zA-Z]*\b' | tr '[A-Z]' '[a-z]' | sort | uniq -c | sort -nr | head -1 | grep -o '[a-zA-Z]*\b'`"

# d. find (first) least repetitive word
# does not include alphanumeric words, only alphabetic words
least_word="`echo "$text" | grep -o '[a-zA-Z]*\b' | tr '[A-Z]' '[a-z]' | sort | uniq -c | sort -k5,5nr | head -1 | grep -o '[a-zA-Z]*\b'`"

# e. specific word counts
# e.1. count the words that start with "d" and end with "d" irrespective of case
word1="`echo $text | egrep -oi '\<[dD][a-zA-Z]+[dD]\>' | wc -l`"

# e.2. count the words that start with "a" irrespective of case
word2="`echo $text | egrep -oi '\<[aA][a-zA-Z]+\>' | wc -l`"

# e.3. count purely numeric words
word3="`echo $text | egrep -oi '\<[0-9]+\>' | wc -l`"

# e.4. count alphanumeric words (words that MUST include numbers)
# I overthought this--purely numeric and alphabetical words are both SUBSETs of alphanumeric words,
# so it should be ok to include them in the count
word4="`echo $text | egrep -oi '\<\w+\>' | wc -l`"
# word4="`echo $text | egrep -oi '\<[0-9]\>' | wc -l`"
# word4="`echo $text | egrep -oi '\b\w*[0-9]+\w*\b' | wc -l`"
# word4="`echo $text | egrep -oi '\<[\w0-9+]+\>' | wc -l`"
# word4="`echo $text | grep -o '\w*\b' | egrep -oi '^[0-9]+$'`"

# 3. print report
printf 'Lines:\t\t\t %s\n' $lines
printf 'Words:\t\t\t %s\n' $words

printf 'Most common word:\t %s\n' $most_word
printf 'Least common word:\t %s\n' $least_word

printf 'Stars/ends with D:\t %s\n' $word1
printf 'Stars with A:\t\t %s\n' $word2
printf 'Numeric words:\t\t %s\n' $word3
printf 'Alphanumeric words:\t %s\n' $word4
