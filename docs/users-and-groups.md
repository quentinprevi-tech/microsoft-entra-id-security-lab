# Users and Groups

This document describes the cloud-only users and security groups created in the lab.

## Cloud Users

The following users were created:

- Alice User
- Bob User
- Charlie User

These users are cloud-only accounts.

They are not synchronized from on-premises Active Directory.

## Security Groups

The following security groups were created:

- GG-Lab-Users
- GG-Lab-IT-Admins
- GG-Lab-MFA-Required

All groups use assigned membership.

## Group Membership

### GG-Lab-Users

Members:

- Alice User
- Bob User
- Charlie User

Purpose:

General group for standard lab users.

### GG-Lab-IT-Admins

Members:

- Charlie User

Purpose:

Group representing users with limited IT administration responsibilities.

### GG-Lab-MFA-Required

Members:

- Alice User
- Bob User
- Charlie User

Purpose:

Group used to document an MFA/security baseline targeting model.

## Design Reasoning

Groups are used to separate identity management from individual user configuration.

This makes the environment easier to document, audit and extend later.
