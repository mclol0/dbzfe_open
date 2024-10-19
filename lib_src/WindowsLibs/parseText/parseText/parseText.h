// The following ifdef block is the standard way of creating macros which make exporting
// from a DLL simpler. All files within this DLL are compiled with the PARSETEXT_EXPORTS
// symbol defined on the command line. This symbol should not be defined on any project
// that uses this DLL. This way any other project whose source files include this file see
// PARSETEXT_API functions as being imported from a DLL, whereas this DLL sees symbols
// defined with this macro as being exported.
#ifdef PARSETEXT_EXPORTS
#define PARSETEXT_API __declspec(dllexport)
#else
#define PARSETEXT_API __declspec(dllimport)
#endif

// This class is exported from the dll
class PARSETEXT_API CparseText {
public:
	CparseText(void);
	// TODO: add your methods here.
};

extern PARSETEXT_API int nparseText;

PARSETEXT_API int fnparseText(void);
extern "C" {
    PARSETEXT_API const char* ParseColors(int argc, const char* argv[]);
    PARSETEXT_API const char* StripColors(int argc, const char* argv[]);
    PARSETEXT_API const char* ByondColors(int argc, const char* argv[]);
    PARSETEXT_API const char* systemTime();
}
