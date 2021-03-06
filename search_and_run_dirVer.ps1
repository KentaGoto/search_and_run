# ファイルを検索して実行する


#.NET Frameworkのダイアログオブジェクトをインポート
Add-Type -AssemblyName System.Windows.Forms;

Write-Output ''
$inputDir = Read-Host "Please enter the directory path"
pushd $inputDir

Write-Output ''
$inputFile = Read-Host "Please enter the file name"

Write-Progress "Process:" -Status "Searching..."

if ($found = (gci -Recurse "*$inputFile*").FullName){
	
	# オプション: ヒットしたアイテムのフルパスをクリップボードにコピー
	$found|clip

	# コンソールに出力
	echo ''
	Write-Host 'Found!' -ForeGroundColor Cyan
	echo ''
	#echo "$found"
	#echo ''
	
	# ダイアログに出力
	# ダイアログに表示する内容
	$text = "ヒットしたアイテムを実行しますか?`n`n$found";
	# ダイアログのタイトル
	$caption = "Found!";
	# ダイアログのボタン
	$buttonsType_found = "OKCancel";
	# [Found!]ダイアログを表示
	$result = [System.Windows.Forms.MessageBox]::Show($text, $caption, $buttonsType_found, "Information");
	$result
	# ダイアログのボタンに応じたアクション
	if ($result -eq 'OK') {
		# ヒットしたアイテムを関連付けされているアプリケーションで実行する
		ii $found
	}
	elseif ($result -eq 'Cancel'){
		exit
	}
	
	echo ''
	
	} else {
	# コンソールに出力
	echo ''
	Write-Host 'Not found (☝゜д゜)☝' -ForeGroundColor Red
	echo ''
	
	# ダイアログに出力
	# ダイアログに表示する内容
	$text = "Not found (☝゜д゜)☝";
	# ダイアログのタイトル
	$caption = "ないよー";
	# ダイアログのボタン
	$buttonsType_notFound = "OK";
	# [ないよー]ダイアログを表示
	$result2 = [System.Windows.Forms.MessageBox]::Show($text, $caption, $buttonsType_notFound, "Warning");
	$result2

}
