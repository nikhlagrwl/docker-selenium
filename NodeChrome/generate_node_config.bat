setlocal enabledelayedexpansion

REM Function to extract short version
:short_version
set "__long_version=%~1"
set "__version_split="
for /f "tokens=1-2 delims=." %%a in ("!__long_version!") do (
    set "__version_split=%%a.%%b"
)
echo !__version_split!

REM Check and set CONFIG_FILE
if "%CONFIG_FILE%"=="" (
    set "FILENAME=C:\opt\selenium\config.toml"
) else (
    set "FILENAME=%CONFIG_FILE%"
)
echo %FILENAME%
REM Write to the file
(
    echo [events]
    echo publish = "tcp://%SE_EVENT_BUS_HOST%:%SE_EVENT_BUS_PUBLISH_PORT%"
    echo subscribe = "tcp://%SE_EVENT_BUS_HOST%:%SE_EVENT_BUS_SUBSCRIBE_PORT%"
) > "%FILENAME%"

REM Check and configure server
if "%SE_NODE_HOST%"=="" if "%SE_NODE_PORT%"=="" (
    echo Configuring server...
) else (
    echo [server] >> "%FILENAME%"
)

REM Set SE_NODE_HOST
if "%SE_NODE_HOST%"=="" (
    echo Setting up SE_NODE_HOST...
) else (
    echo host = "%SE_NODE_HOST%" >> "%FILENAME%"
)

REM Set SE_NODE_PORT
if "%SE_NODE_PORT%"=="" (
    echo Setting up SE_NODE_PORT...
) else (
    echo port = "%SE_NODE_PORT%" >> "%FILENAME%"
)

REM Write node configuration
(
    echo [node]
    REM Set grid url
    if "%SE_NODE_GRID_URL%"=="" (
        @REM echo Setting up SE_NODE_PORT...
    ) else (
        echo grid-url = "%SE_NODE_GRID_URL%"
    )
    echo session-timeout = "%SE_NODE_SESSION_TIMEOUT%"
    echo override-max-sessions = %SE_NODE_OVERRIDE_MAX_SESSIONS%
    echo detect-drivers = false
    echo drain-after-session-count = %DRAIN_AFTER_SESSION_COUNT:-%SE_DRAIN_AFTER_SESSION_COUNT%
    echo max-sessions = %SE_NODE_MAX_SESSIONS%
) >> "%FILENAME%"

REM Set default value if browser version is not found
if not defined SE_NODE_BROWSER_VERSION set "SE_NODE_BROWSER_VERSION=unknown"

REM Set SE_NODE_STEREOTYPE
if not defined SE_NODE_STEREOTYPE set "SE_NODE_STEREOTYPE={"browserName": "%SE_NODE_BROWSER_NAME%", "browserVersion": "%SE_NODE_BROWSER_VERSION%", "platformName": "Windows"}"
echo %SE_NODE_STEREOTYPE%

REM Write node driver configuration
(
    echo [[node.driver-configuration]]
    echo display-name = "%SE_NODE_BROWSER_NAME%"
    echo stereotype = '%SE_NODE_STEREOTYPE%'
    echo max-sessions = %SE_NODE_MAX_SESSIONS%
) >> "%FILENAME%"
