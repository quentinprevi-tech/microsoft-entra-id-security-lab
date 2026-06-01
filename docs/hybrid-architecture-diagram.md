# Hybrid Cloud Sync Architecture Diagram

This diagram summarizes the hybrid identity flow between the on-premises Active Directory lab and Microsoft Entra ID.

```mermaid
flowchart LR
    subgraph OnPrem["On-premises lab / Proxmox"]
        AD["SRV-AD01<br>AD DS / DNS<br>homelab.local<br>10.10.20.10"]
        OU["OU: Cloud-Sync-Lab<br>Hybrid Alice<br>Hybrid Bob"]
        SYNC["SRV-SYNC01<br>Microsoft Entra Provisioning Agent<br>10.10.20.20"]
        GMSA["gMSA<br>provAgentgMSA"]
        FW["OPNsense Firewall<br>Outbound 80 / 443 / 5671"]
    end

    subgraph Cloud["Microsoft Entra ID"]
        CLOUDSYNC["Cloud Sync Configuration<br>Status: Healthy"]
        USERS["Synced hybrid users<br>Hybrid Alice<br>Hybrid Bob"]
        PHS["Password Hash Sync"]
    end

    AD --> OU
    OU --> SYNC
    GMSA --> SYNC
    SYNC --> FW
    FW --> CLOUDSYNC
    CLOUDSYNC --> USERS
    CLOUDSYNC --> PHS

    TLS["TLS 1.2 / Schannel / .NET Strong Crypto fix"]
    TLS --> SYNC
```

## Key Points

- The synchronization scope is limited to the `Cloud-Sync-Lab` OU.
- The Microsoft Entra Provisioning Agent runs on `SRV-SYNC01`.
- The agent uses a gMSA named `provAgentgMSA`.
- Password hash synchronization is enabled.
- Outbound firewall access is restricted to required web and Entra sync ports.
- A TLS 1.2 / Schannel / .NET Strong Crypto fix was required to resolve the initial WebSocket issue.
