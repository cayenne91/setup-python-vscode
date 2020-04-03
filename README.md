# setup-python-vscode
scripts to setup python vscode intergrations for testing and debugging on a repo

expects two positional args passed in:
* the absolute or relative path including the root folder of the repo
* the absolute or relative path of the venv activate file

`./setup_python_vscode.sh "path/to/root/root-folder-of-repo" "path/to/venv/activate/script/activate-script"`

#### Important
Assumes that you use separate virtual environments for each project and have already cloned the repo and created the virtualenv
