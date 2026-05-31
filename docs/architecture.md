# Architecture

This lab is based on a dedicated Microsoft Entra ID tenant used only for learning and portfolio documentation.

## High-Level Design

The lab focuses on cloud identity administration.

Main components:

- Microsoft Entra ID tenant
- Cloud-only users
- Security groups
- Built-in Entra admin roles
- Security Defaults
- App registration
- Microsoft Graph permissions
- Audit and sign-in logs

## Design Goals

The design follows these principles:

- avoid using production, school or employer tenants
- keep the lab cloud-only for Phase 1
- apply least privilege
- avoid unnecessary Azure resources
- avoid pay-as-you-go resources
- document all configuration through screenshots and markdown notes

## Tenant Model

The tenant contains:

- regular cloud users
- lab security groups
- one limited admin user
- one internal app registration

No Azure virtual machines, databases, VPN gateways or paid infrastructure resources are required for this phase.
