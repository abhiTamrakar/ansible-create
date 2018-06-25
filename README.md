## ansible-create
This is an ansible playbook that helps creating a playbook and its directory structure.

### usage

#### defaults
```
playbook_path: ~/default
playbook_user: current user
playbook_group: current user
copy_default: no
ansible_directories:
 * defaults
 * templates
 * group_vars
 * host_vars
 * roles
 * inventory
 * files
roles_directories:
 * defaults
 * templates
 * files
 * tasks
 * meta
 * handlers
# define extra role and include a default one
extras:
 * common
```

#### To create an ansible playbook with some name and few roles
`
ansible-playbook ansible-create.yml -e 'playbook_path=/tmp/app' -e '{"extras": [databases, application, monitoring]}'
`

#### To create an ansible playbook with defaults.
`ansible-playbook ansible-create.yml`

#### The default directory structure
```
/home/tamrakar/default/
├── defaults
├── files
├── group_vars
├── host_vars
├── inventory
├── roles
│   └── common
│       ├── defaults
│       ├── files
│       ├── handlers
│       ├── meta
│       ├── tasks
│       └── templates
└── templates
```
