// The following ifdef block is the standard way of creating macros which make exporting
// from a DLL simpler. All files within this DLL are compiled with the CRYPTO_EXPORTS
// symbol defined on the command line. This symbol should not be defined on any project
// that uses this DLL. This way any other project whose source files include this file see
// CRYPTO_API functions as being imported from a DLL, whereas this DLL sees symbols
// defined with this macro as being exported.
#ifdef CRYPTO_EXPORTS
#define CRYPTO_API __declspec(dllexport)
#else
#define CRYPTO_API __declspec(dllimport)
#endif

// This class is exported from the dll
class CRYPTO_API Ccrypto {
public:
	Ccrypto(void);
	// TODO: add your methods here.
};

extern CRYPTO_API int ncrypto;

CRYPTO_API int fncrypto(void);
