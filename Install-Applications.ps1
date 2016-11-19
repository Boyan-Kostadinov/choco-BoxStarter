try {
	cinst DotNet3.5 -y

	cinst Launchy -y

	cinst TeamViewer -y
	cinst Dropbox -y
	cinst GoogleChrome -y

	cinst Kdiff3 -y
	cinst GitExtensions -y
	cinst JRE8 -y
	cinst VisualStudioCode -y
	cinst WebStorm -y
	cinst DataGrip -y
	cinst MSSQLServerManagementStudio2014Express -y

	# cinst OpenLiveWriter -y

	cinst K-LiteCodecPackMega -y
	cinst DisplayFusion -y

	cinst ConEmu -y
	cinst WebPI -y

	# cinst Office365Business -y
	# cinst VMWareWorkstation -y
	# cinst nodejs.install -y

	cinst nodejs.install -version 7.0.0 -y
	npm install -g angular-cli@latest

	if (Test-PendingReboot) { Invoke-Reboot }
}
catch {
	Write-ChocolateyFailure 'Installation Failed: ' $($_.Exception.ToString())
	throw
}

# Provide optional product key with: --installargs "/ProductKey YOURKEYHERE"
cinst VisualStudio2015Enterprise -y `
	-s "\\nas\Data\Applications\_Install\Programming\Chocolatey" `
	-packageParameters "--AdminFile http://bit.ly/win10boxstarter-vsadmin"

# ReSharper
cinst resharper-platform -y

Install-ChocolateyVsixPackage SpellChecker http://bit.ly/win10boxstarter-vs-spellchecker

#Install-ChocolateyVsixPackage SaveAllTheTime http://bit.ly/win10boxstarert-vs-saveallthetime
#Install-ChocolateyVsixPackage BuildOnSave https://bit.ly/win10boxstarert-vs-buildonsave

if (Test-PendingReboot) { Invoke-Reboot }