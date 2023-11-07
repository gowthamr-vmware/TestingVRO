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
# Add a machine to DNS
ipconfig /flushdns
dnscmd {{server}} /recordadd {{zone}} {{name}} {{if ptr}} /CreatePTR {{/if}} {{type}} {{ipAddress}}; echo "Exit Code: $LastExitCode."; if($LastExitCode){ throw "Add DNS Record failed." };
ipconfig /flushdns