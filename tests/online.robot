*** Settings ***
Documentation       Online

Resource        ../resources/base.resource

*** Test Cases ***
Webapp deve estar online
#Chamando a função de acessar o navegador que foi definido em base.robot
    Start Session
    Get Title       equal         Mark85 by QAx

    Sleep       2