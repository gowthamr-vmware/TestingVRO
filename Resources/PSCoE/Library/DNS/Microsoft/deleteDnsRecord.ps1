###
# #%L
# dns
# %%
# Copyright (C) 2020 VMWARE
# %%
# This program is licensed under Technical Preview License by VMware.
# VMware shall own and retain all right, title and interest in and to the Intellectual Property Rights in the Technology Preview Software.
# ALL RIGHTS NOT EXPRESSLY GRANTED IN LICENSE ARE RESERVED TO VMWARE.
# VMware is under no obligation to support the Technology Preview Software in any way or to provide any Updates to Licensee.
# You should have received a copy of the Technical Preview License along with this program.  If not, see 
# <https://flings.vmware.com/vrealize-build-tools/license>
# #L%
###
# Remove a machine from DNS
ipconfig /flushdns

{{if type|equals>A}}
$ip = $null
$recordCount = @([System.Net.Dns]::GetHostAddresses("{{name}}.{{zone}}")).Count
try {$ip = @([System.Net.Dns]::GetHostAddresses("{{name}}.{{zone}}") | Where-Object { $_.AddressFamily -eq 'InterNetwork' } | Select-Object -Expand IPAddressToString)[0] } catch {write "Address not found: {{name}}.{{zone}}"}

if($recordCount -gt 1) {
	dnscmd {{server}} /recorddelete {{zone}} {{name}} {{type}} {{deleteIpAddress}} /f; echo "Exit Code: $LastExitCode."; if($LastExitCode){ throw "Cannot delete DNS record." };
} elseif($ip) {
	dnscmd {{server}} /recorddelete {{zone}} {{name}} {{type}} $ip /f; echo "Exit Code: $LastExitCode."; if($LastExitCode){ throw "Cannot delete DNS record." };
} else {
	echo "Exit Code: 9701.";
}
{{else}}
dnscmd {{server}} /recorddelete {{zone}} {{name}} {{type}} /f; echo "Exit Code: $LastExitCode."; if($LastExitCode){ throw "Cannot delete DNS record." };
{{/if}}


ipconfig /flushdns