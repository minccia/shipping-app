<h2> Configurações </h2>

<ul>
  <li> Versão do Ruby Utilizada: Ruby 3.1.2 </li>
  <li> Versão do framework Rails: 7.0.4 </li>
  <li> Ferramenta para testes: Rspec </li>
  <li> HTTP Web Server: Puma </li>
  <li> Test driver: Capybara </li>
</ul>

<h2> Setup da aplicação </h2>
<p>
  Antes de inicializar a aplicação, rode o comando <code> bin/setup </code> para instalar todas as gems e dependências necessárias para o funcionamento
  adequado da aplicação. Em seguida, você pode subir a aplicação utilizando o comando <code> rails server </code> no seu terminal, que permitirá o acesso no endereço <code> https://localhost:3000/ </code> ou rodar todos os testes com o comando <code> rspec </code>.
  É recomendado rodar o comando <code> rails db:seed </code> no seu terminal para popular o banco de dados com alguns models pré-cadastrados. Caso precise reiniciar o banco de dados, devido a dependência de alguns models associados, é necessário executar o comando <code> rails db:reset </code> no seu terminal. Dessa forma, você terá acesso a dois logins de usuários, um comum e um administrador, na qual o administrador possui alguns acessos a mais do que o usuário comum. Ao clicar no botão <code> Fazer Login </code> localizado na barra de navegação da página inicial, você poderá utilizar as seguintes credenciais para se autenticar:
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

<h2> Specs do sistema </h2>
  <h4> Gems utilizadas: </h4>
  
    * FactoryBot: 
       Gem utilizada para automatizar o processo de população do banco de dados, simplificando as etapas de alguns testes e os deixando mais limpos.
  
    * Faker:
       Gem utilizada para criar dados 'falsos', associada com a FactoryBot é utilizada para gerar strings e números aleatórios que servem como valores dos atributos nas instâncias dos models.
  
    * Devise:
       Gem utilizada para gerenciar a autenticação dos usuários comuns e admins.
