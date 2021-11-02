unit WindowsVersion;

{$IF not(defined(WINDOWS) or defined(MSWINDOWS))}
  {$MESSAGE FATAL 'Unsupported operating system.'}
{$IFEND}

{$IFDEF FPC}
  {$MODE ObjFPC}
{$ENDIF}
{$H+}

interface

uses
  Windows,
  AuxTypes;

{===============================================================================
--------------------------------------------------------------------------------
                               Windows NT version
--------------------------------------------------------------------------------
===============================================================================}
{===============================================================================
    Windows NT version - constants
===============================================================================}
{
  Windows NT version constants.

  High byte contains major version, low byte contains minor version.

  Can be used eg. in calls to VerifyVersionInfo to check which OS is the
  program running on.

  To get major version, use function MajorVersion.
  
  To get minor version, use function MinorVersion.
}
const
  WIN32_WINNT_NT4          = $0400;
  WIN32_WINNT_WIN2K        = $0500;
  WIN32_WINNT_WINXP        = $0501;
  WIN32_WINNT_WS03         = $0502;
  WIN32_WINNT_WIN6         = $0600;
  WIN32_WINNT_VISTA        = $0600;
  WIN32_WINNT_WS08         = $0600;
  WIN32_WINNT_LONGHORN     = $0600;
  WIN32_WINNT_WIN7         = $0601;
  WIN32_WINNT_WIN8         = $0602;
  WIN32_WINNT_WINBLUE      = $0603;
  WIN32_WINNT_WINTHRESHOLD = $0A00;
  WIN32_WINNT_WIN10        = $0A00;

{===============================================================================
    Windows NT version - functions declaration
===============================================================================}

// functions extracting major and minor version from full version
Function MajorVersion(Version: UInt16): UInt8;
Function MinorVersion(Version: UInt16): UInt8;

{===============================================================================
--------------------------------------------------------------------------------
                              Windows version info
--------------------------------------------------------------------------------
===============================================================================}
{===============================================================================
    Windows version info - constants
===============================================================================}
{
  type mask bits

  For use in dwTypeMask parameter in function VerifyVersionInfo (multiple type
  mask bits can be OR-ed into this parameter) or in parameter TypeMask in
  function VerSetConditionMask (only one value).
}
const
  VER_MINORVERSION     = $00000001;
  VER_MAJORVERSION     = $00000002;
  VER_BUILDNUMBER      = $00000004;
  VER_PLATFORMID       = $00000008;
  VER_SERVICEPACKMINOR = $00000010;
  VER_SERVICEPACKMAJOR = $00000020;
  VER_SUITENAME        = $00000040;
  VER_PRODUCT_TYPE     = $00000080;

//------------------------------------------------------------------------------
{
  platform id

  Possible values of dwPlatformId field in TOSVersionInfoEx structure.
}
const
  VER_PLATFORM_WIN32s        = 0;
  VER_PLATFORM_WIN32_WINDOWS = 1;
  VER_PLATFORM_WIN32_NT      = 2;

//------------------------------------------------------------------------------
{
  suite mask

  Possible values of wSuiteMask field in TOSVersionInfoEx structure (can be
  a combination of multiple values).
}
const
  VER_SERVER_NT                      = $80000000;
  VER_WORKSTATION_NT                 = $40000000;
  VER_SUITE_SMALLBUSINESS            = $00000001;
  VER_SUITE_ENTERPRISE               = $00000002;
  VER_SUITE_BACKOFFICE               = $00000004;
  VER_SUITE_COMMUNICATIONS           = $00000008;
  VER_SUITE_TERMINAL                 = $00000010;
  VER_SUITE_SMALLBUSINESS_RESTRICTED = $00000020;
  VER_SUITE_EMBEDDEDNT               = $00000040;
  VER_SUITE_DATACENTER               = $00000080;
  VER_SUITE_SINGLEUSERTS             = $00000100;
  VER_SUITE_PERSONAL                 = $00000200;
  VER_SUITE_BLADE                    = $00000400;
  VER_SUITE_EMBEDDED_RESTRICTED      = $00000800;
  VER_SUITE_SECURITY_APPLIANCE       = $00001000;
  VER_SUITE_STORAGE_SERVER           = $00002000;
  VER_SUITE_COMPUTE_SERVER           = $00004000;
  VER_SUITE_WH_SERVER                = $00008000;


//------------------------------------------------------------------------------
{
  product type

  Possible values of field wProductType in TOSVersionInfoEx structure.
}
const
  VER_NT_WORKSTATION       = $00000001;
  VER_NT_DOMAIN_CONTROLLER = $00000002;
  VER_NT_SERVER            = $00000003;

//------------------------------------------------------------------------------
{
  condition codes

  For use in parameter Condition in function VerSetConditionMask.

    WARINING - to build dwlConditionMask parameter for use in function
               VerifyVersionInfo, use VerSetConditionMask macro functions, do
               not combine them using logical operators.
}
const
  VER_EQUAL         = 1;
  VER_GREATER       = 2;
  VER_GREATER_EQUAL = 3;
  VER_LESS          = 4;
  VER_LESS_EQUAL    = 5;
  VER_AND           = 6;
  VER_OR            = 7;

  VER_CONDITION_MASK              = 7;
  VER_NUM_BITS_PER_CONDITION_MASK = 3;

{===============================================================================
    Windows version info - structures
===============================================================================}

type
  TOSVersionInfoA = record
    dwOSVersionInfoSize:  DWORD;
    dwMajorVersion:       DWORD;
    dwMinorVersion:       DWORD;
    dwBuildNumber:        DWORD;
    dwPlatformId:         DWORD;
    szCSDVersion:         array[0..127] of AnsiChar;
  end;
  POSVersionInfoA = ^TOSVersionInfoA;

  TOSVersionInfoW = record
    dwOSVersionInfoSize:  DWORD;
    dwMajorVersion:       DWORD;
    dwMinorVersion:       DWORD;
    dwBuildNumber:        DWORD;
    dwPlatformId:         DWORD;
    szCSDVersion:         array[0..127] of WideChar;
  end;
  POSVersionInfoW = ^TOSVersionInfoW;

{$IFDEF Unicode}
  TOSVersionInfo = TOSVersionInfoW;
{$ELSE}
  TOSVersionInfo = TOSVersionInfoA;
{$ENDIF}
  POSVersionInfo = ^TOSVersionInfo;

//------------------------------------------------------------------------------

type
  TOSVersionInfoExA = record
    dwOSVersionInfoSize:  DWORD;
    dwMajorVersion:       DWORD;
    dwMinorVersion:       DWORD;
    dwBuildNumber:        DWORD;
    dwPlatformId:         DWORD;
    szCSDVersion:         array[0..127] of AnsiChar;
    wServicePackMajor:    Word;
    wServicePackMinor:    Word;
    wSuiteMask:           Word;
    wProductType:         Byte;
    wReserved:            Byte;
  end;
  POSVersionInfoExA = ^TOSVersionInfoExA;

  TOSVersionInfoExW = record
    dwOSVersionInfoSize:  DWORD;
    dwMajorVersion:       DWORD;
    dwMinorVersion:       DWORD;
    dwBuildNumber:        DWORD;
    dwPlatformId:         DWORD;
    szCSDVersion:         array[0..127] of WideChar;
    wServicePackMajor:    Word;
    wServicePackMinor:    Word;
    wSuiteMask:           Word;
    wProductType:         Byte;
    wReserved:            Byte;
  end;
  POSVersionInfoExW = ^TOSVersionInfoExW;

{$IFDEF Unicode}
  TOSVersionInfoEx = TOSVersionInfoExW;
{$ELSE}
  TOSVersionInfoEx = TOSVersionInfoExA;
{$ENDIF}
  POSVersionInfoEx = ^TOSVersionInfoEx;

{===============================================================================
    Windows version info - external functions
===============================================================================}

Function GetVersionExW(lpVersionInfo: POSVersionInfoExW): BOOL; stdcall; external kernel32;
Function GetVersionExA(lpVersionInfo: POSVersionInfoExA): BOOL; stdcall; external kernel32;
Function GetVersionEx(lpVersionInfo: POSVersionInfoEx): BOOL; overload; stdcall;
  external kernel32 name{$IFDEF Unicode}'GetVersionExW'{$ELSE}'GetVersionExA'{$ENDIF};

Function VerifyVersionInfoW(lpVersionInfo: POSVersionInfoExW; dwTypeMask: DWORD; dwlConditionMask: UInt64): BOOL; stdcall; external kernel32;
Function VerifyVersionInfoA(lpVersionInfo: POSVersionInfoExA; dwTypeMask: DWORD; dwlConditionMask: UInt64): BOOL; stdcall; external kernel32;
Function VerifyVersionInfo(lpVersionInfo: POSVersionInfoEx; dwTypeMask: DWORD; dwlConditionMask: UInt64): BOOL; overload; stdcall;
  external kernel32 name{$IFDEF Unicode}'VerifyVersionInfoW'{$ELSE}'VerifyVersionInfoA'{$ENDIF};

Function VerSetConditionMask(ConditionMask: UInt64; TypeMask: DWORD; Condition: Byte): UInt64; stdcall; external kernel32;

{===============================================================================
    Windows version info - wrapper functions declaration
===============================================================================}

Function GetVersionEx(out VersionInfo: TOSVersionInfo): Boolean; overload;
Function GetVersionEx(out VersionInfo: TOSVersionInfoEx): Boolean; overload;

{===============================================================================
--------------------------------------------------------------------------------
                                 Version helper
--------------------------------------------------------------------------------
===============================================================================}
{===============================================================================
    Version helper - functions declaration
===============================================================================}
{
  Implementation if version helper functions and macros from Windows SDK file
  VersionHelpers.h.
}
Function IsWindowsVersionOrGreater(wMajorVersion,wMinorVersion,wServicePackMajor: Word): Boolean;

Function IsWindowsXPOrGreater: Boolean;
Function IsWindowsXPSP1OrGreater: Boolean;
Function IsWindowsXPSP2OrGreater: Boolean;
Function IsWindowsXPSP3OrGreater: Boolean;
Function IsWindowsVistaOrGreater: Boolean;
Function IsWindowsVistaSP1OrGreater: Boolean;
Function IsWindowsVistaSP2OrGreater: Boolean;
Function IsWindows7OrGreater: Boolean;
Function IsWindows7SP1OrGreater: Boolean;
Function IsWindows8OrGreater: Boolean;
Function IsWindows8Point1OrGreater: Boolean;
Function IsWindowsThresholdOrGreater: Boolean;
Function IsWindows10OrGreater: Boolean;
Function IsWindowsServer: Boolean;

// I do not have SDK for Windows 11 atm, will fill it later

(*
const
#define PRODUCT_UNDEFINED                           0x00000000

#define PRODUCT_ULTIMATE                            0x00000001
#define PRODUCT_HOME_BASIC                          0x00000002
#define PRODUCT_HOME_PREMIUM                        0x00000003
#define PRODUCT_ENTERPRISE                          0x00000004
#define PRODUCT_HOME_BASIC_N                        0x00000005
#define PRODUCT_BUSINESS                            0x00000006
#define PRODUCT_STANDARD_SERVER                     0x00000007
#define PRODUCT_DATACENTER_SERVER                   0x00000008
#define PRODUCT_SMALLBUSINESS_SERVER                0x00000009
#define PRODUCT_ENTERPRISE_SERVER                   0x0000000A
#define PRODUCT_STARTER                             0x0000000B
#define PRODUCT_DATACENTER_SERVER_CORE              0x0000000C
#define PRODUCT_STANDARD_SERVER_CORE                0x0000000D
#define PRODUCT_ENTERPRISE_SERVER_CORE              0x0000000E
#define PRODUCT_ENTERPRISE_SERVER_IA64              0x0000000F
#define PRODUCT_BUSINESS_N                          0x00000010
#define PRODUCT_WEB_SERVER                          0x00000011
#define PRODUCT_CLUSTER_SERVER                      0x00000012
#define PRODUCT_HOME_SERVER                         0x00000013
#define PRODUCT_STORAGE_EXPRESS_SERVER              0x00000014
#define PRODUCT_STORAGE_STANDARD_SERVER             0x00000015
#define PRODUCT_STORAGE_WORKGROUP_SERVER            0x00000016
#define PRODUCT_STORAGE_ENTERPRISE_SERVER           0x00000017
#define PRODUCT_SERVER_FOR_SMALLBUSINESS            0x00000018
#define PRODUCT_SMALLBUSINESS_SERVER_PREMIUM        0x00000019
#define PRODUCT_HOME_PREMIUM_N                      0x0000001A
#define PRODUCT_ENTERPRISE_N                        0x0000001B
#define PRODUCT_ULTIMATE_N                          0x0000001C
#define PRODUCT_WEB_SERVER_CORE                     0x0000001D
#define PRODUCT_MEDIUMBUSINESS_SERVER_MANAGEMENT    0x0000001E
#define PRODUCT_MEDIUMBUSINESS_SERVER_SECURITY      0x0000001F
#define PRODUCT_MEDIUMBUSINESS_SERVER_MESSAGING     0x00000020
#define PRODUCT_SERVER_FOUNDATION                   0x00000021
#define PRODUCT_HOME_PREMIUM_SERVER                 0x00000022
#define PRODUCT_SERVER_FOR_SMALLBUSINESS_V          0x00000023
#define PRODUCT_STANDARD_SERVER_V                   0x00000024
#define PRODUCT_DATACENTER_SERVER_V                 0x00000025
#define PRODUCT_ENTERPRISE_SERVER_V                 0x00000026
#define PRODUCT_DATACENTER_SERVER_CORE_V            0x00000027
#define PRODUCT_STANDARD_SERVER_CORE_V              0x00000028
#define PRODUCT_ENTERPRISE_SERVER_CORE_V            0x00000029
#define PRODUCT_HYPERV                              0x0000002A
#define PRODUCT_STORAGE_EXPRESS_SERVER_CORE         0x0000002B
#define PRODUCT_STORAGE_STANDARD_SERVER_CORE        0x0000002C
#define PRODUCT_STORAGE_WORKGROUP_SERVER_CORE       0x0000002D
#define PRODUCT_STORAGE_ENTERPRISE_SERVER_CORE      0x0000002E
#define PRODUCT_STARTER_N                           0x0000002F
#define PRODUCT_PROFESSIONAL                        0x00000030
#define PRODUCT_PROFESSIONAL_N                      0x00000031
#define PRODUCT_SB_SOLUTION_SERVER                  0x00000032
#define PRODUCT_SERVER_FOR_SB_SOLUTIONS             0x00000033
#define PRODUCT_STANDARD_SERVER_SOLUTIONS           0x00000034
#define PRODUCT_STANDARD_SERVER_SOLUTIONS_CORE      0x00000035
#define PRODUCT_SB_SOLUTION_SERVER_EM               0x00000036
#define PRODUCT_SERVER_FOR_SB_SOLUTIONS_EM          0x00000037
#define PRODUCT_SOLUTION_EMBEDDEDSERVER             0x00000038
#define PRODUCT_SOLUTION_EMBEDDEDSERVER_CORE        0x00000039
#define PRODUCT_PROFESSIONAL_EMBEDDED               0x0000003A
#define PRODUCT_ESSENTIALBUSINESS_SERVER_MGMT       0x0000003B
#define PRODUCT_ESSENTIALBUSINESS_SERVER_ADDL       0x0000003C
#define PRODUCT_ESSENTIALBUSINESS_SERVER_MGMTSVC    0x0000003D
#define PRODUCT_ESSENTIALBUSINESS_SERVER_ADDLSVC    0x0000003E
#define PRODUCT_SMALLBUSINESS_SERVER_PREMIUM_CORE   0x0000003F
#define PRODUCT_CLUSTER_SERVER_V                    0x00000040
#define PRODUCT_EMBEDDED                            0x00000041
#define PRODUCT_STARTER_E                           0x00000042
#define PRODUCT_HOME_BASIC_E                        0x00000043
#define PRODUCT_HOME_PREMIUM_E                      0x00000044
#define PRODUCT_PROFESSIONAL_E                      0x00000045
#define PRODUCT_ENTERPRISE_E                        0x00000046
#define PRODUCT_ULTIMATE_E                          0x00000047
#define PRODUCT_ENTERPRISE_EVALUATION               0x00000048
#define PRODUCT_MULTIPOINT_STANDARD_SERVER          0x0000004C
#define PRODUCT_MULTIPOINT_PREMIUM_SERVER           0x0000004D
#define PRODUCT_STANDARD_EVALUATION_SERVER          0x0000004F
#define PRODUCT_DATACENTER_EVALUATION_SERVER        0x00000050
#define PRODUCT_ENTERPRISE_N_EVALUATION             0x00000054
#define PRODUCT_EMBEDDED_AUTOMOTIVE                 0x00000055
#define PRODUCT_EMBEDDED_INDUSTRY_A                 0x00000056
#define PRODUCT_THINPC                              0x00000057
#define PRODUCT_EMBEDDED_A                          0x00000058
#define PRODUCT_EMBEDDED_INDUSTRY                   0x00000059
#define PRODUCT_EMBEDDED_E                          0x0000005A
#define PRODUCT_EMBEDDED_INDUSTRY_E                 0x0000005B
#define PRODUCT_EMBEDDED_INDUSTRY_A_E               0x0000005C
#define PRODUCT_STORAGE_WORKGROUP_EVALUATION_SERVER 0x0000005F
#define PRODUCT_STORAGE_STANDARD_EVALUATION_SERVER  0x00000060
#define PRODUCT_CORE_ARM                            0x00000061
#define PRODUCT_CORE_N                              0x00000062
#define PRODUCT_CORE_COUNTRYSPECIFIC                0x00000063
#define PRODUCT_CORE_SINGLELANGUAGE                 0x00000064
#define PRODUCT_CORE                                0x00000065
#define PRODUCT_PROFESSIONAL_WMC                    0x00000067
#define PRODUCT_MOBILE_CORE                         0x00000068
#define PRODUCT_EMBEDDED_INDUSTRY_EVAL              0x00000069
#define PRODUCT_EMBEDDED_INDUSTRY_E_EVAL            0x0000006A
#define PRODUCT_EMBEDDED_EVAL                       0x0000006B
#define PRODUCT_EMBEDDED_E_EVAL                     0x0000006C
#define PRODUCT_NANO_SERVER                         0x0000006D
#define PRODUCT_CLOUD_STORAGE_SERVER                0x0000006E
#define PRODUCT_CORE_CONNECTED                      0x0000006F
#define PRODUCT_PROFESSIONAL_STUDENT                0x00000070
#define PRODUCT_CORE_CONNECTED_N                    0x00000071
#define PRODUCT_PROFESSIONAL_STUDENT_N              0x00000072
#define PRODUCT_CORE_CONNECTED_SINGLELANGUAGE       0x00000073
#define PRODUCT_CORE_CONNECTED_COUNTRYSPECIFIC      0x00000074
#define PRODUCT_CONNECTED_CAR                       0x00000075
#define PRODUCT_INDUSTRY_HANDHELD                   0x00000076
#define PRODUCT_PPI_PRO                             0x00000077
#define PRODUCT_ARM64_SERVER                        0x00000078
#define PRODUCT_EDUCATION                           0x00000079
#define PRODUCT_EDUCATION_N                         0x0000007A
#define PRODUCT_IOTUAP                              0x0000007B
#define PRODUCT_CLOUD_HOST_INFRASTRUCTURE_SERVER    0x0000007C
#define PRODUCT_ENTERPRISE_S                        0x0000007D
#define PRODUCT_ENTERPRISE_S_N                      0x0000007E
#define PRODUCT_PROFESSIONAL_S                      0x0000007F
#define PRODUCT_PROFESSIONAL_S_N                    0x00000080
#define PRODUCT_ENTERPRISE_S_EVALUATION             0x00000081
#define PRODUCT_ENTERPRISE_S_N_EVALUATION           0x00000082
#define PRODUCT_HOLOGRAPHIC                         0x00000087

#define PRODUCT_UNLICENSED                          0xABCDABCD
*)

// IsWow64Process...

implementation

{===============================================================================
--------------------------------------------------------------------------------
                               Windows NT version
--------------------------------------------------------------------------------
===============================================================================}
{===============================================================================
    Windows NT version - functions implementation
===============================================================================}

Function MajorVersion(Version: UInt16): UInt8;
begin
Result := (Version shr 8) and $FF;
end;

//------------------------------------------------------------------------------

Function MinorVersion(Version: UInt16): UInt8;
begin
Result := Version and $FF;
end;

{===============================================================================
--------------------------------------------------------------------------------
                              Windows version info
--------------------------------------------------------------------------------
===============================================================================}
{===============================================================================
    Windows version info - wrapper functions implementation
===============================================================================}

Function GetVersionEx(out VersionInfo: TOSVersionInfo): Boolean;
begin
FillChar(VersionInfo,SizeOf(VersionInfo),0);
VersionInfo.dwOSVersionInfoSize := SizeOf(VersionInfo);
Result := GetVersionEx(@VersionInfo);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Function GetVersionEx(out VersionInfo: TOSVersionInfoEx): Boolean;
begin
FillChar(VersionInfo,SizeOf(VersionInfo),0);
VersionInfo.dwOSVersionInfoSize := SizeOf(VersionInfo);
Result := GetVersionEx(@VersionInfo);
end;

{===============================================================================
--------------------------------------------------------------------------------
                                 Version helper
--------------------------------------------------------------------------------
===============================================================================}
{===============================================================================
    Version helper - functions implementation
===============================================================================}

Function IsWindowsVersionOrGreater(wMajorVersion,wMinorVersion,wServicePackMajor: Word): Boolean;
var
  OSVersion:      TOSVersionInfoEx;
  ConditionMask:  Int64;
begin
FillChar(Addr(OSVersion)^,SizeOf(TOSVersionInfoEx),0);
OSVersion.dwOSVersionInfoSize := SizeOf(TOSVersionInfoEx);
ConditionMask := VerSetConditionMask(
  VerSetConditionMask(
    VerSetConditionMask(0,VER_MAJORVERSION,VER_GREATER_EQUAL),
    VER_MINORVERSION,VER_GREATER_EQUAL),
  VER_SERVICEPACKMAJOR,VER_GREATER_EQUAL);
OSVersion.dwMajorVersion := wMajorVersion;
OSVersion.dwMinorVersion := wMinorVersion;
OSVersion.wServicePackMajor := wServicePackMajor;
Result := VerifyVersionInfo(@OSVersion,VER_MAJORVERSION or VER_MINORVERSION or VER_SERVICEPACKMAJOR,ConditionMask);
end;

//------------------------------------------------------------------------------

Function IsWindowsXPOrGreater: Boolean;
begin
Result := IsWindowsVersionOrGreater(MajorVersion(WIN32_WINNT_WINXP),MinorVersion(WIN32_WINNT_WINXP),0);
end;

//------------------------------------------------------------------------------

Function IsWindowsXPSP1OrGreater: Boolean;
begin
Result := IsWindowsVersionOrGreater(MajorVersion(WIN32_WINNT_WINXP),MinorVersion(WIN32_WINNT_WINXP),1);
end;

//------------------------------------------------------------------------------

Function IsWindowsXPSP2OrGreater: Boolean;
begin
Result := IsWindowsVersionOrGreater(MajorVersion(WIN32_WINNT_WINXP),MinorVersion(WIN32_WINNT_WINXP),2);
end;

//------------------------------------------------------------------------------

Function IsWindowsXPSP3OrGreater: Boolean;
begin
Result := IsWindowsVersionOrGreater(MajorVersion(WIN32_WINNT_WINXP),MinorVersion(WIN32_WINNT_WINXP),3);
end;

//------------------------------------------------------------------------------

Function IsWindowsVistaOrGreater: Boolean;
begin
Result := IsWindowsVersionOrGreater(MajorVersion(WIN32_WINNT_VISTA),MinorVersion(WIN32_WINNT_VISTA),0);
end;

//------------------------------------------------------------------------------

Function IsWindowsVistaSP1OrGreater: Boolean;
begin
Result := IsWindowsVersionOrGreater(MajorVersion(WIN32_WINNT_VISTA),MinorVersion(WIN32_WINNT_VISTA),1);
end;

//------------------------------------------------------------------------------

Function IsWindowsVistaSP2OrGreater: Boolean;
begin
Result := IsWindowsVersionOrGreater(MajorVersion(WIN32_WINNT_VISTA),MinorVersion(WIN32_WINNT_VISTA),2);
end;

//------------------------------------------------------------------------------

Function IsWindows7OrGreater: Boolean;
begin
Result := IsWindowsVersionOrGreater(MajorVersion(WIN32_WINNT_WIN7),MinorVersion(WIN32_WINNT_WIN7),0);
end;

//------------------------------------------------------------------------------

Function IsWindows7SP1OrGreater: Boolean;
begin
Result := IsWindowsVersionOrGreater(MajorVersion(WIN32_WINNT_WIN7),MinorVersion(WIN32_WINNT_WIN7),1);
end;

//------------------------------------------------------------------------------

Function IsWindows8OrGreater: Boolean;
begin
Result := IsWindowsVersionOrGreater(MajorVersion(WIN32_WINNT_WIN8),MinorVersion(WIN32_WINNT_WIN8),0);
end;

//------------------------------------------------------------------------------

Function IsWindows8Point1OrGreater: Boolean;
begin
Result := IsWindowsVersionOrGreater(MajorVersion(WIN32_WINNT_WINBLUE),MinorVersion(WIN32_WINNT_WINBLUE),0);
end;

//------------------------------------------------------------------------------

Function IsWindowsThresholdOrGreater: Boolean;
begin
Result := IsWindowsVersionOrGreater(MajorVersion(WIN32_WINNT_WINTHRESHOLD),MinorVersion(WIN32_WINNT_WINTHRESHOLD),0);
end;

//------------------------------------------------------------------------------

Function IsWindows10OrGreater: Boolean;
begin
Result := IsWindowsVersionOrGreater(MajorVersion(WIN32_WINNT_WINTHRESHOLD),MinorVersion(WIN32_WINNT_WINTHRESHOLD),0);
end;

//------------------------------------------------------------------------------

Function IsWindowsServer: Boolean;
var
  OSVersion:  TOSVersionInfoEx;
begin
FillChar(Addr(OSVersion)^,SizeOf(TOSVersionInfoEx),0);
OSVersion.wProductType := VER_NT_WORKSTATION;
Result := not VerifyVersionInfo(@OSVersion,VER_PRODUCT_TYPE,VerSetConditionMask(0,VER_PRODUCT_TYPE,VER_EQUAL));
end;

end.
