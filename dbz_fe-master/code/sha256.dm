// Define a global variable to hold the API response
var/global/api_response = ""

// Function to initiate the API call
proc/getSHA256Hash(inputString)

    // Make the API request
    var/http[] = world.Export("https://api.hashify.net/hash/sha256/hex?value=[inputString]")

    var/F = http["CONTENT"]

    world << F
    //ExportResponse(200, F)
    world << api_response
    // Assuming the response is immediately available and stored in `api_response`
    // In a real scenario, you might need to implement a waiting mechanism or handle the response in a callback
    return api_response

// Callback function that BYOND calls when `world.Export()` completes
proc/ExportResponse(status, responseText)
    if(status == 200) // HTTP OK
    {
        // Find the start of the "Digest" value
        var/start = findtext(responseText, "\"Digest\":\"") + 10 // 10 is the length of "\"Digest\":\""
        // Find the end of the "Digest" value
        var/end = findtext(responseText, "\"", start)

        // Extract the "Digest" value
        var/digest = copytext(responseText, start, end)

        // Store or use the digest value as needed
        api_response = digest
    }
    else
    {
        api_response = "Error: Unable to fetch hash"
    }


// Helper function to URL encode the input string
proc/ur_encode(str)
    var/char
    var/encoded = ""
    for(var/i=1, i<=length(str), i++)
        char = copytext(str, i, i+1)
        switch(char)
            if(" ", "!", "$", "&", "'", "(", ")", "*", "+", ",", "/", ":", ";", "=", "?", "@", "\[", "\]")
                encoded += "%" + ascii2hex(char)
            else
                encoded += char
    return encoded

// Helper function to convert characters to their ASCII hex representation
proc/ascii2hex(char)
    var/num = ascii2text(char)
    return num2text(num, 16)
