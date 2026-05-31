# Lessons Learned

## Azure Subscription Owner Is Not Always Tenant Administrator

One important lesson is that being Owner of an Azure subscription does not automatically mean being Global Administrator of the Microsoft Entra tenant.

This was observed with an education subscription linked to an external organization tenant.

## Dedicated Lab Tenant Is Better

A dedicated lab tenant avoids risks related to school or employer environments.

It also makes documentation safer and easier to publish.

## Security Defaults Are Useful for Small Labs

Security Defaults provide a simple baseline without requiring advanced Conditional Access configuration.

## Least Privilege Applies to Users and Applications

Least privilege should be applied to:

- admin users
- security groups
- app registrations
- Microsoft Graph permissions

## Logs Are Important Evidence

Audit logs and sign-in logs provide proof that identity operations were performed and can be reviewed later.
