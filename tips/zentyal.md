# Zentyal

## Zentyal components well known issue
- Virtualization Manager 7.0.1 and bridge: [1853](https://github.com/zentyal/zentyal/issues/1853) & [1868](https://github.com/zentyal/zentyal/issues/1868)
  - Workaround: use Zentyal as a VM in Proxmox

## Server

## Client
### Virtual Machine Manager
on your Linux Desktop use Virtual Machine Manager to manage VM on Zentyal
#### Hint
##### Password
`grep passwd /var/lib/zentyal/machines/<virtual machine name>/domain.xml`
