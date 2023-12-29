rem Calling node config generation script
call C:\opt\generate_node_config.bat

echo "NODE CONFIG GENERATED"

start "NodeApp" node C:\high-scale-testing\screen_recorder\index.js
echo "Node process started"

java %SE_JAVA_OPTS% -Dwebdriver.http.factory=jdk-http-client -jar C:\opt\selenium\selenium-server.jar --ext C:\opt\selenium\selenium-http-jdk-client.jar node --bind-host false --config %CONFIG_FILE% --log-level FINE --log C:\opt\selenium\assets\selenium.log