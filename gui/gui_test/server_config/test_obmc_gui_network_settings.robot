*** Settings ***

Documentation   Test OpenBMC GUI "Network settings" sub-menu of
...             "Server configuration".

Resource        ../../lib/resource.robot

Suite Setup     Suite Setup Execution
Suite Teardown  Close Browser

*** Variables ***

${xpath_network_setting_heading}  //h1[text()="Network settings"]
${xpath_interface}                //h2[text()="Interface"]
${xpath_system}                   //h2[text()="System"]
${xpath_static_ipv4}              //h2[text()="Static IPv4"]
${xpath_static_dns}               //h2[text()="Static DNS"]
${xpath_hostname_input}           //*[@data-test-id="networkSettings-input-hostname"]
${xpath_network_save_settings}    //button[@data-test-id="networkSettings-button-saveNetworkSettings"]
${xpath_default_gateway_input}    //*[@data-test-id="networkSettings-input-gateway"]
${xpath_mac_address_input}        //*[@data-test-id="networkSettings-input-macAddress"]
${xpath_static_input_ip0}         //*[@data-test-id="networkSettings-input-staticIpv4-0"]
${xpath_add_static_ip}            //button[contains(text(),"Add static IP")]
${xpath_setting_success}          //*[contains(text(),"Successfully saved network settings.")]
${xpath_add_dns_server}           //button[contains(text(),"Add DNS server")]

*** Test Cases ***

Verify Navigation To Network Settings Page
    [Documentation]  Verify navigation to network settings page.
    [Tags]  Verify_Navigation_To_Network_Settings_Page

    Page Should Contain Element  ${xpath_network_setting_heading}


Verify Existence Of All Sections In Network Settings Page
    [Documentation]  Verify existence of all sections in network settings page.
    [Tags]  Verify_Existence_Of_All_Sections_In_Network_Settings_Page

    Page Should Contain Element  ${xpath_interface}
    Page Should Contain Element  ${xpath_system}
    Page Should Contain Element  ${xpath_static_ipv4}
    Page Should Contain Element  ${xpath_static_dns}


Verify Existence Of All Buttons In Network Settings Page
    [Documentation]  Verify existence of all buttons in network settings page.
    [Tags]  Verify_Existence_Of_All_Buttons_In_Network_Settings_Page

    Page Should Contain Element  ${xpath_add_static_ip}
    Page Should Contain Element  ${xpath_add_dns_server}


Verify Network Settings From Server Configuration
    [Documentation]  Verify ability to select "Network Settings" sub-menu option
    ...  of "Server Configuration".
    [Tags]  Verify_Network_Settings_From_Server_Configuration

    Page Should Contain  IP address


Verify Hostname Text Configuration
    [Documentation]  Verify hostname text is configurable from "network settings"
    ...  sub-menu.
    [Tags]  Verify_Hostname_Text_Configuration

    Input Text  ${xpath_hostname_input}  witherspoon1
    Click Button  ${xpath_network_save_settings}
    Wait Until Page Contains Element  ${xpath_setting_success}  timeout=10
    Element Should Be Disabled  ${xpath_network_save_settings}
    Click Element  ${xpath_select_refresh_button}
    Wait Until Keyword Succeeds  15 sec  5 sec  Textfield Should Contain  ${xpath_hostname_input}
    ...  witherspoon1


Verify Default Gateway Editable
    [Documentation]  Verify default gateway text input allowed from "network
    ...  settings".
    [Tags]  Verify_Default_Gateway_Editable

    Wait Until Page Contains Element  ${xpath_default_gateway_input}
    Input Text  ${xpath_default_gateway_input}  10.6.6.7


Verify MAC Address Editable
    [Documentation]  Verify MAC address text input allowed from "network
    ...  settings".
    [Tags]  Verify_MAC_Address_Editable

    Wait Until Page Contains Element  ${xpath_mac_address_input}
    Input Text  ${xpath_mac_address_input}  AA:E2:84:14:28:79


Verify Static IP Address Editable
    [Documentation]  Verify static IP address is editable.
    [Tags]  Verify_Static_IP_Address_Editable

    ${exists}=  Run Keyword And Return Status  Wait Until Page Contains Element  ${xpath_static_input_ip0}
    Run Keyword If  '${exists}' == '${False}'
    ...  Click Element  ${xpath_add_static_ip}

    Input Text  ${xpath_static_input_ip0}  ${OPENBMC_HOST}


*** Keywords ***

Suite Setup Execution
   [Documentation]  Do test case setup tasks.

    Launch Browser And Login GUI
    Click Element  ${xpath_server_configuration}
    Click Element  ${xpath_select_network_settings}
    Wait Until Keyword Succeeds  30 sec  10 sec  Location Should Contain  network-settings

