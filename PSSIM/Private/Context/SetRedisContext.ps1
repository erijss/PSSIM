function PSSIM.Context.SetRedisContext {
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

        $redis = @{}

        $redis.Folder = $config | PSSIM.Functions.FindJsonPath -JsonPath "redis.folder" | PSSIM.Helpers.GetValue
        $redis.Version = $config | PSSIM.Functions.FindJsonPath -JsonPath "redis.version" | PSSIM.Helpers.GetValue

        $PSSIM.Context.Redis = $redis
    }
}
