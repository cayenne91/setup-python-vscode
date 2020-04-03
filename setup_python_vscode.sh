# script assumes that you have already cloned the project repo from github and created the venv
# i.e you have already run the 'make .venv' cmd

# installations
brew list jq > /dev/null 2>&1 || brew install jq  # needed as cmd line tool for editing json
brew list moreutils > /dev/null 2>&1 || brew install moreutils  # needed for sponge to handle modified files

cd $1
vs_code=".vscode"
settings="settings.json"
path_to_settings=$vs_code/$settings

# check vscode folder exists and create if not
if [ ! -d $vs_code/ ];
then
    echo "Directory $vs_code/ for this project DOES NOT exist. Creating..." && mkdir $vs_code/
fi

# check settings.json exists and create if not
if [ ! -f $vs_code/$settings ];
then
    echo "$settings for this project DOES NOT exist. Creating..." && echo "{}" > $vs_code/$settings
fi

# jq queries
python_python_path='."python.pythonPath" |= ".venv/bin/python"'
python_testing_auto_test_discover_on_save_enabled='."python.testing.autoTestDiscoverOnSaveEnabled" |= true'
python_testing_pytest_enabled='."python.testing.pytestEnabled" |= true'
python_testing_unittest_enabled='."python.testing.unittestEnabled" |= false'
python_testing_nosetests_enabled='."python.testing.nosetestsEnabled" |= false'

# update/add keys in settings.json
echo "adding or updating key values in $settings"
jq "$python_python_path" $vs_code/$settings | sponge $vs_code/$settings | echo "$python_python_path"
jq "$python_testing_auto_test_discover_on_save_enabled" $vs_code/$settings | sponge $vs_code/$settings | echo "$python_testing_auto_test_discover_on_save_enabled"
jq "$python_testing_pytest_enabled" $vs_code/$settings | sponge $vs_code/$settings | echo "$python_testing_pytest_enabled"
jq "$python_testing_unittest_enabled" $vs_code/$settings | sponge $vs_code/$settings | echo "$python_testing_unittest_enabled"
jq "$python_testing_nosetests_enabled" $vs_code/$settings | sponge $vs_code/$settings | echo "$python_testing_nosetests_enabled"

# add PYTHONPATH to venv;
echo "export PYTHONPATH=." >> $2 | echo "PYTHONPATH environment variable added to $2 script"
