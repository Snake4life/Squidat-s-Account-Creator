#include <IE.au3>
#include <File.au3>

$server = InputBox("Server","EUW - EUNE - NA - LAN - LAS - BR - OCE")
	if ($server = "eune") Then
		;$download = "https://signup.eune.leagueoflegends.com/en/signup/download"
		;$download1 = "https://signup.eune.leagueoflegends.com/en/signup/redownload"
		$download2 = "https://signup.eune.leagueoflegends.com/en/signup/download?type=new"
	EndIf
	if ($server = "euw") Then
		$download2 = "https://signup.euw.leagueoflegends.com/en/signup/download?type=new"
	EndIf
	if ($server = "na") Then
		$download2 = "https://signup.na.leagueoflegends.com/en/signup/download"
	EndIf
	if ($server = "lan") Then
		$download2 = "https://signup.lan.leagueoflegends.com/en/signup/download"
	EndIf
	if ($server = "las") Then
		$download2 = "https://signup.las.leagueoflegends.com/en/signup/download"
	EndIf
	if ($server = "oce") Then
		$download2 = "https://signup.oce.leagueoflegends.com/en/signup/redownload"
	EndIf
	if ($server = "br") Then
		$download2 = "https://signup.br.leagueoflegends.com/en/signup/download"
	EndIf

$strUsers = InputBox("Amount of Accounts","How many accounts do you want to create?")
$spliterino = StringSplit($strUsers,0)
$cantUsers = Number($strUsers)
$userPassowrd = InputBox("Password for the accounts", "Write the password you want on all of the accounts")
$path = @ScriptDir
_FileCreate($path & "\" & "usernames.txt")

$randomUsernameGen = $path & "\" & "randomusernamev2.exe"

$rutaArchivo = $path & "\" & "usernames.txt"
$exeUser = Run($randomUsernameGen)

Sleep (200)
ControlSend($randomUsernameGen,"","", $strUsers)
Send("{ENTER}")
Sleep(3000)
ProcessClose($exeUser)

Global $oIE = _IECreate("http://")
$url = ("https://signup." & $server & ".leagueoflegends.com/en/signup/index?realm_key=" & $server)
Global $file = $rutaArchivo

FileOpen($file, 0)
For $i = 1 to _FileCountLines($file)
    $line = FileReadLine($file, $i)

	_IENavigate($oIE,$url)

	Local $username = _IEGetObjById($oIE,"PvpnetAccountName")
	Local $password1 = _IEGetObjById($oIE,"PvpnetAccountPassword")
	Local $passwordConf = _IEGetObjById($oIE,"PvpnetAccountConfirmPassword")
	Local $day = _IEGetObjById($oIE,"PvpnetAccountDateOfBirthDay")
	Local $month = _IEGetObjById($oIE,"PvpnetAccountDateOfBirthMonth")
	Local $year = _IEGetObjById($oIE,"PvpnetAccountDateOfBirthYear")
	Local $agree = _IEGetObjById($oIE,"PvpnetAccountTouAgree");
	Local $email = _IEGetObjById($oIE,"PvpnetAccountEmailAddress");
	$divcoll = _IETagNameGetCollection($oIE,"div")


	_IEFormElementSetValue($username,$line)
	_IEFormElementSetValue($password1,$userPassowrd)
	_IEFormElementSetValue($passwordConf,$userPassowrd)
	_IEFormElementSetValue($email,$line & $line & "1000" & "@gmail.com")

	For $div In $divcoll
			if ($div.className = "selectize-input items not-full has-options") Then

				if ($div.innertext = "Day") Then
					_IEAction($div,"click")
					Sleep(200)
					Send("{1 1}")
					Send("{ENTER}")
					Sleep(200)
				EndIf
				;ControlSend("Sign up | League of Legends","","", "1990")
				Sleep(2000)
				;Send("{ENTER}")

			EndIf
	Next

	If Not $agree.checked Then    ;Agree terms and conditions
		$agree.checked = True
		$agree.fireEvent ("onclick")
	EndIf
	$continue = '';
	while ($continue <> $download2) ;or ($continue <> $download)  Or ($continue <> $download1) ;($continue <> $download) Or ($continue <> $download1) Or
		Sleep(100)
		$continue = _IEPropertyGet($oIE,"locationurl")
		;MsgBox(0,"",$continue)
	WEnd

	;_IEQuit($oIE)

Next
_IEQuit($oIE)
FileClose($file)
