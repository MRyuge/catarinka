unit CatUI;

{
  Catarinka - User Interface related functions

  Copyright (c) 2003-2014 Felipe Daragon
  License: 3-clause BSD
  See https://github.com/felipedaragon/catarinka/ for details

  ForceForegroundWindow function by Ray Lischner,
  based on code from Karl E. Peterson, with portions from
  Daniel P. Stasinski
}

interface

{$I Catarinka.inc}

uses
{$IFDEF DXE2_OR_UP}
  Winapi.Windows, Vcl.Forms, Vcl.Menus, Vcl.ExtCtrls, System.SysUtils,
  System.Classes, Vcl.Controls, Vcl.ComCtrls, Winapi.CommCtrl, Winapi.Messages,
  Winapi.ShlObj;
{$ELSE}
  Windows, Forms, Menus, ExtCtrls, SysUtils, Classes, Controls, ComCtrls,
  CommCtrl, Messages, ShlObj;
{$ENDIF}
function AskYN(const question: string): Boolean;
function GetWindowState: integer;
function ForceForegroundWindow(hwnd: THandle): Boolean;
function GetWindowClassHandle(const Title: string): integer;
function GetFullPath(N: TTreeNode; Sep: string = '\'): string;
function GetFullPathData(N: TTreeNode): string;
function GetLVCheckedItems(lvcomp: TListview): string;
function GetLVCheckedItemsSingleLn(lvcomp: TListview): string;
function GetPercentage(const percent, Value: integer): Int64;
function GetSpecialFolderPath(const Folder: integer;
  const CanCreate: Boolean): string;
function MakeNotifyEvent(forObject: TObject; const procname: string)
  : TNotifyEvent;
function TreeItemSearch(tv: ttreeview; const SearchItem: string): TTreeNode;

procedure AddListViewItem(LV: TListview; const capt: string; const ii: integer;
  const mv: Boolean);
procedure AddMultipleListViewItems(LV: TListview; const captlist: string;
  const ii: integer; const mv: Boolean);
procedure ApplyWindowState(const i: integer);
procedure CommaToLVItems(lvcomp: TListview; const commastring: string);
procedure CloseWindowByClass(const classname: string);
procedure DisableLVToolTips(H: THandle);
procedure ExpandTreeViewItems(tv: ttreeview);
procedure FlashUI(const times: integer = 2; const delay: integer = 500);
procedure LoadListviewStrings(listview: TListview; const filename: string);
procedure QuickSortTreeViewItems(tv: ttreeview);
procedure ShowPopupMenu(PopupMenu: TPopupMenu; const AppHandle: integer);
procedure SaveListviewStrings(listview: TListview; const filename: string);
procedure SaveMemStreamToStrings(Stream: TMemoryStream; List: TStrings);
procedure SetNodeBoldState(Node: TTreeNode; const Value: Boolean);

type
  TCanvasPanel = class(TPanel)
  public
    property Canvas;
  end;

  {
    CSIDL_DESKTOPDIRECTORY returns the path to the current desktop
    CSIDL_PERSONAL is the My Documents directory
    CSIDL___LOCAL_APPDATA is the (user name)\Local Settings\Application Data directory }
const
  CSIDL_DESKTOP = $0000; { <desktop> }
  CSIDL_INTERNET = $0001; { Internet Explorer (icon on desktop) }
  CSIDL_PROGRAMS = $0002; { Start Menu\Programs }
  CSIDL_CONTROLS = $0003; { My Computer\Control Panel }
  CSIDL_PRINTERS = $0004; { My Computer\Printers }
  CSIDL_PERSONAL = $0005;
  { My Documents.  This is equivalent to CSIDL_MYDOCUMENTS in XP and above }
  CSIDL_FAVORITES = $0006; { <user name>\Favorites }
  CSIDL_STARTUP = $0007; { Start Menu\Programs\Startup }
  CSIDL_RECENT = $0008; { <user name>\Recent }
  CSIDL_SENDTO = $0009; { <user name>\SendTo }
  CSIDL_BITBUCKET = $000A; { <desktop>\Recycle Bin }
  CSIDL_STARTMENU = $000B; { <user name>\Start Menu }
  CSIDL_MYDOCUMENTS = $000C; { logical "My Documents" desktop icon }
  CSIDL_MYMUSIC = $000D; { "My Music" folder }
  CSIDL_MYVIDEO = $000E; { "My Video" folder }
  CSIDL_DESKTOPDIRECTORY = $0010; { <user name>\Desktop }
  CSIDL_DRIVES = $0011; { My Computer }
  CSIDL_NETWORK = $0012; { Network Neighborhood (My Network Places) }
  CSIDL_NETHOOD = $0013; { <user name>\nethood }
  CSIDL_FONTS = $0014; { windows\fonts }
  CSIDL_TEMPLATES = $0015;
  CSIDL_COMMON_STARTMENU = $0016; { All Users\Start Menu }
  CSIDL_COMMON_PROGRAMS = $0017; { All Users\Start Menu\Programs }
  CSIDL_COMMON_STARTUP = $0018; { All Users\Startup }
  CSIDL_COMMON_DESKTOPDIRECTORY = $0019; { All Users\Desktop }
  CSIDL_APPDATA = $001A; { <user name>\Application Data }
  CSIDL_PRINTHOOD = $001B; { <user name>\PrintHood }
  CSIDL_LOCAL_APPDATA = $001C;
  { <user name>\Local Settings\Application Data (non roaming) }
  CSIDL_ALTSTARTUP = $001D; { non localized startup }
  CSIDL_COMMON_ALTSTARTUP = $001E; { non localized common startup }
  CSIDL_COMMON_FAVORITES = $001F;
  CSIDL_INTERNET_CACHE = $0020;
  CSIDL_COOKIES = $0021;
  CSIDL_HISTORY = $0022;
  CSIDL_COMMON_APPDATA = $0023; { All Users\Application Data }
  CSIDL_WINDOWS = $0024; { GetWindowsDirectory() }
  CSIDL_SYSTEM = $0025; { GetSystemDirectory() }
  CSIDL_PROGRAM_FILES = $0026; { C:\Program Files }
  CSIDL_MYPICTURES = $0027; { C:\Program Files\My Pictures }
  CSIDL_PROFILE = $0028; { USERPROFILE }
  CSIDL_SYSTEMX86 = $0029; { x86 system directory on RISC }
  CSIDL_PROGRAM_FILESX86 = $002A; { x86 C:\Program Files on RISC }
  CSIDL_PROGRAM_FILES_COMMON = $002B; { C:\Program Files\Common }
  CSIDL_PROGRAM_FILES_COMMONX86 = $002C; { x86 C:\Program Files\Common on RISC }
  CSIDL_COMMON_TEMPLATES = $002D; { All Users\Templates }
  CSIDL_COMMON_DOCUMENTS = $002E; { All Users\Documents }
  CSIDL_COMMON_ADMINTOOLS = $002F;
  { All Users\Start Menu\Programs\Administrative Tools }
  CSIDL_ADMINTOOLS = $0030;
  { <user name>\Start Menu\Programs\Administrative Tools }
  CSIDL_CONNECTIONS = $0031; { Network and Dial-up Connections }
  CSIDL_COMMON_MUSIC = $0035; { All Users\My Music }
  CSIDL_COMMON_PICTURES = $0036; { All Users\My Pictures }
  CSIDL_COMMON_VIDEO = $0037; { All Users\My Video }
  CSIDL_RESOURCES = $0038; { Resource Directory }
  CSIDL_RESOURCES_LOCALIZED = $0039; { Localized Resource Directory }
  CSIDL_COMMON_OEM_LINKS = $003A; { Links to All Users OEM specific apps }
  CSIDL_CDBURN_AREA = $003B;
  { USERPROFILE\Local Settings\Application Data\Microsoft\CD Burning }
  CSIDL_COMPUTERSNEARME = $003D;
  { Computers Near Me (computered from Workgroup membership) }
  CSIDL_PROFILES = $003E;

implementation

uses
  CatPointer, CatStrings;

procedure AddListViewItem(LV: TListview; const capt: string; const ii: integer;
  const mv: Boolean);
begin
  with LV.Items.Add do
  begin
    Caption := capt;
    imageindex := ii;
    makevisible(mv);
  end;
end;

procedure AddMultipleListViewItems(LV: TListview; const captlist: string;
  const ii: integer; const mv: Boolean);
var
  c, i: integer;
  List: TStringlist;
begin
  List := TStringlist.Create;
  List.text := captlist;
  c := List.count;
  for i := 0 to c do
  begin
    if i < c then
      AddListViewItem(LV, List[i], ii, mv);
  end;
  List.free;
end;

procedure ApplyWindowState(const i: integer);
begin
  case i of
    0:
      Application.MainForm.WindowState := WsMaximized;
    1:
      Application.MainForm.WindowState := WsMinimized;
    2:
      Application.MainForm.WindowState := WsNormal;
  end;
end;

function AskYN(const question: string): Boolean;
begin
  result:= false;
  case Application.MessageBox({$IFDEF UNICODE}pwidechar{$ELSE}pchar{$ENDIF}(question), {$IFDEF UNICODE}pwidechar{$ELSE}pchar{$ENDIF}(Application.Title), mb_YesNo + mb_DefButton1) of
    IDYes:
      Result := true;
    IDNo:
      Result := false;
  end;
end;

// Usage example CloseWindowByClass('TSomeForm')
procedure CloseWindowByClass(const classname: string);
var
  winHandle: THandle;
  winClass: array [0 .. 63] of char;
begin
  winHandle := Application.Handle;
  repeat
    winHandle := GetNextWindow(winHandle, GW_HWNDNEXT);
    GetClassName(winHandle, winClass, sizeof(winClass));
    if (winHandle <> 0) and (StrComp(winClass, pchar(classname)) = 0) then
      PostMessage(winHandle, WM_CLOSE, 0, 0);
  until (winHandle = 0);
end;

procedure CommaToLVItems(lvcomp: TListview; const commastring: string);
var
  i: integer;
  sl: TStringlist;
begin
  sl := TStringlist.Create;
  sl.CommaText := commastring;
  for i := 0 to sl.count - 1 do
  begin
    if (before(sl[i], '=') <> emptystr) then
    begin
      with lvcomp.Items.Add do
      begin
        Caption := before(sl[i], '=');
        if after(sl[i], '=') = '1' then
          checked := true
        else
          checked := false;
      end;
    end;
  end;
  sl.free;
end;

// Needs testing
procedure DisableLVToolTips(H: THandle);
var
  styles: dword;
begin
  styles := ListView_GetExtendedListViewStyle(H);
  styles := styles and not LVS_EX_INFOTIP;
  ListView_SetExtendedListViewStyle(H, styles);
end;

procedure ExpandTreeViewItems(tv: ttreeview);
var
  i, c: integer;
begin
  tv.Items.BeginUpdate;
  c := tv.Items.count;
  for i := 0 to c do
  begin
    if i < c then
    begin
      tv.Items[i].Expand(false);
    end;
  end;
  tv.Items.EndUpdate;
  try
    tv.Items[0].Selected := true;
  except
  end;
end;

procedure FlashUI(const times: integer = 2; const delay: integer = 500);
var
  i: integer;
  procedure doflash(b: Boolean);
  begin
    FlashWindow(Application.MainForm.Handle, b);
    FlashWindow(Application.Handle, b);
  end;

begin
  for i := 0 to times do
  begin
    doflash(true);
    sleep(delay);
    doflash(false);
    sleep(delay);
  end;
end;

function GetFullPath(N: TTreeNode; Sep: string = '\'): string;
begin
  Result := N.text;
  N := N.Parent;
  while (N <> nil) do
  begin
    Result := N.text + Sep + Result;
    N := N.Parent;
  end;
end;

function GetFullPathData(N: TTreeNode): string;
begin
  Result := PointerToStr(N.data);
  N := N.Parent;
  while (N <> nil) do
  begin
    Result := PointerToStr(N.data) + '/' + Result;
    N := N.Parent;
  end;
end;

function GetLVCheckedItems(lvcomp: TListview): string;
var
  i: integer;
  sl: TStringlist;
begin
  sl := TStringlist.Create;
  for i := 0 to lvcomp.Items.count - 1 do
  begin
    if lvcomp.Items[i].checked then
      sl.Add(lvcomp.Items[i].Caption + '=1')
    else
      sl.Add(lvcomp.Items[i].Caption + '=0');
  end;
  Result := sl.CommaText;
  sl.free;
end;

function GetLVCheckedItemsSingleLn(lvcomp: TListview): string;
var
  i: integer;
begin
  for i := 0 to lvcomp.Items.count - 1 do
  begin
    if lvcomp.Items[i].checked then
      Result := Result + inttostr(i) + ';';
  end;
  Result := Result;
end;

function GetPercentage(const percent, Value: integer): Int64;
var
  p: Real;
begin
  p := ((percent / Value) * 100);
  Result := Round(p);
end;

// Gets the path of special system folders
// Usage example: GetSpecialFolderPath (CSIDL_PERSONAL, false);
function GetSpecialFolderPath(const Folder: integer;
  const CanCreate: Boolean): string;
var
  FilePath: array [0 .. 255] of char;
begin
  SHGetSpecialFolderPath(0, @FilePath[0], Folder, CanCreate);
  Result := FilePath;
end;

function GetWindowClassHandle(const Title: string): integer;
begin
  result := FindWindow(pchar(Title), nil);
end;

function GetWindowState: integer;
begin
  Result := 2;
  case Application.MainForm.WindowState of
    WsMaximized:
      Result := 0;
    WsMinimized:
      Result := 1;
    WsNormal:
      Result := 2;
  end;
end;

procedure LoadListviewStrings(listview: TListview; const filename: string);
var
  sl, lineelements: TStringlist;
  i: integer;
  item: TListItem;
begin
  Assert(Assigned(listview));
  sl := TStringlist.Create;
  try
    sl.LoadFromFile(filename);
    lineelements := TStringlist.Create;
    try
      for i := 0 to sl.count - 1 do
      begin
        lineelements.Clear;
        SplitString(sl[i], #9, lineelements);
        if lineelements.count > 0 then
        begin
          item := listview.Items.Add;
          item.Caption := lineelements[0];
          lineelements.Delete(0);
          item.SubItems.Assign(lineelements);
        end;
      end;
    finally
      lineelements.free;
    end;
  finally
    sl.free
  end;
end;

function MakeNotifyEvent(forObject: TObject; const procname: String)
  : TNotifyEvent;
begin
  TMethod(Result).data := forObject;
  TMethod(Result).code := forObject.methodAddress(procname);
end;

procedure QuickSortTreeViewItems(tv: ttreeview);
begin
  tv.Items.BeginUpdate;
  tv.sorttype := stnone;
  tv.sorttype := sttext;
  tv.Items.EndUpdate;
end;

procedure SaveListviewStrings(listview: TListview; const filename: string);
var
  sl: TStringlist;
  S: string;
  i, si: integer;
  item: TListItem;
begin
  Assert(Assigned(listview));
  sl := TStringlist.Create;
  try
    for i := 0 to listview.Items.count - 1 do
    begin
      item := listview.Items[i];
      S := item.Caption;
      for si := 0 to item.SubItems.count - 1 do
        S := S + #9 + item.SubItems[si];
      sl.Add(S);
    end;
    sl.SaveToFile(filename);
  finally
    sl.free
  end;
end;

procedure SaveMemStreamToStrings(Stream: TMemoryStream; List: TStrings);
var
  p, q, r: pchar;
begin
  p := Stream.Memory;
  q := p + Stream.Size - 1;
  r := p;
  while (p <> nil) and (p < q) do
  begin
    while (p < q) and (p^ <> #13) and (p^ <> #10) do
      Inc(p);
    List.Add(Copy(StrPas(r), 1, p - r));
    if (p[0] = #13) and (p[1] = #10) then
      Inc(p, 2)
    else
      Inc(p);
    r := p;
  end;
end;

procedure ShowPopupMenu(PopupMenu: TPopupMenu; const AppHandle: integer);
var
  p: TPoint;
begin
  SetForegroundWindow(AppHandle);
  GetCursorPos(p);
  PopupMenu.Popup(p.x, p.y);
  PostMessage(AppHandle, WM_NULL, 0, 0);
end;

procedure SetNodeBoldState(Node: TTreeNode; const Value: Boolean);
var
  TVItem: TTVItem;
begin
  if not Assigned(Node) then
    Exit;
  with TVItem do
  begin
    mask := TVIF_STATE or TVIF_HANDLE;
    hItem := Node.ItemId;
    stateMask := TVIS_BOLD;
    if Value then
      state := TVIS_BOLD
    else
      state := 0;
    TreeView_SetItem(Node.Handle, TVItem);
  end;
end;

function TreeItemSearch(tv: ttreeview; const SearchItem: string): TTreeNode;
var
  i: integer;
  sitem: string;
begin
  Result := nil;
  if (tv = nil) or (SearchItem = emptystr) then
    Exit;
  for i := 0 to tv.Items.count - 1 do
  begin
    sitem := tv.Items[i].text;
    if SearchItem = sitem then
    begin
      Result := tv.Items[i];
      Exit;
    end
    else
      Result := nil;
  end;
end;

function ForceForegroundWindow(hwnd: THandle): Boolean;
const
  SPI_GETFOREGROUNDLOCKTIMEOUT = $2000;
  SPI_SETFOREGROUNDLOCKTIMEOUT = $2001;
var
  ForegroundThreadID, ThisThreadID, timeout: dword;
begin
  if IsIconic(hwnd) then
    ShowWindow(hwnd, SW_RESTORE);

  if GetForegroundWindow = hwnd then
    Result := true
  else
  begin
    // Windows 98/2000 doesn't want to foreground a window when some other
    // window has keyboard focus

    if ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion > 4)) or
      ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
      ((Win32MajorVersion > 4) or ((Win32MajorVersion = 4) and
      (Win32MinorVersion > 0)))) then
    begin
      // Code from Karl E. Peterson, www.mvps.org/vb/sample.htm
      // Converted to Delphi by Ray Lischner
      // Published in The Delphi Magazine 55, page 16

      Result := false;
      ForegroundThreadID := GetWindowThreadProcessID(GetForegroundWindow, nil);
      ThisThreadID := GetWindowThreadProcessID(hwnd, nil);
      if AttachThreadInput(ThisThreadID, ForegroundThreadID, true) then
      begin
        BringWindowToTop(hwnd); // IE 5.5 related hack
        SetForegroundWindow(hwnd);
        AttachThreadInput(ThisThreadID, ForegroundThreadID, false);
        Result := (GetForegroundWindow = hwnd);
      end;
      if not Result then
      begin
        // Code by Daniel P. Stasinski
        SystemParametersInfo(SPI_GETFOREGROUNDLOCKTIMEOUT, 0, @timeout, 0);
        SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(0),
          SPIF_SENDCHANGE);
        BringWindowToTop(hwnd); // IE 5.5 related hack
        SetForegroundWindow(hwnd);
        SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(timeout),
          SPIF_SENDCHANGE);
      end;
    end
    else
    begin
      BringWindowToTop(hwnd); // IE 5.5 related hack
      SetForegroundWindow(hwnd);
    end;

    Result := (GetForegroundWindow = hwnd);
  end;
end;

// ------------------------------------------------------------------------//
end.
