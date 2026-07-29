*** Settings ***
Documentation           Elementos e ações da página de cadastro

Library     Browser
Resource    ../env.resource

*** Keywords ***
Go to signup page

    Go To       ${BASE_URL}/signup

    # Checkpoint, pontos de validação do fluxo
    # Aguarda até um determinado elemento ficar visível
    Wait For Elements State         css=h1          visible     5
    # Valida que o texto do elemento selecionado é igual ao que digitamos aqui
    Get Text                        css=h1          equal       Faça seu cadastro

    Take Screenshot

Submit signup form
    [Arguments]         ${user}

    #Preenche campos de texto
    Fill Text                       css=input[name=name]         ${user}[name]
    Fill Text                       css=input[name=email]        ${user}[email]
    Fill Text                       css=input[name=password]     ${user}[password]

    Take Screenshot

    #Realiza clique em um determinado elemento
    Click                           css=button[type=submit] >> text=Cadastrar
