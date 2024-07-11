#ifndef		GRSYSCALL_H
#define		GRSYSCALL_H

typedef struct _tagGR_RECT 
{
	long X1;
	long Y1;
	long X2;
	long Y2;
} GR_RECT;

#define			Make_RGB(r, g, b) ( ( ( (unsigned long)r << 8 ) & 0x0000f800) | \
									( ( (unsigned long)g << 3 ) & 0x000007e0) | \
									( ( (unsigned long)b >> 3 ) & 0x0000001f)  )

//-----------------------------------------------------------------------------
//		base control
//-----------------------------------------------------------------------------
syscall bool		BaseCtrl_ModifyStyle    (handle pBC, quad nRemoveStyle, quad nAddStyle);
syscall bool		BaseCtrl_SetRange       (handle pBC, long X1, long Y1, long X2, long Y2);
syscall bool		BaseCtrl_SetFont        (handle pBC, quad FontType);
syscall bool		BaseCtrl_SetForeColor   (handle pBC, quad ForeColor);
syscall bool		BaseCtrl_SetBkColor     (handle pBC, quad BkColor);
syscall quad		BaseCtrl_GetStyle       (handle pBC);
syscall quad		BaseCtrl_GetFont        (handle pBC);
syscall quad		BaseCtrl_GetForeColor   (handle pBC);
syscall quad		BaseCtrl_GetBkColor     (handle pBC);
syscall bool		BaseCtrl_PtInRange      (handle pBC, long X, long Y);
syscall long		BaseCtrl_PointingProcess(handle pBC, long nAction, long X, long Y);
syscall bool		BaseCtrl_SetForeColorEx	(handle pBC, COLOR ForeColor);
syscall bool		BaseCtrl_SetBkColorEx	(handle pBC, COLOR BkColor);
syscall COLOR		BaseCtrl_GetForeColorEx	(handle pBC);
syscall COLOR		BaseCtrl_GetBkColorEx	(handle pBC);
syscall bool		BaseCtrl_GetRange		(handle pBC, GR_RECT* target);

//-----------------------------------------------------------------------------
//		Frm control
//-----------------------------------------------------------------------------
#define		FrmCtrl_GetStyle(pC)			BaseCtrl_GetStyle     (pC)
#define		FrmCtrl_GetRange(pC, p)			BaseCtrl_GetRange     (pC, p)
#define		FrmCtrl_GetFont(pC)				BaseCtrl_GetFont      (pC)
#define		FrmCtrl_GetForeColor(pC)		BaseCtrl_GetForeColor (pC)
#define		FrmCtrl_GetBkColor(pC)			BaseCtrl_GetBkColor   (pC)
#define		FrmCtrl_PtInRange(pC,X,Y)		BaseCtrl_PtInRange    (pC,X,Y)
#define		FrmCtrl_GetForeColorEx(pC)		BaseCtrl_GetForeColorEx ((stBaseCtrl*)(pC))
#define		FrmCtrl_GetBkColorEx(pC)		BaseCtrl_GetBkColorEx   ((stBaseCtrl*)(pC))

syscall bool			FrmCtrl_ModifyStyle      (handle pFC, quad nRemoveStyle, quad nAddStyle);
syscall bool			FrmCtrl_SetRange         (handle pFC, long X1, long Y1, long X2, long Y2);
syscall bool			FrmCtrl_SetFont          (handle pFC, quad FontType);
syscall bool			FrmCtrl_SetForeColor     (handle pFC, quad ForeColor);
syscall bool			FrmCtrl_SetBkColor       (handle pFC, quad BkColor);
syscall bool			FrmCtrl_SetDelta         (handle pFC, long nDeltaX, long nDeltaY);
syscall bool			FrmCtrl_SetTitle         (handle pFC, const char* pTitle);
syscall bool			FrmCtrl_SetTitleFont     (handle pFC, quad TitleFont);
syscall bool			FrmCtrl_SetTitleForeColor(handle pFC, quad Color);
syscall bool			FrmCtrl_SetTitleBkColor  (handle pFC, quad Color);
syscall bool			FrmCtrl_SetTitleHeight   (handle pFC, long nTitleHeight);
syscall bool			FrmCtrl_PtInClientRect   (handle pFC, long X, long Y);
syscall long			FrmCtrl_PointingProcess  (handle pFC, long nAction, long X, long Y);
syscall bool			FrmCtrl_Draw             (handle pFC, bool bClear, bool bActive);
syscall bool			FrmCtrl_SetForeColorEx		(handle pFC, COLOR ForeColor);
syscall bool			FrmCtrl_SetBkColorEx		(handle pFC, COLOR BkColor);
syscall bool			FrmCtrl_SetTitleForeColorEx	(handle pFC, COLOR Color);
syscall bool			FrmCtrl_SetTitleBkColorEx	(handle pFC, COLOR Color);
syscall bool			FrmCtrl_GetClientRect		(handle pFC, GR_RECT* pRect);
syscall handle			FrmCtrl_GetVScroll			(handle pFC);
syscall handle			FrmCtrl_GetHScroll			(handle pFC);

//-------------------------------------------------------------------------------------------------
//	프레임 컨트롤의 가변 스크롤 바의 넓이를 설정한다.
//	FRMSTY_VARSCROLLBAR 스타일을 가져야만 한다.
//-------------------------------------------------------------------------------------------------
//	pFC     : 컨트롤 핸들
//	thick	: 스크롤바 두께. SCRLBAR_NORMAL_THICKNESS보다 크고 255보다 작아야 한다.
//-------------------------------------------------------------------------------------------------
//	리턴값  : 성공하면 TRUE, 실패하면 FALSE
//-------------------------------------------------------------------------------------------------
syscall bool			FrmCtrl_SetVarScrollThickness(handle pFC, long thick);

//dkjung 2016-04-11
//라운디드 렉트 그래픽라이브러리 기능 추가.
syscall bool			FrmCtrl_SetRoundRadius		(handle pFC, long radius);
syscall bool			FrmCtrl_SetRoundThickness	(handle pFC, long thick);
syscall bool			FrmCtrl_SetRoundBoarderColor(handle pFC, COLOR activColor, COLOR inactivColor);

//-------------------------------------------------------------------------------------------------
//	프레임 컨트롤의 가변 스크롤 바의 넓이를 구한다.
//	FRMSTY_VARSCROLLBAR 스타일을 가져야만 한다.
//-------------------------------------------------------------------------------------------------
//	pFC     : 컨트롤 핸들
//-------------------------------------------------------------------------------------------------
//	리턴값  : 성공하면 넓이, 실패하면 0
//-------------------------------------------------------------------------------------------------
syscall long			FrmCtrl_GetVarScrollThickness(handle pFC);


//-----------------------------------------------------------------------------
//		button control
//-----------------------------------------------------------------------------
#define		ButCtrl_GetStyle(pC)			FrmCtrl_GetStyle		(pC)
#define		ButCtrl_GetRange(pC,r)			FrmCtrl_GetRange		(pC,r)
#define		ButCtrl_GetClientRect(pC,r)		FrmCtrl_GetClientRect	(pC,r)
#define		ButCtrl_GetFont(pC)				FrmCtrl_GetFont			(pC)
#define		ButCtrl_GetForeColor(pC)		FrmCtrl_GetForeColor	(pC)
#define		ButCtrl_GetBkColor(pC)			FrmCtrl_GetBkColor		(pC)
#define		ButCtrl_PtInRange(pC,X,Y)		FrmCtrl_PtInRange		(pC,X,Y)
#define		ButCtrl_PtInClientRect(pC,X,Y)	FrmCtrl_PtInClientRect	(pC,X,Y)
#define		ButCtrl_GetForeColorEx(pC)		FrmCtrl_GetForeColorEx  (pC)
#define		ButCtrl_GetBkColorEx(pC)		FrmCtrl_GetBkColorEx    (pC)
#define		ButCtrl_SetRoundRadius(pC, r)						FrmCtrl_SetRoundRadius		(pC, r)
#define		ButCtrl_SetRoundThickness(pC, t)					FrmCtrl_SetRoundThickness   (pC, t)
#define		ButCtrl_SetRoundBoarderColor(pC, activ, inactiv)	FrmCtrl_SetRoundBoarderColor(pC, activ, inactiv)


syscall handle	ButCtrl_CreateObject		(long X1, long Y1, long X2, long Y2, long ID, char* pText);
syscall bool	ButCtrl_DeleteObject		(handle pBC);
syscall bool	ButCtrl_ModifyStyle			(handle pBC, quad nRemoveStyle, quad nAddStyle);
syscall bool	ButCtrl_SetRange			(handle pBC, long X1, long Y1, long X2, long Y2);
syscall bool	ButCtrl_SetDelta			(handle pBC, long nDeltaX, long nDeltaY);
syscall bool	ButCtrl_SetFont				(handle pBC, quad FontType);
syscall void	ButCtrl_SetForeColor		(handle pBC, quad ForeColor);
syscall void	ButCtrl_SetBkColor			(handle pBC, quad BkColor);
syscall bool	ButCtrl_SetID				(handle pBC, long ID);
syscall bool	ButCtrl_SetText				(handle pBC, char* pText);
syscall bool	ButCtrl_SetImage			(handle pBC, byte* pImage);
syscall bool	ButCtrl_SetActiveImage		(handle pBC, byte* pImage);
syscall bool	ButCtrl_SetSelKey			(handle pBC, quad SelKey);
syscall bool	ButCtrl_SetDefault			(handle pBC, bool bDefault);
syscall bool	ButCtrl_KeyProcess			(handle pBC, quad Ky);
syscall long	ButCtrl_PointingProcess		(handle pBC, long nAction, long X, long Y);
syscall bool	ButCtrl_Draw				(handle pBC, bool bActive);
syscall bool	ButCtrl_SetForeColorEx		(handle pBC, COLOR ForeColor);
syscall bool	ButCtrl_SetBkColorEx		(handle pBC, COLOR BkColor);

//-----------------------------------------------------------------------------
//		check control
//-----------------------------------------------------------------------------
syscall handle	ChkCtrl_CreateObject		(long X1, long Y1, char* pStr);
syscall bool	ChkCtrl_DeleteObject		(handle pCC);
syscall bool	ChkCtrl_ModifyStyle			(handle pCC, quad nRemoveStyle, quad nAddStyle);
syscall bool	ChkCtrl_SetRange			(handle pCC, long X1, long Y1, long X2, long Y2);
syscall bool	ChkCtrl_SetFont				(handle pCC, quad FontType);
syscall bool	ChkCtrl_SetForeColor		(handle pCC, quad ForeColor);
syscall bool	ChkCtrl_SetBkColor			(handle pCC, quad BkColor);
syscall bool	ChkCtrl_SetCheck			(handle pCC, bool bFlag);
syscall bool	ChkCtrl_SetDistance			(handle pCC, long Dist);
syscall bool	ChkCtrl_SetSelKey			(handle pCC, quad Ky);
syscall quad	ChkCtrl_GetStyle			(handle pCC);
syscall word	ChkCtrl_GetDistance			(handle pCC);
syscall bool	ChkCtrl_IsCheck				(handle pCC);
syscall bool	ChkCtrl_KeyProcess			(handle pCC, quad Ky);
syscall bool	ChkCtrl_Draw				(handle pCC, bool bActive);
syscall bool	ChkCtrl_PointingProcess		(handle pCC, long nAction, long X, long Y);
syscall bool	ChkCtrl_SetForeColorEx		(handle pCC, COLOR ForeColor);
syscall bool	ChkCtrl_SetBkColorEx		(handle pCC, COLOR BkColor);
syscall bool	ChkCtrl_SetImage			(handle pCC, byte* pOnImage, byte* pOffImage);

//-----------------------------------------------------------------------------
//		dialog base
//-----------------------------------------------------------------------------
#define		Dialog_GetStyle(pC)				FrmCtrl_GetStyle       (pC)
#define		Dialog_GetRange(pC,r)			FrmCtrl_GetRange       (pC,r)
#define		Dialog_GetClientRect(pC,r)		FrmCtrl_GetClientRect  (pC,r)
#define		Dialog_GetFont(pC)				FrmCtrl_GetFont        (pC)
#define		Dialog_GetForeColor(pC)			FrmCtrl_GetForeColor   (pC)
#define		Dialog_GetBkColor(pC)			FrmCtrl_GetBkColor     (pC)
#define		Dialog_PtInRange(pC,X,Y)		FrmCtrl_PtInRange      (pC,X,Y)
#define		Dialog_PtInClientRect(pC,X,Y)	FrmCtrl_PtInClientRect (pC,X,Y)
#define		DlgCtrl_Hide(pD,I)				DlgCtrl_SetVisible(pD, I, FALSE)
#define		DlgCtrl_Show(pD,I)				DlgCtrl_SetVisible(pD, I, TRUE)
#define		Dialog_GetForeColorEx(pC)		FrmCtrl_GetForeColorEx   (pC)
#define		Dialog_GetBkColorEx(pC)			FrmCtrl_GetBkColorEx     (pC)
#define		Dialog_SetRoundRadius(pC, r)					FrmCtrl_SetRoundRadius		(pC, r)
#define		Dialog_SetRoundThickness(pC, t)					FrmCtrl_SetRoundThickness   (pC, t)
#define		Dialog_SetRoundBoarderColor(pC, activ, inactiv)	FrmCtrl_SetRoundBoarderColor(pC, activ, inactiv)

syscall handle	Dialog_CreateObject			(void);
syscall bool	Dialog_DeleteObject			(handle pDlg);
syscall handle	Dialog_CreateButCtrl		(handle pDlg, long nIndex, long X1, long Y1, long X2, long Y2, long ID, char* pText);
syscall handle	Dialog_CreateEditCtrl		(handle pDlg, long nIndex, long X1, long Y1, long X2, long Y2, long nMaxChar);
syscall handle	Dialog_CreateIconCtrl		(handle pDlg, long nIndex, long X,  long Y,  byte* pImage);
syscall handle	Dialog_CreateLineCtrl		(handle pDlg, long nIndex, long X1, long Y1, long X2, long Y2);
syscall handle	Dialog_CreateListCtrl		(handle pDlg, long nIndex, long X1, long Y1, long X2, long Y2);
syscall handle	Dialog_CreateSelCtrl		(handle pDlg, long nIndex, long X1, long Y1, long X2, long Y2);
syscall handle	Dialog_CreateChkCtrl		(handle pDlg, long nIndex, long X1, long Y1, char* pStr);
syscall handle	Dialog_CreateTextCtrl		(handle pDlg, long nIndex, long X1, long Y1, long X2, long Y2, char* pText);
syscall handle	Dialog_CreateGridCtrl       (handle pDlg, long nIndex, long X1, long Y1, long X2, long Y2, long nMaxRow, long nMaxCol);

syscall bool	Dialog_ModifyStyle			(handle pDlg, quad nRemoveStyle, quad nAddStyle);
syscall bool	Dialog_SetRange				(handle pDlg, long X1, long Y1, long X2, long Y2);
syscall bool	Dialog_SetSize				(handle pDlg, long W, long H);
syscall bool	Dialog_SetTitle				(handle pDlg, char* pTitle);
syscall bool	Dialog_SetDefaultFont		(handle pDlg, quad FontFontType);
syscall bool	Dialog_SetTitleFont			(handle pDlg, quad FontType);
syscall bool	Dialog_SetTitleForeColor	(handle pDlg, quad Color);
syscall bool	Dialog_SetTitleBkColor		(handle pDlg, quad Color);
syscall bool	Dialog_SetTitleHeight		(handle pDlg, long nHeight);
syscall bool	Dialog_SetForeColor			(handle pDlg, quad Clr);
syscall bool	Dialog_SetBkColor			(handle pDlg, quad Clr);
syscall bool	Dialog_SetScroll			(handle pDlg, long nScrollX, long nScrollY);
syscall bool	Dialog_SetMoveKey			(handle pDlg, quad PrevKey, quad NextKey);
syscall bool	Dialog_SetLifeTime			(handle pDlg, quad nTime);
syscall long	Dialog_GetScrollX			(handle pDlg);
syscall long	Dialog_GetScrollY			(handle pDlg);
syscall long	Dialog_GetActiveCtrlIndex	(handle pDlg);
syscall bool	Dialog_IsPopupMode			(handle pDlg);
syscall bool	Dialog_SetActiveCtrl		(handle pDlg, long nIndex);
syscall long	Dialog_MoveActiveCtrl		(handle pDlg, long nOffset);
syscall bool	Dialog_EnsureVisible		(handle pDlg, long nIndex);
syscall bool	Dialog_ShowCursor			(handle pDlg, bool bShow);
syscall long	Dialog_KeyProcess			(handle pDlg, quad Ky);
syscall bool	Dialog_CharProcess			(handle pDlg, long Code);
syscall bool	Dialog_Draw					(handle pDlg, bool bClear);
syscall bool	Dialog_Timer				(handle pDlg);
syscall long	Dialog_PointingProcess		(handle pDlg, long nAction, long X, long Y);
syscall bool	Dialog_SetTitleForeColorEx  (handle pDlg, COLOR Color);
syscall bool	Dialog_SetTitleBkColorEx    (handle pDlg, COLOR Color);
syscall bool	Dialog_SetForeColorEx       (handle pDlg, COLOR Color);
syscall bool	Dialog_SetBkColorEx         (handle pDlg, COLOR Color);


//-----------------------------------------------------------------------------
//		dialog control
//-----------------------------------------------------------------------------
syscall bool	DlgCtrl_ModifyStyle			(handle pDlg, long nIndex, quad nRemoveStyle, quad nAddStyle);
syscall bool	DlgCtrl_SetRange			(handle pDlg, long nIndex, long X1, long Y1, long X2, long Y2);
syscall bool	DlgCtrl_SetDelta			(handle pDlg, long nIndex, long nDeltaX, long nDeltaY);
syscall bool	DlgCtrl_SetFont				(handle pDlg, long nIndex, quad FontType);
syscall bool	DlgCtrl_SetForeColor		(handle pDlg, long nIndex, quad ForeColor);
syscall bool	DlgCtrl_SetBkColor			(handle pDlg, long nIndex, quad BkColor);
syscall long	DlgCtrl_GetType				(handle pDlg, long nIndex);
syscall bool	DlgCtrl_GetRange			(handle pDlg, long nIndex, GR_RECT* pRange);
syscall long	DlgCtrl_GetSelIndex			(handle pDlg, long nIndex);
syscall char*	DlgCtrl_GetSelStr			(handle pDlg, long nIndex);
syscall bool	DlgCtrl_ResetAllItems		(handle pDlg, long nIndex);
syscall bool	DlgCtrl_AddItem				(handle pDlg, long nIndex, char* pStr, quad dwData);
syscall bool	DlgCtrl_AddSeparator		(handle pDlg, long nIndex);
syscall bool	DlgCtrl_SelectItem			(handle pDlg, long nIndex, long nSelIndex);
syscall bool	DlgCtrl_SelectNextItem		(handle pDlg, long nIndex);
syscall bool	DlgCtrl_SelectPrevItem		(handle pDlg, long nIndex);
syscall bool	DlgCtrl_Draw				(handle pDlg, long nIndex, bool bFocus);
syscall bool	DlgCtrl_SetVisible			(handle pDlg, long nIndex, bool bVisible);
syscall bool	DlgCtrl_SetEnable			(handle pDlg, long nIndex, bool bEnable);
syscall bool	DlgCtrl_SetGray				(handle pDlg, long nIndex, bool bGray);
syscall bool	DlgCtrl_IsVisible			(handle pDlg, long nIndex);
syscall bool	DlgCtrl_IsEnable			(handle pDlg, long nIndex);
syscall bool	DlgCtrl_IsGray				(handle pDlg, long nIndex);
syscall handle	DlgCtrl_GetHandle			(handle pDlg, long nIndex);
syscall bool	DlgCtrl_SetForeColorEx      (handle pDlg, long nIndex, COLOR ForeColor);
syscall bool	DlgCtrl_SetBkColorEx        (handle pDlg, long nIndex, COLOR BkColor);

//-----------------------------------------------------------------------------
//		dialog popup
//-----------------------------------------------------------------------------
syscall bool	DlgPopup_SetFont			(handle pDlg, quad FontType);
syscall bool	DlgPopup_SetInitIndex		(handle pDlg, long nInitIndex);
syscall bool	DlgPopup_SetIcon			(handle pDlg, long nIndex, word nIcon);
syscall bool	DlgPopup_SetIconWidth		(handle pDlg, long nIconWidth);
syscall long	DlgPopup_GetSelIndex		(handle pDlg);
syscall char*	DlgPopup_GetStr				(handle pDlg, long nIndex);
syscall char*	DlgPopup_GetSelStr			(handle pDlg);
syscall quad	DlgPopup_GetData			(handle pDlg, long nIndex);
syscall bool	DlgPopup_AttachIconList		(handle pDlg, handle pIconList);
syscall bool	DlgPopup_ResetAllItems		(handle pDlg);
syscall bool	DlgPopup_AddItem			(handle pDlg, char* pStr, quad nData, word nIcon);
syscall bool	DlgPopup_AddSeparator		(handle pDlg);
syscall bool	DlgPopup_AddPopup			(handle pDlg, char* pStr, word nIcon, handle pPC);
syscall bool	DlgPopup_SelectItem			(handle pDlg, long nIndex);
syscall bool	DlgPopup_EnableItem			(handle pDlg, long nIndex, bool bEnable);
syscall bool	DlgPopup_Run				(handle pDlg);
syscall bool	DlgPopup_Draw				(handle pDlg);
syscall handle	DlgPopup_GetHandle			(handle pDlg);

//-----------------------------------------------------------------------------
//		edit control
//-----------------------------------------------------------------------------
#define		EditCtrl_GetStyle(pC)			FrmCtrl_GetStyle       (pC)
#define		EditCtrl_GetRange(pC,r)			FrmCtrl_GetRange       (pC,r)
#define		EditCtrl_GetClientRect(pC,r)	FrmCtrl_GetClientRect  (pC,r)
#define		EditCtrl_GetFont(pC)			FrmCtrl_GetFont        (pC)
#define		EditCtrl_GetForeColor(pC)		FrmCtrl_GetForeColor   (pC)
#define		EditCtrl_GetBkColor(pC)			FrmCtrl_GetBkColor     (pC)
#define		EditCtrl_PtInRange(pC,X,Y)		FrmCtrl_PtInRange      (pC,X,Y)
#define		EditCtrl_PtInClientRect(pC,X,Y)	FrmCtrl_PtInClientRect (pC,X,Y)
#define		EditCtrl_GetForeColorEx(pC)		FrmCtrl_GetForeColorEx   (pC)
#define		EditCtrl_GetBkColorEx(pC)		FrmCtrl_GetBkColorEx     (pC)
#define		EditCtrl_SetRoundRadius(pC, r)						FrmCtrl_SetRoundRadius		(pC, r)
#define		EditCtrl_SetRoundThickness(pC, t)					FrmCtrl_SetRoundThickness   (pC, t)
#define		EditCtrl_SetRoundBoarderColor(pC, activ, inactiv)	FrmCtrl_SetRoundBoarderColor(pC, activ, inactiv)

syscall handle	EditCtrl_CreateObject		(long X1, long Y1, long X2, long Y2, long nMaxChar);
syscall bool	EditCtrl_DeleteObject		(handle pEC);
syscall bool	EditCtrl_ModifyStyle		(handle pEC, quad nRemoveStyle, quad nAddStyle);
syscall bool	EditCtrl_SetRange			(handle pEC, long X1, long Y1, long X2, long Y2);
syscall bool	EditCtrl_SetDelta			(handle pEC, long nDeltaX, long nDeltaY);
syscall bool	EditCtrl_SetFont			(handle pEC, quad FontType);
syscall bool	EditCtrl_SetForeColor		(handle pEC, quad ForeColor);
syscall bool	EditCtrl_SetBkColor			(handle pEC, quad BkColor);
syscall bool	EditCtrl_SetAlign			(handle pEC, long nAlignType);
syscall bool	EditCtrl_SetEditableMode	(handle pEC, word nMode);
syscall word	EditCtrl_SetEditMode		(handle pEC, word nMode);
syscall bool	EditCtrl_SetMaxChar			(handle pEC, long nMaxChar);
syscall long	EditCtrl_SetCursorPos		(handle pEC, long nCursorPos);
syscall bool	EditCtrl_SetMultiLine		(handle pEC, bool bMode, long nLineGap, long nSeparator);
syscall bool	EditCtrl_SetStr				(handle pEC, char* pStr);
syscall bool	EditCtrl_AssignStr			(handle pEC, char* pStr, long nMaxChar);
syscall bool	EditCtrl_InsertStr			(handle pEC, char* pInsertStr);
syscall char*	EditCtrl_GetStr				(handle pEC);
syscall long	EditCtrl_GetStrLen			(handle pEC);
syscall long	EditCtrl_GetCursorPos		(handle pEC);
syscall long	EditCtrl_GetMaxChar			(handle pEC);
syscall bool	EditCtrl_IsEndPos			(handle pEC);
syscall bool	EditCtrl_CanInsertChar		(handle pEC);
syscall bool	EditCtrl_ScrollUp			(handle pEC);
syscall bool	EditCtrl_ScrollDown			(handle pEC);
syscall bool	EditCtrl_KeyProcess			(handle pEC, quad Ky);
syscall bool	EditCtrl_CharProcess		(handle pEC, long Code);
syscall bool	EditCtrl_Draw				(handle pEC, bool bActive);
syscall bool	EditCtrl_DrawCursor			(handle pEC);
syscall bool	EditCtrl_Timer				(handle pEC);
syscall bool	EditCtrl_PointingProcess	(handle pEC, long nAction, long X, long Y);
syscall word	EditCtrl_GetEditMode		(void);
syscall byte	EditCtrl_GetEditState		(void);
syscall void	EditCtrl_ShowCursor			(void);
syscall void	EditCtrl_HideCursor			(void);
syscall void	EditCtrl_SkipCursorBlink	(void);
syscall bool	EditCtrl_SetForeColorEx		(handle pEC, COLOR ForeColor);
syscall bool	EditCtrl_SetBkColorEx		(handle pEC, COLOR BkColor);

//dkjung 2009-10-21
syscall handle	EditCtrl_CreateObjectEx		(long X1, long Y1, long X2, long Y2, long nMaxChar, char* pText);
syscall BOOL	EditCtrl_SetTickerState		(handle pEC, BOOL bFlag);
syscall long	EditCtrl_SetTickerInfo		(handle pEC, long nTickTime, long nStep);

//dkjung 2014-09-30
syscall long	EditCtrl_ShowEditInput		(handle pEC, char* pText);
syscall long	EditCtrl_ShowEditInputEx	(handle pEC, char* pText, long opt);

//-----------------------------------------------------------------------------
//		font
//-----------------------------------------------------------------------------
syscall long	Font_GetHeight				(quad FontType);
syscall long	Font_GetWidth				(quad FontType);
syscall void*	Font_GetWriteOneByteProc	(quad FontType);
syscall void*	Font_GetWriteTwoByteProc	(quad FontType);

//-----------------------------------------------------------------------------
//		graphic
//-----------------------------------------------------------------------------
syscall void	Graphic_Init				(void);
syscall void	Graphic_Exit				(void);
syscall void	Graphic_SetOrigin			(long X, long Y);
syscall long	Graphic_GetOriginX			(void);
syscall long	Graphic_GetOriginY			(void);
syscall bool	Graphic_SaveOrigin			(handle pPoint);
syscall bool	Graphic_RestoreOrigin		(handle pPoint);
syscall void	Graphic_SetScroll			(long X, long Y);
syscall long	Graphic_GetScrollX			(void);
syscall long	Graphic_GetScrollY			(void);
syscall bool	Graphic_SaveScroll			(handle pPoint);
syscall bool	Graphic_RestoreScroll		(handle pPoint);
syscall bool	Graphic_SetDevOrg			(long X, long Y);
syscall long	Graphic_GetDevOrgX			(void);
syscall long	Graphic_GetDevOrgY			(void);
syscall bool	Graphic_SaveDevOrg			(handle pPoint);
syscall bool	Graphic_RestoreDevOrg		(handle pPoint);
syscall bool	Graphic_SetDevWidth			(long W);
syscall bool	Graphic_SetDevHeight		(long H);
syscall long	Graphic_GetDevWidth			(void);
syscall long	Graphic_GetDevHeight		(void);
syscall void	Graphic_SetClipRect			(long X1, long Y1, long X2, long Y2);
syscall void	Graphic_IntersectClipRect	(long X1, long Y1, long X2, long Y2);
syscall void	Graphic_SaveClipRect		(handle pRect);
syscall void	Graphic_RestoreClipRect		(handle pRect);
syscall void	Graphic_RefreshRegion		(long Y1, long Y2);
syscall void	Graphic_ClearRegion			(long Y1, long Y2);
syscall void	Graphic_ClearRect			(long X1, long Y1, long X2, long Y2);
syscall void	Graphic_InverseRect			(long X1, long Y1, long X2, long Y2);
syscall void	Graphic_InverseRound		(long X1, long Y1, long X2, long Y2, long R);
syscall void	Graphic_InactiveRegion		(long Y1, long Y2);
syscall void	Graphic_InactiveRect		(long X1, long Y1, long X2, long Y2);
syscall void	Graphic_SaveRegion			(byte* pBuf, long Y1, long Y2);
syscall void	Graphic_RestoreRegion		(byte* pBuf, long Y1, long Y2);
syscall void	Graphic_PutPixel			(long X, long Y, COLOR Clr);
syscall COLOR	Graphic_GetPixel			(long X, long Y);
syscall void	Graphic_DrawHLine			(long Y, long X1, long X2, COLOR Clr);
syscall void	Graphic_DrawVLine			(long X, long Y1, long Y2, COLOR Clr);
syscall void	Graphic_DrawLine			(long X1, long Y1, long X2, long Y2, COLOR Clr);
syscall void	Graphic_DrawRect			(long X1, long Y1, long X2, long Y2, COLOR Clr);
syscall void	Graphic_FillRect			(long X1, long Y1, long X2, long Y2, COLOR Clr);
syscall void	Graphic_DrawCircle			(long X, long Y, quad D, COLOR Clr);
syscall void	Graphic_FillCircle			(long X, long Y, quad D, COLOR Clr);
syscall void	Graphic_DrawEllipse			(long X, long Y, long D1, long D2, COLOR Clr);
syscall void	Graphic_FillEllipse			(long X, long Y, long D1, long D2, COLOR Clr);
syscall void	Graphic_DrawArc				(long X, long Y, long D1, long D2, long nStartAngle, long nArcAngle, COLOR Clr);
syscall void	Graphic_FillArc				(long X, long Y, long D1, long D2, long nStartAngle, long nArcAngle, COLOR Clr);
syscall void	Graphic_FloodFill			(long X, long Y, COLOR FillColor, COLOR BorderColor);
syscall void	Graphic_PutImage			(byte* pImage, long X, long Y);
syscall void	Graphic_GetImage			(byte* pImage, long X1, long Y1, long X2, long Y2);
syscall void	Graphic_SetTextStyle		(long SX, long EndX, long nMaxLineNum, long nLineGap);
syscall void	Graphic_SetTextStartX		(long SX);
syscall void	Graphic_SetTextEndX			(long EX);
syscall void	Graphic_WriteStr			(long X, long Y, char* pStr, quad FontType);
syscall long	Graphic_WriteStrFromLeft	(long X, long Y, char* pStr, quad FontType);
syscall long	Graphic_WriteStrFromRight	(long X, long Y, char* pStr, quad FontType);
syscall void	Graphic_PutCh				(long X, long Y, word Code);
syscall void	Graphic_DrawFont			(byte* pFont, long X, long Y, long W, long H);
syscall COLOR	Graphic_GetNearColor		(long R, long G, long B);


//-----------------------------------------------------------------------------
//		graphic device
//-----------------------------------------------------------------------------
syscall void	GrDev_Init					(byte* pGrBuf);
syscall void	GrDev_SetGrBuf				(byte* pGrBuf);
syscall byte*	GrDev_GetGrBuf				(void);
syscall void	GrDev_SetClipRect			(long X1, long Y1, long X2, long Y2);
syscall void	GrDev_IntersectClipRect		(long X1, long Y1, long X2, long Y2);
syscall void	GrDev_SaveClipRect			(handle pRect);
syscall void	GrDev_RestoreClipRect		(handle pRect);
syscall void	GrDev_Refresh				(void);
syscall void	GrDev_RefreshRegion			(long Y1, long Y2);
syscall void	GrDev_ClearRegion			(long Y1, long Y2);
syscall void	GrDev_ClearRect				(long X1, long Y1, long X2, long Y2);
syscall void	GrDev_InverseRect			(long X1, long Y1, long X2, long Y2);
syscall void	GrDev_InverseRound			(long X1, long Y1, long X2, long Y2, long R);
syscall void	GrDev_Inactive				(void);
syscall void	GrDev_InactiveRegion		(long Y1, long Y2);
syscall void	GrDev_InactiveRect			(long X1, long Y1, long X2, long Y2);
syscall void	GrDev_SaveRegion			(byte* pBuf, long Y1, long Y2);
syscall void	GrDev_RestoreRegion			(byte* pBuf, long Y1, long Y2);
syscall void	GrDev_Reset					(void);
syscall quad	GrDev_SetTextColor			(COLOR Clr);
syscall COLOR	GrDev_GetTextColor			(void);
syscall long	GrDev_SetThickness			(long Thickness);
syscall long	GrDev_GetThickness			(void);
syscall byte	GrDev_SetStroke				(long nStroke);
syscall byte	GrDev_GetStroke				(void);
syscall long	GrDev_SetBkMode				(long nMode);
syscall long	GrDev_GetBkMode				(void);
syscall quad	GrDev_SetBkColor			(COLOR C0l0r);
syscall COLOR	GrDev_GetBkColor			(void);
syscall bool	GrDev_SetBold				(bool bBold);
syscall bool	GrDev_GetBold				(void);
syscall void	GrDev_PutPixel				(long X, long Y, COLOR Clr);
syscall COLOR	GrDev_GetPixel				(long X, long Y);
syscall void	GrDev_DrawHLine				(long Y, long X1, long X2, COLOR Clr);
syscall void	GrDev_DrawVLine				(long X, long Y1, long Y2, COLOR Clr);
syscall void	GrDev_DrawLineEx			(long X1, long Y1, long X2, long Y2, COLOR Clr);
syscall void	GrDev_DrawRect				(long X1, long Y1, long X2, long Y2, COLOR Clr);
syscall void	GrDev_FillRect				(long X1, long Y1, long X2, long Y2, COLOR Clr);
syscall void	GrDev_DrawCircle			(long X, long Y, long D, COLOR Clr);
syscall void	GrDev_FillCircle			(long X, long Y, long D, COLOR Clr);
syscall void	GrDev_DrawEllipse			(long X, long Y, long D1, long D2, COLOR Clr);
syscall void	GrDev_FillEllipse			(long X, long Y, long D1, long D2, COLOR Clr);
syscall void	GrDev_DrawArc				(long X, long Y, long D1, long D2, long nStartAngle, long nArcAngle, COLOR Clr);
syscall void	GrDev_FillArc				(long X, long Y, long D1, long D2, long nStartAngle, long nArcAngle, COLOR Clr);
syscall void	GrDev_FloodFill				(long X, long Y, COLOR FillColor, COLOR BorderColor);
syscall void	GrDev_PutImage				(byte* pImage, long X, long Y);
syscall void	GrDev_GetImage				(byte* pImage, long X1, long Y1, long X2, long Y2);
syscall void	GrDev_SetTextStyle			(long SX, long EX, long nMaxLineNum, long nLineGap);
syscall void	GrDev_SetTextStartX			(long SX);
syscall void	GrDev_SetTextEndX			(long EX);
syscall void	GrDev_SetTextMaxLineNum		(long nMaxLineNum);
syscall void	GrDev_SetTextLineGap		(long nLineGap);
syscall void	GrDev_WriteStr				(long X, long Y, char* pStr, quad FontType);
syscall long	GrDev_WriteStrFromLeft		(long X, long Y, char* pStr, quad FontType);
syscall long	GrDev_WriteStrFromRight		(long X, long Y, char* pStr, quad FontType);
syscall void	GrDev_PutCh					(long X, long Y, word Code);
syscall void	GrDev_DrawFont				(byte* pFont, long X, long Y, long W, long H);
syscall quad	GrDev_GetStrWidth			(byte* pszStr, quad FontType);

//PNG
//[Image Type]
#define PNG_COLOR_NORMAL	16
#define PNG_COLOR_ALPHA		32
syscall byte*	GrDev_LoadPngImage			(long nColorBit, char* pszPngFile);
syscall byte*	GrDev_ResizePixels			(byte* pImage, long X1, long Y1, long X2, long Y2);

//TTF
syscall BOOL	GrDev_SetFontFace			(char* pcszFace);
syscall char*	GrDev_GetFontFace			(void);
syscall quad	GrDev_GetCharWidth			(quad dwCode, quad nSize);

//-----------------------------------------------------------------------------
//		icon control
//-----------------------------------------------------------------------------
syscall handle	IconCtrl_CreateObject		(long X, long Y, byte* pImage);
syscall bool	IconCtrl_DeleteObject		(handle pIC);
syscall bool	IconCtrl_SetPos				(handle pIC, long X, long Y);
syscall bool	IconCtrl_SetImage			(handle pIC, long nIndex, byte* pImage);
syscall bool	IconCtrl_SetSelIndex		(handle pIC, long nIndex);
syscall byte*	IconCtrl_GetImage			(handle pIC, long nIndex);
syscall word	IconCtrl_GetSelIndex		(handle pIC);
syscall byte*	IconCtrl_GetSelImage		(handle pIC);
syscall bool	IconCtrl_AddImage			(handle pIC, byte* pImage);
syscall bool	IconCtrl_Draw				(handle pIC);

//-----------------------------------------------------------------------------
//		icon list
//-----------------------------------------------------------------------------
syscall handle	IconList_CreateObject		(void);
syscall bool	IconList_DeleteObject		(handle pIL);
syscall bool	IconList_ResetAllImages		(handle pIL);
syscall long	IconList_AddImage			(handle pIL, byte* pImage);
syscall bool	IconList_RemoveImage		(handle pIL, long nIndex);
syscall byte*	IconList_GetImage			(handle pIL, long nIndex);

//-----------------------------------------------------------------------------
//		line control
//-----------------------------------------------------------------------------
syscall handle	LineCtrl_CreateObject		(long X1, long Y1, long X2, long Y2);
syscall bool	LineCtrl_DeleteObject		(handle pLC);
syscall bool	LineCtrl_SetStartPos		(handle pLC, long nIndex, long X, long Y);
syscall bool	LineCtrl_SetEndPos			(handle pLC, long nIndex, long X, long Y);
syscall bool	LineCtrl_SetColor			(handle pLC, quad Clr);
syscall bool	LineCtrl_SetThickness		(handle pLC, long nThick);
syscall bool	LineCtrl_SetStroke			(handle pLC, byte nStroke);
syscall bool	LineCtrl_AddLine			(handle pLC, long X1, long Y1, long X2, long Y2);
syscall bool	LineCtrl_Draw				(handle pLC);
syscall bool	LineCtrl_SetColorEx			(handle pLC, COLOR Color);

//-----------------------------------------------------------------------------
//		list control
//-----------------------------------------------------------------------------
#define		ListCtrl_GetStyle(pC)			FrmCtrl_GetStyle       (pC)
#define		ListCtrl_GetRange(pC,r)			FrmCtrl_GetRange       (pC,r)
#define		ListCtrl_GetClientRect(pC,r)	FrmCtrl_GetClientRect  (pC,r)
#define		ListCtrl_GetFont(pC)			FrmCtrl_GetFont        (pC)
#define		ListCtrl_GetForeColor(pC)		FrmCtrl_GetForeColor   (pC)
#define		ListCtrl_GetBkColor(pC)			FrmCtrl_GetBkColor     (pC)
#define		ListCtrl_PtInRange(pC,X,Y)		FrmCtrl_PtInRange      (pC,X,Y)
#define		ListCtrl_PtInClientRect(pC,X,Y)	FrmCtrl_PtInClientRect (pC,X,Y)
#define		ListCtrl_GetForeColorEx(pC)		FrmCtrl_GetForeColorEx   (pC)
#define		ListCtrl_GetBkColorEx(pC)		FrmCtrl_GetBkColorEx     (pC)
#define		ListCtrl_SetRoundRadius(pC, r)						FrmCtrl_SetRoundRadius		(pC, r)
#define		ListCtrl_SetRoundThickness(pC, t)					FrmCtrl_SetRoundThickness   (pC, t)
#define		ListCtrl_SetRoundBoarderColor(pC, activ, inactiv)	FrmCtrl_SetRoundBoarderColor(pC, activ, inactiv)

syscall handle	ListCtrl_CreateObject		(long X1, long Y1, long X2, long Y2);
syscall bool	ListCtrl_DeleteObject		(handle pLC);
syscall bool	ListCtrl_ModifyStyle		(handle pLC, quad nRemoveStyle, quad nAddStyle);
syscall bool	ListCtrl_SetRange			(handle pLC, long X1, long Y1, long X2, long Y2);
syscall bool	ListCtrl_SetDelta			(handle pLC, long nDeltaX, long nDeltaY);
syscall bool	ListCtrl_SetFont			(handle pLC, quad FontType);
syscall bool	ListCtrl_SetForeColor		(handle pLC, quad ForeColor);
syscall bool	ListCtrl_SetBkColor			(handle pLC, quad BkColor);
syscall bool	ListCtrl_SetLineGap			(handle pLC, long nLineGap);
syscall bool	ListCtrl_SetInvOffset		(handle pLC, long nInvOffset);
syscall bool	ListCtrl_SetScroll			(handle pLC, long nScrollX, long nScrollY);
syscall bool	ListCtrl_SetMaxScrollX		(handle pLC, long nMaxScrollX);
syscall bool	ListCtrl_SetIcon			(handle pLC, long nIndex, word nIcon);
syscall bool	ListCtrl_SetIconWidth		(handle pLC, long nIconWidth);
syscall bool	ListCtrl_SetDetailIcon		(handle pLC, word nIcon);
syscall bool	ListCtrl_SetDetailStr		(handle pLC, char* pDetailStr);
syscall bool	ListCtrl_SetMultiLineNum	(handle pLC, long nMultiLineNum);
syscall bool	ListCtrl_SetCursorColor	(handle pLC, quad Color);
syscall char*	ListCtrl_GetStr				(handle pLC, long nIndex);
syscall quad	ListCtrl_GetData			(handle pLC, long nIndex);
syscall word	ListCtrl_GetStatus			(handle pLC, long nIndex);
syscall word	ListCtrl_GetIcon			(handle pLC, long nIndex);
syscall long	ListCtrl_GetSelIndex		(handle pLC);
syscall char*	ListCtrl_GetSelStr			(handle pLC);
syscall char*	ListCtrl_GetDetailStr		(handle pLC);
syscall long	ListCtrl_GetScrollX			(handle pLC);
syscall long	ListCtrl_GetScrollY			(handle pLC);
syscall long	ListCtrl_GetMaxScrollX		(handle pLC);
syscall long	ListCtrl_GetItemNum			(handle pLC);
syscall handle	ListCtrl_GetIconList		(handle pLC);
syscall long	ListCtrl_GetIconWidth		(handle pLC);
syscall bool	ListCtrl_AttachIconList		(handle pLC, handle pIconList);
syscall bool	ListCtrl_ResetAllItems		(handle pLC);
syscall bool	ListCtrl_ResetState			(handle pLC);
syscall bool	ListCtrl_AddItem			(handle pLC, char* pStr, quad nData, word nIcon);
syscall bool	ListCtrl_AddSeparator		(handle pLC);
syscall bool	ListCtrl_SelectItem			(handle pLC, long nIndex);
syscall long	ListCtrl_SelectNextItem		(handle pLC);
syscall long	ListCtrl_SelectPrevItem		(handle pLC);
syscall bool	ListCtrl_CheckItem			(handle pLC, long nIndex, bool bCheck);
syscall bool	ListCtrl_EnableItem			(handle pLC, long nIndex, bool bEnable);
syscall bool	ListCtrl_AttachArrow		(handle pLC, long nIndex);
syscall bool	ListCtrl_EnsureVisible		(handle pLC, long nIndex);
syscall bool	ListCtrl_KeyProcess			(handle pLC, quad Ky);
syscall bool	ListCtrl_Draw				(handle pLC, bool bActive);
syscall bool	ListCtrl_PointingProcess	(handle pLC, long nAction, long X, long Y);
syscall bool	ListCtrl_SetForeColorEx		(handle pLC, COLOR ForeColor);
syscall bool	ListCtrl_SetBkColorEx		(handle pLC, COLOR BkColor);

//외부 리스트 컨트롤
syscall long	ListCtrl_ShowListInput		(handle pLC);
syscall void	ListCtrl_QuickView			(char* pInData, long opt);

//-----------------------------------------------------------------------------
//		popup control
//-----------------------------------------------------------------------------
syscall handle	PopupCtrl_CreateObject		(quad nStyle, long nBaseX, long nBaseY);
syscall bool	PopupCtrl_DeleteObject		(handle pPC);
syscall bool	PopupCtrl_ModifyStyle		(handle pPC, quad nRemoveStyle, quad nAddStyle);
syscall bool	PopupCtrl_SetBase			(handle pPC, long nBaseX, long nBaseY);
syscall bool	PopupCtrl_SetMaxHeight		(handle pPC, long nMaxHeight);
syscall bool	PopupCtrl_SetFont			(handle pPC, quad FontType);
syscall bool	PopupCtrl_SetInitIndex		(handle pPC, long nInitIndex);
syscall bool	PopupCtrl_SetIcon			(handle pPC, long nIndex, word nIcon);
syscall bool	PopupCtrl_SetIconWidth		(handle pPC, long nIconWidth);
syscall long	PopupCtrl_GetSelIndex		(handle pPC);
syscall char*	PopupCtrl_GetStr			(handle pPC, long nIndex);
syscall char*	PopupCtrl_GetSelStr			(handle pPC);
syscall quad	PopupCtrl_GetData			(handle pPC, long nIndex);
syscall bool	PopupCtrl_AttachIconList	(handle pPC, handle pIconList);
syscall bool	PopupCtrl_ResetAllItems		(handle pPC);
syscall bool	PopupCtrl_AddItem			(handle pPC, char* pStr, quad bData, word nIcon);
syscall bool	PopupCtrl_AddSeparator		(handle pPC);
syscall bool	PopupCtrl_AddPopup			(handle pPC, char* pStr, word nIcon, handle pSubPC);
syscall bool	PopupCtrl_SelectItem		(handle pPC, long nIndex);
syscall bool	PopupCtrl_EnableItem		(handle pPC, long nIndex, bool bEnable);
syscall bool	PopupCtrl_ResetState		(handle pPC);
syscall long	PopupCtrl_KeyProcess		(handle pPC, quad Ky);
syscall long	PopupCtrl_PointingProcess	(handle pPC, long nAction, long X, long Y);
syscall bool	PopupCtrl_Draw				(handle pPC);
syscall handle	PopupCtrl_GetListCtrlHandle	(handle pPC);


//-----------------------------------------------------------------------------
//		scroll control
//-----------------------------------------------------------------------------
#define		ScrCtrl_GetStyle(pC)			BaseCtrl_GetStyle     (pC)
#define		ScrCtrl_GetRange(pC,r)			BaseCtrl_GetRange     (pC,r)
#define		ScrCtrl_GetFont(pC)				BaseCtrl_GetFont      (pC)
#define		ScrCtrl_GetForeColor(pC)		BaseCtrl_GetForeColor (pC)
#define		ScrCtrl_GetBkColor(pC)			BaseCtrl_GetBkColor   (pC)
#define		ScrCtrl_PtInRange(pC,X,Y)		BaseCtrl_PtInRange    (pC,X,Y)
#define		ScrCtrl_GetForeColorEx(pC)		BaseCtrl_GetForeColorEx (pC)
#define		ScrCtrl_GetBkColorEx(pC)		BaseCtrl_GetBkColorEx   (pC)

syscall handle	ScrlBar_CreateObject		(handle pOwner, quad nStyle);
syscall bool	ScrlBar_DeleteObject		(handle pSB);
syscall bool	ScrlBar_ModifyStyle			(handle pSB, quad nRemoveStyle, quad nAddStyle);
syscall bool	ScrlBar_SetForeColor		(handle pSB, quad ForeColor);
syscall bool	ScrlBar_SetBkColor			(handle pSB, quad BkColor);
syscall bool	ScrlBar_SetValue			(handle pSB, long nRange, long nPos, long nLength);
syscall long	ScrlBar_GetMaxScrollV		(handle pSB);
syscall bool	ScrlBar_IsFullScroll		(handle pSB);
syscall long	ScrlBar_PointingProcess		(handle pSB, long nAction, long X, long Y);
syscall bool	ScrlBar_Draw				(handle pSB, bool bActive);
syscall long	ScrlBar_GetPointingMoveV	(void);
syscall bool	ScrlBar_SetForeColorEx		(handle pSB, COLOR ForeColor);
syscall bool	ScrlBar_SetBkColorEx		(handle pSB, COLOR BkColor);
//-------------------------------------------------------------------------------------------------
//	수평 스크롤바의 경우 바의 왼쪽, 수직의 경우 바의 위쪽의 위치를 리턴한다.
//-------------------------------------------------------------------------------------------------
//	pSB     : 스크롤 컨트롤 핸들
//	max		: 스크롤바의 위치의 백분율에 곱할 수
//-------------------------------------------------------------------------------------------------
//	리턴값  : 바의 위치 백분율 * max 
//-------------------------------------------------------------------------------------------------
syscall long	ScrlBar_GetHighPos			(handle pSB, int max);
//-------------------------------------------------------------------------------------------------
//	수평 스크롤바의 경우 바의 오른쪽, 수직의 경우 바의 아래쪽의 위치를 리턴한다.
//-------------------------------------------------------------------------------------------------
//	pSB     : 스크롤 컨트롤 핸들
//	max		: 스크롤바의 위치의 백분율에 곱할 수
//-------------------------------------------------------------------------------------------------
//	리턴값  : 바의 위치 백분율 * max 
//-------------------------------------------------------------------------------------------------
syscall long	ScrlBar_GetLowPos			(handle pSB, int max);

//-------------------------------------------------------------------------------------------------
//	가변 넓이 스크롤바의 넓이를 설정한다. 스타일에 SCRLSTY_VARTHICKNESS있어야 만 한다.
//-------------------------------------------------------------------------------------------------
//	pSB     : 스크롤 컨트롤 핸들
//	thick	: 스크롤바의 넓이. SCRLBAR_NORMAL_THICKNESS 커고 255보다는 작아야 한다.
//-------------------------------------------------------------------------------------------------
//	리턴값  : 실패하면 0, 성공하면 설정된 크기 
//-------------------------------------------------------------------------------------------------
syscall long	ScrlBar_SetThickness		(handle pSB, long thick);

//-------------------------------------------------------------------------------------------------
//	가변 넓이 스크롤바의 넓이를 구한다. 스타일에 SCRLSTY_VARTHICKNESS있어야 만 한다.
//-------------------------------------------------------------------------------------------------
//	pSB     : 스크롤 컨트롤 핸들
//-------------------------------------------------------------------------------------------------
//	리턴값  : 실패하면 0, 성공하면 설정된 크기 
//-------------------------------------------------------------------------------------------------
syscall long	ScrlBar_GetThickness		(handle pSB);

//-----------------------------------------------------------------------------
//		select control
//-----------------------------------------------------------------------------
#define		SelCtrl_GetStyle(pC)			FrmCtrl_GetStyle       (pC)
#define		SelCtrl_GetRange(pC,r)			FrmCtrl_GetRange       (pC,r)
#define		SelCtrl_GetClientRect(pC,r)		FrmCtrl_GetClientRect  (pC,r)
#define		SelCtrl_GetFont(pC)				FrmCtrl_GetFont        (pC)
#define		SelCtrl_GetForeColor(pC)		FrmCtrl_GetForeColor   (pC)
#define		SelCtrl_GetBkColor(pC)			FrmCtrl_GetBkColor     (pC)
#define		SelCtrl_PtInRange(pC,X,Y)		FrmCtrl_PtInRange      (pC,X,Y)
#define		SelCtrl_PtInClientRect(pC,X,Y)	FrmCtrl_PtInClientRect (pC,X,Y)
#define		SelCtrl_GetForeColorEx(pC)		FrmCtrl_GetForeColorEx   ((stFrmCtrl*)(pC))
#define		SelCtrl_GetBkColorEx(pC)		FrmCtrl_GetBkColorEx     ((stFrmCtrl*)(pC))

syscall handle	SelCtrl_CreateObject		(long X1, long Y1, long X2, long Y2);
syscall bool	SelCtrl_DeleteObject		(handle pSC);
syscall bool	SelCtrl_ModifyStyle			(handle pSC, quad nRemoveStyle, quad nAddStyle);
syscall bool	SelCtrl_SetRange			(handle pSC, long X1, long Y1, long X2, long Y2);
syscall bool	SelCtrl_SetDelta			(handle pSC, long nDeltaX, long nDeltaY);
syscall bool	SelCtrl_SetFont				(handle pSC, quad FontType);
syscall bool	SelCtrl_SetForeColor		(handle pSC, quad ForeColor);
syscall bool	SelCtrl_SetBkColor			(handle pSC, quad BkColor);
syscall bool	SelCtrl_SetTag				(handle pSC, char* strTag);
syscall bool	SelCtrl_SetMoveKey			(handle pSC, quad PrevKey, quad NextKey);
syscall long	SelCtrl_GetSelIndex			(handle pSC);
syscall char*	SelCtrl_GetSelStr			(handle pSC);
syscall char*	SelCtrl_GetStr				(handle pSC, long nIndex);
syscall bool	SelCtrl_ResetAllItems		(handle pSC);
syscall bool	SelCtrl_ResetState			(handle pSC);
syscall bool	SelCtrl_AddItem				(handle pSC, char* pStr);
syscall bool	SelCtrl_SelectItem			(handle pSC, long nIndex);
syscall long	SelCtrl_SelectNextItem		(handle pSC);
syscall long	SelCtrl_SelectPrevItem		(handle pSC);
syscall bool	SelCtrl_AssignStrSet		(handle pSC, char* pStringSet, long nStrNum);
syscall bool	SelCtrl_KeyProcess			(handle pSC, quad Ky);
syscall bool	SelCtrl_Draw				(handle pSC, bool bActive);
syscall bool	SelCtrl_PointingProcess		(handle pSC, long nAction, long X, long Y);
syscall bool	SelCtrl_SetForeColorEx		(handle pSC, COLOR ForeColor);
syscall bool	SelCtrl_SetBkColorEx		(handle pSC, COLOR BkColor);


//-----------------------------------------------------------------------------
//		grid control
//-----------------------------------------------------------------------------
syscall handle	GridCtrl_CreateObject		(long X1, long Y1, long X2, long Y2, long row, long col);
syscall bool	GridCtrl_DeleteObject		(handle pGC);
syscall long	GridCtrl_CreateTable		(handle pGC);
syscall long	GridCtrl_SetColumn			(handle pGC, long index, char* pName, long width, long mode, long ctrltype, long max_char);
syscall long	GridCtrl_SetColumnStyle		(handle pGC, long index, long add_style, long rem_style, long font, long fr_color, long bk_color);
syscall long	GridCtrl_SetHeaderHeight	(handle pGC, long height);
syscall long	GridCtrl_SetBodyHeight		(handle pGC, long height);
syscall long	GridCtrl_SetGap				(handle pGC, long gap);

syscall long	GridCtrl_KeyProcess         (handle pGC, quad Key);
syscall bool	GridCtrl_CharProcess        (handle pGC, long Code);
syscall bool	GridCtrl_Draw               (handle pGC, bool bClear);
syscall handle	GridCtrl_GetScrollHandle    (handle pGC);
syscall long	GridCtrl_PointingProcess    (handle pGC, long nAction, long X, long Y);
syscall bool	GridCtrl_SetScroll          (handle pGC, long nScrollX, long nScrollY);
syscall void	GridCtrl_SetScrollDelta		(handle pGC, long nScrollDelta);

syscall handle	GridCtrl_GetCellHandle		(handle pGC, long x, long y);
syscall char*	GridCtrl_GetCellStr			(handle pGC, long x, long y);
syscall void	GridCtrl_SetCellStr			(handle pGC, long x, long y, char* pstr);
syscall long	GridCtrl_ScrollProcess		(handle pGC, long event);
syscall long	GridCtrl_ScrollMoveProcess	(handle pGC, long V, long nDownV);
syscall bool	GridCtrl_SetSelectedColor	(handle pGC, long y, COLOR color);
syscall COLOR	GridCtrl_GetSelectedColor	(handle pGC);
syscall long	GridCtrl_GetScrollX			(handle pGC);
syscall long	GridCtrl_GetScrollY			(handle pGC);
syscall long	GridCtrl_GetMaxScrollX		(handle pGC);
syscall long	GridCtrl_GetMaxScrollY		(handle pGC);
syscall bool	GridCtrl_SetStripedColor	(handle pGC, COLOR color);

#endif	//	GRSYSCALL_H


