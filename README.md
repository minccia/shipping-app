<h2> Configurações </h2>

<ul>
  <li> Versão do Ruby Utilizada: Ruby 3.1.2 </li>
  <li> Versão do framework Rails: 7.0.4 </li>
  <li> Ferramenta para testes: Rspec </li>
  <li> Test driver: Capybara </li>
</ul>

<p>
  Antes de inicializar a aplicação, rode o comando 'rails db:seed' no seu terminal para popular o banco de dados com alguns models pré-cadastrados, sendo essencial para ver e testar as funcionalidades do sistema. Caso precise reiniciar o banco de dados, devido
  a dependência de alguns models associados, é necessário executar primeiro rails db:drop seguido de rails db:setup, para não enfrentar erros com foreign key constraints.
  Você terá acesso a dois logins de usuários, um comum e um administrador, na qual o administrador possui alguns acessos a mais do que o usuário comum. Ao clicar no botão 'Fazer Login' localizado na barra de navegação da página inicial, você poderá utilizar   as credenciais para se autenticar:
</p>

<p>
  <h3> Usuário comum </h3>
    <ul>
      <li> Email: common@sistemadefrete.com.br </li>
      <li> Senha: 1234567 </li>
    <ul>
</p>

<h3> Usuário administrador </h3>
    <ul>
      <li> Email: admin@sistemadefrete.com.br </li>
      <li> Senha: 1234567 </li>
    <ul>
</p>

<h2> Considerações </h2>
  - Não consegui implementar os motivos de atraso da ordem de serviço a tempo
  - Algumas coisas, principalmente em questão de validação, poderiam estar melhores, mas por falta de tempo tentei entregar as funcionalidades essenciais do sistema, e deixar a estética do site e pequenos detalhes para incrementar depois.

<h2> Specs do sistema </h2>
  <h4> Gems utilizadas: </h4>
  
    * FactoryBot: 
       Gem utilizada para automatizar o processo de população do banco de dados, simplificando as etapas de alguns testes e os deixando mais limpos.
  
    * Faker:
       Gem utilizada para criar dados 'falsos', associada com a FactoryBot é utilizada para gerar strings e números aleatórios que servem como valores dos atributos nas instâncias dos models.
  
    * Devise:
       Gem utilizada para gerenciar a autenticação dos usuários comuns e admins.
