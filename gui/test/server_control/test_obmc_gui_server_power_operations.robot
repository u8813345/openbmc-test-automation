*** Settings ***

Documentation   Test OpenBMC GUI "Server power operation" sub-menu of
...             "Server control".

Resource        ../../lib/resource.robot

Test Teardown   Close Browser


*** Variables ***

${xpath_power_indicator_bar}     //*[@id='power-indicator-bar']
${xpath_shutdown_button}         //button[contains(text(), "Shut down")]
${xpath_reboot_button}           //button[contains(text(), "Reboot")]
${xpath_power_on_button}         //button[contains(text(), "Power on")]

*** Test Cases ***

Verify System State At Power Off
    [Documentation]  Verify system state at power off.
    [Tags]  Verify_System_State_At_Power_Off
    [Setup]  Setup For Test Execution  ${OBMC_PowerOff_state}

    Element Should Contain  ${xpath_power_indicator_bar}  Off


Verify BMC IP In Server Power Operation Page
    [Documentation]  Verify BMC IP in server power operation page.
    [Tags]  Verify_BMC_IP_In_Server_Power_Operation_Page
    [Setup]  Setup For Test Execution  ${OBMC_PowerOff_state}

    Element Should Contain  ${xpath_power_indicator_bar}  ${OPENBMC_HOST}


Verify Shutdown Button At Power Off
    [Documentation]  Verify that shutdown button is not present at power Off.
    [Tags]  Verify_Shutdown_Button_At_Power_Off
    [Setup]  Setup For Test Execution  ${OBMC_PowerOff_state}

    Element Should Not Be Visible  ${xpath_shutdown_button}


Verify Reboot Button At Power Off
    [Documentation]  Verify that reboot button is not present at power Off.
    [Tags]  Verify_Reboot_Button_At_Power_Off
    [Setup]  Setup For Test Execution  ${OBMC_PowerOff_state}

    Element Should Not Be Visible  ${xpath_reboot_button}


Verify Power On Button At Power Off
    [Documentation]  Verify presence of "Power On" button at power off.
    [Tags]  Verify_Power_On_Button_At_Power_Off
    [Setup]  Setup For Test Execution  ${OBMC_PowerOff_state}

    Element Should Be Visible  ${xpath_power_on_button}


Verify System State At Power On
    [Documentation]  Verify system state at power on.
    [Tags]  Verify_System_State_At_Power_On
    [Setup]  Setup For Test Execution  ${obmc_PowerRunning_state}

    Element Should Contain  ${xpath_power_indicator_bar}  Running


Verify Shutdown Button At Power On
    [Documentation]  Verify that shutdown button is present at power on.
    [Tags]  Verify_Shutdown_Button_At_Power_On
    [Setup]  Setup For Test Execution  ${obmc_PowerRunning_state}

    Element Should Be Visible  ${xpath_shutdown_button}


Verify Reboot Button At Power On
    [Documentation]  Verify that reboot button is present at power on.
    [Tags]  Verify_Reboot_Button_At_Power_On
    [Setup]  Setup For Test Execution  ${obmc_PowerRunning_state}

    Element Should Be Visible  ${xpath_reboot_button}


*** Keywords ***

Setup For Test Execution
    [Documentation]  Do setup tasks for test case.
    [Arguments]  ${obmc_required_state}

    # Description of argument(s):
    # obmc_required_state  The OpenBMC state which is required for the test.

    Test Setup Execution  ${obmc_required_state}
    Wait Until Page Does Not Contain Element  ${xpath_refresh_circle}
    Click Element  ${xpath_select_server_control}
    Wait Until Page Does Not Contain Element  ${xpath_refresh_circle}
    Click Element  ${xpath_select_server_power_operations}
    Wait Until Page Contains  Server power operations
