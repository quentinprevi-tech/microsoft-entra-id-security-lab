# Security Notes

This document lists the main security practices followed in the lab.

## Tenant Isolation

The lab uses a dedicated tenant.

Production, school and employer tenants are not used for the documented configuration.

## Data Masking

Before publishing screenshots, the following information is masked:

- personal email addresses
- tenant IDs
- subscription IDs
- app/client IDs
- object IDs
- public IP addresses
- request IDs
- correlation IDs
- generated domains containing personal identifiers

## Least Privilege

The lab avoids unnecessary privileged access.

Charlie User is assigned Groups Administrator instead of Global Administrator.

The app registration receives read-only Microsoft Graph permissions.

## Cost Control

No Azure virtual machines, databases, VPN gateways or paid infrastructure resources are required for Phase 1.

The lab focuses on Entra ID identity management and security configuration.
