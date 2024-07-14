proc
    text_to_list(string, delimiter=" ")
        var/list/listified = new, last=1
        for(var/find=findtext(string, delimiter); find; find=findtext(string, delimiter, find+length(delimiter)))
            listified += copytext(string, last, find)
            last=find+length(delimiter)

        listified += copytext(string, last)

        return listified