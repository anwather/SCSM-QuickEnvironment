Configuration Main
{

Param ( [string]$nodeName,[pscredential]$AdminCredential )

Import-DscResource -ModuleName PSDesiredStateConfiguration,xActiveDirectory,xNetworking 

Node $nodeName
  {
	LocalConfigurationManager
        {
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RebootNodeIfNeeded = $true
            ActionAfterReboot = 'ContinueConfiguration'
            AllowModuleOverwrite = $true

        }

        WindowsFeature DNS 
        { 
            Ensure = "Present" 
            Name = "DNS"
        }

        WindowsFeature ADDS_Install 
        { 
            Ensure = 'Present' 
            Name = 'AD-Domain-Services' 
        } 

        WindowsFeature RSAT_AD_AdminCenter 
        {
            Ensure = 'Present'
            Name   = 'RSAT-AD-AdminCenter'
        }

        WindowsFeature RSAT_ADDS 
        {
            Ensure = 'Present'
            Name   = 'RSAT-ADDS'
        }

        WindowsFeature RSAT_AD_PowerShell 
        {
            Ensure = 'Present'
            Name   = 'RSAT-AD-PowerShell'
        }

        WindowsFeature RSAT_AD_Tools 
        {
            Ensure = 'Present'
            Name   = 'RSAT-AD-Tools'
        }

        WindowsFeature RSAT_Role_Tools 
        {
            Ensure = 'Present'
            Name   = 'RSAT-Role-Tools'
        }

	  xDNSServerAddress DnsServer_Address
        {
            Address = $Node.DNSServerAddress
            InterfaceAlias = $Node.InterfaceAlias
            AddressFamily = $Node.AddressFamily
            DependsOn = '[WindowsFeature]RSAT_AD_PowerShell'
        }      		

      xADDomain CreateForest 
        { 
            DomainName = $Node.DomainName            
            DomainAdministratorCredential = $AdminCredential
            SafemodeAdministratorPassword = $AdminCredential
            DomainNetbiosName = $Node.DomainNetBiosName
			DatabasePath = "C:\Windows\NTDS"
			LogPath = "C:\Windows\NTDS"
			SysvolPath = "C:\Windows\Sysvol"
			DependsOn = '[WindowsFeature]ADDS_Install','[WindowsFeature]DNS'
        }  
  }
}