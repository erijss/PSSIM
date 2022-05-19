function PSSIM.Context.SetSqlServerContext {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
    process {
        $config =  $PSSIM.Configuration

        $sqlserver = @{}


        $sqlserver.Edition = $config | PSSIM.Functions.FindJsonPath -JsonPath "sqlserver.edition" | PSSIM.Helpers.GetValue
        $sqlserver.Version = $config | PSSIM.Functions.FindJsonPath -JsonPath "sqlserver.version" | PSSIM.Helpers.GetValue

        $sqlserver.InstanceServer = $config | PSSIM.Functions.FindJsonPath -JsonPath "sqlserver.instance.server" | PSSIM.Helpers.GetValue
        $sqlserver.InstanceName = $config | PSSIM.Functions.FindJsonPath -JsonPath "sqlserver.instance.name" | PSSIM.Helpers.GetValue
        if ( $sqlserver.InstanceName -eq "" ) {
            $sqlserver.Instance = $sqlserver.InstanceServer
        }
        else {
            $sqlserver.Instance = $sqlserver.InstanceServer + "\" + $sqlServer.InstanceName
        }

        $admin = @{}
        $admin.Username = $config | PSSIM.Functions.FindJsonPath -JsonPath "sqlserver.administrator.username" | PSSIM.Helpers.GetValue
        $admin.Password = $config | PSSIM.Functions.FindJsonPath -JsonPath "sqlserver.administrator.password" | PSSIM.Helpers.GetValue
        $sqlserver.Administrator = $admin

        $PSSIM.Context.SqlServer = $sqlserver
    }
}


