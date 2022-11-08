*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                              http://www.amazon.com.br
${MENU_ELETRONICOS}                 //a[@href='/Eletronicos-e-Tecnologia/b/?ie=UTF8&node=16209062011&ref_=nav_cs_electronics'][contains(.,'Eletrônicos')]
${TITLE_ELETRONICOS}                //span[@class='a-size-base a-color-base apb-browse-refinements-indent-1 a-text-bold'][contains(.,'Eletrônicos e Tecnologia')] 
${TEXTBOX_PESQUISAR}                twotabsearchtextbox
${BUTTON_PESQUISAR}                 nav-search-submit-button
${BUTTON_ADD_AO_CARRINHO}           //input[contains(@name,'submit.add-to-cart')]
${IMG_RESULTADO_PESQUISA}           //img[@data-image-index='1']
${BUTTON_CARRINHO}                  nav-cart-count
${BUTTON_EXCLUIR_PRODUTO_CARRINHO}  //input[@value='Excluir']
${TEXT_CARRINHO_VAZIO}              //h1[@class='a-spacing-mini a-spacing-top-base'][contains(.,'Seu carrinho de compras da Amazon está vazio.')]

*** Keywords ***
Abrir o navegador
    Open Browser    browser=chrome
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser

Acessar a home page do site Amazon.com.br
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}

Entrar no menu "Eletrônicos"
    Click Element    locator=${MENU_ELETRONICOS}

Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains    text=${FRASE}
    Wait Until Element Is Visible    locator=${TITLE_ELETRONICOS}

Verificar se o título da página fica "${TITULO}" 
    Title Should Be    title=${TITULO}

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=//a[contains(@aria-label,'${NOME_CATEGORIA}')]

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa     
    Input Text    locator=${TEXTBOX_PESQUISAR}    text=${PRODUTO} 

Clicar no botão de pesquisa   
    Click Element    locator=${BUTTON_PESQUISAR}

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Wait Until Element Is Visible    locator=(//span[contains(.,'${PRODUTO}')])[2]  
    
#  GHERKIN STEPS
Dado que estou na home page da Amazon.com.br 
    Acessar a home page do site Amazon.com.br
    Verificar se o título da página fica "Amazon.com.br | Tudo pra você, de A a Z."

Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"

Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o título da página fica "Eletrônicos e Tecnologia | Amazon.com.br"

E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"

E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"

Quando pesquisar pelo produto "Xbox Series S"    
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa

Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    Verificar se o título da página fica "Amazon.com.br : Xbox Series S"

E um produto da linha "Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"

Adicionar o produto "Console Xbox Series S" no carrinho
    Click Image    locator=${IMG_RESULTADO_PESQUISA}
    Wait Until Element Is Visible    locator=${BUTTON_ADD_AO_CARRINHO}
    Click Element    locator=${BUTTON_ADD_AO_CARRINHO}

Verificar se o produto "${PRODUTO}" foi adicionado com sucesso
     Click Element    locator=${BUTTON_CARRINHO}
     Element Should Be Visible    locator=//span[@class='a-truncate-cut'][contains(.,'${PRODUTO}')]

Remover o produto "${PRODUTO}" do carrinho
    Element Should Be Visible    locator=//span[@class='a-truncate-cut'][contains(.,'${PRODUTO}')]
    Click Button    locator=${BUTTON_EXCLUIR_PRODUTO_CARRINHO}
    

Verificar se o carrinho fica vazio    
    Wait Until Element Is Visible    locator=${TEXT_CARRINHO_VAZIO}
    Element Should Be Visible    locator=${TEXT_CARRINHO_VAZIO}

Quando adicionar o produto "Console Xbox Series S" no carrinho
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"
    Adicionar o produto "Console Xbox Series S" no carrinho

Então o produto "${PRODUTO}" deve ser mostrado no carrinho
    Verificar se o produto "${PRODUTO}" foi adicionado com sucesso

E existe o produto "Console Xbox Series S" no carrinho
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"
    Adicionar o produto "Console Xbox Series S" no carrinho
    Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso
    
Quando remover o produto "Console Xbox Series S" do carrinho
    Remover o produto "Console Xbox Series S" do carrinho    

Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio
