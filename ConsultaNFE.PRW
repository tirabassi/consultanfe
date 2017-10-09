#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa: CONSULTANFE  Autor ³  Carlos Tirabassi    ³ Data ³ 20/05/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³                  ³Contato ³                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Consulta o Status da Nota pela chave                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function ConsultaNfe(cChave)

Local aArea       := GETAREA()
Local cURL        := GetMV("MV_SPEDURL")
Local _lServOk    := .F.
Local cIdEnt      := ''
Local aRet        := Array(4)
Local oWs

DEFAULT cChave = ''

_lServOk:= TSSIsReady() // Verifica se a Conexão com a Totvs foi estabelecida

IF _lServOk == .T.
	cIdEnt := GetId()
	If !Empty(cIdEnt)
		oWs:= WsNFeSBra():New()
		oWs:cUserToken   := "TOTVS"
		oWs:cID_ENT      := cIdEnt
		oWs:_URL         := AllTrim(cURL)+"/NFeSBRA.apw"
		oWs:cCHVNFE      := AllTrim(cChave)
		If oWs:CONSULTACHAVENFE()
			aRet[1]  := oWs:oWSCONSULTACHAVENFERESULT:cCODRETNFE  //Código de Retorn
			aRet[2]  := oWs:oWSCONSULTACHAVENFERESULT:cMSGRETNFE  //Mensagem
			aRet[3]  := oWs:oWSCONSULTACHAVENFERESULT:cPROTOCOLO  //Protocolo
			aRet[4]  := oWs:oWSCONSULTACHAVENFERESULT:dRECBTO     //Data de Emissão
		EndIf
	EndIf
EndIf

RestArea(aArea)

Return aRet

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa: TSSIsReady  Autor ³  Desconhecido		 Data ³           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³                  ³Contato ³                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Verifica se o TSS está online                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TSSIsReady()

Local nX       := 0
Local cHelp    := ""
Local oWS
Local lRetorno := .F.

DEFAULT nTipo := 1

SuperGetMv() //Limpa o cache de parametros - nao retirar

DEFAULT cURL      := PadR(GetNewPar("MV_SPEDURL","http://"),250)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿

//³Verifica se o servidor da Totvs esta no ar                              ³

//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oWs := WsSpedCfgNFe():New()

oWs:cUserToken := "TOTVS"

oWS:_URL := AllTrim(cURL)+"/SPEDCFGNFe.apw"

If oWs:CFGCONNECT()
	
	lRetorno := .T.
	
Else
	
	lRetorno := .F.
	
EndIf

DelClassIntf()

Return(lRetorno)  

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa: GetId       Autor ³  Desconhecido         ³ Data ³ 20/05/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³                  ³Contato ³                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Retorna o ID da empresa no TSS                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GetId()

Local aArea     := GetArea()
Local cIdEnt    := ""
Local cURL      := PadR(GetNewPar("MV_SPEDURL","http://"),250)
Local lMethodOk := .F.
Local oWsSPEDAdm

BEGIN SEQUENCE

IF !( CTIsReady(cURL) )
	BREAK
EndIF

cURL := AllTrim(cURL)+"/SPEDADM.apw"

IF !( CTIsReady(cURL) )
	BREAK
EndIF

oWsSPEDAdm := WsSPEDAdm():New()

oWsSPEDAdm:cUSERTOKEN 		:= "TOTVS"
oWsSPEDAdm:oWsEmpresa:cCNPJ 	:= SM0->(IF(M0_TPINSC==2 .Or. Empty(M0_TPINSC),M0_CGC,""))
oWsSPEDAdm:oWsEmpresa:cCPF 	:= SM0->( IF(M0_TPINSC==3,M0_CGC,"") )
oWsSPEDAdm:oWsEmpresa:cIE 	:= SM0->M0_INSC
oWsSPEDAdm:oWsEmpresa:cIM 	:= SM0->M0_INSCM
oWsSPEDAdm:oWsEmpresa:cNOME 	:= SM0->M0_NOMECOM
oWsSPEDAdm:oWsEmpresa:cFANTASIA := SM0->M0_NOME
oWsSPEDAdm:oWsEmpresa:cENDERECO := FisGetEnd(SM0->M0_ENDENT)[1]
oWsSPEDAdm:oWsEmpresa:cNUM 	:= FisGetEnd(SM0->M0_ENDENT)[3]
oWsSPEDAdm:oWsEmpresa:cCOMPL 	:= FisGetEnd(SM0->M0_ENDENT)[4]
oWsSPEDAdm:oWsEmpresa:cUF 	:= SM0->M0_ESTENT
oWsSPEDAdm:oWsEmpresa:cCEP 	:= SM0->M0_CEPENT
oWsSPEDAdm:oWsEmpresa:cCOD_MUN 	:= SM0->M0_CODMUN
oWsSPEDAdm:oWsEmpresa:cCOD_PAIS := "1058"
oWsSPEDAdm:oWsEmpresa:cBAIRRO 	:= SM0->M0_BAIRENT
oWsSPEDAdm:oWsEmpresa:cMUN 	:= SM0->M0_CIDENT
oWsSPEDAdm:oWsEmpresa:cCEP_CP 	:= NIL
oWsSPEDAdm:oWsEmpresa:cCP 	:= NIL
oWsSPEDAdm:oWsEmpresa:cDDD 	:= Str(FisGetTel(SM0->M0_TEL)[2],3)
oWsSPEDAdm:oWsEmpresa:cFONE 	:= AllTrim(Str(FisGetTel(SM0->M0_TEL)[3],15))
oWsSPEDAdm:oWsEmpresa:cFAX 	:= AllTrim(Str(FisGetTel(SM0->M0_FAX)[3],15))
oWsSPEDAdm:oWsEmpresa:cEMAIL 	:= UsrRetMail(RetCodUsr())
oWsSPEDAdm:oWsEmpresa:cNIRE 	:= SM0->M0_NIRE
oWsSPEDAdm:oWsEmpresa:dDTRE 	:= SM0->M0_DTRE
oWsSPEDAdm:oWsEmpresa:cNIT 	:= SM0->( IF(M0_TPINSC==1,M0_CGC,"") )
oWsSPEDAdm:oWsEmpresa:cINDSITESP:= ""
oWsSPEDAdm:oWsEmpresa:cID_MATRIZ:= ""
oWsSPEDAdm:oWsOutrasInscricoes:oWsInscricao := SPEDADM_ARRAYOFSPED_GENERICSTRUCT():New()
oWsSPEDAdm:_URL := cURL

lMethodOk := oWsSPEDAdm:AdmEmpresas()

DEFAULT lMethodOk := .F.

IF !( lMethodOk )
	cError := IF( Empty( GetWscError(3) ) , GetWscError(1) , GetWscError(3) )
	BREAK
EndIF

cIdEnt := oWsSPEDAdm:cAdmEmpresasResult

END SEQUENCE

RestArea(aArea)

Return( cIdEnt )

