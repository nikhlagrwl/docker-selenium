rem Calling node config generation script
call C:\opt\selenium\generate_node_config.bat

java %SE_JAVA_OPTS% -Dwebdriver.http.factory=jdk-http-client -jar C:\opt\selenium\selenium-server.jar --ext C:\opt\selenium\selenium-http-jdk-client.jar node --bind-host false --config %CONFIG_FILE% --log-level FINE --log C:\opt\selenium\assets\selenium.log