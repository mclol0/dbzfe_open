// crypto.cpp : Defines the exported functions for the DLL.
//

#include "pch.h"
#include "framework.h"
#include "crypto.h"
#include <string>
#include <hex.h>
#include <base64.h>
#include <sha.h>
#include <memory>

extern "C" __declspec(dllexport) const char* SHA1(int argc, const char* argv[]);
extern "C" __declspec(dllexport) const char* SHA224(int argc, const char* argv[]);
extern "C" __declspec(dllexport) const char* SHA256(int argc, const char* argv[]);
extern "C" __declspec(dllexport) const char* SHA384(int argc, const char* argv[]);
extern "C" __declspec(dllexport) const char* SHA512(int argc, const char* argv[]);

using namespace std;

namespace {
    thread_local string output;

    template <typename HashFunction>
    const char* computeHash(const char* input) {
        HashFunction hash;
        vector<CryptoPP::byte> digest(hash.DigestSize());
        hash.CalculateDigest(digest.data(), reinterpret_cast<const CryptoPP::byte*>(input), strlen(input));

        output.clear();
        CryptoPP::HexEncoder encoder(new CryptoPP::StringSink(output));
        encoder.Put(digest.data(), digest.size());
        encoder.MessageEnd();

        return output.c_str();
    }
}

extern "C" const char* SHA1(int argc, const char* argv[]) {
    return computeHash<CryptoPP::SHA1>(argv[0]);
}

extern "C" const char* SHA224(int argc, const char* argv[]) {
    return computeHash<CryptoPP::SHA224>(argv[0]);
}

extern "C" const char* SHA256(int argc, const char* argv[]) {
    return computeHash<CryptoPP::SHA256>(argv[0]);
}

extern "C" const char* SHA384(int argc, const char* argv[]) {
    return computeHash<CryptoPP::SHA384>(argv[0]);
}

extern "C" const char* SHA512(int argc, const char* argv[]) {
    return computeHash<CryptoPP::SHA512>(argv[0]);
}


// This is an example of an exported variable
CRYPTO_API int ncrypto=0;

// This is an example of an exported function.
CRYPTO_API int fncrypto(void)
{
    return 0;
}

// This is the constructor of a class that has been exported.
Ccrypto::Ccrypto()
{
    return;
}
