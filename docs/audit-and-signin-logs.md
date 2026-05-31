# Audit and Sign-in Logs

This document describes the log review performed in the lab.

## Sign-in Logs

Sign-in logs were reviewed to validate authentication activity.

Observed examples include successful sign-ins to:

- Azure Portal
- Microsoft Azure Signup
- Microsoft Graph

Sensitive values such as IP addresses, user principal names, request IDs and resource IDs are masked in screenshots.

## Audit Logs

Audit logs were reviewed to validate administrative changes.

Observed events include:

- Add application
- Add service principal
- Update application
- Add delegated permission grant
- Add app role assignment to service principal
- Consent to application
- Add member to role

These logs demonstrate that Microsoft Entra records identity and application management activity.

## Value for Administration

Audit and sign-in logs are useful for:

- troubleshooting authentication issues
- verifying administrative changes
- investigating suspicious activity
- documenting security operations
