/*

	Text-Handling Procs by Hiead

	This library contains some basic text-handling functions.

	Overview:


    -	In cases where there is a "text" form and a
        "Text" form, the behavior is case-insensitive
        for the "text" form.

	find.dm:

findtext_first_of(haystack, needle, pos=1)

    -	Returns position of the first character from needle
        found in haystack, starting from pos.

findText_first_of(haystack, needle, pos=1)

findtext_first_not_of(haystack, needle, pos=1)

    -	Returns position of the first character from haystack
        not found in needle, starting from pos.

findText_first_not_of(haystack, needle, pos=1)

findtext_last_of(haystack, needle, pos=0)

    -	Returns position of the last occurrence of a character
        from needle in hastack, starting from pos (0 = end).

findText_last_of(haystack, needle, pos=0)

findtext_last_not_of(haystack, needle, pos=0)

    -	Returns position of the last character from haystack
        not found in needle, starting from pos (0 = end).

findText_last_not_of(haystack, needle, pos=0)



	replace.dm:

replacetext(haystack, needle, replace)

    -	Replace occurrences of needle in haystack with replace.

replaceText(haystack, needle, replace)



	utils.dm:

reversetext(text)

    -	Reverses string order.

explodetext(text, delim, limit=0)

    -	Returns a list of strings, each of which is a substring
        of text formed by splitting it on boundaries formed by
        delim. When limit = 0, the list has no boundary length.

explodeText(text, delim, limit=0)

implodetext(list/L, delim)

    -	Returns a string formed by concatenating the elements of
        L with the delim string.

*/