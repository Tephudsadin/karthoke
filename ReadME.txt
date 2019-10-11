run install pip
pip install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib robotframework robotframework-seleniumlibrary restinstance


runtestcaseRobot 
robot -d Result -t Report10 report.robot
robot -d Result -t Report12 report.robot
robot -d Result -t Report18 report.robot
robot -d Result -t Report22 report.robot

