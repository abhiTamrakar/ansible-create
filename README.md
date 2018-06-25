## ansible-create
This is an ansible playbook that helps creating a playbook and its directory structure.

### usage
#### To create an ansible playbook with some name and few roles
'''
ansible-playbook ansible-create.yml -e 'playbook_path=/tmp/app' -e '{"extras": [databases, application, monitoring]}'
'''

#### To create an ansible playbook with defaults.
ansible-playbook ansible-create.yml

#### The default directory structure
'''
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
'''
