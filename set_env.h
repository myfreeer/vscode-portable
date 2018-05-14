#include <tchar.h>
#include <stdbool.h>

DWORD WINAPI GetModulePath(TCHAR *pDirBuf, DWORD bufLength) {
    TCHAR* szEnd = NULL;
    GetModuleFileName(NULL, pDirBuf, bufLength);
    szEnd = _tcsrchr(pDirBuf, _T('\\'));
    *(szEnd) = 0;
    return szEnd - pDirBuf;
}

void DLLHijackAttach(bool isSucceed) {
    if (isSucceed) {
#ifdef HookDebug
        MessageBox(NULL, TEXT("DLL Hijack Attach Succeed!"), TEXT(DLL_NAME " DLL Hijack Attach"), MB_OK);
#endif
        TCHAR szDir[MAX_PATH] = { 0 };
        GetModulePath(szDir, MAX_PATH);
        SetEnvironmentVariable(_T("VSCODE_APPDATA"), szDir);
        _tcscat(szDir, _T("\\extensions"));
        SetEnvironmentVariable(_T("VSCODE_EXTENSIONS"), szDir);
        // SetEnvironmentVariable(_T("APPDATA"), szDir);
        // SetEnvironmentVariable(_T("LOCALAPPDATA"), szDir);
        // SetEnvironmentVariable(_T("ALLUSERSPROFILE"), szDir);
        // SetEnvironmentVariable(_T("USERPROFILE"), szDir);
    }
}

void DLLHijackDetach(bool isSucceed) {
    if (isSucceed) {
#ifdef HookDebug
        MessageBox(NULL, TEXT("DLL Hijack Detach Succeed!"), TEXT(DLL_NAME " DLL Hijack Detach"), MB_OK);
#endif
    }
}
