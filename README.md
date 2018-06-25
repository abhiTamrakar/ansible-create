## create
This is an ansible playbook that helps creating a playbook and its directory structure.

### usage

#### defaults
| variable | default value |
|----------|:-------------:|
| playbook_path | ~/default |
| playbook_user |   current user |
| playbook_group |   current user |
| copy_default |   no |
| ansible_directories |   |
|  |  defaults |
|  |  templates |
|  |  group_vars |
|  |  host_vars |
|  |  roles |
|  |  inventory |
|  |  files |
| roles_directories |   |
|  |  defaults |
|  |  templates |
|  |  files |
|  |  tasks |
|  |  meta |
|  |  handlers |
| extras | common | 
>extras is defined for roles.

#### To create an ansible playbook with some name and few roles
`
ansible-playbook create.yml -e 'playbook_path=/tmp/app' -e '{"extras": [databases, application, monitoring]}'
`

#### To create an ansible playbook with defaults.
`ansible-playbook create.yml`

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

#### Worried about if ansible is installed! or the format for ansible-playbook. Use the script provided.
```
 $ ./mkplaybook.sh

        -h|--help           print this usage and exit
        -d|--dir            playbook dir (default current directory)
        -p|--playbook-path  destination path for new playbook with name (default is /home/tamrakar/myplaybook)
        -r|--roles          additional role directories to create (comma separated)
        -c|--copy-default   copy default files (main.yml)

        examples:
        mkplaybook.sh -h

        mkplaybook.sh -d /tmp/ansible-create -p /path/to/new-playbook -r 'database.,webservers,monitoring' -c

```
