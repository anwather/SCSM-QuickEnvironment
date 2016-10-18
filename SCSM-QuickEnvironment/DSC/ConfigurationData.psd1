@{
	AllNodes = @(
       @{
            NodeName="*"
            RetryCount = 30
            RetryIntervalSec = 30
			PSDscAllowDomainUser = $true
			PSDscAllowPlainTextPassword = $true			
         },

		@{
			NodeName = 'SCSM-DC01'
			PSDscAllowDomainUser = $true
			PSDscAllowPlainTextPassword = $true
			DomainName = 'scsm.lab'
            DomainNetBIOSName = 'scsm'
			DNSServerAddress = '127.0.0.1'
            InterfaceAlias = 'Ethernet'
            AddressFamily = 'IPv4'
		},
		@{
			NodeName = 'SCSM-MS01'
			PSDscAllowDomainUser = $true
			PSDscAllowPlainTextPassword = $true
			DomainName = 'scsm.lab'
            DomainNetBIOSName = 'scsm'
			DNSServerAddress = '10.6.0.4'
            InterfaceAlias = 'Ethernet'
            AddressFamily = 'IPv4'
			SqlSourcePath = "C:\SQLServer_12.0_Full"
			SysAdminAccounts = 'scsm\s-admin'
		}
	)
}

