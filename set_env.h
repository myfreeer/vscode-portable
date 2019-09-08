#include <tchar.h>
#include <stdbool.h>

#define memcpy_str(dest, str) memcpy((dest), (str), sizeof(str))

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
        DWORD pathLength = GetModulePath(szDir, MAX_PATH);
        SetEnvironmentVariable(_T("VSCODE_APPDATA"), szDir);
        memcpy_str(szDir + pathLength, _T("\\AppData"));
        if (CreateDirectory(szDir, NULL) || GetLastError() == ERROR_ALREADY_EXISTS) {
          _tcscat(szDir, _T("\\Roaming"));
          if (CreateDirectory(szDir, NULL) || GetLastError() == ERROR_ALREADY_EXISTS) {
            *(szDir + pathLength) = _T('\0');
            SetEnvironmentVariable(_T("USERPROFILE"), szDir);
            SetEnvironmentVariable(_T("ALLUSERSPROFILE"), szDir);
          }
        }
        memcpy_str(szDir + pathLength, _T("\\extensions"));
        SetEnvironmentVariable(_T("VSCODE_EXTENSIONS"), szDir);
        memcpy_str(szDir + pathLength, _T("\\logs"));
        SetEnvironmentVariable(_T("VSCODE_LOGS"), szDir);
        // SetEnvironmentVariable(_T("APPDATA"), szDir);
        // SetEnvironmentVariable(_T("LOCALAPPDATA"), szDir);
    }
}

void DLLHijackDetach(bool isSucceed) {
    if (isSucceed) {
#ifdef HookDebug
        MessageBox(NULL, TEXT("DLL Hijack Detach Succeed!"), TEXT(DLL_NAME " DLL Hijack Detach"), MB_OK);
#endif
    }
}
