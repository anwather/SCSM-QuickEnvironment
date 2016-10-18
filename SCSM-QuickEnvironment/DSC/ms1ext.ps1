Configuration Main
{

Param ( [string] $nodeName, [pscredential] $DomainAdminCredential )

Import-DscResource -ModuleName PSDesiredStateConfiguration,xNetworking,xComputerManagement,xSQLServer

Node $nodeName
  {
	LocalConfigurationManager
        {
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RebootNodeIfNeeded = $true
            ActionAfterReboot = 'ContinueConfiguration'
            AllowModuleOverwrite = $true

        }

	xDNSServerAddress DnsServer_Address
        {
            Address = $Node.DNSServerAddress
            InterfaceAlias = $Node.InterfaceAlias
            AddressFamily = $Node.AddressFamily
        }  
	  
	xComputer AddtoDomain
		{
			Name = $env:ComputerName
			DomainName = $Node.DomainName
			Credential = $DomainAdminCredential
			DependsOn = "[xDNSServerAddress]DNSServer_Address"
		} 
  }
}