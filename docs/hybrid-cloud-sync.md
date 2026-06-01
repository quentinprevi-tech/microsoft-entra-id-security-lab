# Hybrid Identity with Microsoft Entra Cloud Sync

## Objective

This phase documents a hybrid identity lab between an on-premises Active Directory domain and Microsoft Entra ID using Microsoft Entra Cloud Sync.

The objective was to synchronize only a dedicated test OU from Active Directory to Microsoft Entra ID, while keeping the scope controlled and safe for a lab environment.

## Architecture

Architecture diagram: [Hybrid Cloud Sync Architecture Diagram](hybrid-architecture-diagram.md)

Flow:

- SRV-AD01 / Active Directory / DNS
- SRV-SYNC01 / Microsoft Entra Provisioning Agent
- Microsoft Entra ID

## Lab Components

### SRV-AD01

- Role: Active Directory Domain Services and DNS
- Domain: homelab.local
- IP address: 10.10.20.10
- Network: SERVERS / OPT1

### SRV-SYNC01

- Role: Microsoft Entra Provisioning Agent server
- OS: Windows Server 2022
- Domain joined: homelab.local
- IP address: 10.10.20.20
- DNS server: 10.10.20.10
- Network: SERVERS / OPT1

## Active Directory Scope

A dedicated OU was created for Cloud Sync:

OU=Cloud-Sync-Lab,DC=homelab,DC=local

The following test users were created in this OU:

- Hybrid Alice
- Hybrid Bob

Only this OU was selected in the Cloud Sync scoping filters. The full Active Directory domain was not synchronized.

## Cloud Sync Configuration

The Microsoft Entra Provisioning Agent was installed on SRV-SYNC01.

A group managed service account was created by the setup wizard:

homelab.local\provAgentgMSA

Cloud Sync configuration:

- Direction: Active Directory to Microsoft Entra ID
- Password hash synchronization: enabled
- Scope: selected organizational units only
- Selected OU: OU=Cloud-Sync-Lab,DC=homelab,DC=local
- Agent: SRV-SYNC01.homelab.local
- Final status: healthy

## Validation

Before relying on scheduled synchronization, on-demand provisioning was tested.

The following users were successfully provisioned from Active Directory to Microsoft Entra ID:

- Hybrid Alice
- Hybrid Bob

The provisioning logs showed successful Create actions from Active Directory to Microsoft Entra ID.

## Troubleshooting: WebSocket / TLS Issue

During the first tests, on-demand provisioning failed with timeout errors.

The agent was visible as active in Microsoft Entra ID, but provisioning still failed. Local logs showed repeated WebSocket errors:

- Web socket failed to connect
- Error while establishing web socket connection
- An existing connection was forcibly closed by the remote host
- ConnectorSignalingWebSocket
- System.NullReferenceException

Troubleshooting checks performed:

- AD connectivity from SRV-SYNC01 to SRV-AD01
- DNS resolution
- Microsoft endpoint HTTPS reachability
- OPNsense firewall rules
- WinHTTP proxy settings
- OPNsense IDS/IPS
- Squid / SSL inspection
- Zenarmor / Sensei
- Cloud Sync scope
- Distinguished names of AD users
- Agent services

The issue was resolved by forcing TLS 1.2 for the Windows and .NET Framework stack used by the Microsoft Entra Provisioning Agent.

The fix included:

- Disabling TLS 1.3 client-side through Schannel
- Explicitly enabling TLS 1.2 client-side through Schannel
- Enabling SchUseStrongCrypto for .NET Framework 4.x
- Rebooting SRV-SYNC01
- Restarting the provisioning agent services

After this change, the WebSocket communication succeeded and on-demand provisioning worked.

## Cloud Sync Quarantine

After the successful fix, the Cloud Sync configuration briefly showed a quarantine status with:

HybridIdentityServiceNoActiveAgents

This likely happened because SRV-SYNC01 or the provisioning agent services were not running when Microsoft Entra attempted scheduled synchronization.

After the VM and services were running again, the Cloud Sync configuration returned to a healthy state.

## Firewall Hardening

During troubleshooting, a temporary broad firewall rule was used for SRV-SYNC01.

After validation, the rule was removed or disabled.

Final OPNsense rules were hardened so that SRV-SYNC01 only had targeted outbound access:

- SRV_SYNC01 to WEB_PORTS
- SRV_SYNC01 to ENTRA_SYNC_PORTS

Alias examples:

- WEB_PORTS: TCP 80, 443
- ENTRA_SYNC_PORTS: TCP 443, 5671

The broad OPT1 net to any any troubleshooting rule was not kept as a permanent rule.

## Final Validated State

Final state:

- SRV-SYNC01 joined to homelab.local
- Microsoft Entra Provisioning Agent installed
- Agent visible as active in Microsoft Entra ID
- Cloud Sync configuration healthy
- Scope limited to Cloud-Sync-Lab
- Hybrid Alice synchronized successfully
- Hybrid Bob synchronized successfully
- Password hash synchronization enabled
- TLS 1.2 / Schannel / .NET Strong Crypto fix applied
- OPNsense firewall rules hardened
- Proxmox snapshot created after successful validation

Snapshot name:

srv-sync01-cloudsync-healthy

## Screenshot Evidence

### Active Directory test OU

![Active Directory Cloud Sync lab OU users](../screenshots/ad-cloud-sync-lab-ou-users.png)

### Cloud Sync configuration healthy

![Microsoft Entra Cloud Sync configuration healthy](../screenshots/entra-cloud-sync-configuration-healthy.png)

### Cloud Sync agent active

![Microsoft Entra Cloud Sync agent active](../screenshots/entra-cloud-sync-agent-active.png)

### Cloud Sync scoped OU filter

![Microsoft Entra Cloud Sync scoped OU filter](../screenshots/entra-cloud-sync-scope-ou.png)

### Successful user provisioning audit logs

![Microsoft Entra Cloud Sync audit success](../screenshots/ad-cloud-sync-lab-success.png)

### Hardened OPNsense firewall rules

![OPNsense SRV-SYNC01 firewall rules](../screenshots/opnsense-srv-sync01-firewall-rules.png)

## Security Notes

Sensitive information must be masked before publishing screenshots:

- Personal email addresses
- Tenant ID
- Subscription ID
- Source IDs
- Target IDs
- Object IDs
- External IP address
- onmicrosoft.com tenant domain if identifiable
- Request IDs
- Correlation IDs
- Transaction IDs

## Lessons Learned

This phase showed that a hybrid identity deployment is not only about installing an agent.

Important validation points included:

- Limiting synchronization scope
- Validating AD connectivity
- Checking DNS and HTTPS connectivity
- Reading local agent logs
- Distinguishing agent registration from real provisioning health
- Troubleshooting WebSocket communication issues
- Hardening temporary firewall rules after troubleshooting
- Documenting root cause and remediation

This troubleshooting process reflects real-world hybrid identity diagnostics.
