*** Settings ***
Documentation       Cenários de testes do cadastro de usuários

#Library         FakerLibrary

Resource        ../resources/base.resource

#Antes de cada teste faz determinada ação
Test Setup      Start Session
#Depois que finaliza o teste faz uma determinada ação
Test Teardown   Take Screenshot

#DEFININDO VARIÁVEIS GLOBAIS
#*** Variables ***

#${name}                     Kesley de Lima
#${email}                    kesley@gmail.com
#${password}                 C@sa123456

*** Test Cases ***
Deve poder cadastrar um novo usuário

    #Utilizando a biblioteca faker, vamos gerar nomes aleatórios que serão armazenados,
    #na variável ${name} e será chamada no código, o mesmo para email.
    #${name}             FakerLibrary.Name
    #${email}            FakerLibrary.Free Email
    
    #Set Variable, serve para o sistema entender que o texto "C@sa123456" será atribuido
    #a variável password
    #${password}         Set Variable        C@sa123456
    #${name}             Set Variable        Kesley de Lima
    #${email}            Set Variable        kesley@gmail.com

    #Criando super variáveis
    ${user}         Create Dictionary       
    ...     name=Kesley de Lima
    ...     email=kesley@gmail.com      
    ...     password=C@sa123456  

    Remove user from database       ${user}[email]

    #Chamando a função de acessar o navegador que foi definido em base.robot
    #Start Session

    Go to signup page
    Submit signup form  ${user}
    Notice should be    Boas vindas ao Mark85, o seu gerenciador de tarefas.

    #Intervalo para executar a próxima ação
    Sleep       1


Não deve permitir o cadastro com email duplicado
    #Tags, serve para marcar o teste para futuramente executar somente os q pertencem a Tag
    [Tags]      dup

    ${user}         Create Dictionary       
    ...             name=Kesley Constantino
    ...             email=constantino@gmail.com   
    ...             password=C@sa123456      

    Remove user from database       ${user}[email]
    Insert user from database       ${user}

    #Start Session

    Go to signup page
    Submit signup form  ${user} 
    Notice should be    Oops! Já existe uma conta com o e-mail informado.
    
    Sleep       1

Campos obrigatórios

    [Tags]      required

    ${user}         Create Dictionary
    ...             name=${EMPTY}
    ...             email=${EMPTY}
    ...             password=${EMPTY}

    Go to signup page
    Submit signup form  ${user}

    Alert should be     Informe seu nome completo
    Alert should be     Informe seu e-email
    Alert should be     Informe uma senha com pelo menos 6 digitos

    Sleep       1

Não deve cadastrar com email incorreto
    [Tags]      inv_email

    ${user}         Create Dictionary       
    ...             name=Kesley Constantino
    ...             email=kesley.com.br  
    ...             password=C@sa123456      

    Go to signup page
    Submit signup form  ${user} 
    Alert should be     Digite um e-mail válido
    
    Sleep       1

Não deve cadastrar com senha muito curta
    [Tags]      temp

    @{password_list}     Create List     1   12  123     1234    12345

    FOR     ${password}     IN      @{password_list}
        ${user}         Create Dictionary
        ...             name=Lima Kesley
        ...             email=constantino@gmail.com
        ...             password=${password}

        Go to signup page
        Submit signup form  ${user}

        Alert should be     Informe uma senha com pelo menos 6 digitos

        Sleep       1

    END

